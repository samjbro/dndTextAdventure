#using YAML for party saves, and JSON for game data - probably better to use one or the other?
require 'yaml'
require 'rubygems'
require 'json'
require 'ostruct'
require_relative 'rules.rb' #userInput and dice rolls are loaded from here
#Party array not necessary here, but mentioned as a reminder of its scope
$party = Array.new

#Selection of monsters
$monsterManual = File.read("gameData/monsterManual.json")
$monsterManual = JSON.parse($monsterManual, :symbolize_names => true)

#Selection of playable fighting classes
$fightClasses = File.read("gameData/fightClasses.json")
$fightClasses = JSON.parse($fightClasses, :symbolize_names => true)

#Selection of playable races
$races = File.read("gameData/races.json")
$races = JSON.parse($races, :symbolize_names => true)

#Create a new Game
class Game
  def initialize
  end
  #Begins the game
  def begin
    partyImporter
    Environment.new($party).town
  end
  #The player chooses whether to import a new party, or create a new one
  def partyImporter
    confirm = userInput("Hail adventurer! Would you like to import a party?\n==>")
    if confirm == true #consider making these separate methods
      importParty
    elsif confirm == false
      createParty
    else partyImporter
    end
  end
  #The player chooses their character name, race and fighting class
  def createPlayer(playerNo)
    playerName = userInput("Hail, adventurer #{playerNo}! What is your name?\n==>").downcase.capitalize
    playerName = "Oik" if playerName == ""

    puts "And your race? Available races are as follows:"
    $races.values.take($races.values.length-1).each_with_index do |race, index| 
      puts "\n" if (index%3 == 0) && (index > 0)
      print "#{index+1}) #{race[:name].ljust(12)}"
    end
    puts "\n"
    selection = userInput
    if selection.to_i.to_s == selection
      raceIndex = selection.to_i - 1
      playerRace = $races.values[raceIndex]
    else  
      playerRace = $races[userInput.to_sym]
      playerRace = $races[:urchin] if playerRace == nil
    end

    puts "And your class? Available classes are as follows:"
    $fightClasses.values.take($fightClasses.values.length-1).each_with_index do |fightClass, index| 
      puts "\n" if (index%3 == 0) && (index > 0)
      print "#{index+1}) #{fightClass[:name].ljust(12)}" #index+1) is not included in ljust, so double digits formatting is wrong
    end
    puts "\n"    
    selection = userInput
    if selection.to_i.to_s == selection
      classIndex = selection.to_i - 1
      fightClass = $fightClasses.values[classIndex]
    else  
      fightClass = $fightClasses[userInput.downcase.to_sym]
      fightClass = $fightClasses[:beggar] if fightClass == nil
    end
    $party.push(Player.new(playerName, playerRace, fightClass, $party.length+1))
  end
end

#Create a new Player
class Player < Game
  attr_accessor :name
  attr_accessor :playerNo
  attr_accessor :race
  attr_accessor :fightClass
  attr_accessor :level
  attr_accessor :hp
  attr_accessor :actions
  attr_accessor :inventory
  attr_accessor :attacks
#Set the Player's starting parameters
  def initialize(name, race, fightClass, playerNo)
    @name = name
    @playerNo = playerNo
    @race = race
    @fightClass = fightClass
    @level = 1
    @hp = 60 + d(20, 1)
    @actions = ["attack", "flee", "check Inventory", "suicide"]
    @inventory = ["Basic Potion", "Basic Rations"]
    @attacks = {:thrust=> {:d8=>5, :d10=>1}, :swipe=> {:d1=>66}}
  end
  #Displays a player's status
  def status
    puts "Player #{@playerNo}".center(60)
    puts "Name: #{@name}".center(60)
    puts "Class: #{@fightClass[:name]}".center(60)
    puts "Race: #{@race[:name]}".center(60)
    puts "HP: #{@hp}".center(60)
    puts "Level: #{@level}".center(60)
    puts "Actions: #{@actions.map(&:capitalize).join(', ')}".center(60)
    puts "Attacks: #{@attacks.keys.map(&:capitalize).join(', ')}".center(60)
    puts "Inventory: #{@inventory.join(', ')}".center(60)
    puts ""
  end
  #Greets the player
  def greeting
    puts "Greetings, #{@name} the #{@race[:adj]} #{@fightClass[:name]}!"
    userInput("")
  end
