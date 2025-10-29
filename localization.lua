-- Last update : 29/10/2006

-- <<--
--	Global info
-- -->>

EMOTEBUTTONS_NAME		= "EmoteButtons";
EMOTEBUTTONS_VERSION		= "1.0";

EMOTEBUTTONS_NAMEVERSION	= EMOTEBUTTONS_NAME.." v"..EMOTEBUTTONS_VERSION;

-- Version : English
-- Last update : 29/10/2006

-- <<--
--
-- -->>
EMOTEBUTTONS_ROTATION		= "Rotation";
EMOTEBUTTONS_SIZE		= "Size";
EMOTEBUTTONS_INIT_TEXT		= EMOTEBUTTONS_NAMEVERSION.." loaded";

EMOTEBUTTONS_SETTINGSWARN	= "|n|n|cff22ff22".."Shift-click to change this button!";

EMOTEBUTTONS_BUTTON		= "Button";

EMOTEBUTTONS_MAINHELP		= "|cFFFFFFFF"..EMOTEBUTTONS_NAME.."|n|n|r".."Right-click and drag to move|nShift-click a button for setup";

EMOTEBUTTONS_ERROR		= "Error";

EMOTEBUTTONS_SETACTION		= "Set Action";
EMOTEBUTTONS_SETTOOLTIP		= "Set Label";

EMOTEBUTTONS_OPENDECK		= "Open Deck";
EMOTEBUTTONS_SLASHCOMMAND	= "Do Emote";

EMOTEBUTTONS_CHANGELABEL	= "Change label to:";
EMOTEBUTTONS_CHANGECOMMAND	= "Change action command to:";
EMOTEBUTTONS_CHANGEEMOTE	= "Change emote to:";
EMOTEBUTTONS_CHANGEDECK	= "Change deck action to:";

EMOTEBUTTONS_SETICON = "Set Icon"
EMOTEBUTTONS_SETEMOTE = "Set Emote"
EMOTEBUTTONS_SETCOMMAND = "Set Command"
EMOTEBUTTONS_SETDECK = "Set Deck"
EMOTEBUTTONS_SETLABEL = "Label/Tooltip:"

DeckCFG_POPUP_TEXT = "Label/Tooltip:";
DeckCFG_CHOOSE_ICON = "Choose an Icon:"

EMOTEBUTTONS_OPENDECK1		= EMOTEBUTTONS_OPENDECK.." 1";
EMOTEBUTTONS_OPENDECK2		= EMOTEBUTTONS_OPENDECK.." 2";
EMOTEBUTTONS_OPENDECK3		= EMOTEBUTTONS_OPENDECK.." 3";
EMOTEBUTTONS_OPENDECK4		= EMOTEBUTTONS_OPENDECK.." 4";
EMOTEBUTTONS_OPENDECK5		= EMOTEBUTTONS_OPENDECK.." 5";
EMOTEBUTTONS_OPENDECK6		= EMOTEBUTTONS_OPENDECK.." 6";
EMOTEBUTTONS_OPENDECK7		= EMOTEBUTTONS_OPENDECK.." 7";
EMOTEBUTTONS_OPENDECK8		= EMOTEBUTTONS_OPENDECK.." 8";

EBACTTYPE_DECK = 0
EBACTTYPE_EMOTE = 1
EBACTTYPE_SLASHCMD = 2

--type=EBACTTYPE_DECK,
--type=EBACTTYPE_EMOTE,
--type=EBACTTYPE_SLASHCMD,

