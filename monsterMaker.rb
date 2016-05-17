require 'rubygems'
require 'json'
require 'pp'

require_relative 'rules.rb'
include Rules
#Needs to handle multi-word input...
def monsterMaker
	name = Rules.userInput("What is the Monster's name?\n==>").unCamelize
	hp = Rules.userInput("What is the Monster's hp?\n==>").to_i
	atk1 = Rules.userInput("What is the Monster's first attack?\n==>").unCamelize
	dam1 = Rules.userInput("How much damage does that attack do?\n==>").to_i
	atk2 = Rules.userInput("What is the Monster's second attack?\n==>").unCamelize
	dam2 = Rules.userInput("How much damage does that attack do?\n==>").to_i
	loot = Rules.userInput("What is the Monster's loot?\n==>").unCamelize

	newMonster = {name => {
					"type" => "name"
				    "hp" => hp,
				    "attacks" => {
				      atk1 => dam1,
				      atk2 => dam2
				    },
				    "loot" => loot
				  }}

	json = File.read("gameData/monsterManual.json")

	File.open("gameData/monsterManual.json", "w") do |f| 
		f.puts JSON.pretty_generate(JSON.parse(json).merge!(newMonster)) 
	end
end

def attackMaker
	name = Rules.userInput("What is the Attack's name?\n==>").unCamelize
	die1 = Rules.userInput("What is the attack's first die?\n==>")
	dam1 = Rules.userInput("How many times is that die rolled?\n==>").to_i
	die2 = Rules.userInput("What is the attack's second die?\n==>")
	dam2 = Rules.userInput("How many times is that die rolled?\n==>").to_i
	newAttack = {name => {
				    "d" + die1 => dam1,
				    "d" + die2 => dam2
				  }}

	json = File.read("gameData/attacks.json")

	File.open("gameData/attacks.json", "w") do |f| 
		f.puts JSON.pretty_generate(JSON.parse(json).merge!(newAttack)) 
	end
end
Rules.userInput("Would you like to input a 1)Monster, or 2) Attack?\n==>") == "1" ? monsterMaker : attackMaker