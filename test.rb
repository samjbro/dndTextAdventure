#Array of saved game files
$saves = Array.new
#Selection of monsters
$monsterManual = {:Orc => {:hp=>46, :attacks=>{:"Sword Thrust"=>5, :"Charge"=>7}, :loot=> "Battered Gauntlets"}, 
                  :Goblin => {:hp=>23, :attacks=>{:Lunge=>5, :"Stab Stab Stab"=>7}, :loot=> "Soggy Hat"}, 
                  :Troll => {:hp=>60, :attacks=>{:Smash=>5, :Belch=>7}, :loot=> "Troll Dick"}, 
                  :Dragon => {:hp=>999, :attacks=>{:"Fire Breath"=>90, :"Tail Swipe"=>65}, :loot=> "All The Treasure"}}
#Selection of playable fighting classes
$fightClasses = {:cleric => {:name => "Cleric"},
                 :barbarian => {:name => "Barbarian"},
                 :rogue => {:name => "Rogue"},
                 :sorcerer => {:name => "Sorcerer"},
                 :bard => {:name => "Bard"},
                 :ranger => {:name => "Ranger"},
                 :gunslinger => {:name => "Gunslinger"},
                 :druid => {:name => "Druid"},
                 :thief => {:name => "Thief"},
                 :paladin => {:name => "Paladin"},
                 :fighter => {:name => "Fighter"},
                 :beggar => {:name => "Weakling"}}
#Selection of playable races
$races        = {:human => {:name => "Human", :adj => "Human", :lang => "Common"},
                 :gnome => {:name => "Gnome", :adj => "Gnomish", :lang => "Common"},
                 :goliath => {:name => "Goliath", :adj => "Goliath", :lang => "Common"},
                 :halfElf => {:name => "Half-Elf", :adj => "Half-Elven", :lang => "Common"},
                 :elf => {:name => "Elf", :adj => "Elven", :lang => "Common"},
                 :dragonborn => {:name => "Dragonborn", :adj => "Dragonborn", :lang => "Common"},
                 :tiefling => {:name => "Tiefling", :adj => "Tiefling", :lang => "Common"},
                 :orc => {:name => "Orc", :adj => "Orcish", :lang => "Common"},
                 :halfling => {:name => "Halfling", :adj => "Halfling", :lang => "Common"},
                 :dwarf => {:name => "Dwarf", :adj => "Dwarven", :lang => "Common"},
                 :urchin => {:name => "Urchin", :adj => "Urchin", :lang => "Common"}}
#Define the game's Rules
class Rules
#create the dice roll method
  def d(sides, rolls)
    damage = 0
    rolls.times do |i|
      damage += (rand(sides)+1)
    end
    damage
  end
  
end

#Create a new Game
class Game < Rules
  attr_accessor :party
  attr_reader :saveName
  def initialize(saveName)
    @party = []
    @saveName = saveName
  end
  #Begins the game
  def begin
      (userInput("Hail adventurers! How many will be in your party?\n==>").to_i).times {|x| createPlayer(x+1); @party[x].greeting } until @party.length >0
      Environment.new(@party).town
  end
  #Is called any time the game requires user input - this allows for universal commands such as 'quit', 'save' and 'status'
  def userInput(text="==> ")
    print text
    input = gets.chomp
    unless input == ""
      input = input.downcase.tr('-',' ').split(' ').map(&:capitalize).join
      input[0] = input[0].downcase
    end
    case input
      when "quit"
        print "Are you sure you want to quit?\n==> "
          quitConfirm = gets.chomp.downcase
          return userInput("You have not quit the game :)") unless (quitConfirm == "y" || quitConfirm == "yes" || quitConfirm == "quit")   
          abort("You have quit the game :(") 
      when "status" 
        puts "Whose status would you like to check?"
        $saves[-1].party.each{|x| puts x.name}
        choice = userInput.downcase.capitalize
        $saves[-1].party.find {|player| player.name == choice}.status
        userInput(text)
      when "saveData"
        puts "The current save file is: #{$saves}"
        userInput
      else
        input
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
    playerRace = $races[userInput.to_sym]
    playerRace = $races[:urchin] if playerRace == nil

    puts "And your class? Available classes are as follows:"
    $fightClasses.values.take($fightClasses.values.length-1).each_with_index do |fightClass, index| 
      puts "\n" if (index%3 == 0) && (index > 0)
      print "#{index+1}) #{fightClass[:name].ljust(12)}" #index+1) is not included in ljust, so double digits formatting is wrong
    end
    puts "\n"    
    fightClass = $fightClasses[userInput.downcase.to_sym]
    fightClass = $fightClasses[:beggar] if fightClass == nil

    @party.push(Player.new(playerName, playerRace, fightClass, @party.length+1))
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
    @actions = ["attack", "flee", "inventory", "suicide"]
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
     #maybe instead of this, look at all the defined action method names and list them?
    userMethod = userInput("What will #{@name} do? They may: \n#{@actions.map(&:capitalize).join("\n")}\n==>").downcase #how do i center all of these, not just the first?
    (@actions.include? userMethod) ? method(userMethod).call(enemy) : (puts "#{@name} attempts to #{userMethod}... Nothing happens.") 
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
  def inventoryCheck(enemy)
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
    @party = party
  end
  def town
    @answer = userInput("Your party is currently in a town. Do you want them to leave?\nYes or No?==>").downcase
    @answer == "yes" ? forest : town
  end
  def forest
    @answer = userInput("Your party is standing at the entrance to a dark forest.\nDo they Enter, or Return to the town?==>").downcase
    case @answer
      when "enter"
        Encounter.new($saves[-1].party).hostileSingle
      when "return"
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
     @party = party
  end
  def hostileSingle
    puts "Your party is attacked by an angry #{@enemy.type}!!" # a(n) depending on vowel
    puts ""
    puts "The #{@enemy.type} has #{@enemy.stats[:hp]} HP.\n".center(60)
    @party.each{|member| puts "#{member.name} has #{member.hp} HP.".center(60)}
    userInput("")
   #COULD THIS BE USEFUL? @party.each {|member| instance_variable_set("@player#{@party.index(member)+1}", member)}
    

    until @player1.hp < 1 || @enemy.stats[:hp] < 1 # initiative roll
      for i in 0..(@party.length-1)
        @party[i].actions(@enemy)
        break if @enemy.stats[:hp] < 1
      end
      break if @player1.hp < 1 || @enemy.stats[:hp] < 1
      @enemy.attack(@party[rand(@party.length)])
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


print "What would you like to call your new saved game?\n==> "
$saves << Game.new(gets.chomp + ".dnd")
$saves[-1].begin #rather than accessing by last index, could use .find to select the object with the chosen saveName




