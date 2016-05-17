#using YAML for party saves, and JSON for game data - probably better to use one or the other?
require 'yaml'
require 'rubygems'
require 'json'
require 'ostruct'
require_relative 'rules.rb' #Rules.userInput and dice rolls are loaded from here
require_relative 'party.rb' #party-related methods are loaded from here
require_relative 'actions.rb' #character action methods are loaded from here
require_relative 'battle.rb' #battle methods are loaded from here
require_relative 'navigation.rb' #navigation methods are loaded from here
require_relative 'character.rb' #character methods are loaded from here
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

#Selection of attacks
$attacks = File.read("gameData/attacks.json")
$attacks = JSON.parse($attacks, :symbolize_names => true)

#Create a new Game
class Game
  #Begins the game
  def begin
    Party.partyImporter
    Navigation.town
  end
end


#Select a new Monster
class Monster
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
      Rules.userInput
    end
end

Game.new.begin




