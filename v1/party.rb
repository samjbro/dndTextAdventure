module Party
  #The player chooses whether to import a new party, or create a new one
  def Party.partyImporter
    confirm = Rules.userInput("Hail adventurer! Would you like to import a party?\n==>")
    if confirm == true #consider making these separate methods
      Party.importParty
    elsif confirm == false
      Party.createParty
    else Party.partyImporter
    end
  end

  def Party.importParty
    puts "What is the name of the saved party you wish to import?\nAvailable saves:"
    savesArr = Dir.entries("savedChars").reject {|f| File.directory? f}
    savesArr.each_with_index {|f, index| puts "#{index+1}) #{f}"} #Put "No saved games" if none
    chosenSave = Rules.userInput
    if chosenSave.to_i.to_s == chosenSave
      chosenSave = savesArr[chosenSave.to_i - 1]
    end
    savedChar = "savedChars/" + chosenSave# + ".rb"
    if File.file?(savedChar)
      $party = YAML.load(File.read(savedChar))
    else 
      puts "Save file does not exist.\n"
      Rules.userInput
      return Party.importParty
    end
    Rules.userInput("You have loaded saved party: #{chosenSave}")
  end

  def Party.createParty
  saveName = Rules.userInput("What would you like to call your new party?\n==>")
  #give party 'saveName' as a party name attribute?
  (Rules.userInput("How many will be in your party?\n==>").to_i).times {|x| Character.createPC(saveName); Actions.greeting($party[x]) } until $party.length >0 #confusingly worded, change the 'until' part
  fileName = "savedChars/" + saveName# + ".rb"
  File.open(fileName, 'w+') {|f| f.write(YAML.dump($party)) }
  end
  
end