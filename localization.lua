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

EMOTEBUTTONS_EMOTEMANAGER = "Emote Manager"
EMOTEBUTTONS_SUBMITBUTTON = "Submit"
EMOTEBUTTONS_CANCELBUTTON = "Cancel"

EMOTEBUTTONS_DECKMANAGER = "Deck Manager"
EMOTEBUTTONS_ADD = "Add"
EMOTEBUTTONS_DELETE = "Delete"


EMOTEBUTTONS_SETICON = "Set Icon"
EMOTEBUTTONS_SETEMOTE = "Set Emote"
EMOTEBUTTONS_SETCOMMAND = "Set Command"
EMOTEBUTTONS_SETDECK = "Set Deck"
EMOTEBUTTONS_SETLABEL = "Tooltip/Icon"
EMOTEBUTTONS_NEWDECK = "New Deck"

EMOTEBUTTONS_TEST = "TEST"

EMOTEBUTTONS_DECKBUILDER = "Deck Builder"
EMOTEBUTTONS_DELETEBUTTON = "Delete Button"
EMOTEBUTTONS_ADDDECK = "Add Deck"
EMOTEBUTTONS_DELETEDECK = "Delete Deck"

EMOTEBUTTONS_ADVANCEDCONFIG = "Advanced Config"
EMOTEBUTTONS_NEWPROFILE = "New Profile"

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
		{action="Deck 1", type=EBACTTYPE_DECK, tooltip="Flattering emotes",image="Ability_CheapShot"},
		{action="BECKON", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="/played", type=EBACTTYPE_SLASHCMD,tooltip="/played",image="Ability_CheapShot"},
		{action="Deck 2", type=EBACTTYPE_DECK,tooltip="Nice emotes",image="Ability_CheapShot"},
		{action="Deck 3", type=EBACTTYPE_DECK,tooltip="Improper behaviour",image="Ability_CheapShot"},
		{action="/cry", type=EBACTTYPE_SLASHCMD,tooltip="Cry",image="Ability_CheapShot"},
		{action="/bye",type=EBACTTYPE_SLASHCMD,tooltip="Farewell",image="Ability_CheapShot"},
		{action="Deck 4", type=EBACTTYPE_DECK,tooltip="Other functions",image="Ability_CheapShot"} },
	["Deck 1"] = { {action="ABSENT", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="AMAZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ANGRY", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="APOLOGIZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="APPLAUD", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ARM", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ATTACKMYTARGET", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"} },
	["Deck 2"] = { {action="ABSENT", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="AMAZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ANGRY", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="APOLOGIZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="APPLAUD", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ARM", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ATTACKMYTARGET", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"} },
	["Deck 3"] = { {action="ABSENT", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="AMAZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ANGRY", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="APOLOGIZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="APPLAUD", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ARM", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ATTACKMYTARGET", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"} },
	["Deck 4"] = { {action="ABSENT", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="AMAZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ANGRY", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="APOLOGIZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="APPLAUD", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ARM", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"},
		{action="ATTACKMYTARGET", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Ability_CheapShot"} },
}

EMOTEBUTTONS_ST = {
	["Main"] = {
		{action="Deck 1", type=EBACTTYPE_DECK, tooltip="Flattering emotes",image="Spell_Frost_Stun"},
		{action="BECKON", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="/played", type=EBACTTYPE_SLASHCMD,tooltip="/played",image="Spell_Frost_Stun"},
		{action="Deck 2", type=EBACTTYPE_DECK,tooltip="Nice emotes",image="Spell_Frost_Stun"},
		{action="Deck 3", type=EBACTTYPE_DECK,tooltip="Improper behaviour",image="Spell_Frost_Stun"},
		{action="/cry", type=EBACTTYPE_SLASHCMD,tooltip="Cry",image="Spell_Frost_Stun"},
		{action="/bye",type=EBACTTYPE_SLASHCMD,tooltip="Farewell",image="Spell_Frost_Stun"},
		{action="Deck 4", type=EBACTTYPE_DECK,tooltip="Other functions",image="Spell_Frost_Stun"} },
	["Deck 1"] = { {action="ABSENT", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="AMAZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ANGRY", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="APOLOGIZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="APPLAUD", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ARM", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ATTACKMYTARGET", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"} },
	["Deck 2"] = { {action="ABSENT", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="AMAZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ANGRY", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="APOLOGIZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="APPLAUD", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ARM", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ATTACKMYTARGET", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"} },
	["Deck 3"] = { {action="ABSENT", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="AMAZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ANGRY", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="APOLOGIZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="APPLAUD", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ARM", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ATTACKMYTARGET", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"} },
	["Deck 4"] = { {action="ABSENT", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="AGREE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="AMAZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ANGRY", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="APOLOGIZE", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="APPLAUD", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ARM", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"},
		{action="ATTACKMYTARGET", type=EBACTTYPE_EMOTE,tooltip="not Agree",image="Spell_Frost_Stun"} },
}

EMOTEBUTTONS_PROFILES = {
	{Name="Default", Decks=EMOTEBUTTONS_SE},
	{Name="Test", Decks=EMOTEBUTTONS_ST}
}