#Give the Player a selection of actions
  def actions(enemy)
    puts "What will #{@name} do? They may:"
    @actions.each_with_index{|a, i| puts "#{i+1}) #{a}"}
     #maybe instead of this, look at all the defined action method names and list them?
    userMethod = userInput #how do i center all of these, not just the first?
    if userMethod.to_i.to_s == userMethod
      unCamel = @actions[userMethod.to_i-1]
      userMethod = unCamel
      userMethod[0] = userMethod[0].downcase
    else
      unCamel = userMethod.split(/(?=[A-Z])/).join
      p userMethod
      p unCamel
    end
    (@actions.include? unCamel) ? method(userMethod).call(enemy) : (puts "#{@name} attempts to #{userMethod}... Nothing happens.") 
  end
#Describe the Player's 'attack' action
  def attack(enemy)
    attack = userInput("#{@name} knows the following attacks: \n#{@attacks.keys.map(&:capitalize).join("\n")}\n==>").downcase.to_sym
    if @attacks[attack]
      damage = 0
      @attacks[attack].each_pair {|d,x| damage += d(d.to_s.tr('d','').to_i ,x)}
      
      enemy.stats[:hp] -= damage
      message = "#{@name} rolled #{damage}! The #{enemy.type} takes #{damage} damage from #{@name}\'s #{attack.capitalize}!"
      case damage
        when 1
         puts message + " Critical Fail..."
        when 20
          puts message + " Critical Hit!!!"
        else
          puts message              
      end
    else puts "#{@name} doesn't know how to attack with their #{attack.downcase}..."
    end
    gets
    puts "The #{enemy.type} now has #{enemy.stats[:hp]} HP!"    
  end
#Describe the Player's 'flee' action
  def flee(enemy)
    puts "CHEEP CHEEP CHEEP CHEEP CHEEP"
  end
  def checkInventory(enemy)
    puts "You currently have the following items in your inventory:"
    puts @inventory
  end
#Suicide results in a self-inflicted Game Over
  def suicide(enemy)
    @hp -= 100000
  end
#Player death method
  def death
    puts "#{@name} has died. Game Over."
  end
end
#Describe the environment
class Environment < Game
  def initialize(party)
    $party = party
  end
  def town
    userInput("\nYour party is currently in a town. Do you want them to leave?\nYes or No?==>") == true ? forest : town
  end
  def forest
    @answer = userInput("\nYour party is standing at the entrance to a dark forest.\nDo they 1)Enter, or 2)Return to the town?==>")
    case @answer
      when "enter", "e", "1"
        Encounter.new($party).hostileSingle
      when "return", "r", "2"
        town
      else
        forest
    end
  end
end
#Describe a basic encounter with a Monster
class Encounter < Game
  def initialize(party)
     @enemy = Monster.new
     $party = party
  end
  def hostileSingle
    puts "\nYour party is attacked by an angry #{@enemy.type}!!" # a(n) depending on vowel
    puts ""
    puts "The #{@enemy.type} has #{@enemy.stats[:hp]} HP.\n".center(60)
    $party.each{|member| puts "#{member.name} has #{member.hp} HP.".center(60)}
    userInput("")
    $party.each {|member| instance_variable_set("@player#{$party.index(member)+1}", member)} #CHANGE THIS
    

    until @player1.hp < 1 || @enemy.stats[:hp] < 1 # initiative roll
      for i in 0..($party.length-1)
        $party[i].actions(@enemy)
        break if @enemy.stats[:hp] < 1
      end
      break if @player1.hp < 1 || @enemy.stats[:hp] < 1
      @enemy.attack($party[rand($party.length)])
    end

    if (@player1.hp < 1)
     @player1.death
    else puts "You have killed the #{@enemy.type}! Well done!"
      puts "You gain #{rand(10)+1} XP!"
      puts "You loot 1x #{@enemy.stats[:loot]} from the dead #{@enemy.type}!!"
      @player1.inventory.push(@enemy.stats[:loot])
      puts "It was added to your inventory."
      userInput
    end
  end
end
#Create a new Monster
class Monster < Game
    attr_accessor :type
    attr_accessor :stats
     def initialize
      @type = $monsterManual.keys[rand($monsterManual.length)].to_s
      @stats = $monsterManual[@type.to_sym]
    end
#Describe the Monster's 'attack' action
    def attack(player)
      moveList = @stats[:attacks]
      attack = moveList.keys[rand(moveList.length)]
      puts "\nThe #{type} used #{attack}!!"
      puts "#{player.name} took #{moveList[attack]} pts of damage..."
      player.hp -= moveList[attack]
      puts "#{player.name} now has #{player.hp} HP"
      userInput
    end
end

Game.new.begin




