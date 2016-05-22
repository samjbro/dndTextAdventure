module Map_Methods
	def Map_Methods.map_maker
		puts "What will the map be called?"
		map_name = gets.chomp
		puts "How wide is the map?"
		x_max = gets.chomp.to_i
		puts "How long is the map?"
		y_max = gets.chomp.to_i
		puts "What is the default terrain?"
		terrain = gets.chomp
		puts "What terrain borders the map?"
		border = gets.chomp
		
		new_map = Map.new(map_name, x_max, y_max, terrain, border)
		Map_Methods.save_if_instance(new_map)
	end
	def Map_Methods.hashify(map)
		hash = {}
		map.instance_variables.each do |var|
			var = var.to_s
			hash[var] = map.instance_variable_get(var)
		end
		p hash
		hash
	end
	def Map_Methods.show_maps(map="all", player)
		if map == "all"
			$maps.each {|k,v| print "\nMap of #{k}"; Map_Methods.display_map(v)}
		else
			print "\nMap of #{map["@map_name"]}"; Map_Methods.display_map(map, player)
		end
	end
	def Map_Methods.display_map(map, player)
			puts ("\n" + "----------------" * map["@x_max"])
		map["@map_tiles"].each_slice(map["@x_max"]) do |row|
			print "|"
			row.each do |tile| 
				if tile[0] == player.location
					print "-YOU ARE HERE-".center(15)
				elsif tile[1]["traversable"] == false
					print ("X"*15).center(15)
				else
					print "".center(15)
				end
				print "|"
			end
			print "\n|"
			row.each {|tile| print "#{tile[0]}".center(15) + "|"} 
			print "\n|"
			row.each {|tile| print "#{tile[1]["terrain"]}".center(15) + "|"} 
			print "\n|"
			row.each do |tile| 
				creatures = tile[1]["contents"]["creatures"]
				char_array = []
				creatures.each {|char| char_array << $creatures[char]["data"]["type"]}
				print char_array.join(',').center(15) + "|"
			end 
			print "\n|"
			row.each do |tile| 
				items = tile[1]["contents"]["items"]
				item_array = []
				items.each {|item| item_array << $items[item]["data"]["type"]}
				print item_array.join(',').center(15) + "|"
			end 
			puts ("\n" + "----------------" * map["@x_max"])
		end
	end
	def Map_Methods.save_if_instance(map)
		$maps[map.map_name] = Map_Methods.hashify(map)
		File.open("minigameData/mini_maps.json", "w") {|f| f.write $maps.to_json}
	end
	def Map_Methods.save_if_hash(map)
		#p map["@map_name"]
		$maps[map["@map_name"]] = map
		File.open("minigameData/mini_maps.json", "w") {|f| f.write $maps.to_json}
	end
	
end

class Map
	attr_accessor :map_name, :x_max, :y_max, :map_tiles
	def initialize(map_name, x_max, y_max, terrain, border)
		@map_name = map_name
		@x_max = x_max
		@y_max = y_max
		@map_tiles = Hash.new
		y_max.times do |y|
			x_max.times do |x|
				@map_tiles[[x,y_max-1-y]] = {"terrain" => terrain.upcase, 
											 "traversable" => true, 
											 "contents" => {"items" => [], 
											 			   "creatures" => []}}
			end
		end
		self.border(border)
	end
	def border(border)
		@map_tiles.each{|key, val| (val["terrain"]=border.upcase; val["traversable"] = false) if (key[0] % (@x_max-1) == 0) || (key[1] % (@y_max-1) == 0)}
	end
end
class String
	def convert_to_coords
		string = self[1..-2]
		arr = []
		string = string.split(', ')
		string.each {|x| arr << x.to_i}
		arr
	end

end
#Map_Methods.map_maker