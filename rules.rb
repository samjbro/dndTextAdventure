#Define the game's Rules
def d(sides, rolls)
  damage = 0
  rolls.times do |i|
    damage += (rand(sides)+1)
  end
  damage
end
  #Is called any time the game requires user input - this allows for universal commands such as 'quit', 'save' and 'status'
def userInput(text="==> ") #redo this so that there are cases for "y, yes" and "n, no" that return true and false
  print text
  input = gets.chomp.downcase
  unless input == ""
    input = input.downcase.tr('-',' ').split(' ').map(&:capitalize).join
    input[0] = input[0].downcase
  end
  case input
  when "y", "yes"
    true
  when "n", "no"
    false
  when "quit"
    print "Are you sure you want to quit?\n==> "
    quitConfirm = gets.chomp.downcase
    return userInput("You have not quit the game :)") unless (quitConfirm == "y" || quitConfirm == "yes" || quitConfirm == "quit")   
    abort("You have quit the game :(") 
  when "status" #allow going instantly to a char's status by typing "status charName"
    puts "Whose status would you like to check?"
    $party.each{|x| puts x.name}
    choice = userInput.downcase.capitalize
    $party.find {|player| player.name == choice}.status
    userInput(text)
  when "saveData"
    puts "The current save file is: #{$saves}"
    userInput
  else
      input
  end
end
