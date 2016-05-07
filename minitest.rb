require 'json'
$races = File.read("gameData/races.json")
$races = JSON.parse($races, :symbolize_names => true)
p $races.values[0]
thing = $races.values_at($races[1])
p thing
selection = 5
 playerRace = $races.select{|race, key| key[:num] == selection}
 p playerRace