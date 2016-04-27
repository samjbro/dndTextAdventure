=begin
---------------	
Sunday 24/04/16
		new players are .pushed to a "party" array class variable within Game
		moved 'greeting' method from Game class to Player class
		all 'gets' have been replaced by the 'userInput' method (except those within the userInput method itself)
		typing "quit" at any time will exit the program
		user is prompted for confirmation after typing 'quit' - 'y' or 'yes' will abort with message, anything else will continue with message
		formatted player name at definition
		at start of program, user names save file, the Game object is then .pushed to a $saves array
		typing 'status' at any time will allow user to check status of each player
		typing 'save' at any time will... not save or anything, it will just give the saveName of the current game
---------------
Monday 25/04/16
		userInput now camelcases multi-word commands
		Races now have attributes - name, adjective form of name, language
		Race and fightClass selection are now formatted and numbered
		input now treats hyphenated words as two distinct words (e.g. "Half-Elf" is treated as "Half Elf")
		Player status readout is now centred
----------------
Tuesday 26/04/16
		all files now stored on GitHub
		Users may now save and load parties to/from the 'savedChars' sub-directory
------------------
Wednesday 27/04/16
		Some general clean-up of code
		races, fightClasses, monsterManual are now stored in external JSON files






GOALS:
		Determine combat turn order by an initiative roll
		If a party member's health is brought below 1, they are KO'd; if all party members are KO'd, it is GAME OVER
=end