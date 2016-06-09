require 'sinatra'

@@global_pos = 6
get '/dnd' do

$envs = ["field", "marsh", "forest", "road"]
$items = ["dagger", "ring", "potion"]
$inventory = []

def add_items()

   @@my_map.each do |key, value|
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
    {"env"=> tile_type(tile), "item"=> nil, "curr_tile"=> false}
end

arr = *(1 .. 16)
@@my_map = arr.each_with_object({}) { |v,my_map| my_map[v] = make_tile(v) }
add_items()
@@my_map[@@global_pos]["curr_tile"] = true
    erb :dnd
end



def move(direction)

  @@global_pos += direction
  if @@my_map[@@global_pos]["env"] != "mountain"
  		@@my_map[@@global_pos -= direction]["curr_tile"] =  false
    	@@my_map[@@global_pos]["curr_tile"] =  true
	else
		@@global_pos -= direction
	end
  
end





post "/runMethod" do

  move(params[:'data-direction'])

end
