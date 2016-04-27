require 'rubygems'
require 'json'
require 'ostruct'

json = File.read('input.json')
obj = JSON.parse(json)
obj["locations"].each do |key, val| #using .each on a hash expects |key, val| rather than just |item| like on an array
	val["env"] = "forest" #val is the key {"env"=>""}, so val["env"] targets the vale you want
end

#This works, but adds it to the end of the existing data - subsequent attempts to load the json file will therefore fail
File.open("input.json","a") do |f|
  f.write("\n#{obj.to_json}") #This now adds the data to a new line - just makes it easier to read, doesn't fix the problem
end


def make_map()


end

