require 'json'

json = File.read('input.json')
obj = JSON.parse(json)

$envs = ["field", "marsh", "forest"]

def make_map()
	$envs.sample
	
end

# Another way of iterating over a hash - you can do each_value as well

#obj.each_key { |location| 
	#obj[locations]["#{location}"]["env"] = make_map()
#}


obj["locations"].each do |key, val| #using .each on a hash expects |key, val| rather than just |item| like on an array
	val["env"] = make_map() #val is the key {"env"=>""}, so val["env"] targets the vale you want
end

#This works, but adds it to the end of the existing data - subsequent attempts to load the json file will therefore fail

# Changed the "a" to "w"
File.open("input.json","w") do |f|
  f.write("\n#{obj.to_json}") #This now adds the data to a new line - just makes it easier to read, doesn't fix the problem
end



