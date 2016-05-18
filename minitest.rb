require 'yaml'
require 'json'


def create_map(rows,cols)#why is one e
	mappy = Hash.new
	rows.times do |y|
		cols.times do |x|
			mappy[[x,rows-y-1]] = {:terrain => "grassland", :traversable => true} #create "empty" key/val to tell game whether to look through monster/item arrays? This would save processing time maybe?
		end
	end
	mappy
end

# def create_map_alt(rows,cols)
# 	map = Array.new(rows){Array.new(cols)}
# 	map.each_with_index do |row, y|
# 		row.each_with_index do |tile, x|
			
# 			row[x]= x, rows - 1 - y
# 		end
# 	end
# 	#map.each {|x| print x; puts ""}
# end
def action
	puts "Your current co-ordinates are #{$player[:location]}."
	puts "\nWill you 1) move? or 2) look around? or 3) quit?"
	case gets.chomp
	when "1"
		puts "Which direction will you move?"
		move(gets.chomp)
	when "2"
		look_around
	when "3"
		abort("You have quit")
	end
end

def move(direction)
	start_coords = $player[:location]
	destination = []
	case direction.downcase
	when "n", "north"
		direction = "North"
		destination = [start_coords[0]+1, start_coords[1]]
	when "e", "east"
		direction = "East"
		destination = [start_coords[0], start_coords[1]+1]
	when "s", "south"
		direction = "South"
		destination = [start_coords[0]-1, start_coords[1]]
	when "w", "west"
		direction = "West"
		destination = [start_coords[0], start_coords[1]-1]
	end
	$player[:location] = destination if ($new_map.keys.include?(destination) && $new_map[destination][:traversable])
	if $player[:location] !=  destination
		puts "You cannot go #{direction}."
	else
		puts "You moved 1 space #{direction}. Your co-ordinates are now #{$player[:location]}."
	end
	look_around
	action
end

def look_around
	if $items.keys.include?($player[:location])
		puts "There is a #{$items[$player[:location]][:type]} on the floor in front of you."
		gets
	elsif $monsters.keys.include?($player[:location])
		puts "There is a terrifying #{$monsters[$player[:location]][:type]} in front of you!"
		gets
	else
		puts "There is nothing here."
	end
	action
end