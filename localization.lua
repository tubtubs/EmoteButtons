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

EMOTEBUTTONS_MT = {
	["Main"] = {
		{action="/emotebuttons deckbuilder", type=EBACTTYPE_SLASHCMD, tooltip="Start building!",image="Ability_Rogue_Disguise"}
	}
}

EMOTEBUTTONS_T ={
["Combat"]={
{action="Taunts", type=0, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="Mercy", type=0, tooltip="", image="INV_Misc_Bandage_Netherweave_Heavy"},
{action="Orders", type=0, tooltip="", image="INV_Misc_Cape_Naxxramas_03"},
{action="Warnings", type=0, tooltip="", image="vas_factionchange"},
{action="Signals", type=0, tooltip="", image="INV_Rod_Titanium"},
{action="CHARGE", type=1, tooltip="", image="INV_Shoulder_73"},
{action="BLEED", type=1, tooltip="", image="Trade_Fishing"},
{action="APOLOGIZE", type=1, tooltip="", image="Spell_Magic_FeatherFall"}
},
["Animations"]={
{action="SIT", type=1, tooltip="", image="Spell_Shadow_SummonSuccubus"},
{action="STAND", type=1, tooltip="", image="INV_Belt_22"},
{action="DANCE", type=1, tooltip="", image="Spell_DeathKnight_EmpowerRuneBlade"},
{action="KNEEL", type=1, tooltip="", image="INV_Misc_Bandage_02"},
{action="LAYDOWN", type=1, tooltip="", image="Spell_Shadow_SummonSuccubus"},
{action="SLEEP", type=1, tooltip="", image="INV_Misc_Bandage_12"},
{action="POINT", type=1, tooltip="", image="INV_Holiday_ToW_SpiceBrownie"},
{action="MOUNTSPECIAL", type=1, tooltip="", image="INV_Misc_Map09"}
},
["Flirt2"]={
{action="SHAKE", type=1, tooltip="", image="INV_Misc_EngGizmos_32"},
{action="SHY", type=1, tooltip="", image="INV_Potion_164"},
{action="CUDDLE", type=1, tooltip="", image="INV_Crystallized_Earth"},
{action="LICK", type=1, tooltip="", image="INV_Inscription_ParchmentVar02"},
{action="PURR", type=1, tooltip="", image="Ability_Warrior_PunishingBlow"},
{action="LOVE", type=1, tooltip="", image="INV_Weapon_Hand_19"},
{action="FLIRT", type=1, tooltip="", image="INV_Holiday_Christmas_Present_02"},
{action="Flirt3", type=0, tooltip="More...", image="INV_Holiday_Thanksgiving_Empty_Cornucopia"}
},
["Misc RP"]={
{action="MAP", type=1, tooltip="", image="INV_Misc_MonsterTail_01"},
{action="PET", type=1, tooltip="", image="INV_Letter_01"},
{action="SEARCH", type=1, tooltip="", image="INV_Potion_117"},
{action="BACKPACK", type=1, tooltip="", image="Achievement_Zone_Sholazar_07"},
{action="FAINT", type=1, tooltip="", image="Achievement_PVP_P_10"},
{action="WORK", type=1, tooltip="", image="INV_Potion_69"},
{action="SING", type=1, tooltip="", image="Spell_Holy_CircleOfRenewal"},
{action="COVEREARS", type=1, tooltip="", image="Ability_Mage_Burnout"}
},
["Bored"]={
{action="BORED", type=1, tooltip="", image="INV_Chest_Wolf"},
{action="FIDGET", type=1, tooltip="", image="INV_Scroll_16"},
{action="TWIDDLE", type=1, tooltip="", image="INV_Chest_Wolf"},
{action="BOUNCE", type=1, tooltip="", image="INV_Mushroom_13"},
{action="TAP", type=1, tooltip="", image="INV_Mace_104"}
},
["Discussion2"]={
{action="MUTTER", type=1, tooltip="", image="INV_Misc_Beer_10"},
{action="OFFER", type=1, tooltip="", image="INV_Misc_Bandana_03"},
{action="PROMISE", type=1, tooltip="", image="vas_factionchange"},
{action="Discussion", type=0, tooltip="Back...", image="INV_Misc_Beer_10"}
},
["Rude"]={
{action="FACEPALM", type=1, tooltip="", image="Ability_Creature_Poison_03"},
{action="SPIT", type=1, tooltip="", image="INV_Misc_Gift_05"},
{action="BLAME", type=1, tooltip="", image="Achievement_PVP_G_06"},
{action="RASP", type=1, tooltip="", image="INV_Sword_123"},
{action="HISS", type=1, tooltip="", image="INV_Drink_22"},
{action="FAIL", type=1, tooltip="", image="INV_Alchemy_Potion_06"},
{action="CRINGE", type=1, tooltip="", image="Trade_Engineering"},
{action="Rude2", type=0, tooltip="More..", image="INV_Misc_Sandbox_SpectralTiger_01"}
},
["I'm Feeling"]={
{action="Happy", type=0, tooltip="", image="Achievement_Halloween_Smiley_01"},
{action="Angry", type=0, tooltip="", image="Achievement_BG_kill_carrier_opposing_flagroom"},
{action="Sad", type=0, tooltip="", image="Inv_Misc_Tournaments_banner_Scourge"},
{action="Surprised", type=0, tooltip="", image="INV_Holiday_Christmas_Present_01"},
{action="Scared", type=0, tooltip="", image="INV_Misc_Fish_27"},
{action="Bored", type=0, tooltip="", image="Spell_Magic_PolymorphRabbit"},
{action="Tired", type=0, tooltip="", image="Spell_Nature_Sleep"},
{action="I'm Feeling 2", type=0, tooltip="More Emotes", image="Ability_Rogue_Disguise"}
},
["Conversation"]={
{action="Discussion", type=0, tooltip="", image="Ability_Hunter_ZenArchery"},
{action="Silly", type=0, tooltip="", image="INV_Fishingpole_06"},
{action="Comfort", type=0, tooltip="", image="Spell_unused2"},
{action="Sus", type=0, tooltip="", image="INV_Chest_Wolf"},
{action="Direction", type=0, tooltip="", image="INV_Potion_99"},
{action="Agree", type=0, tooltip="", image="Spell_Magic_PolymorphRabbit"},
{action="Disagree", type=0, tooltip="", image="Ability_Mount_Wyvern_01"},
{action="Celebrations", type=0, tooltip="", image="INV_Misc_Herb_DreamFoil"}
},
["Boats"]={
{action="/use Darnassian Gondola", type=2, tooltip="", image="INV_HELMET_127"},
{action="/use Thalassian Sampan", type=2, tooltip="", image="INV_Helmet_46"},
{action="/use Theramore Rowboat", type=2, tooltip="", image="INV_Mace_90"}
},
["CMDs"]={
{action="/script ReloadUI()", type=2, tooltip="Reload UI", image="INV_Chest_Mail_05"},
{action="/who", type=2, tooltip="who", image="INV_Bracer_50"},
{action="/dnd I'm busy", type=2, tooltip="DND", image="Achievement_BG_hld4bases_EOS"},
{action="/afk smoke break", type=2, tooltip="Smoke Break", image="INV_Misc_Beer_01"},
{action="/eb deckbuilder", type=2, tooltip="Emote Buttons Options", image="INV_Misc_Food_101_SourCheese"},
{action="/eb options", type=2, tooltip="Emote Buttons Options", image="INV_Staff_55"},
{action="/script ResetInstances()", type=2, tooltip="Reset Instances", image="INV_Misc_Cape_06"}
},
["Flirt3"]={
{action="WINK", type=1, tooltip="", image="INV_Hammer_06"},
{action="HOLDHAND", type=1, tooltip="", image="Spell_Nature_UnleashedRage"},
{action="SCRATCH", type=1, tooltip="", image="INV_Misc_Desecrated_PlateBracer"},
{action="WHISTLE", type=1, tooltip="", image="INV_Misc_Rune_11"},
{action="TICKLE", type=1, tooltip="", image="Ability_Warlock_EverlastingAffliction"},
{action="POKE", type=1, tooltip="", image="INV_Misc_Food_58"},
{action="RUFFLE", type=1, tooltip="", image="INV_Pet_SleepyWilly"},
{action="Flirt4", type=0, tooltip="More...", image="Spell_DeathKnight_FrostFever"}
},
["Taunts2"]={
{action="REGRET", type=1, tooltip="", image="INV_Stone_SharpeningStone_02"},
{action="BRANDISH", type=1, tooltip="", image="INV_Potion_142"},
{action="CHALLENGE", type=1, tooltip="", image="INV_Misc_Food_33"},
{action="SHAKEFIST", type=1, tooltip="", image="Spell_Misc_Drink"},
{action="SHOUT", type=1, tooltip="", image="Ability_Shaman_Lavalash"},
{action="SNARL", type=1, tooltip="", image="Achievement_Boss_GrandMagusTelestra"},
{action="CRACK", type=1, tooltip="", image="Ability_Paladin_BeaconofLight"},
{action="Taunts", type=0, tooltip="Back...", image="INV_Shield_71"}
},
["Mercy"]={
{action="BEG", type=1, tooltip="", image="INV_Elemental_Eternal_Water"},
{action="MERCY", type=1, tooltip="", image="Spell_Frost_SummonWaterElemental"},
{action="GROVEL", type=1, tooltip="", image="INV_Misc_Herb_DreamFoil"},
{action="PLEAD", type=1, tooltip="", image="INV_Drink_06"},
{action="SURRENDER", type=1, tooltip="", image="INV_Stone_04"},
{action="TRUCE", type=1, tooltip="", image="Ability_Warrior_StrengthOfArms"},
{action="SQUEAL", type=1, tooltip="", image="INV_ELEMENTAL_CRYSTAL_EARTH"},
{action="ARM", type=1, tooltip="", image="INV_Inscription_MajorGlyph19"}
},
["Thinking"]={
{action="THINK", type=1, tooltip="", image="INV_Weapon_Rifle_03"},
{action="PUZZLE", type=1, tooltip="", image="Spell_Shaman_MaelstromWeapon"},
{action="PONDER", type=1, tooltip="", image="Achievement_Boss_Harbinger_Skyriss"}
},
["Sad"]={
{action="CRY", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="MOURN", type=1, tooltip="", image="Ability_Druid_Typhoon"},
{action="VIOLIN", type=1, tooltip="", image="INV_Chest_Wolf"},
{action="FROWN", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="GROAN", type=1, tooltip="", image="INV_Boots_Wolf"},
{action="SIGH", type=1, tooltip="", image="vas_factionchange"},
{action="POUT", type=1, tooltip="", image="vas_factionchange"},
{action="SAD", type=1, tooltip="", image="vas_factionchange"}
},
["Thanks"]={
{action="BOW", type=1, tooltip="", image="Spell_Shadow_VampiricAura"},
{action="CURTSEY", type=1, tooltip="", image="Thrown_1H_Harpoon_D_01Silver"},
{action="THANK", type=1, tooltip="", image="INV_Stone_WeightStone_08"},
{action="YW", type=1, tooltip="", image="INV_Weapon_Staff_109"}
},
["Comfort"]={
{action="SOOTHE", type=1, tooltip="", image="Spell_Fire_WindsofWoe"},
{action="COMFORT", type=1, tooltip="", image="INV_Boots_Wolf"},
{action="PAT", type=1, tooltip="", image="Trade_Tailoring"},
{action="ENCOURAGE", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="PULSE", type=1, tooltip="", image="INV_Misc_Cape_Naxxramas_03"}
},
["Agree"]={
{action="AGREE", type=1, tooltip="", image="Spell_Ice_Rune"},
{action="NOD", type=1, tooltip="", image="INV_Misc_Cape_Naxxramas_03"},
{action="RAISE", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"}
},
["Angry"]={
{action="ANGRY", type=1, tooltip="", image="Ability_Warlock_ShadowFlame"},
{action="GLOWER", type=1, tooltip="", image="vas_factionchange"},
{action="REVENGE", type=1, tooltip="", image="INV_Mace_99"},
{action="SCOFF", type=1, tooltip="", image="INV_Sword_Draenei_08"},
{action="SCOLD", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="SCOWL", type=1, tooltip="", image="INV_Shoulder_HaremMatron_D_01"},
{action="CROSSARMS", type=1, tooltip="", image="INV_Belt_83"},
{action="HEADACHE", type=1, tooltip="", image="vas_factionchange"}
},
["Main"]={
{action="I'm Feeling", type=0, tooltip="Emotions", image="Ability_Rogue_Disguise"},
{action="Greetings", type=0, tooltip="", image="Achievement_Reputation_01"},
{action="Small Talk", type=0, tooltip="", image="Temp"},
{action="Conversation", type=0, tooltip="", image="INV_Drink_22"},
{action="Combat", type=0, tooltip="", image="Achievement_Arena_2v2_7"},
{action="RP", type=0, tooltip="", image="Achievement_Zone_Stonetalon_01"},
{action="Spells", type=0, tooltip="", image="INV_Misc_Food_107_Venison"},
{action="CMDs", type=0, tooltip="", image="Ability_Mage_MissileBarrage"}
},
["Warnings"]={
{action="WARN", type=1, tooltip="", image="INV_Egg_08"},
{action="ENEMY", type=1, tooltip="", image="INV_Misc_ArmorKit_31"},
{action="INCOMING", type=1, tooltip="", image="INV_Drink_09"}
},
["LOL"]={
{action="CACKLE", type=1, tooltip="", image="vas_factionchange"},
{action="CHUCKLE", type=1, tooltip="", image="Ability_Shaman_WaterShield"},
{action="GUFFAW", type=1, tooltip="", image="INV_Misc_Powder_Tin"},
{action="ROFL", type=1, tooltip="", image="Spell_Nature_WrathofAir _Totem"},
{action="SNICKER", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="GLOAT", type=1, tooltip="", image="INV_Mushroom_13"},
{action="LAUGH", type=1, tooltip="", image="Spell_Fire_WindsofWoe"},
{action="GIGGLE", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"}
},
["Signals"]={
{action="READY", type=1, tooltip="", image="Spell_Fire_BluePyroblast"},
{action="SNAP", type=1, tooltip="", image="INV_Drink_Waterskin_12"},
{action="SIGNAL", type=1, tooltip="", image="INV_ValentinesCandy"},
{action="OOM", type=1, tooltip="", image="Achievement_Boss_KelidanTheBreaker"}
},
["Happy"]={
{action="HAPPY", type=1, tooltip="", image="INV_Weapon_Glave_01"},
{action="TALKEX", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="SMIRK", type=1, tooltip="", image="Achievement_Boss_Kael'thasSunstrider_01"},
{action="SMILE", type=1, tooltip="", image="Achievement_WorldEvent_Brewmaster"},
{action="GRIN", type=1, tooltip="", image="Ability_Mount_Wyvern_01"}
},
["Sarcastic"]={
{action="ROLLEYES", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="SNORT", type=1, tooltip="", image="Ability_Hunter_ZenArchery"},
{action="GROAN", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"}
},
["Disagree"]={
{action="NO", type=1, tooltip="", image="Spell_Shadow_VampiricAura"},
{action="OBJECT", type=1, tooltip="", image="Ability_Druid_Typhoon"},
{action="VETO", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="DISAGREE", type=1, tooltip="", image="Trade_Tailoring"},
{action="SNUB", type=1, tooltip="", image="Ability_Mount_Wyvern_01"},
{action="DOUBT", type=1, tooltip="", image="Spell_DeathKnight_Vendetta"},
{action="SILENCE", type=1, tooltip="", image="INV_Chest_Wolf"}
},
["Rude2"]={
{action="EMBARRASS", type=1, tooltip="", image="INV_Fishingpole_03"},
{action="RUDE", type=1, tooltip="", image="INV_Shirt_GuildTabard_01"},
{action="INSULT", type=1, tooltip="", image="Achievement_Boss_Thorim"},
{action="MOCK", type=1, tooltip="", image="Trade_Tailoring"},
{action="SHOO", type=1, tooltip="", image="Spell_Druid_feralchargecat"},
{action="PITY", type=1, tooltip="", image="Spell_Shaman_LavaBurst"},
{action="MOON", type=1, tooltip="", image="INV_Axe_30"},
{action="Rude", type=0, tooltip="Back...", image="INV_Fishingpole_03"}
},
["Celebrations"]={
{action="APPLAUD", type=1, tooltip="", image="INV_Weapon_Hand_34"},
{action="CHEER", type=1, tooltip="", image="Trade_Tailoring"},
{action="CLAP", type=1, tooltip="", image="INV_Scroll_16"},
{action="CONGRATULATE", type=1, tooltip="", image="Spell_Holy_WordFortitude"},
{action="COMMEND", type=1, tooltip="", image="INV_Weapon_Shortblade_99"},
{action="PRAISE", type=1, tooltip="", image="INV_Misc_Cape_Naxxramas_03"},
{action="TOAST", type=1, tooltip="", image="Ability_Mage_WorldInFlames"},
{action="Celebrations2", type=0, tooltip="More...", image="Spell_Holy_WordFortitude"}
},
["Small Talk"]={
{action="LOL", type=0, tooltip="", image="INV_Fishingpole_06"},
{action="Rude", type=0, tooltip="", image="vas_factionchange"},
{action="Thanks", type=0, tooltip="", image="INV_Mushroom_13"},
{action="Who Stinks?", type=0, tooltip="", image="Spell_Fire_WindsofWoe"},
{action="Celebrations", type=0, tooltip="", image="INV_Pants_Wolf"}
},
["RP"]={
{action="Animations", type=0, tooltip="", image="INV_Mushroom_13"},
{action="Body Functions", type=0, tooltip="", image="Ability_Paladin_TouchedbyLight"},
{action="Food/Drink", type=0, tooltip="", image="Spell_Shaman_TotemRecall"},
{action="Look", type=0, tooltip="", image="vas_factionchange"},
{action="Thinking", type=0, tooltip="", image="vas_factionchange"},
{action="Attacks", type=0, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="Misc RP", type=0, tooltip="", image="INV_Misc_Wrench_02"}
},
["Flirt"]={
{action="BASHFUL", type=1, tooltip="", image="Achievement_Dungeon_Ulduar77_10man"},
{action="BLUSH", type=1, tooltip="", image="Spell_Misc_HellifrePVPThrallmarFavor"},
{action="HUG", type=1, tooltip="", image="Ability_Warrior_IntensifyRage"},
{action="KISS", type=1, tooltip="", image="Ability_Warlock_DemonicEmpowerment"},
{action="MASSAGE", type=1, tooltip="", image="INV_Gizmo_RocketBoot_01"},
{action="MOAN", type=1, tooltip="", image="Trade_Mining"},
{action="SEXY", type=1, tooltip="", image="INV_Misc_Horn_01"},
{action="Flirt2", type=0, tooltip="More...", image="Achievement_Boss_Aeonus_01"}
},
["Orders"]={
{action="OPENFIRE", type=1, tooltip="", image="INV_Shield_04"},
{action="ATTACKMYTARGET", type=1, tooltip="", image="Spell_DeathKnight_SummonDeathCharger"},
{action="STOPATTACK", type=1, tooltip="", image="INV_Pants_07"},
{action="HEALME", type=1, tooltip="", image="INV_Letter_03"},
{action="HELPME", type=1, tooltip="", image="INV_Jewelry_Necklace_35"},
{action="FLEE", type=1, tooltip="", image="INV_Weapon_Hand_11"},
{action="HURRY", type=1, tooltip="", image="INV_Axe_38"},
{action="GO", type=1, tooltip="", image="INV_Misc_ShadowEgg"}
},
["Attacks"]={
{action="SLAP", type=1, tooltip="", image="INV_Elemental_Crystal_Air"},
{action="PUNCH", type=1, tooltip="", image="Spell_Shadow_PainSpike"},
{action="SMACK", type=1, tooltip="", image="Ability_Paladin_DivineStorm"},
{action="BONK", type=1, tooltip="", image="Spell_Deathknight_FrostPresence"},
{action="PINCH", type=1, tooltip="", image="Achievement_Zone_GrizzlyHills_03"},
{action="BITE", type=1, tooltip="", image="INV_Staff_17"},
{action="POUNCE", type=1, tooltip="", image="Achievement_Zone_StormPeaks_09"},
{action="PULSE", type=1, tooltip="", image="Achievement_BG_tophealer_AB"}
},
["Pets"]={
{action="/use Cat Carrier (Bombay)", type=2, tooltip="Bombay Cat", image="Ability_Rogue_FanofKnives"},
{action="/use Cat Carrier (Cornish Rex)", type=2, tooltip="", image="INV_Sword_92"},
{action="/use Cat Carrier (Orange Tabby)", type=2, tooltip="", image="Achievement_FeatsOfStrength_Gladiator_06"},
{action="/use Cat Carrier (Silver Tabby)", type=2, tooltip="", image="INV_Misc_Food_02"}
},
["Body Functions2"]={
{action="SNORT", type=1, tooltip="", image="INV_Elemental_Primal_Earth"},
{action="SPIT", type=1, tooltip="", image="INV_Gauntlets_23"},
{action="NOSEPICK", type=1, tooltip="", image="INV_Potion_13"},
{action="Body Functions", type=0, tooltip="Back...", image="INV_Misc_Food_146_CakeSlice"}
},
["Discussion"]={
{action="AMAZE", type=1, tooltip="", image="INV_Weapon_Shortblade_99"},
{action="CURIOUS", type=1, tooltip="", image="Item_icecrownringD"},
{action="SHRUG", type=1, tooltip="", image="INV_Misc_Powder_Tin"},
{action="TALK", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="WHINE", type=1, tooltip="", image="Ability_Mount_Wyvern_01"},
{action="LISTEN", type=1, tooltip="", image="INV_Potion_99"},
{action="IDEA", type=1, tooltip="", image="INV_Weapon_Staff_109"},
{action="Discussion2", type=0, tooltip="More...", image="INV_Shirt_Yellow_01"}
},
["Look2"]={
{action="AWE", type=1, tooltip="", image="Achievement_Zone_ZulDrak_05"},
{action="LOOK", type=1, tooltip="", image="Spell_Shaman_BlessingOfEternals"},
{action="SHIFTY", type=1, tooltip="", image="INV_Misc_Food_26"},
{action="SHUDDER", type=1, tooltip="", image="INV_Weapon_Bow_15"},
{action="PEER", type=1, tooltip="", image="Ability_Hunter_Misdirection"},
{action="CONFUSED", type=1, tooltip="", image="INV_Belt_66Black"},
{action="Look", type=0, tooltip="Back...", image="Ability_Druid_GaleWinds"}
},
["Taunts"]={
{action="CHICKEN", type=1, tooltip="", image="INV_Glyph_MajorMage"},
{action="FLEX", type=1, tooltip="", image="Spell_Shadow_LastingAffliction"},
{action="GLARE", type=1, tooltip="", image="INV_Drink_11"},
{action="ROAR", type=1, tooltip="", image="INV_TradeskillItem_01"},
{action="THREATEN", type=1, tooltip="", image="INV_Misc_MissileLargeCluster_Green"},
{action="TAUNT", type=1, tooltip="", image="Achievement_PVP_O_12"},
{action="GROWL", type=1, tooltip="", image="Ability_Hunter_ZenArchery"},
{action="Taunts2", type=0, tooltip="More...", image="INV_Shield_29"}
},
["Look"]={
{action="STARE", type=1, tooltip="", image="INV_Pants_Cloth_24"},
{action="BLINK", type=1, tooltip="", image="Spell_DeathKnight_ArmyOfTheDead"},
{action="EYE", type=1, tooltip="", image="INV_Weapon_ShortBlade_15"},
{action="GAZE", type=1, tooltip="", image="Racial_Dwarf_FindTreasure"},
{action="BLANK", type=1, tooltip="", image="INV_Misc_Bandage_05"},
{action="EYEBROW", type=1, tooltip="", image="INV_Misc_Marrigolds_01"},
{action="ABSENT", type=1, tooltip="", image="INV_Sword_78"},
{action="Look2", type=0, tooltip="More...", image="Achievement_PVP_H_15"}
},
["Greetings"]={
{action="Greets", type=0, tooltip="", image="vas_factionchange"},
{action="Farewells", type=0, tooltip="", image="Item_icecrownringD"}
},
["Food/Drink"]={
{action="DRINK", type=1, tooltip="", image="INV_Jewelry_Ring_70"},
{action="EAT", type=1, tooltip="", image="INV_Misc_Eye_04"},
{action="CHUG", type=1, tooltip="", image="INV_Misc_Gem_Pearl_01"},
{action="THIRSTY", type=1, tooltip="", image="Achievement_Zone_GrizzlyHills_08"},
{action="HUNGRY", type=1, tooltip="", image="INV_Drink_26_GoatsMilk"}
},
["Greets"]={
{action="HAIL", type=1, tooltip="", image="INV_Mushroom_13"},
{action="HELLO", type=1, tooltip="", image="INV_Mace_99"},
{action="INTRODUCE", type=1, tooltip="", image="INV_Misc_Beer_10"},
{action="WELCOME", type=1, tooltip="", image="INV_Sword_Draenei_08"},
{action="GREET", type=1, tooltip="", image="INV_Sword_Draenei_08"},
{action="SALUTE", type=1, tooltip="", image="Spell_unused2"},
{action="WAVE", type=1, tooltip="", image="INV_Sword_Draenei_08"},
{action="POKE", type=1, tooltip="", image="Ability_WIntergrasp_rank3"}
},
["Body Functions"]={
{action="HICCUP", type=1, tooltip="", image="INV_Qiraj_JewelEncased"},
{action="DROOL", type=1, tooltip="", image="Achievement_Dungeon_Ulduar80_25man"},
{action="FART", type=1, tooltip="", image="Achievement_Dungeon_UlduarRaid_IronDwarf_01"},
{action="BURP", type=1, tooltip="", image="Spell_Fire_MeteorStorm"},
{action="BREATH", type=1, tooltip="", image="INV_Misc_Food_100_HardCheese"},
{action="COUGH", type=1, tooltip="", image="INV_Mace_20"},
{action="SNEEZE", type=1, tooltip="", image="Spell_Shadow_UnholyStrength"},
{action="Body Functions2", type=0, tooltip="", image="Achievement_Zone_HowlingFjord_04"}
},
["Flirt4"]={
{action="CHARM", type=1, tooltip="", image="INV_Letter_17"},
{action="SHIMMY", type=1, tooltip="", image="Ability_Mount_WhiteTiger"},
{action="TEASE", type=1, tooltip="", image="INV_Misc_Fish_42"},
{action="Flirt", type=0, tooltip="Back...", image="Achievement_Forgemaster"}
},
["Celebrations2"]={
{action="DING", type=1, tooltip="", image="Spell_Ice_Rune"},
{action="PROUD", type=1, tooltip="", image="INV_Shoulder_HaremMatron_D_01"},
{action="HIGHFIVE", type=1, tooltip="", image="INV_Shoulder_HaremMatron_D_01"},
{action="VICTORY", type=1, tooltip="", image="Ability_Mount_Wyvern_01"},
{action="Celebrations", type=0, tooltip="Back...", image="INV_Potion_99"}
},
["Scared"]={
{action="SWEAT", type=1, tooltip="", image="vas_factionchange"},
{action="SCARED", type=1, tooltip="", image="INV_Weapon_Halberd_AhnQiraj"},
{action="BADFEELING", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="COWER", type=1, tooltip="", image="Spell_Nature_WrathofAir _Totem"},
{action="PRAY", type=1, tooltip="", image="INV_Mushroom_13"},
{action="PANIC", type=1, tooltip="", image="vas_factionchange"},
{action="DUCK", type=1, tooltip="", image="Ability_Shaman_WaterShield"},
{action="NERVOUS", type=1, tooltip="", image="INV_Fishingpole_06"}
},
["Direction"]={
{action="BECKON", type=1, tooltip="", image="INV_Mushroom_13"},
{action="FOLLOW", type=1, tooltip="", image="INV_Shoulder_HaremMatron_D_01"},
{action="WAIT", type=1, tooltip="", image="vas_factionchange"},
{action="POINT", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="GO", type=1, tooltip="", image="vas_factionchange"},
{action="HURRY", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="LOST", type=1, tooltip="", image="INV_Belt_83"}
},
["Who Stinks?"]={
{action="SNIFF", type=1, tooltip="", image="INV_Misc_Beer_10"},
{action="STINK", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"}
},
["Surprised"]={
{action="BOGGLE", type=1, tooltip="", image="INV_Elemental_Primal_Water"},
{action="SURPRISED", type=1, tooltip="", image="vas_factionchange"},
{action="GASP", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"}
},
["Mounts"]={
{action="/use Swift Zulian Tiger", type=2, tooltip="", image="Spell_Holy_RetributionAura"},
{action="/use Swift Razzashi Raptor", type=2, tooltip="", image="INV_Jewelcrafting_CrimsonSpinel_01"},
{action="/use Mekgineer's Chopper", type=2, tooltip="", image="Ability_Warlock_ImprovedSoulLeech"},
{action="/use Swift White Hawkstrider", type=2, tooltip="", image="Achievement_BG_winSOA"}
},
["Sus"]={
{action="TALKQ", type=1, tooltip="", image="INV_Misc_Gem_Pearl_11"},
{action="SUSPICIOUS", type=1, tooltip="", image="INV_Chest_Cloth_31"},
{action="PUZZLE", type=1, tooltip="", image="INV_Potion_57"}
},
["I'm Feeling 2"]={
{action="CALM", type=1, tooltip="Calm", image="Achievement_Character_Draenei_Male"},
{action="JEALOUS", type=1, tooltip="Jealous", image="INV_Rod_Titanium"},
{action="SERIOUS", type=1, tooltip="Serious", image="Achievement_Character_Orc_Male"},
{action="GLOAT", type=1, tooltip="Boastful", image="INV_Mace_99"},
{action="GRIN", type=1, tooltip="Evil", image="Achievement_Leader_King_Varian_Wrynn"},
{action="TAP", type=1, tooltip="Impatient...", image="Spell_Nature_StormReach"},
{action="COLD", type=1, tooltip="Cold", image="Spell_Frost_FrostArmor"},
{action="SHIVER", type=1, tooltip="Shivering", image="INV_Boots_Cloth_03"}
},
["Silly"]={
{action="MOO", type=1, tooltip="", image="INV_Shirt_Yellow_01"},
{action="JOKE", type=1, tooltip="", image="INV_Misc_Wrench_02"},
{action="TICKLE", type=1, tooltip="", image="INV_Misc_Bag_Soulbag"},
{action="TRAIN", type=1, tooltip="choochoo", image="Achievement_Zone_ZulDrak_12"},
{action="JK", type=1, tooltip="", image="Spell_Shaman_TotemRecall"},
{action="FLOP", type=1, tooltip="", image="Ability_WIntergrasp_rank3"},
{action="TEASE", type=1, tooltip="", image="Spell_Nature_WrathofAir _Totem"}
},
["Professions"]={
{action="/cast First Aid", type=2, tooltip="", image="INV_Letter_01"},
{action="/cast Cooking", type=2, tooltip="", image="Ability_Vehicle_OilJets"},
{action="/cast Fishing", type=2, tooltip="", image="Spell_Frost_SummonWaterElemental"},
{action="/cast Bushcraft", type=2, tooltip="", image="Spell_Nature_NullifyPoison_02"},
{action="/cast Woodcutting", type=2, tooltip="", image="INV_Fishingpole_03"},
{action="/cast Investigate", type=2, tooltip="", image="INV_Misc_Toy_10"},
{action="/cast Camouflage", type=2, tooltip="", image="INV_Misc_Marrigolds_01"},
{action="/cast Navigate", type=2, tooltip="", image="INV_Drink_Waterskin_04"}
},
["Tired"]={
{action="TIRED", type=1, tooltip="", image="INV_Axe_99"},
{action="YAWN", type=1, tooltip="", image="Spell_Magic_PolymorphRabbit"},
{action="SLEEP", type=1, tooltip="", image="INV_Stone_WeightStone_08"}
},
["Farewells"]={
{action="BYE", type=1, tooltip="", image="INV_Mushroom_13"},
{action="SALUTE", type=1, tooltip="", image="Ability_Warlock_ShadowFlame"},
{action="GOODLUCK", type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
{action="LUCK", type=1, tooltip="", image="INV_Misc_Bandana_03"},
{action="SNEAK", type=1, tooltip="", image="vas_factionchange"},
{action="GOING", type=1, tooltip="", image="Ability_WIntergrasp_rank3"},
{action="BRB", type=1, tooltip="", image="INV_Shoulder_HaremMatron_D_01"}
},
["Spells"]={
{action="/cast Hearth", type=2, tooltip="", image="INV_Misc_Rune_01"},
{action="Professions", type=0, tooltip="", image="INV_Potion_140"},
{action="Mounts", type=0, tooltip="", image="INV_Potion_34"},
{action="Pets", type=0, tooltip="", image="INV_Weapon_Hand_02"},
{action="Boats", type=0, tooltip="", image="Spell_DeathKnight_Subversion"}
}
}


EMOTEBUTTONS_PROFILES = {
	{Name="Default", Decks=EMOTEBUTTONS_SE},
	{Name = "WIP", Decks=EMOTEBUTTONS_T},
	{Name="Empty", Decks=EMOTEBUTTONS_MT}
}