EMOTEBUTTONS_SE = {
	["Main"] = {
		{action="Deck 1", type=EBACTTYPE_DECK, tooltip="Flattering emotes"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="Agree"},
		{action="/played", type=EBACTTYPE_SLASHCMD,tooltip="/played"},
		{action="Deck 2", type=EBACTTYPE_DECK,tooltip="Nice emotes"},
		{action="Deck 3", type=EBACTTYPE_DECK,tooltip="Improper behaviour"},
		{action="/cry", type=EBACTTYPE_SLASHCMD,tooltip="Cry"},
		{action="/bye",type=EBACTTYPE_SLASHCMD,tooltip="Farewell"},
		{action="Deck 8", type=EBACTTYPE_DECK,tooltip="Other functions"} },
	["Deck 1"] = { {action="/played",type=EBACTTYPE_SLASHCMD, tooltip="/played"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="Agree"},
		{action="/bow", type=EBACTTYPE_SLASHCMD,tooltip="Bow"},
		{action="/whistle",type=EBACTTYPE_SLASHCMD, tooltip="Whistle"},
		{action="Deck 9", type=EBACTTYPE_DECK,tooltip="Deck 9"}},
	["Deck 2"] = { {action="/dance",type=EBACTTYPE_EMOTE, tooltip="Dance"},
		{action="/salute", type=EBACTTYPE_EMOTE,tooltip="Salute"},
		{action="/kiss",type=EBACTTYPE_EMOTE,tooltip="Kiss"},
		{action="/wave", type=EBACTTYPE_EMOTE,tooltip="Wave"},
		{action="/train",type=EBACTTYPE_EMOTE, tooltip="Make train voices"},
		{action="/kiss", type=EBACTTYPE_EMOTE,tooltip=" down"},
		{action="/sit", type=EBACTTYPE_EMOTE,tooltip="TEST"},
		{action="Deck 9",type=EBACTTYPE_DECK,tooltip="Deck 9"} },
	["Deck 3"] = { {action="/angry", type=EBACTTYPE_EMOTE,tooltip="Raise your fist"},
		{action="/shoo", type=EBACTTYPE_EMOTE,tooltip="Shoo away"},
		{action="/rude",type=EBACTTYPE_EMOTE, tooltip="Make a rude gesture"},
		{action="/doom", type=EBACTTYPE_EMOTE,tooltip="Threaten"} },
	["Deck 4"] = { {action="/cheer", type=EBACTTYPE_EMOTE,tooltip="Cheer"},
		{action="/charge",type=EBACTTYPE_EMOTE,tooltip="Charge"},
		{action="/congratulate",type=EBACTTYPE_EMOTE, tooltip="Congratulate"},
		{action="/nod", type=EBACTTYPE_EMOTE,tooltip="Nod"},
		{action="/flee", type=EBACTTYPE_EMOTE,tooltip="Tell them to flee"},
		{action="/kiss", type=EBACTTYPE_EMOTE,tooltip=" down"},
		{action="/sit", type=EBACTTYPE_EMOTE,tooltip="TEST"},
		{action="/followme", type=EBACTTYPE_EMOTE,tooltip="Tell them to follow you"} },
	["Deck 5"] = { {action="/flex",type=EBACTTYPE_EMOTE, tooltip="Flex your muscles"},
		{action="/curious", type=EBACTTYPE_EMOTE,tooltip="Look curious"},
		{action="/cuddle",type=EBACTTYPE_EMOTE, tooltip="Cuddle"},
		{action="/drink", type=EBACTTYPE_EMOTE,tooltip="Drink"},
		{action="/eat", type=EBACTTYPE_EMOTE,tooltip="Eat"},
		{action="/kiss", type=EBACTTYPE_EMOTE,tooltip=" down"},
		{action="/sit", type=EBACTTYPE_EMOTE,tooltip="TEST"},
		{action="/calm", type=EBACTTYPE_EMOTE,tooltip="Remain calm"} },
	["Deck 6"] = { {action="/burp", type=EBACTTYPE_EMOTE,tooltip="Burp"},
		{action="/bounce", type=EBACTTYPE_EMOTE,tooltip="Bounce"},
		{action="/drool", type=EBACTTYPE_EMOTE,tooltip="Drool"},
		{action="/panic", type=EBACTTYPE_EMOTE,tooltip="Panic"},
		{action="/frown",type=EBACTTYPE_EMOTE, tooltip="Frown"},
		{action="/kiss", type=EBACTTYPE_EMOTE,tooltip=" down"},
		{action="/sit",type=EBACTTYPE_EMOTE, tooltip="TEST"},
		{action="/tired", type=EBACTTYPE_EMOTE,tooltip="Look tired"} },
	["Deck 7"] = { {action="/ginfo", EBACTTYPE_SLASHCMD,tooltip="Show information about your guild"},
		{action="/follow",EBACTTYPE_SLASHCMD, tooltip="Follow your target"},
		{action="/inspect", EBACTTYPE_SLASHCMD,tooltip="Inspect your target"},
		{action="/friend", EBACTTYPE_SLASHCMD,tooltip="Add your target to your friendlist"},
		{action="/ignore", EBACTTYPE_SLASHCMD,tooltip="Ignore target"},
		{action="/kiss", EBACTTYPE_SLASHCMD,tooltip=" down"},
		{action="/sit",EBACTTYPE_SLASHCMD, tooltip="TEST"},
		{action="/unignore",EBACTTYPE_SLASHCMD, tooltip="Remove target from your ignore list"} },
	["Deck 8"] = { {action="/played",type=EBACTTYPE_SLASHCMD, tooltip="/played"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="Agree"},
		{action="/who", type=EBACTTYPE_SLASHCMD,tooltip="Do a who search"},
		{action="/macro", type=EBACTTYPE_SLASHCMD,tooltip="Open macro UI"},
		{action="/console reloadui",type=EBACTTYPE_SLASHCMD, tooltip="Reload the User Interface"},
		{action="/kiss", type=EBACTTYPE_EMOTE,tooltip=" down"},
		{action="/sit", type=EBACTTYPE_EMOTE,tooltip="TEST"},
		{action="Deck 9", type=EBACTTYPE_DECK,tooltip="Deck 9"} },
	["Deck 9"] = { {action="/played",type=EBACTTYPE_SLASHCMD, tooltip="/played"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="Agree"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="Do search"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="Ocro UI"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="Rrface"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip=" n"},
		{action="AGREE",type=EBACTTYPE_EMOTE, tooltip="TT"},
		{action="Deck 10", type=EBACTTYPE_DECK,tooltip="Deck 10"} },
	["Deck 10"] = { {action="/played", type=EBACTTYPE_SLASHCMD,tooltip="Show played time"},
		{action="/raidinfo", type=EBACTTYPE_SLASHCMD,tooltip="Show raid info"},
		{action="/who", type=EBACTTYPE_SLASHCMD,tooltip="Do a who search"},
		{action="/macro", type=EBACTTYPE_SLASHCMD,tooltip="Open macro UI"},
		{action="/console reloadui",type=EBACTTYPE_SLASHCMD, tooltip="Reload the User Interface"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip=" down"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="TEST"},
		{action="Deck 9", type=EBACTTYPE_DECK,tooltip="Deck 9"} }		
}
