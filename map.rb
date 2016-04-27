require 'rubygems'
require 'json'
require 'ostruct'

json = File.read('input.json')
obj = JSON.parse(json)


obj["locations"].each do |loc| 

	#loc["env"] = "forest"
end
#print obj["locations"]["00"]
File.open("input.json","a") do |f|
  #f.write(obj.to_json)
end


def make_map()


end