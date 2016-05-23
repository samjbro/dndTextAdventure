module Mini_Actions
	def Mini_Actions.use(player, item="whatever")
		
		puts "noooope"
	end
	def Mini_Actions.look(player, direction="around")
		x_current = player.location[0]
		y_current = player.location[1]

		north = $maps[$current_map]["@map_tiles"][[x_current+1,y_current]]
		east =	$maps[$current_map]["@map_tiles"][[x_current,y_current+1]]
		south = $maps[$current_map]["@map_tiles"][[x_current-1,y_current]]
		west = $maps[$current_map]["@map_tiles"][[x_current,y_current-1]]
		case direction
		when "n", "north"
			puts "To the North there is #{"impassable " unless north["traversable"]}" + north["terrain"]
		when "e", "east"
			puts "To the East there is #{"impassable " unless east["traversable"]}" + east["terrain"]
		when "s", "south"
			puts "To the South there is #{"impassable " unless south["traversable"]}" + south["terrain"]
		when "w", "west"
			puts "To the West there is #{"impassable " unless west["traversable"]}" + west["terrain"]
		else
			tile_chars = $maps[$current_map]["@map_tiles"][player.location]["contents"]["creatures"]
			tile_items = $maps[$current_map]["@map_tiles"][player.location]["contents"]["items"]
			
			puts "You are standing in a #{$maps[$current_map]["@map_tiles"][player.location]["terrain"]}."
			($time.hour > 6 && $time.hour < 20) ? puts("It is day time.") : puts("It is night time.")
			puts "In front of you there is a #{$creatures[tile_chars[0]]["data"]["type"]}." unless tile_chars.empty?
			puts "There is a #{$items[tile_items[0]]["data"]["type"]} on the floor." unless tile_items.empty?
		end
	end
	def Mini_Actions.go(player, direction)
		destination = []
		x_current = player.location[0]
		y_current = player.location[1]
		case direction.downcase
		when "n", "north"
			direction = "North"
			destination = [x_current, y_current+1]
		when "e", "east"
			direction = "East"
			destination = [x_current+1, y_current]
		when "s", "south"
			direction = "South"
			destination = [x_current, y_current-1]
		when "w", "west"
			direction = "West"
			destination = [x_current-1, y_current]
		end
		player.location = destination if (!!$maps[$current_map]["@map_tiles"][destination] && $maps[$current_map]["@map_tiles"][destination]["traversable"])
		if player.location !=  destination
			puts "You cannot go #{direction}, as a #{$maps[$current_map]["@map_tiles"][destination]["terrain"]} region blocks your path."
		else
			puts "You move 1 space #{direction}."
			Mini_Actions.look(player)
		end
		$time += (10*60)
	end
	def Mini_Actions.take(player, item)
		item_ids = $maps[$current_map]["@map_tiles"][player.location]["contents"]["items"]
		match = false
		selection_id = ""
		item_ids.each { |id| (match = true; selection_id = id) if $items[id]["data"]["type"].downcase == item}
		if match
			puts "You got the #{$items[selection_id]["data"]["type"]}!"
			$items[selection_id]["location"] = "#{player.name}\'s Inventory"
			$maps[$current_map]["@map_tiles"][player.location]["contents"]["items"].delete(selection_id)
			player.inventory << selection_id
		else
			puts "There is no such item in sight."
		end
	end
	def Mini_Actions.check(player, target="inventory")
		case target
		when "inventory", "bag", "pack", "belongings", "possessions"
			player_items = []
			player.inventory.each {|i| player_items << $items[i]}
			puts "You have the following items in your inventory:"
			player_items.each {|i| puts i["data"]["type"]}
		when "time"
			puts $time.strftime("It is currently %H:%M on day %d, month %m of the year %Y")
		when "map"
			player.inventory.include?("#I002") ? Map_Methods.show_maps($maps[$current_map], player) : puts("You do not have a map.")
		when "area", "surroundings"
			Mini_Actions.look(player)
		else
			puts "What would you like to check?"
			Mini_Actions.check(player, gets.chomp.downcase)
		end
	end
	def Mini_Actions.fight(player, character)
		character_ids = $maps[$current_map]["@map_tiles"][player.location]["contents"]["creatures"]
		match = false
		selection_id = ""
		character_ids.each { |id| (match = true; selection_id = id) if $creatures[id]["data"]["type"].downcase == character}
		if match
			puts "You attack the #{$creatures[selection_id]["data"]["type"]}!"
			puts "The #{$creatures[selection_id]["data"]["type"]} is dead!"
			$ogre_dead = true
			$maps[$current_map]["@map_tiles"][player.location]["contents"]["creatures"].delete(selection_id)
		else
			puts "There is no such creature in sight."
		end
	end
	def Mini_Actions.wait(player, time=nil)
		puts "How long will you wait?"
		input = gets.chomp.split(' ', 2)
		input = input[0].split( /(?![0-10])/, 2) if input.size == 1 #BROKEN - splits after first integer... also doesn't check for decimal point
		case input[1]
		when "seconds", "secs", "second", "sec"
			time_in_seconds = input[0].to_i
		when "minutes", "mins", nil
			time_in_seconds = input[0].to_i*60
		when "hours", "hrs", "hour", "hr"
			time_in_seconds = input[0].to_i*3600
		when "days", "day"
			time_in_seconds = input[0].to_i*3600*24
		when "years", "yrs", "year", "yr"
			time_in_seconds = input[0].to_i*3.154e+7
		else
			time_in_seconds = input[0].to_i*60
		end
		$time += time_in_seconds
		if time_in_seconds >= 3.154e+7
			puts "You wait for #{(time_in_seconds/3.154e+7).floor} year(s)..."
		else
			puts "You wait for #{time_in_seconds/3600} hours, #{time_in_seconds%3600/60} minutes and #{time_in_seconds%3600%60} seconds."
		end
		Mini_Actions.check(player, "time")
	end

end