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
  when "saveData"
    puts "The current save file is: #{$saves}"
    userInput
  else
      input
  end
end

def importParty
  puts "What is the name of the saved party you wish to import?\nAvailable saves:"
  savesArr = Dir.entries("savedChars").reject {|f| File.directory? f}
  savesArr.each_with_index {|f, index| puts "#{index+1}) #{f}"} #Put "No saved games" if none
  chosenSave = userInput
  if chosenSave.to_i.to_s == chosenSave
    chosenSave = savesArr[chosenSave.to_i - 1]
  end
  savedChar = "savedChars/" + chosenSave# + ".rb"
  if File.file?(savedChar)
    $party = YAML.load(File.read(savedChar))
  else 
    puts "Save file does not exist.\n"
    userInput
    return importParty
  end
  userInput("You have loaded saved party: #{chosenSave}")
end

def createParty
  saveName = userInput("What would you like to call your new party?\n==>")
  #give party 'saveName' as a party name attribute?
  (userInput("How many will be in your party?\n==>").to_i).times {|x| createPlayer(x+1); $party[x].greeting } until $party.length >0 #confusingly worded, change the 'until' part
  fileName = "savedChars/" + saveName# + ".rb"
  File.open(fileName, 'w+') {|f| f.write(YAML.dump($party)) }
end