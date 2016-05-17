module Character
  def Character.createNPC(type=random) #create non-player character
    type = $monsterManual.keys[rand($monsterManual.length)].to_s if type == random
    stats = $monsterManual[@type.to_sym]
  end
  def Character.createPC(partyName) #create player character
    playerName = Rules.userInput("Hail, adventurer! What is your name?\n==>").capitalize
    playerName = "Oik" if playerName == ""

    puts "And your race? Available races are as follows:"
    $races.values.take($races.values.length-1).each_with_index do |race, index| 
      puts "\n" if (index%3 == 0) && (index > 0)
      print "#{index+1}) #{race[:name].ljust(12)}"
    end
    puts "\n"
    selection = Rules.userInput
    if selection.to_i.to_s == selection
      raceIndex = selection.to_i - 1
      playerRace = $races.values[raceIndex]
    else  
      playerRace = $races[selection.to_sym]
      puts "hello my race is #{playerRace}"
      playerRace = $races[:urchin] if playerRace == nil
    end

    puts "And your class? Available classes are as follows:"
    $fightClasses.values.take($fightClasses.values.length-1).each_with_index do |fightClass, index| 
      puts "\n" if (index%3 == 0) && (index > 0)
      print "#{index+1}) #{fightClass[:name].ljust(12)}" #index+1) is not included in ljust, so double digits formatting is wrong
    end
    puts "\n"    
    selection = Rules.userInput
    if selection.to_i.to_s == selection
      classIndex = selection.to_i - 1
      fightClass = $fightClasses.values[classIndex]
    else  
      fightClass = $fightClasses[selection.downcase.to_sym]
      fightClass = $fightClasses[:beggar] if fightClass == nil
    end
    $party.push(Player.new(playerName, playerRace, fightClass, $party.length+1))
  end
end

#Create a new Player
  class Player
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
      @hp = 60 + Rules.d(20, 1)
      @actions = ["attack", "flee", "checkInventory", "suicide"]
      @inventory = ["Basic Potion", "Basic Rations"]
      @attacks = ["thrust", "swipe"]
    end
    #Displays a player's status
    def status
      puts "Player #{@playerNo}".center(60)
      puts "Name: #{@name}".center(60)
      puts "Class: #{@fightClass[:name]}".center(60)
      puts "Race: #{@race[:name]}".center(60)
      puts "HP: #{@hp}".center(60)
      puts "Level: #{@level}".center(60)
      puts "Actions: #{@actions.map(&:unCamelize).join(', ')}".center(60)
      puts "Attacks: #{@attacks.map(&:unCamelize).join(', ')}".center(60)
      puts "Inventory: #{@inventory.join(', ')}".center(60)
      puts ""
    end
    
  #Give the Player a selection of actions
    def actions(enemy)
      puts "What will #{@name} do? They may:"
      @actions.each_with_index{|a, i| puts "#{i+1}) #{a.unCamelize}"}
       #maybe instead of this, look at all the defined action method names and list them?
      userMethod = Rules.userInput
      (userMethod.to_i.to_s == userMethod) ? userMethod = @actions[userMethod.to_i-1] : userMethod = userMethod.camelize
      (@actions.include? userMethod) ? Actions.method(userMethod).call(self, enemy) : (puts "#{@name} attempts to #{userMethod.unCamelize}... Nothing happens.") 
    end
  
  end

#Select a new Monster
# class Monster
#     attr_accessor :type
#     attr_accessor :stats
#      def initialize
#       @type = $monsterManual.keys[rand($monsterManual.length)].to_s
#       @stats = $monsterManual[@type.to_sym]
#     end
# #Describe the Monster's 'attack' action
#     def attack(player)
#       moveList = @stats[:attacks]
#       attack = moveList.keys[rand(moveList.length)]
#       puts "\nThe #{type} used #{attack}!!"
#       puts "#{player.name} took #{moveList[attack]} pts of damage..."
#       player.hp -= moveList[attack]
#       puts "#{player.name} now has #{player.hp} HP"
#       Rules.userInput
#     end
# end
