require 'rubygems'
require 'json'
require 'pp'

require_relative 'rules.rb'

#Needs to handle multi-word input...

name = userInput("What is the Monster's name?\n==>").capitalize
hp = userInput("What is the Monster's hp?\n==>").to_i
atk1 = userInput("What is the Monster's first attack?\n==>").capitalize
dam1 = userInput("How much damage does that attack do?\n==>").to_i
atk2 = userInput("What is the Monster's second attack?\n==>").capitalize
dam2 = userInput("How much damage does that attack do?\n==>").to_i
loot = userInput("What is the Monster's loot?\n==>").capitalize

newMonster = {name => {
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

