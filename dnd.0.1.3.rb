=begin
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
=end