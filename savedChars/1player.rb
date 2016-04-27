---
- !ruby/object:Player
  name: Sam
  playerNo: 1
  race:
    :name: Human
    :adj: Human
    :lang: Common
  fightClass:
    :name: Bard
  level: 1
  hp: 68
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
