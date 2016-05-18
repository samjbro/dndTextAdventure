require 'yaml'
require 'json'

def createMap(rows,cols)
	map = Array.new(rows){Array.new(cols)}
	map.each_with_index do |row, y|
		
		row.each_with_index do |tile, x|
			row[x]= x, rows-1-y
		end
	end
	map.each {|x| print x; puts ""}
end
puts "How wide is your map?"
width = gets.chomp.to_i
puts "How long is your map?"
length = gets.chomp.to_i
createMap(width,length)


