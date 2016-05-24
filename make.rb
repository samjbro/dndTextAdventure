$global_pos = 6
$envs = ["field", "marsh", "forest", "road"]
$items = ["dagger", "ring", "potion"]
$inventory = []

def test()

print "!!!!"
	end

def add_items()

   $my_map.each do |key, value|
   	if value["env"] != "mountain" && rand(10) < 7
     value["item"] = $items[0]
     $items.shift
 	end
   end

end

def item_type()
   $items[0]

end

def tile_type(tile)

	case tile
	when 1..4
		"mountain"
	when 13..16
		"mountain"
	when 8, 12
		"mountain"
	when 5, 9
		"mountain"
	else
		$envs.sample		
	end	
end



def make_tile(tile)
    {"env"=> tile_type(tile), "item"=> nil}
end

arr = *(1 .. 16)
$my_map = arr.each_with_object({}) { |v,my_map| my_map[v] = make_tile(v) }
add_items()

print $my_map

def do_stuff(action)
case action
when "north"
	move(-4)
when "south"
	move(4)
when "east"
	move(1)
when "west"
	move(-1)
when "exit"
	$x = 0
when "look"
	look()
when "take"
	take()
when "inv"
	inv()
end
end

def look()
   h = {"North" => -4, "South" => 4, "East" => 1, "West" => -1}
   h.each do |key, val|
   print "To the #{key} is a " + $my_map[$global_pos + val]["env"] + "\n"
   end
   if $my_map[$global_pos]["item"]
   print "You see a " + $my_map[$global_pos]["item"] + "\n"
   end
end

def move(direction)
  print $global_pos	
  $global_pos += direction
  print $global_pos
  if $my_map[$global_pos]["env"] != "mountain"
    	print "You are in a " + $my_map[$global_pos]["env"] + "\n"
	else
		    	print $global_pos
		print "You can't go that way" + "\n"
		$global_pos -= direction
	end
  
end

def take()
	$inventory.push($my_map[$global_pos]["item"])
	$my_map[$global_pos]["item"] = nil
	print "You have a dagger" + $inventory[0]
end

def inv()
 	print $inventory
end

$x = 1

def run()
	commands = %w[north south east west exit look take inv]
    while $x == 1
      action = gets.downcase.chomp
      if commands.include? action then send :do_stuff, action
		else puts "#{action} is not a valid command"
	  end
      
    end
end

run()


