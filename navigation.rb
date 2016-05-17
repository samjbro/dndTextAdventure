module Navigation
  class Map
    def initialize(x=3, y=3)
      tiles = x*y
      layout = Arr.new(x){ Array.new(y, Tile.new)}
    end
  end
  class Tile
    def initialize(type=field)

    end
  end
  def Navigation.town
    puts "Your party is currently in a town. Do you want them to leave?\n1)Yes or 2)No"
    input = Rules.userInput
    case input
    when "1", true
      Navigation.forest
    else
      Navigation.town
    end
  end
  def Navigation.forest
    answer = Rules.userInput("Your party is standing at the entrance to a dark forest.\nDo they 1)Enter, or 2)Return to the town?==>")
    case answer
      when "enter", "e", "1", true
        Battle.hostileSingle
      when "return", "r", "2", false
        Navigation.town
      else
        Navigation.forest
    end
  end
end