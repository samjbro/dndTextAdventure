require 'yaml'
require 'json'

def createMap(rows,cols)
	map = Array.new(rows){Array.new(cols)}
	map.each_with_index do |row, y|
		
		row.each_with_index do |tile, x|
			p tile
			row[x]= x, cols - 1 - y
		end
	end
	map.each {|x| print x; puts ""}
end

createMap(3,3)
createMap(9,10)


