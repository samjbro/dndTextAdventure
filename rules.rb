class String
  def camelize
    str = self.unCamelize.downcase.tr('-',' ').split(' ').map(&:capitalize).join
    str[0] = str[0].downcase
    str
  end
  def unCamelize
    self.split(/(?=[A-Z])/).map(&:capitalize).join(' ').tr('  ', ' ')
  end
end

module Rules
  #Define the game's Rules
  def Rules.d(sides, rolls)
    damage = 0
    rolls.times do |i|
      damage += (rand(sides)+1)
    end
    damage
  end
    #Is called any time the game requires user input - this allows for universal commands such as 'quit', 'save' and 'status'
  def Rules.userInput(text="==> ") #redo this so that there are cases for "y, yes" and "n, no" that return true and false
    print text
    input = gets.chomp
    unless input == ""
      input = input.camelize
    end
    case input
    when "y", "yes"
      true
    when "n", "no"
      false

    when "quit"
      print "Are you sure you want to quit?\n==> "
      quitConfirm = gets.chomp.downcase
      case quitConfirm
      when "y", "yes", "quit"
        abort("You have quit the game :(") 
      else
        userInput("You have not quit the game :)")
      end

    when "status" #allow going instantly to a char's status by typing "status charName"
      puts "Whose status would you like to check?"
      $party.each_with_index{|x, index| puts "#{index+1}) #{x.name}"}
      selection = userInput
      if selection.to_i.to_s == selection
        choice = $party[selection.to_i - 1]
      else
        choice = selection.downcase.capitalize
        choice = $party.find {|player| player.name == choice}
      end
      choice ?  choice.status : (puts "That character is not in your party...")
      userInput

    when "save"
      puts "The current save file is: #{$saves}"
      userInput
    
    else
        input
    end
  end
end