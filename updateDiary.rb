=begin
	
Sunday 24/04/16:

	GOALS: 
		dynamically create "player" instance var to allow for multiple player creation
			- using instance_variable_set(name, value)
		create a way of quitting the game at any time
		creat a way of viewing a player's stats at any time

	ACHIEVED:
		new players are .pushed to a "party" array class variable within Game
		moved 'greeting' method from Game class to Player class
		all 'gets' have been replaced by the 'userInput' method (except those within the userInput method itself)
		typing "quit" at any time will exit the program
		user is prompted for confirmation after typing 'quit' - 'y' or 'yes' will abort with message, anything else will continue with message
		formatted player name at definition
		at start of program, user names save file, the Game object is then .pushed to a $saves array
		typing 'status' at any time will allow user to check status of each player
		typing 'save' at any time will... not save or anything, it will just give the saveName of the current game


Monday 25/04/16:

	GOALS:
		Player stats should be influenced by fightClass and race
		Add an adjective form of each race for use in certain phrasing (e.g. dwarven for dwarf, elven for elf)
		Add languages to races
		Add multiple players to combat round
		Determine turn order by an initiative roll
		Randomise the monster's target, and subtract HP from the appropriate party member
		If a party member's health is brought below 1, they are KO'd; if all party members are KO'd, it is GAME OVER
		Consider giving all classes access to game data by passing them the save name. for now can target last object in $saves
	ACHIEVED:
		userInput now camelcases multi-word commands
		Races now have attributes - name, adjective form of name, language
		Race and fightClass selection are now formatted and numbered
		input now treats hyphenated words as two distinct words (e.g. "Half-Elf" is treated as "Half Elf")
		Player status readout is now centred

Tuesday 26/04/16

	ACHIEVED:
		Users may now save and load parties to/from the 'savedChars' sub-directory


=end