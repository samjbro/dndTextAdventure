---
- !ruby/object:Player
  name: Sam
  playerNo: 1
  race:
    :name: Half-Elf
    :adj: Half-Elven
    :lang: Common
  fightClass:
    :name: Paladin
  level: 1
  hp: 78
  actions:
  - attack
  - flee
  - inventory
  - suicide
  inventory:
  - Basic Potion
  - Basic Rations
  attacks:
    :thrust:
      :d8: 5
      :d10: 1
    :swipe:
      :d1: 66
- !ruby/object:Player
  name: Terry
  playerNo: 2
  race:
    :name: Tiefling
    :adj: Tiefling
    :lang: Common
  fightClass:
    :name: Gunslinger
  level: 1
  hp: 69
  actions:
  - attack
  - flee
  - inventory
  - suicide
  inventory:
  - Basic Potion
  - Basic Rations
  attacks:
    :thrust:
      :d8: 5
      :d10: 1
    :swipe:
      :d1: 66
