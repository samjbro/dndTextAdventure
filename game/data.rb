class Player
	attr_accessor :location, :name, :methods, :inventory
	def initialize(location, name)
		@name = name
		@location = location
		@inventory = []
		@actions = ["look", "go", "take", "fight", "check", "use", "wait"] 
	end
	def action
		print "=>"
		command = gets.chomp.downcase.split(' ',2)
		case command[0] #Build synonym database
		when "n","e","s","w", "north", "east", "west", "south"
			Mini_Actions.go(self, command[0])
		when "quit", "q"
			abort("You have quit the game.")
		when "attack"
			Mini_Actions.fight(self, command[1])
		else
			if @actions.include?(command[0])
				Mini_Actions.public_send command[0], self, command[1]
			else
				puts "You can't do that."
			end
		end
	end
end












