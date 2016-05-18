require_relative 'minitest'

# puts "How many rows does your map have?"
# rows = gets.chomp.to_i
# puts "How many columns does your map have?"
# cols = gets.chomp.to_i

$new_map = create_map(2,2)
$player = {:name => "Sam", :location => [0,0]}
$items = {[1,1]=>{:type => "Potion", :location => [1,1]}}
$monsters = {[0,1]=>{:type => "Basilisk", :location => [0,1]}}


action

#MOVE
# puts "Your current position is #{$player[:location]}."
# puts "Which way do you want to go?"
# move(gets.chomp)

#LOOK AROUND
#look_around



#TARGET CO-ORDINATES
# puts "What co-ordinates would you like to examine?"
# coords = gets.chomp.split(",").map(&:to_i)


#CHANGE TERRAIN TYPE
# puts "What type of terrain should #{coords} be?"
# terr = gets.chomp
# $new_map[coords]["terrain"] = terr


