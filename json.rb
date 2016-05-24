require 'json'

a = {
  "#I001": {
    "location": [
      1,
      3
    ],
    "data": {
      "type": "Potion"
    }
  },
    "#I002": {
    "location": [
      3,
      1
    ],
    "data": {
      "type": "Map"
    }
  }
}


hash = JSON.parse(a.to_json)
print hash

print JSON.generate(hash)