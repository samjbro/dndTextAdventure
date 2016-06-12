module Battle

  	def Battle.hostileSingle
  		enemy = Monster.new
	    puts "Your party is attacked by an angry #{enemy.type}!!" # a(n) depending on vowel
	    puts "The #{enemy.type} has #{enemy.stats[:hp]} HP.".center(60)
	    $party.each{|member| puts "#{member.name} has #{member.hp} HP.".center(60)}
	    Rules.userInput
	    #Roll for initiative
	    $party.each {|member| instance_variable_set("@player#{$party.index(member)+1}", member)} #CHANGE THIS
	    

	    until @player1.hp < 1 || enemy.stats[:hp] < 1 # initiative roll
	      for i in 0..($party.length-1)
	        $party[i].actions(enemy)
	        break if enemy.stats[:hp] < 1
	      end
	      break if @player1.hp < 1 || enemy.stats[:hp] < 1
	      enemy.attack($party[rand($party.length)])
	    end

	    if (@player1.hp < 1)
	     Actions.death(@player1)
	    else puts "You have killed the #{enemy.type}! Well done!"
	      puts "You gain #{rand(10)+1} XP!"
	      puts "You loot 1x #{enemy.stats[:loot]} from the dead #{enemy.type}!!"
	      @player1.inventory.push(enemy.stats[:loot])
	      puts "It was added to your inventory."
	      Rules.userInput
	    end
  	end
  	def Battle.victory

  	end
end