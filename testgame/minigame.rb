require 'json'
require_relative 'minidata'
require_relative 'mini_actions'
require_relative 'map_module'


$maps = File.read("minigameData/mini_maps.json")
$maps = JSON.parse($maps)
#Converts co-ordinates back into arrays, since they are parsed from the JSON as strings
$maps.each {|k,v| v["@map_tiles"] = Hash[v["@map_tiles"].map {|key,val| [key.convert_to_coords, val]}]}

$creatures = File.read("minigameData/creatures.json")
$creatures = JSON.parse($creatures)

$items = File.read("minigameData/mini_items.json")
$items = JSON.parse($items)

$play = true

$time = Time.new(1365, 03, 12, 8, 0)

$new_player = Player.new([3,3], "Sampson")

$current_map = "World"

$creatures.each do |k,v| 
	$maps[$current_map]["@map_tiles"][v["location"]]["contents"]["creatures"] = [k]
	Map_Methods.save_if_hash($maps[$current_map])
end
$items.each do |k,v| 
	$maps[$current_map]["@map_tiles"][v["location"]]["contents"]["items"] = [k]
	Map_Methods.save_if_hash($maps[$current_map])
end

$new_player.action until $play == false



#TARGET CO-ORDINATES
# puts "What co-ordinates would you like to examine?"
# coords = gets.chomp.split(",").map(&:to_i)


#CHANGE TERRAIN TYPE
# puts "What type of terrain should #{coords} be?"
# terr = gets.chomp
# $world_map[coords]["terrain"] = terr


