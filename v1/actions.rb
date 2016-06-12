module Actions
#Greets the character
    def Actions.greeting(character)
      puts "Greetings, #{character.name} the #{character.race[:adj]} #{character.fightClass[:name]}!"
      Rules.userInput("")
    end
    #Describe a PC's 'attack' action
    def Actions.chooseAttack(character, enemy)
    	
    	p self
      	Actions.attack(attack)
    end
    def Actions.attack(character, enemy)
    	puts "#{character.name} knows the following attacks:"
    	character.attacks.each_with_index{|atk, i| puts "#{i+1}) #{atk.unCamelize.capitalize}"}
    	attack = Rules.userInput
      	attack = character.attacks[attack.to_i - 1] if attack.to_i.to_s == attack
      	#THIS IS WHERE YOU LEFT OFF. NEED TO REFACTOR SO THAT THE ATTACKS ARE PULLED FROM ATTACKS.JSON RATHER THAN AN INSTANCE VARIABLE
      if character.attacks.include? attack
        damage = 0
        $attacks[attack.to_sym].each_pair {|die,x| damage += Rules.d(die.to_s.tr('d','').to_i ,x)}
        
        enemy.stats[:hp] -= damage
        message = "#{character.name} rolled #{damage}! The #{enemy.type} takes #{damage} damage from #{character.name}\'s #{attack.capitalize}!"
        case damage
          when 1
           puts message + " Critical Fail..."
          when 20
            puts message + " Critical Hit!!!"
          else
            puts message              
        end
      else puts "#{character.name} doesn't know how to attack with their #{attack.downcase}..."
      end
      #gets
      puts "The #{enemy.type} now has #{enemy.stats[:hp]} HP!"    
    end
    #Describe an NPC's 'attack' action
    def Actions.npcAttack(player)
      moveList = self.stats[:attacks]
      attack = moveList.keys[rand(moveList.length)]
      puts "\nThe #{type} used #{attack}!!"
      puts "#{player.name} took #{moveList[attack]} pts of damage..."
      player.hp -= moveList[attack]
      puts "#{player.name} now has #{player.hp} HP"
      Rules.userInput
    end
  #Describe the character's 'flee' action
    def Actions.flee(character, enemy)
      puts "CHEEP CHEEP CHEEP CHEEP CHEEP"
    end
    def Actions.checkInventory(character, enemy)
      puts "You currently have the following items in your inventory:"
      puts character.inventory
    end
  #Suicide results in a self-inflicted Game Over
    def Actions.suicide(character, enemy)
      character.hp -= 100000
    end
  #character death method
    def Actions.death(character)
      puts "#{character.name} has died. Game Over."
    end
    #gives player access to a new action by adding it to the actions array
    def Actions.learn(character, action)

    end

end