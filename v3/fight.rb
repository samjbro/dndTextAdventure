=begin
Create a battle module, a la FF.
- Firstly, there must be a player, with skills available to use. Later this can be customized and r/w functionality added.
- (LATER) There is an environment, which affects terrain, movement, monster spawns, skill effectiveness, etc. 
- The type of monster is chosen at random from a list of available monsters. This can be updated with percentage chances based on location.
- Once the monster type has been chosen, the individual monster's stats are randomised within certain boundaries. However, there are some unique monsters whose stats always stay the same.
- Once the monster has been generated, battle commences. Model it as closely to D&D rules as possible - i.e. start with an initiative roll, then choose attack.
- Introduce status effects.
- Once one combatant is KO'd, the battle ends, and a victory or defeat screen appears.
=end
require 'json'
$monsters = File.read("data/monsters.json")
$monsters = JSON.parse($monsters)
class Player
	attr_accessor :name
	attr_accessor :hp
	def initialize
		@name = "Sampson"
		@hp = 99
	end
end

class Monster
	attr_accessor :name
	attr_accessor :hp
	def initialize(type)
		@name = type
		@hp = 70
	end
end

player = Player.new
enemy = Monster.new($monsters.sample)

def battle(player, enemy)
	puts "#{player.name} is fighting #{enemy.name}!"
	puts "#{player.name} has #{player.hp} hp!"

end

battle(player, enemy)
