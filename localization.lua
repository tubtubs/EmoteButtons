-- Last update : 29/10/2006

-- <<--
--	Global info
-- -->>

EMOTEBUTTONS_NAME		= "EmoteButtons";
EMOTEBUTTONS_VERSION		= "2.0";

EMOTEBUTTONS_NAMEVERSION	= EMOTEBUTTONS_NAME.." v"..EMOTEBUTTONS_VERSION;


-- Version : English
-- Last update : 29/10/2006

--Sliders
EMOTEBUTTONS_ROTATION		= "Rotation";
EMOTEBUTTONS_SIZE		= "Size";

EMOTEBUTTONS_INIT_TEXT		= EMOTEBUTTONS_NAMEVERSION.." loaded";

EMOTEBUTTONS_SETTINGSWARN	= "|n|n|cff22ff22".."Shift-click to change this button!";

EMOTEBUTTONS_MAINHELP		= "|cFFFFFFFF"..EMOTEBUTTONS_NAME.."|n|n|r".."Right-click and drag to move|nShift-click a button for setup";

EMOTEBUTTONS_SLASHHELP = [[|cFF00FF00Emote Buttons:|r This is help topic for |cFFFFFF00 /EmoteButtons or /EB.|r
|cFF00FF00Emote Buttons:|r |cFFFFFF00 /EmoteButtons deckbuilder|r - opens the deckbuilder.
|cFF00FF00Emote Buttons:|r |cFFFFFF00 /EmoteButtons mode extended |r - changes to extended mode (emote list). Extended mode is only works on servers that support extended emotes.
|cFF00FF00Emote Buttons:|r |cFFFFFF00 /EmoteButtons mode vanilla |r - changes to vanilla mode (emote list)
|cFF00FF00Emote Buttons:|r |cFFFFFF00 /EmoteButtons options|r - opens the advanced config window.
|cFF00FF00Emote Buttons:|r |cFFFFFF00 /EmoteButtons resetposition|r - resets position of the main button.
|cFF00FF00Emote Buttons:|r |cFFFFFF00 /EmoteButtons resetprofile|r - resets the current profile to default.
]]

EMOTEBUTTONS_SLASHUNKNOWN = "|cFF00FF00Emote Buttons:|r unknown command"

EMOTEBUTTONS_SUBMITBUTTON = "Submit"
EMOTEBUTTONS_CANCELBUTTON = "Cancel"
EMOTEBUTTONS_TEST = "ERROR"

EMOTEBUTTONS_EMOTEMANAGER = "Emote Manager"
EMOTEBUTTONS_DECKMANAGER = "Deck Manager"

--Deck Builder Strings
EMOTEBUTTONS_DECKBUILDER = "Deck Builder"
EMOTEBUTTONS_SETEMOTE = "Set Emote"
EMOTEBUTTONS_SETCOMMAND = "Set Command"
EMOTEBUTTONS_SETDECK = "Set Deck"
EMOTEBUTTONS_SETLABEL = "Tooltip/Icon"
EMOTEBUTTONS_NEWDECK = "New Deck"
EMOTEBUTTONS_RENAMEDECK = "Rename Deck"
EMOTEBUTTONS_ADDDECK = "Add Deck"
EMOTEBUTTONS_DELETEDECK = "Delete Deck"
EMOTEBUTTONS_MOVEUP = "Move Up"
EMOTEBUTTONS_MOVEDOWN = "Move Down"
EMOTEBUTTONS_DELETEBUTTON = "Delete Button"
EMOTEBUTTONS_INVALIDEMOTE = "Invalid emote...\nMay need to disable extended mode \nin advanced options, or check patches."

--Advanced Config Strings
EMOTEBUTTONS_ADVANCEDCONFIG = "Advanced Config"
EMOTEBUTTONS_NEWPROFILE = "New Profile"
EMOTEBUTTONS_IMPORTPROFILE = "Import Profile"
EMOTEBUTTONS_EXPORTPROFILE = "Export Profile"
EMOTEBUTTONS_RESETPOSITION = "Reset Main Button Position"
EMOTEBUTTONS_RESETPROFILE =  "Reset Current Profile"
EMOTEBUTTONS_SETPROFILE = "Set Profile"
EMOTEBUTTONS_DELETEPROFILE = "Delete Profile"
EMOTEBUTTONS_DUPLICATEPROFILE = "Duplicate Profile" 
EMOTEBUTTONS_CREATEPROFILE = "Create Profile"
EMOTEBUTTONS_EXTENDEDMODE = "Extended Mode (more emotes)"
EMOTEBUTTONS_EXTENDEDMODETIP = "Only works on supported servers, use Default - Extended Profile with this enabled.\nIf emotes don't work, check patch installation and if this server supports it."

--Modes
EB_VANILLA = 1
EB_EXTENDED = 2

--Action Types
EBACTTYPE_DECK = 0
EBACTTYPE_EMOTE = 1
EBACTTYPE_SLASHCMD = 2

--type=EBACTTYPE_DECK,
--type=EBACTTYPE_EMOTE,
--type=EBACTTYPE_SLASHCMD,

--Profile Data

--Empty
EMOTEBUTTONS_MT = {
	["Main"] = {
		{action="/emotebuttons deckbuilder", type=EBACTTYPE_SLASHCMD, tooltip="Start building!",image="Ability_Rogue_Disguise"}
	}
}

--Default profile
EMOTEBUTTONS_ET = {
	["Combat"]={
	{action=[[Taunts]], type=0, tooltip="", image="Ability_Warrior_Rampage"},
	{action=[[Mercy]], type=0, tooltip="", image="Achievement_Halloween_Cat_01"},
	{action=[[Orders]], type=0, tooltip="", image="Ability_Warrior_RallyingCry"},
	{action=[[Warnings]], type=0, tooltip="", image="Ability_Warrior_FuriousResolve"},
	{action=[[Signals]], type=0, tooltip="", image="Spell_Holy_Stoicism"},
	{action=[[Celebrations]], type=0, tooltip="", image="Achievement_Quests_Completed_06"},
	{action=[[CHARGE]], type=1, tooltip="", image="Ability_Warrior_Charge"},
	{action=[[BLEED]], type=1, tooltip="", image="Spell_DeathKnight_BloodBoil"}
	},
	["Animations"]={
	{action=[[SIT]], type=1, tooltip="Sit", image="INV_Misc_Toy_02"},
	{action=[[STAND]], type=1, tooltip="Stand", image="Achievement_BG_kill_carrier_opposing_flagroom"},
	{action=[[DANCE]], type=1, tooltip="", image="INV_Misc_FireDancer_01"},
	{action=[[KNEEL]], type=1, tooltip="", image="Ability_Paladin_GaurdedbytheLight"},
	{action=[[LAYDOWN]], type=1, tooltip="", image="Spell_Shadow_TwistedFaith"},
	{action=[[SLEEP]], type=1, tooltip="", image="Spell_Nature_Sleep"},
	{action=[[POINT]], type=1, tooltip="", image="Spell_Holy_Stoicism"},
	{action=[[MOUNTSPECIAL]], type=1, tooltip="Mount Special", image="Ability_Mount_RidingHorse"}
	},
	["Flirt2"]={
	{action=[[SHAKE]], type=1, tooltip="", image="INV_Misc_Food_99"},
	{action=[[SHY]], type=1, tooltip="", image="Spell_Misc_EmotionHappy"},
	{action=[[CUDDLE]], type=1, tooltip="", image="Spell_Holy_GuardianSpirit"},
	{action=[[LICK]], type=1, tooltip="", image="Spell_Shadow_SoothingKiss"},
	{action=[[PURR]], type=1, tooltip="", image="INV_Misc_Head_Tiger_01"},
	{action=[[LOVE]], type=1, tooltip="", image="Achievement_WorldEvent_Valentine"},
	{action=[[FLIRT]], type=1, tooltip="", image="Achievement_Character_Bloodelf_Female"},
	{action=[[Flirt3]], type=0, tooltip="More...", image="Achievement_WorldEvent_Valentine"}
	},
	["I'm Feeling 2"]={
	{action=[[CALM]], type=1, tooltip="Calm", image="Achievement_Character_Draenei_Male"},
	{action=[[JEALOUS]], type=1, tooltip="Jealous", image="Achievement_Character_Bloodelf_Female"},
	{action=[[SERIOUS]], type=1, tooltip="Serious", image="Achievement_Character_Orc_Male"},
	{action=[[GLOAT]], type=1, tooltip="Boastful", image="INV_Misc_Coin_02"},
	{action=[[GRIN]], type=1, tooltip="Evil", image="Achievement_Leader_King_Varian_Wrynn"},
	{action=[[COLD]], type=1, tooltip="Cold", image="Spell_Frost_FrostArmor"},
	{action=[[SHIVER]], type=1, tooltip="Shivering", image="INV_Boots_Cloth_03"},
	{action=[[CONFUSED]], type=1, tooltip="Confused", image="Spell_Frost_Stun"}
	},
	["Misc RP"]={
	{action=[[MAP]], type=1, tooltip="", image="INV_Misc_Map02"},
	{action=[[PET]], type=1, tooltip="", image="Spell_Holy_Resurrection"},
	{action=[[SEARCH]], type=1, tooltip="", image="INV_Misc_Spyglass_03"},
	{action=[[BACKPACK]], type=1, tooltip="", image="INV_Misc_Bag_07"},
	{action=[[FAINT]], type=1, tooltip="", image="INV_Misc_Bone_HumanSkull_01"},
	{action=[[WORK]], type=1, tooltip="", image="Trade_Mining"},
	{action=[[SING]], type=1, tooltip="", image="Spell_Holy_DivineHymn"},
	{action=[[COVEREARS]], type=1, tooltip="", image="Ability_Mage_StudentOfTheMind"}
	},
	["Bored"]={
	{action=[[BORED]], type=1, tooltip="Bored", image="Spell_Nature_Polymorph_Cow"},
	{action=[[FIDGET]], type=1, tooltip="", image="INV_Sigil_Thorim"},
	{action=[[TWIDDLE]], type=1, tooltip="", image="INV_Misc_SurgeonGlove_01"},
	{action=[[BOUNCE]], type=1, tooltip="", image="INV_Misc_ThrowingBall_01"},
	{action=[[TAP]], type=1, tooltip="", image="Ability_Kick"}
	},
	["Discussion2"]={
	{action=[[MUTTER]], type=1, tooltip="", image="Ability_Rogue_SinisterCalling"},
	{action=[[OFFER]], type=1, tooltip="", image="Spell_Holy_Chastise"},
	{action=[[PROMISE]], type=1, tooltip="Promise", image="Spell_Holy_ImpHolyConcentration"},
	{action=[[Discussion]], type=0, tooltip="Back...", image="Ability_Warrior_CommandingShout"}
	},
	["Rude"]={
	{action=[[FACEPALM]], type=1, tooltip="", image="Spell_Arcane_FocusedPower"},
	{action=[[SPIT]], type=1, tooltip="", image="INV_Elemental_Crystal_Water"},
	{action=[[BLAME]], type=1, tooltip="", image="Spell_Misc_EmotionSad"},
	{action=[[RASP]], type=1, tooltip="", image="INV_Sword_123"},
	{action=[[HISS]], type=1, tooltip="", image="Spell_Nature_GuardianWard"},
	{action=[[FAIL]], type=1, tooltip="", image="INV_Gizmo_SuperSapperCharge"},
	{action=[[CRINGE]], type=1, tooltip="", image="Spell_Misc_EmotionAfraid"},
	{action=[[Rude2]], type=0, tooltip="More..", image="Spell_Druid_feralchargecat"}
	},
	["I'm Feeling"]={
	{action=[[Happy]], type=0, tooltip="", image="Spell_Misc_EmotionHappy"},
	{action=[[Angry]], type=0, tooltip="", image="Spell_Misc_EmotionAngry"},
	{action=[[Sad]], type=0, tooltip="Sad", image="Spell_Misc_EmotionSad"},
	{action=[[Surprised]], type=0, tooltip="Surprised", image="INV_Holiday_Christmas_Present_01"},
	{action=[[Scared]], type=0, tooltip="Scared", image="Spell_Misc_EmotionAfraid"},
	{action=[[Bored]], type=0, tooltip="Bored", image="Spell_Magic_PolymorphRabbit"},
	{action=[[Tired]], type=0, tooltip="Tired", image="Spell_Nature_Sleep"},
	{action=[[I'm Feeling 2]], type=0, tooltip="More Emotes", image="Ability_Rogue_Disguise"}
	},
	["Conversation"]={
	{action=[[Discussion]], type=0, tooltip="", image="Ability_Warrior_CommandingShout"},
	{action=[[Silly]], type=0, tooltip="", image="Spell_Shadow_Charm"},
	{action=[[Comfort]], type=0, tooltip="", image="Spell_Holy_Heroism"},
	{action=[[Sus]], type=0, tooltip="", image="Ability_Rogue_MasterOfSubtlety"},
	{action=[[Direction]], type=0, tooltip="", image="INV_Misc_Map02"},
	{action=[[Agree]], type=0, tooltip="", image="Achievement_BG_tophealer_WSG"},
	{action=[[Disagree]], type=0, tooltip="", image="Achievement_Boss_Exarch_Maladaar"},
	{action=[[Flirt]], type=0, tooltip="", image="Achievement_WorldEvent_Valentine"}
	},
	["Farewells"]={
	{action=[[BYE]], type=1, tooltip="", image="INV_Gauntlets_04"},
	{action=[[SALUTE]], type=1, tooltip="", image="Achievement_PVP_G_04"},
	{action=[[GOODLUCK]], type=1, tooltip="", image="INV_Misc_Herb_GoldClover"},
	{action=[[LUCK]], type=1, tooltip="", image="INV_Misc_Herb_GoldClover"},
	{action=[[SNEAK]], type=1, tooltip="", image="Ability_Stealth"},
	{action=[[GOING]], type=1, tooltip="", image="Achievement_BG_captureflag_WSG"},
	{action=[[BRB]], type=1, tooltip="", image="Achievement_BG_returnXflags_def_WSG"}
	},
	["Tired"]={
	{action=[[TIRED]], type=1, tooltip="", image="Spell_Nature_Sleep"},
	{action=[[YAWN]], type=1, tooltip="", image="Ability_Warrior_BattleShout"},
	{action=[[SLEEP]], type=1, tooltip="", image="INV_Misc_Bandage_07"}
	},
	["Signals"]={
	{action=[[READY]], type=1, tooltip="", image="Achievement_BG_tophealer_WSG"},
	{action=[[SNAP]], type=1, tooltip="", image="INV_Gauntlets_16"},
	{action=[[SIGNAL]], type=1, tooltip="", image="Achievement_BG_tophealer_AB"},
	{action=[[OOM]], type=1, tooltip="", image="INV_Drink_18"},
	{action=[[BECKON]], type=1, tooltip="", image="INV_Stone_12"}
	},
	["CMDs"]={
	{action=[[/script ReloadUI()]], type=2, tooltip="Reload UI", image="INV_Misc_PunchCards_Blue"},
	{action=[[/who]], type=2, tooltip="who", image="INV_Misc_Spyglass_02"},
	{action=[[/dnd I'm busy]], type=2, tooltip="DND", image="Spell_Shadow_SacrificialShield"},
	{action=[[/afk smoke break]], type=2, tooltip="Smoke Break", image="INV_Misc_Pipe_01"},
	{action=[[/script local r = GetXPExhaustion() if r then DEFAULT_CHAT_FRAME:AddMessage("Rested XP: " .. tostring(math.floor((r / UnitXPMax("player")) * 100)) .. "%", "SAY") else DEFAULT_CHAT_FRAME:AddMessage("No Rested XP.", "SAY") end]], type=2, tooltip="Rested XP", image="Spell_Nature_Sleep"},
	{action=[[/script ResetInstances()]], type=2, tooltip="Reset Instances", image="Achievement_Boss_Algalon_01"},
	{action=[[/script TargetByName("Moonstalker",true);
	/run SetRaidTarget("target", 8); ]], type=2, tooltip="Look for NPC", image="Ability_CheapShot"},
	{action=[[/eb options]], type=2, tooltip="Emote Buttons Options", image="INV_Misc_Wrench_02"}
	},
	["Flirt3"]={
	{action=[[WINK]], type=1, tooltip="", image="Spell_Nature_FocusedMind"},
	{action=[[HOLDHAND]], type=1, tooltip="", image="Spell_Holy_Chastise"},
	{action=[[SCRATCH]], type=1, tooltip="", image="INV_Misc_Bone_06"},
	{action=[[WHISTLE]], type=1, tooltip="", image="Ability_Hunter_BeastCall"},
	{action=[[TICKLE]], type=1, tooltip="", image="INV_Feather_06"},
	{action=[[POKE]], type=1, tooltip="", image="Achievement_Reputation_Ogre"},
	{action=[[RUFFLE]], type=1, tooltip="", image="INV_Misc_Comb_01"},
	{action=[[Flirt4]], type=0, tooltip="More...", image="Achievement_WorldEvent_Valentine"}
	},
	["Flirt"]={
	{action=[[BASHFUL]], type=1, tooltip="", image="INV_Hammer_18"},
	{action=[[BLUSH]], type=1, tooltip="", image="ACHIEVEMENT_BOSS_KILJAEDAN"},
	{action=[[HUG]], type=1, tooltip="", image="Ability_Druid_Maul"},
	{action=[[KISS]], type=1, tooltip="", image="Spell_Shadow_SoothingKiss"},
	{action=[[MASSAGE]], type=1, tooltip="", image="INV_Gauntlets_06"},
	{action=[[MOAN]], type=1, tooltip="", image="Achievement_Boss_Auriaya_01"},
	{action=[[SEXY]], type=1, tooltip="", image="INV_Misc_Idol_01"},
	{action=[[Flirt2]], type=0, tooltip="More...", image="Achievement_WorldEvent_Valentine"}
	},
	["Mercy"]={
	{action=[[BEG]], type=1, tooltip="", image="Spell_Holy_Chastise"},
	{action=[[MERCY]], type=1, tooltip="", image="Ability_Seal"},
	{action=[[GROVEL]], type=1, tooltip="", image="Ability_Paladin_GaurdedbytheLight"},
	{action=[[PLEAD]], type=1, tooltip="", image="Spell_Holy_SealOfBlood"},
	{action=[[SURRENDER]], type=1, tooltip="", image="Achievement_BG_kill_carrier_opposing_flagroom"},
	{action=[[TRUCE]], type=1, tooltip="", image="INV_Letter_20"},
	{action=[[SQUEAL]], type=1, tooltip="", image="Spell_Magic_PolymorphPig"},
	{action=[[ARM]], type=1, tooltip="", image="Spell_Holy_Renew"}
	},
	["Angry"]={
	{action=[[ANGRY]], type=1, tooltip="", image="Ability_Warrior_BloodFrenzy"},
	{action=[[GLOWER]], type=1, tooltip="", image="Ability_Hunter_MasterTactitian"},
	{action=[[REVENGE]], type=1, tooltip="", image="Ability_Warrior_RallyingCry"},
	{action=[[SCOFF]], type=1, tooltip="", image="Ability_Warrior_CommandingShout"},
	{action=[[SCOLD]], type=1, tooltip="", image="Achievement_Dungeon_UlduarRaid_Titan_01"},
	{action=[[SCOWL]], type=1, tooltip="", image="Achievement_Boss_Illidan"},
	{action=[[CROSSARMS]], type=1, tooltip="", image="Achievement_Arena_2v2_1"},
	{action=[[HEADACHE]], type=1, tooltip="", image="Ability_Mage_StudentOfTheMind"}
	},
	["Sad"]={
	{action=[[CRY]], type=1, tooltip="", image="Ability_Rogue_BloodyEye"},
	{action=[[MOURN]], type=1, tooltip="", image="INV_Misc_Bone_HumanSkull_02"},
	{action=[[VIOLIN]], type=1, tooltip="", image="INV_Misc_Drum_01"},
	{action=[[FROWN]], type=1, tooltip="", image="Spell_Misc_EmotionSad"},
	{action=[[GROAN]], type=1, tooltip="", image="Ability_Devour"},
	{action=[[SIGH]], type=1, tooltip="", image="Ability_Suffocate"},
	{action=[[POUT]], type=1, tooltip="", image="INV_Misc_Fish_34"},
	{action=[[SAD]], type=1, tooltip="", image="Achievement_Leader_Prophet_Velen"}
	},
	["Thanks"]={
	{action=[[BOW]], type=1, tooltip="", image="Ability_Paladin_GaurdedbytheLight"},
	{action=[[CURTSEY]], type=1, tooltip="", image="INV_Kilt_Cloth_02"},
	{action=[[THANK]], type=1, tooltip="", image="Spell_Holy_DevineAegis"},
	{action=[[YW]], type=1, tooltip="", image="Spell_Misc_EmotionHappy"},
	{action=[[APOLOGIZE]], type=1, tooltip="", image="Spell_Misc_EmotionSad"}
	},
	["Mounts"]={
	{action=[[/use Swift Zulian Tiger]], type=2, tooltip="Tiger", image="Ability_Mount_JungleTiger"},
	{action=[[/use Swift Razzashi Raptor]], type=2, tooltip="", image="Ability_Mount_Raptor"},
	{action=[[/use Mekgineer's Chopper]], type=2, tooltip="", image="INV_Misc_Key_06"},
	{action=[[/use Swift White Hawkstrider]], type=2, tooltip="", image="Ability_Mount_CockatriceMountElite_White"}
	},
	["Agree"]={
	{action=[[AGREE]], type=1, tooltip="", image="Achievement_BG_tophealer_WSG"},
	{action=[[NOD]], type=1, tooltip="", image="INV_Helmet128"},
	{action=[[RAISE]], type=1, tooltip="", image="Ability_Paladin_BlessedHands"}
	},
	["Mercs"]={
	{action=[[POINT]], type=1, tooltip="", image="Ability_Paladin_InfusionofLight"},
	{action=[[BECKON]], type=1, tooltip="", image="INV_Misc_Gem_LionsEye_01"},
	{action=[[FOLLOW]], type=1, tooltip="", image="Achievement_BG_captureflag_EOS"},
	{action=[[ATTACKMYTARGET]], type=1, tooltip="", image="INV_Sword_06"},
	{action=[[STOPATTACK]], type=1, tooltip="", image="INV_ValentinesChocolate01"},
	{action=[[WAIT]], type=1, tooltip="", image="firesglow"},
	{action=[[FLEE]], type=1, tooltip="", image="Ability_Warlock_ImprovedSoulLeech"},
	{action=[[HEALME]], type=1, tooltip="", image="Spell_Holy_AshesToAshes"}
	},
	["Main"]={
	{action=[[I'm Feeling]], type=0, tooltip="Emotions", image="Ability_Rogue_Disguise"},
	{action=[[Greetings]], type=0, tooltip="", image="Achievement_Reputation_01"},
	{action=[[Small Talk]], type=0, tooltip="", image="Temp"},
	{action=[[Conversation]], type=0, tooltip="", image="INV_Drink_22"},
	{action=[[Combat]], type=0, tooltip="", image="Achievement_Arena_2v2_7"},
	{action=[[RP]], type=0, tooltip="", image="Achievement_Zone_Stonetalon_01"},
	{action=[[Spells]], type=0, tooltip="", image="Ability_Racial_Ultravision"},
	{action=[[CMDs]], type=0, tooltip="", image="Mail_GMIcon"}
	},
	["Warnings"]={
	{action=[[WARN]], type=1, tooltip="", image="Spell_Misc_EmotionAfraid"},
	{action=[[ENEMY]], type=1, tooltip="", image="Achievement_Boss_CThun"},
	{action=[[INCOMING]], type=1, tooltip="", image="Achievement_BG_KillXEnemies_GeneralsRoom"}
	},
	["LOL"]={
	{action=[[CACKLE]], type=1, tooltip="", image="Spell_Shadow_CurseOfTounges"},
	{action=[[CHUCKLE]], type=1, tooltip="", image="Achievement_Boss_Auriaya_01"},
	{action=[[GUFFAW]], type=1, tooltip="", image="Achievement_Character_Dwarf_Male"},
	{action=[[ROFL]], type=1, tooltip="", image="INV_Misc_Toy_09"},
	{action=[[SNICKER]], type=1, tooltip="", image="Ability_Hunter_Pet_Hyena"},
	{action=[[GLOAT]], type=1, tooltip="", image="INV_Misc_Coin_02"},
	{action=[[LAUGH]], type=1, tooltip="", image="Spell_Fire_LavaSpawn"},
	{action=[[GIGGLE]], type=1, tooltip="", image="Achievement_Character_Gnome_Female"}
	},
	["Scrolls"]={
	{action=[[/use Scroll of Spirit]], type=2, tooltip="Scroll of Spirit", image="INV_Scroll_01"},
	{action=[[/use Scroll of Protection]], type=2, tooltip="Scroll of Protection", image="INV_Scroll_07"},
	{action=[[/use Scroll of Stamina]], type=2, tooltip="Scroll of Stamina", image="INV_Scroll_07"},
	{action=[[/use Scroll of Intellect]], type=2, tooltip="Scroll of Intellect", image="INV_Scroll_01"},
	{action=[[/use Scroll of Strength]], type=2, tooltip="Scroll of Strength", image="INV_Scroll_02"},
	{action=[[/use Scroll of Agility]], type=2, tooltip="Scroll of Agility", image="INV_Scroll_02"}
	},
	["Happy"]={
	{action=[[SMILE]], type=1, tooltip="", image="Achievement_WorldEvent_Brewmaster"},
	{action=[[HAPPY]], type=1, tooltip="", image="INV_Misc_PenguinPet"},
	{action=[[TALKEX]], type=1, tooltip="", image="Temp"},
	{action=[[SMIRK]], type=1, tooltip="", image="Achievement_Boss_Kael'thasSunstrider_01"},
	{action=[[GRIN]], type=1, tooltip="", image="Spell_Shadow_Charm"}
	},
	["Sarcastic"]={
	{action=[[ROLLEYES]], type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
	{action=[[SNORT]], type=1, tooltip="", image="Ability_Hunter_ZenArchery"},
	{action=[[GROAN]], type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"}
	},
	["Surprised"]={
	{action=[[BOGGLE]], type=1, tooltip="", image="INV_Elemental_Primal_Water"},
	{action=[[SURPRISED]], type=1, tooltip="", image="Achievement_Dungeon_ClassicDungeonMaster"},
	{action=[[GASP]], type=1, tooltip="", image="Ability_Creature_Disease_03"}
	},
	["Rude2"]={
	{action=[[EMBARRASS]], type=1, tooltip="", image="INV_Misc_Bone_Skull_02"},
	{action=[[RUDE]], type=1, tooltip="", image="Ability_Warlock_FireandBrimstone"},
	{action=[[INSULT]], type=1, tooltip="", image="Achievement_Boss_trollgore"},
	{action=[[MOCK]], type=1, tooltip="", image="INV_Mask_01"},
	{action=[[SHOO]], type=1, tooltip="", image="Ability_Hunter_BeastSoothe"},
	{action=[[PITY]], type=1, tooltip="", image="Spell_Shadow_RaiseDead"},
	{action=[[MOON]], type=1, tooltip="", image="Spell_Nature_MoonGlow"},
	{action=[[Rude]], type=0, tooltip="Back...", image="Spell_Druid_feralchargecat"}
	},
	["Celebrations"]={
	{action=[[APPLAUD]], type=1, tooltip="", image="Achievement_BG_tophealer_AB"},
	{action=[[CHEER]], type=1, tooltip="", image="Achievement_BG_most_damage_killingblow_dieleast"},
	{action=[[CLAP]], type=1, tooltip="", image="Spell_Holy_BlindingHeal"},
	{action=[[CONGRATULATE]], type=1, tooltip="", image="Achievement_Dungeon_HEROIC_GloryoftheRaider"},
	{action=[[COMMEND]], type=1, tooltip="", image="Achievement_BG_tophealer_AV"},
	{action=[[PRAISE]], type=1, tooltip="", image="Spell_Holy_GreaterBlessingofLight"},
	{action=[[TOAST]], type=1, tooltip="", image="INV_Drink_13"},
	{action=[[Celebrations2]], type=0, tooltip="More...", image="Achievement_Quests_Completed_06"}
	},
	["Small Talk"]={
	{action=[[LOL]], type=0, tooltip="", image="Racial_Troll_Berserk"},
	{action=[[Rude]], type=0, tooltip="", image="Spell_Druid_feralchargecat"},
	{action=[[Thanks]], type=0, tooltip="", image="Spell_Holy_Chastise"},
	{action=[[Who Stinks?]], type=0, tooltip="", image="Spell_Deathknight_UnholyPresence"},
	{action=[[Celebrations]], type=0, tooltip="", image="Achievement_Quests_Completed_06"}
	},
	["RP"]={
	{action=[[Animations]], type=0, tooltip="", image="INV_Misc_Drum_03"},
	{action=[[Body Functions]], type=0, tooltip="", image="INV_Holiday_ToW_SpicePotion02"},
	{action=[[Food/Drink]], type=0, tooltip="", image="INV_Misc_Food_68"},
	{action=[[Look]], type=0, tooltip="", image="Ability_Hunter_MasterMarksman"},
	{action=[[Thinking]], type=0, tooltip="", image="Spell_Arcane_MindMastery"},
	{action=[[Attacks]], type=0, tooltip="", image="Ability_Warrior_Devastate"},
	{action=[[Misc RP]], type=0, tooltip="", image="Achievement_Zone_Terrokar"},
	{action=[[Mercs]], type=0, tooltip="", image="INV_Misc_Coin_02"}
	},
	["Comfort"]={
	{action=[[SOOTHE]], type=1, tooltip="", image="Spell_Holy_Silence"},
	{action=[[COMFORT]], type=1, tooltip="", image="Ability_Paladin_SacredCleansing"},
	{action=[[PAT]], type=1, tooltip="", image="Spell_Holy_Heal"},
	{action=[[ENCOURAGE]], type=1, tooltip="", image="Ability_Warrior_RallyingCry"},
	{action=[[PULSE]], type=1, tooltip="", image="frozendeath"}
	},
	["Orders"]={
	{action=[[OPENFIRE]], type=1, tooltip="", image="INV_Musket_04"},
	{action=[[ATTACKMYTARGET]], type=1, tooltip="", image="INV_Sword_06"},
	{action=[[STOPATTACK]], type=1, tooltip="", image="Spell_Shadow_SacrificialShield"},
	{action=[[HEALME]], type=1, tooltip="", image="Spell_Holy_DivineProvidence"},
	{action=[[HELPME]], type=1, tooltip="", image="Spell_Druid_feralchargecat"},
	{action=[[FLEE]], type=1, tooltip="", image="Ability_Rogue_Sprint"},
	{action=[[HURRY]], type=1, tooltip="", image="INV_Misc_Crop_02"},
	{action=[[GO]], type=1, tooltip="", image="Ability_Warrior_CommandingShout"}
	},
	["Sus"]={
	{action=[[TALKQ]], type=1, tooltip="", image="INV_Misc_QuestionMark"},
	{action=[[SUSPICIOUS]], type=1, tooltip="", image="Ability_Rogue_MasterOfSubtlety"},
	{action=[[PUZZLE]], type=1, tooltip="", image="Inv_Helm_Mask_ZulGurub_D_01"}
	},
	["Pets"]={
	{action=[[/use Cat Carrier (Bombay)]], type=2, tooltip="Bombay Cat", image="INV_Box_PetCarrier_01"},
	{action=[[/use Cat Carrier (Cornish Rex)]], type=2, tooltip="", image="INV_Box_PetCarrier_01"},
	{action=[[/use Cat Carrier (Orange Tabby)]], type=2, tooltip="", image="INV_Box_PetCarrier_01"},
	{action=[[/use Cat Carrier (Silver Tabby)]], type=2, tooltip="", image="INV_Box_PetCarrier_01"}
	},
	["Elixirs"]={
	{action=[[/use Elixir of Minor Defense]], type=2, tooltip="Elixir of Minor Defense", image="INV_Potion_63"},
	{action=[[/use Elixir of Lion's Strength]], type=2, tooltip="Elixir of Lion's Strength", image="INV_Potion_56"},
	{action=[[/use Weak Troll's Blood Potion]], type=2, tooltip="Weak Troll's Blood Potion", image="INV_Potion_77"},
	{action=[[/use Elixir of Minor Fortitude]], type=2, tooltip="Elixir of Minor Fortitude", image="INV_Potion_42"},
	{action=[[/use Elixir of Minor Agility]], type=2, tooltip="Elixir of Minor Agility", image="INV_Potion_91"}
	},
	["Discussion"]={
	{action=[[AMAZE]], type=1, tooltip="", image="Spell_Holy_DivineIllumination"},
	{action=[[CURIOUS]], type=1, tooltip="", image="Ability_Ambush"},
	{action=[[SHRUG]], type=1, tooltip="", image="INV_Jewelcrafting_AzureHare"},
	{action=[[TALK]], type=1, tooltip="", image="Ability_Warrior_CommandingShout"},
	{action=[[WHINE]], type=1, tooltip="", image="Achievement_Character_Bloodelf_Female"},
	{action=[[LISTEN]], type=1, tooltip="", image="Ability_Hunter_Pet_Turtle"},
	{action=[[IDEA]], type=1, tooltip="", image="INV_Misc_Coin_19"},
	{action=[[Discussion2]], type=0, tooltip="More...", image="Ability_Warrior_CommandingShout"}
	},
	["Misc Buffs"]={
	{action=[[/use Shiny Bauble
			/script PickupInventoryItem(16);
			/run ReplaceEnchant();]], type=2, tooltip="Shiny Bauble", image="INV_Misc_Orb_03"},
	{action=[[/use Spiced Wolf Meat]], type=2, tooltip="Spiced Wolf Meat", image="INV_Misc_Food_65"},
	{action=[[/use Rough Sharpening Stone
			/script PickupInventoryItem(16);
			/run ReplaceEnchant();
				]], type=2, tooltip="Rough Sharpening Stone", image="INV_Stone_SharpeningStone_01"},
	{action=[[/use Minor Wizard Oil
			/script PickupInventoryItem(16);
			/run ReplaceEnchant();
				]], type=2, tooltip="Minor Wizard Oil", image="INV_Potion_100"},
	{action=[[/use Rough Weightstone
			/script PickupInventoryItem(16);
			/run ReplaceEnchant();
				]], type=2, tooltip="Rough Weightstone", image="INV_Stone_SharpeningStone_02"}
	},
	["Taunts"]={
	{action=[[CHICKEN]], type=1, tooltip="", image="Spell_Magic_PolymorphChicken"},
	{action=[[FLEX]], type=1, tooltip="", image="Ability_Warrior_StrengthOfArms"},
	{action=[[GLARE]], type=1, tooltip="", image="Ability_Warrior_ImprovedDisciplines"},
	{action=[[ROAR]], type=1, tooltip="", image="Ability_Warrior_BattleShout"},
	{action=[[THREATEN]], type=1, tooltip="", image="Achievement_Boss_Archimonde "},
	{action=[[TAUNT]], type=1, tooltip="", image="Ability_Warrior_WarCry"},
	{action=[[GROWL]], type=1, tooltip="", image="Racial_Orc_BerserkerStrength"},
	{action=[[Taunts2]], type=0, tooltip="More...", image="Ability_Warrior_Rampage"}
	},
	["Look"]={
	{action=[[STARE]], type=1, tooltip="", image="Spell_Holy_PowerInfusion"},
	{action=[[BLINK]], type=1, tooltip="", image="Spell_Nature_Sleep"},
	{action=[[EYE]], type=1, tooltip="", image="INV_Misc_Eye_01"},
	{action=[[GAZE]], type=1, tooltip="", image="Spell_Holy_DivineIllumination"},
	{action=[[BLANK]], type=1, tooltip="", image="INV_Mask_06"},
	{action=[[EYEBROW]], type=1, tooltip="", image="Achievement_Boss_Kael'thasSunstrider_01"},
	{action=[[ABSENT]], type=1, tooltip="", image="INV_Mask_03"},
	{action=[[Look2]], type=0, tooltip="More...", image="Ability_Hunter_MasterMarksman"}
	},
	["Greetings"]={
	{action=[[Greets]], type=0, tooltip="", image="INV_Misc_Toy_07"},
	{action=[[Farewells]], type=0, tooltip="", image="INV_Relics_IdolofFerocity"}
	},
	["Food/Drink"]={
	{action=[[DRINK]], type=1, tooltip="", image="INV_Drink_05"},
	{action=[[EAT]], type=1, tooltip="", image="INV_Misc_Food_11"},
	{action=[[CHUG]], type=1, tooltip="", image="INV_Misc_Beer_03"},
	{action=[[THIRSTY]], type=1, tooltip="", image="Achievement_OgrimsHammer"},
	{action=[[HUNGRY]], type=1, tooltip="", image="Ability_Warrior_BattleShout"}
	},
	["Celebrations2"]={
	{action=[[DING]], type=1, tooltip="", image="Achievement_Level_60"},
	{action=[[PROUD]], type=1, tooltip="", image="Achievement_Boss_KingYmiron"},
	{action=[[HIGHFIVE]], type=1, tooltip="", image="Spell_Holy_Chastise"},
	{action=[[VICTORY]], type=1, tooltip="", image="Achievement_BG_winWSG"},
	{action=[[Celebrations]], type=0, tooltip="Back...", image="Achievement_Quests_Completed_06"}
	},
	["Body Functions"]={
	{action=[[HICCUP]], type=1, tooltip="", image="Ability_Creature_Disease_02"},
	{action=[[DROOL]], type=1, tooltip="", image="Spell_Nature_UnrelentingStorm"},
	{action=[[FART]], type=1, tooltip="", image="Spell_Holiday_ToW_SpiceCloud"},
	{action=[[BURP]], type=1, tooltip="", image="Ability_BullRush"},
	{action=[[BREATH]], type=1, tooltip="", image="Ability_Suffocate"},
	{action=[[COUGH]], type=1, tooltip="", image="INV_Misc_AhnQirajTrinket_03"},
	{action=[[SNEEZE]], type=1, tooltip="", image="INV_Misc_Bandage_07"},
	{action=[[Body Functions2]], type=0, tooltip="", image="INV_Holiday_ToW_SpicePotion02"}
	},
	["Flirt4"]={
	{action=[[CHARM]], type=1, tooltip="", image="Spell_Shadow_SoothingKiss"},
	{action=[[SHIMMY]], type=1, tooltip="", image="INV_Misc_FireDancer_01"},
	{action=[[TEASE]], type=1, tooltip="", image="Spell_Shadow_SummonSuccubus"},
	{action=[[Flirt]], type=0, tooltip="Back...", image="Achievement_WorldEvent_Valentine"}
	},
	["Greets"]={
	{action=[[HAIL]], type=1, tooltip="Hail", image="Achievement_BG_3flagcap_nodeaths"},
	{action=[[HELLO]], type=1, tooltip="Hello", image="Spell_Holy_GreaterHeal"},
	{action=[[INTRODUCE]], type=1, tooltip="", image="Achievement_Reputation_04"},
	{action=[[WELCOME]], type=1, tooltip="", image="Achievement_Reputation_08"},
	{action=[[GREET]], type=1, tooltip="", image="firesglow"},
	{action=[[SALUTE]], type=1, tooltip="", image="Achievement_PVP_P_04"},
	{action=[[WAVE]], type=1, tooltip="", image="INV_Gauntlets_06"},
	{action=[[POKE]], type=1, tooltip="", image="INV_Staff_22"}
	},
	["Scared"]={
	{action=[[SWEAT]], type=1, tooltip="", image="INV_Elemental_Mote_Water01"},
	{action=[[SCARED]], type=1, tooltip="", image="Ability_Rogue_SurpriseAttack"},
	{action=[[BADFEELING]], type=1, tooltip="", image="Achievement_Boss_CThun"},
	{action=[[COWER]], type=1, tooltip="", image="Spell_Shadow_ConeOfSilence"},
	{action=[[PRAY]], type=1, tooltip="", image="Ability_Paladin_BeaconofLight"},
	{action=[[PANIC]], type=1, tooltip="", image="Spell_Shadow_UnstableAffliction_3"},
	{action=[[DUCK]], type=1, tooltip="", image="INV_Misc_TheGoldenCheep"},
	{action=[[NERVOUS]], type=1, tooltip="", image="Spell_Shadow_PsychicScream"}
	},
	["Look2"]={
	{action=[[AWE]], type=1, tooltip="", image="Ability_Warrior_Revenge"},
	{action=[[LOOK]], type=1, tooltip="", image="Spell_Shaman_Hex"},
	{action=[[SHIFTY]], type=1, tooltip="", image="Ability_Rogue_MasterOfSubtlety"},
	{action=[[SHUDDER]], type=1, tooltip="", image="Spell_Misc_EmotionAfraid"},
	{action=[[PEER]], type=1, tooltip="", image="INV_Misc_Spyglass_01"},
	{action=[[Look]], type=0, tooltip="Back...", image="Ability_Hunter_MasterMarksman"}
	},
	["Direction"]={
	{action=[[FOLLOW]], type=1, tooltip="", image="Achievement_BG_captureflag_WSG"},
	{action=[[WAIT]], type=1, tooltip="", image="INV_Misc_SurgeonGlove_01"},
	{action=[[POINT]], type=1, tooltip="", image="Spell_Holy_Stoicism"},
	{action=[[GO]], type=1, tooltip="", image="Spell_Holy_AshesToAshes"},
	{action=[[HURRY]], type=1, tooltip="", image="Ability_Warrior_FuriousResolve"},
	{action=[[LOST]], type=1, tooltip="", image="INV_Misc_Map_01"},
	{action=[[BECKON]], type=1, tooltip="", image="Spell_Holy_Chastise"}
	},
	["Body Functions2"]={
	{action=[[SNORT]], type=1, tooltip="", image="Ability_Hunter_Pet_Boar"},
	{action=[[SPIT]], type=1, tooltip="", image="INV_Misc_Slime_01"},
	{action=[[NOSEPICK]], type=1, tooltip="", image="INV_Misc_Coin_01"},
	{action=[[SCRATCH]], type=1, tooltip="Scratch", image="INV_Misc_Bone_06"},
	{action=[[Body Functions]], type=0, tooltip="Back...", image="INV_Holiday_ToW_SpicePotion02"}
	},
	["Attacks"]={
	{action=[[SLAP]], type=1, tooltip="", image="Ability_Hunter_BeastSoothe"},
	{action=[[PUNCH]], type=1, tooltip="", image="Ability_Rogue_KidneyShot"},
	{action=[[SMACK]], type=1, tooltip="", image="Ability_Warrior_Devastate"},
	{action=[[BONK]], type=1, tooltip="", image="INV_Mace_10"},
	{action=[[PINCH]], type=1, tooltip="", image="INV_Weapon_Hand_01"},
	{action=[[BITE]], type=1, tooltip="", image="Ability_Druid_Berserk"},
	{action=[[POUNCE]], type=1, tooltip="", image="Ability_Druid_SupriseAttack"},
	{action=[[PULSE]], type=1, tooltip="", image="Achievement_BG_tophealer_AB"}
	},
	["Disagree"]={
	{action=[[NO]], type=1, tooltip="", image="Spell_Shadow_DemonicPact"},
	{action=[[OBJECT]], type=1, tooltip="", image="Spell_Shadow_SacrificialShield"},
	{action=[[VETO]], type=1, tooltip="", image="Spell_ChargeNegative"},
	{action=[[DISAGREE]], type=1, tooltip="", image="Inv_Helm_Mask_ZulGurub_D_01"},
	{action=[[SNUB]], type=1, tooltip="", image="Achievement_Boss_GrandWidowFaerlina"},
	{action=[[DOUBT]], type=1, tooltip="", image="Achievement_Dungeon_UlduarRaid_Titan_01"},
	{action=[[SILENCE]], type=1, tooltip="", image="Ability_Racial_Avatar"}
	},
	["Who Stinks?"]={
	{action=[[SNIFF]], type=1, tooltip="", image="INV_Misc_Birdbeck_01"},
	{action=[[STINK]], type=1, tooltip="", image="Ability_Rogue_DeviousPoisons"}
	},
	["Silly"]={
	{action=[[MOO]], type=1, tooltip="", image="Spell_Nature_Polymorph_Cow"},
	{action=[[JOKE]], type=1, tooltip="", image="INV_Misc_Bomb_04"},
	{action=[[TICKLE]], type=1, tooltip="", image="INV_Feather_16"},
	{action=[[TRAIN]], type=1, tooltip="Train", image="INV_Misc_Toy_10"},
	{action=[[JK]], type=1, tooltip="", image="Achievement_Boss_Mekgineer_Thermaplugg "},
	{action=[[FLOP]], type=1, tooltip="", image="Ability_Racial_Avatar"},
	{action=[[TEASE]], type=1, tooltip="", image="Racial_Troll_Berserk"}
	},
	["Professions"]={
	{action=[[/cast First Aid]], type=2, tooltip="First Aid", image="Spell_Holy_SealOfSacrifice"},
	{action=[[/cast Cooking]], type=2, tooltip="", image="INV_Misc_Food_15"},
	{action=[[/cast Fishing]], type=2, tooltip="", image="Trade_Fishing"},
	{action=[[/cast Bushcraft]], type=2, tooltip="", image="INV_Torch_Lit"},
	{action=[[/cast Woodcutting]], type=2, tooltip="", image="INV_TradeskillItem_03"},
	{action=[[/cast Investigate]], type=2, tooltip="", image="Ability_Hunter_MasterMarksman"},
	{action=[[/cast Camouflage]], type=2, tooltip="", image="ability_hunter_camouflage"},
	{action=[[/cast Navigate]], type=2, tooltip="", image="INV_Misc_Map02"}
	},
	["Thinking"]={
	{action=[[THINK]], type=1, tooltip="", image="Spell_Holy_AuraMastery"},
	{action=[[PUZZLE]], type=1, tooltip="", image="Spell_Shaman_Hex"},
	{action=[[PONDER]], type=1, tooltip="", image="Achievement_Boss_Auriaya_01"},
	{action=[[CONFUSED]], type=1, tooltip="", image="Spell_Frost_Stun"}
	},
	["Taunts2"]={
	{action=[[REGRET]], type=1, tooltip="", image="Ability_Druid_Enrage"},
	{action=[[BRANDISH]], type=1, tooltip="", image="INV_Sword_06"},
	{action=[[CHALLENGE]], type=1, tooltip="", image="Achievement_BG_most_damage_killingblow_dieleast"},
	{action=[[SHAKEFIST]], type=1, tooltip="", image="Ability_Warrior_BloodFrenzy"},
	{action=[[SHOUT]], type=1, tooltip="", image="Ability_Warrior_WarCry"},
	{action=[[SNARL]], type=1, tooltip="", image="Ability_Hunter_Pet_Bear"},
	{action=[[CRACK]], type=1, tooltip="", image="Ability_Paladin_BlessedHands"},
	{action=[[Taunts]], type=0, tooltip="Back...", image="Ability_Warrior_Rampage"}
	},
	["Spells"]={
	{action=[[/cast Hearth]], type=2, tooltip="", image="INV_Misc_Rune_01"},
	{action=[[Misc Buffs]], type=0, tooltip="", image="INV_Potion_99"},
	{action=[[Elixirs]], type=0, tooltip="", image="INV_Alchemy_EndlessFlask_04"},
	{action=[[Scrolls]], type=0, tooltip="", image="INV_Inscription_Parchment"},
	{action=[[Professions]], type=0, tooltip="", image="Trade_Engineering"},
	{action=[[Mounts]], type=0, tooltip="Mounts", image="Ability_Mount_BigBlizzardBear"},
	{action=[[Pets]], type=0, tooltip="", image="INV_Box_Birdcage_01"}
	}
}

EMOTEBUTTONS_VT= {
	["Combat"]={
	{action=[[Taunts]], type=0, tooltip="", image="Ability_Warrior_Rampage"},
	{action=[[Mercy]], type=0, tooltip="", image="Achievement_Halloween_Cat_01"},
	{action=[[Orders]], type=0, tooltip="", image="Ability_Warrior_RallyingCry"},
	{action=[[INCOMING]], type=1, tooltip="", image="Ability_Warrior_FuriousResolve"},
	{action=[[Signals]], type=0, tooltip="", image="Spell_Holy_Stoicism"},
	{action=[[Celebrations]], type=0, tooltip="", image="Achievement_Quests_Completed_06"},
	{action=[[CHARGE]], type=1, tooltip="", image="Ability_Warrior_Charge"},
	{action=[[BLEED]], type=1, tooltip="", image="Spell_DeathKnight_BloodBoil"}
	},
	["Animations"]={
	{action=[[SIT]], type=1, tooltip="Sit", image="INV_Misc_Toy_02"},
	{action=[[STAND]], type=1, tooltip="Stand", image="Achievement_BG_kill_carrier_opposing_flagroom"},
	{action=[[DANCE]], type=1, tooltip="", image="INV_Misc_FireDancer_01"},
	{action=[[KNEEL]], type=1, tooltip="", image="Ability_Paladin_GaurdedbytheLight"},
	{action=[[LAYDOWN]], type=1, tooltip="", image="Spell_Shadow_TwistedFaith"},
	{action=[[SLEEP]], type=1, tooltip="", image="Spell_Nature_Sleep"},
	{action=[[POINT]], type=1, tooltip="", image="Spell_Holy_Stoicism"},
	{action=[[MOUNTSPECIAL]], type=1, tooltip="Mount Special", image="Ability_Mount_RidingHorse"}
	},
	["Comfort"]={
	{action=[[SOOTHE]], type=1, tooltip="", image="Spell_Holy_Silence"},
	{action=[[COMFORT]], type=1, tooltip="", image="Ability_Paladin_SacredCleansing"},
	{action=[[PAT]], type=1, tooltip="", image="Spell_Holy_Heal"}
	},
	["Bored"]={
	{action=[[BORED]], type=1, tooltip="Bored", image="Spell_Nature_Polymorph_Cow"},
	{action=[[FIDGET]], type=1, tooltip="", image="INV_Sigil_Thorim"},
	{action=[[BOUNCE]], type=1, tooltip="", image="INV_Misc_ThrowingBall_01"},
	{action=[[TAP]], type=1, tooltip="", image="Ability_Kick"}
	},
	["Rude"]={
	{action=[[RUDE]], type=1, tooltip="", image="Ability_Warlock_FireandBrimstone"},
	{action=[[INSULT]], type=1, tooltip="", image="Achievement_Boss_trollgore"},
	{action=[[MOCK]], type=1, tooltip="", image="INV_Mask_01"},
	{action=[[SHOO]], type=1, tooltip="", image="Ability_Hunter_BeastSoothe"},
	{action=[[PITY]], type=1, tooltip="", image="Spell_Shadow_RaiseDead"},
	{action=[[MOON]], type=1, tooltip="", image="Spell_Nature_MoonGlow"},
	{action=[[Rude3]], type=0, tooltip="More...", image="Spell_Druid_feralchargecat"}
	},
	["I'm Feeling"]={
	{action=[[Happy]], type=0, tooltip="", image="Spell_Misc_EmotionHappy"},
	{action=[[ANGRY]], type=1, tooltip="", image="Spell_Misc_EmotionAngry"},
	{action=[[Sad]], type=0, tooltip="Sad", image="Spell_Misc_EmotionSad"},
	{action=[[Surprised]], type=0, tooltip="Surprised", image="INV_Holiday_Christmas_Present_01"},
	{action=[[Scared]], type=0, tooltip="Scared", image="Spell_Misc_EmotionAfraid"},
	{action=[[Bored]], type=0, tooltip="Bored", image="Spell_Magic_PolymorphRabbit"},
	{action=[[Tired]], type=0, tooltip="Tired", image="Spell_Nature_Sleep"},
	{action=[[I'm Feeling 2]], type=0, tooltip="More Emotes", image="Ability_Rogue_Disguise"}
	},
	["Flirt3"]={
	{action=[[WINK]], type=1, tooltip="", image="Spell_Nature_FocusedMind"},
	{action=[[SCRATCH]], type=1, tooltip="", image="INV_Misc_Bone_06"},
	{action=[[WHISTLE]], type=1, tooltip="", image="Ability_Hunter_BeastCall"},
	{action=[[TICKLE]], type=1, tooltip="", image="INV_Feather_06"},
	{action=[[POKE]], type=1, tooltip="", image="Achievement_Reputation_Ogre"},
	{action=[[TEASE]], type=1, tooltip="", image="Spell_Shadow_SummonSuccubus"},
	{action=[[SHIMMY]], type=1, tooltip="", image="INV_Misc_FireDancer_01"},
	{action=[[Flirt]], type=0, tooltip="Back...", image="Achievement_WorldEvent_Valentine"}
	},
	["CMDs"]={
	{action=[[/script ReloadUI()]], type=2, tooltip="Reload UI", image="INV_Misc_PunchCards_Blue"},
	{action=[[/who]], type=2, tooltip="who", image="INV_Misc_Spyglass_02"},
	{action=[[/dnd I'm busy]], type=2, tooltip="DND", image="Spell_Shadow_SacrificialShield"},
	{action=[[/afk smoke break]], type=2, tooltip="Smoke Break", image="INV_Misc_Pipe_01"},
	{action=[[/script local r = GetXPExhaustion() if r then DEFAULT_CHAT_FRAME:AddMessage("Rested XP: " .. tostring(math.floor((r / UnitXPMax("player")) * 100)) .. "%", "SAY") else DEFAULT_CHAT_FRAME:AddMessage("No Rested XP.", "SAY") end]], type=2, tooltip="Rested XP", image="Spell_Nature_Sleep"},
	{action=[[/script ResetInstances()]], type=2, tooltip="Reset Instances", image="Achievement_Boss_Algalon_01"},
	{action=[[/script TargetByName("Moonstalker",true);
	/run SetRaidTarget("target", 8); ]], type=2, tooltip="Looking for unit", image="Ability_CheapShot"},
	{action=[[/eb options]], type=2, tooltip="Emote Buttons Options", image="INV_Misc_Wrench_02"}
	},
	["Mercy"]={
	{action=[[BEG]], type=1, tooltip="", image="Spell_Holy_Chastise"},
	{action=[[GROVEL]], type=1, tooltip="", image="Ability_Paladin_GaurdedbytheLight"},
	{action=[[PLEAD]], type=1, tooltip="", image="Spell_Holy_SealOfBlood"},
	{action=[[SURRENDER]], type=1, tooltip="", image="Achievement_BG_kill_carrier_opposing_flagroom"}
	},
	["Sad"]={
	{action=[[CRY]], type=1, tooltip="", image="Ability_Rogue_BloodyEye"},
	{action=[[MOURN]], type=1, tooltip="", image="INV_Misc_Bone_HumanSkull_02"},
	{action=[[VIOLIN]], type=1, tooltip="", image="INV_Misc_Drum_01"},
	{action=[[FROWN]], type=1, tooltip="", image="Spell_Misc_EmotionSad"},
	{action=[[GROAN]], type=1, tooltip="", image="Ability_Devour"},
	{action=[[SIGH]], type=1, tooltip="", image="Ability_Suffocate"}
	},
	["Thanks"]={
	{action=[[BOW]], type=1, tooltip="", image="Ability_Paladin_GaurdedbytheLight"},
	{action=[[CURTSEY]], type=1, tooltip="", image="INV_Kilt_Cloth_02"},
	{action=[[THANK]], type=1, tooltip="", image="Spell_Holy_DevineAegis"},
	{action=[[APOLOGIZE]], type=1, tooltip="", image="Spell_Misc_EmotionSad"}
	},
	["Spells"]={
	{action=[[/use Hearthstone]], type=2, tooltip="", image="INV_Misc_Rune_01"},
	{action=[[Misc Buffs]], type=0, tooltip="", image="INV_Potion_99"},
	{action=[[Elixirs]], type=0, tooltip="", image="INV_Alchemy_EndlessFlask_04"},
	{action=[[Scrolls]], type=0, tooltip="", image="INV_Inscription_Parchment"},
	{action=[[Professions]], type=0, tooltip="", image="Trade_Engineering"},
	{action=[[Mounts]], type=0, tooltip="Mounts", image="Ability_Mount_BigBlizzardBear"},
	{action=[[Pets]], type=0, tooltip="", image="INV_Box_Birdcage_01"}
	},
	["Agree"]={
	{action=[[AGREE]], type=1, tooltip="", image="Achievement_BG_tophealer_WSG"},
	{action=[[NOD]], type=1, tooltip="", image="INV_Helmet128"},
	{action=[[RAISE]], type=1, tooltip="", image="Ability_Paladin_BlessedHands"}
	},
	["Rude3"]={
	{action=[[SPIT]], type=1, tooltip="", image="INV_Elemental_Crystal_Water"},
	{action=[[RASP]], type=1, tooltip="", image="INV_Sword_123"},
	{action=[[CRINGE]], type=1, tooltip="", image="Spell_Misc_EmotionAfraid"},
	{action=[[Rude]], type=0, tooltip="Back...", image="Spell_Druid_feralchargecat"}
	},
	["Main"]={
	{action=[[I'm Feeling]], type=0, tooltip="Emotions", image="Ability_Rogue_Disguise"},
	{action=[[Greetings]], type=0, tooltip="", image="Achievement_Reputation_01"},
	{action=[[Small Talk]], type=0, tooltip="", image="Temp"},
	{action=[[Conversation]], type=0, tooltip="", image="INV_Drink_22"},
	{action=[[Combat]], type=0, tooltip="", image="Achievement_Arena_2v2_7"},
	{action=[[RP]], type=0, tooltip="", image="Achievement_Zone_Stonetalon_01"},
	{action=[[Spells]], type=0, tooltip="", image="Ability_Racial_Ultravision"},
	{action=[[CMDs]], type=0, tooltip="", image="Mail_GMIcon"}
	},
	["Sarcastic"]={
	{action=[[ROLLEYES]], type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"},
	{action=[[SNORT]], type=1, tooltip="", image="Ability_Hunter_ZenArchery"},
	{action=[[GROAN]], type=1, tooltip="", image="Achievement_Zone_ZulDrak_12"}
	},
	["LOL"]={
	{action=[[CACKLE]], type=1, tooltip="", image="Spell_Shadow_CurseOfTounges"},
	{action=[[CHUCKLE]], type=1, tooltip="", image="Achievement_Boss_Auriaya_01"},
	{action=[[GUFFAW]], type=1, tooltip="", image="Achievement_Character_Dwarf_Male"},
	{action=[[ROFL]], type=1, tooltip="", image="INV_Misc_Toy_09"},
	{action=[[SNICKER]], type=1, tooltip="", image="Ability_Hunter_Pet_Hyena"},
	{action=[[GLOAT]], type=1, tooltip="", image="INV_Misc_Coin_02"},
	{action=[[LAUGH]], type=1, tooltip="", image="Spell_Fire_LavaSpawn"},
	{action=[[GIGGLE]], type=1, tooltip="", image="Achievement_Character_Gnome_Female"}
	},
	["Signals"]={
	{action=[[READY]], type=1, tooltip="", image="Achievement_BG_tophealer_WSG"},
	{action=[[OOM]], type=1, tooltip="", image="INV_Drink_18"},
	{action=[[BECKON]], type=1, tooltip="", image="INV_Stone_12"}
	},
	["Happy"]={
	{action=[[SMILE]], type=1, tooltip="", image="Achievement_WorldEvent_Brewmaster"},
	{action=[[HAPPY]], type=1, tooltip="", image="INV_Misc_PenguinPet"},
	{action=[[TALKEX]], type=1, tooltip="", image="Temp"},
	{action=[[SMIRK]], type=1, tooltip="", image="Achievement_Boss_Kael'thasSunstrider_01"},
	{action=[[GRIN]], type=1, tooltip="", image="Spell_Shadow_Charm"}
	},
	["I'm Feeling 2"]={
	{action=[[CALM]], type=1, tooltip="Calm", image="Achievement_Character_Draenei_Male"},
	{action=[[GLOAT]], type=1, tooltip="Boastful", image="INV_Misc_Coin_02"},
	{action=[[GRIN]], type=1, tooltip="Evil", image="Achievement_Leader_King_Varian_Wrynn"},
	{action=[[COLD]], type=1, tooltip="Cold", image="Spell_Frost_FrostArmor"},
	{action=[[SHIVER]], type=1, tooltip="Shivering", image="INV_Boots_Cloth_03"},
	{action=[[CONFUSED]], type=1, tooltip="Confused", image="Spell_Frost_Stun"}
	},
	["Tired"]={
	{action=[[TIRED]], type=1, tooltip="", image="Spell_Nature_Sleep"},
	{action=[[YAWN]], type=1, tooltip="", image="Ability_Warrior_BattleShout"},
	{action=[[SLEEP]], type=1, tooltip="", image="INV_Misc_Bandage_07"}
	},
	["Direction"]={
	{action=[[FOLLOW]], type=1, tooltip="", image="Achievement_BG_captureflag_WSG"},
	{action=[[WAIT]], type=1, tooltip="", image="INV_Misc_SurgeonGlove_01"},
	{action=[[POINT]], type=1, tooltip="", image="Spell_Holy_Stoicism"},
	{action=[[LOST]], type=1, tooltip="", image="INV_Misc_Map_01"},
	{action=[[BECKON]], type=1, tooltip="", image="Spell_Holy_Chastise"}
	},
	["Celebrations"]={
	{action=[[APPLAUD]], type=1, tooltip="", image="Achievement_BG_tophealer_AB"},
	{action=[[CHEER]], type=1, tooltip="", image="Achievement_BG_most_damage_killingblow_dieleast"},
	{action=[[CLAP]], type=1, tooltip="", image="Spell_Holy_BlindingHeal"},
	{action=[[CONGRATULATE]], type=1, tooltip="", image="Achievement_Dungeon_HEROIC_GloryoftheRaider"},
	{action=[[COMMEND]], type=1, tooltip="", image="Achievement_BG_tophealer_AV"},
	{action=[[PRAISE]], type=1, tooltip="", image="Spell_Holy_GreaterBlessingofLight"},
	{action=[[VICTORY]], type=1, tooltip="", image="Achievement_BG_KillFlagCarriers_grabFlag_CapIt"}
	},
	["Small Talk"]={
	{action=[[LOL]], type=0, tooltip="", image="Racial_Troll_Berserk"},
	{action=[[Rude]], type=0, tooltip="", image="Spell_Druid_feralchargecat"},
	{action=[[Thanks]], type=0, tooltip="", image="Spell_Holy_Chastise"},
	{action=[[Who Stinks?]], type=0, tooltip="", image="Spell_Deathknight_UnholyPresence"},
	{action=[[Celebrations]], type=0, tooltip="", image="Achievement_Quests_Completed_06"}
	},
	["RP"]={
	{action=[[Animations]], type=0, tooltip="", image="INV_Misc_Drum_03"},
	{action=[[Body Functions]], type=0, tooltip="", image="INV_Holiday_ToW_SpicePotion02"},
	{action=[[Food/Drink]], type=0, tooltip="", image="INV_Misc_Food_68"},
	{action=[[Look]], type=0, tooltip="", image="Ability_Hunter_MasterMarksman"},
	{action=[[Thinking]], type=0, tooltip="", image="Spell_Arcane_MindMastery"},
	{action=[[Attacks]], type=0, tooltip="", image="Ability_Warrior_Devastate"},
	{action=[[WORK]], type=1, tooltip="", image="Trade_Mining"}
	},
	["Conversation"]={
	{action=[[Discussion]], type=0, tooltip="", image="Ability_Warrior_CommandingShout"},
	{action=[[Silly]], type=0, tooltip="", image="Spell_Shadow_Charm"},
	{action=[[Comfort]], type=0, tooltip="", image="Spell_Holy_Heroism"},
	{action=[[Sus]], type=0, tooltip="", image="Ability_Rogue_MasterOfSubtlety"},
	{action=[[Direction]], type=0, tooltip="", image="INV_Misc_Map02"},
	{action=[[Agree]], type=0, tooltip="", image="Achievement_BG_tophealer_WSG"},
	{action=[[Disagree]], type=0, tooltip="", image="Achievement_Boss_Exarch_Maladaar"},
	{action=[[Flirt]], type=0, tooltip="", image="Achievement_WorldEvent_Valentine"}
	},
	["Orders"]={
	{action=[[OPENFIRE]], type=1, tooltip="", image="INV_Musket_04"},
	{action=[[ATTACKMYTARGET]], type=1, tooltip="", image="INV_Sword_06"},
	{action=[[HEALME]], type=1, tooltip="", image="Spell_Holy_DivineProvidence"},
	{action=[[HELPME]], type=1, tooltip="", image="Spell_Druid_feralchargecat"},
	{action=[[FLEE]], type=1, tooltip="", image="Ability_Rogue_Sprint"}
	},
	["Flirt"]={
	{action=[[BASHFUL]], type=1, tooltip="", image="INV_Hammer_18"},
	{action=[[BLUSH]], type=1, tooltip="", image="ACHIEVEMENT_BOSS_KILJAEDAN"},
	{action=[[HUG]], type=1, tooltip="", image="Ability_Druid_Maul"},
	{action=[[KISS]], type=1, tooltip="", image="Spell_Shadow_SoothingKiss"},
	{action=[[MASSAGE]], type=1, tooltip="", image="INV_Gauntlets_06"},
	{action=[[MOAN]], type=1, tooltip="", image="Achievement_Boss_Auriaya_01"},
	{action=[[SEXY]], type=1, tooltip="", image="INV_Misc_Idol_01"},
	{action=[[Flirt2]], type=0, tooltip="More...", image="Achievement_WorldEvent_Valentine"}
	},
	["Pets"]={
	{action=[[/use Cat Carrier (Bombay)]], type=2, tooltip="Bombay Cat", image="INV_Box_PetCarrier_01"},
	{action=[[/use Cat Carrier (Cornish Rex)]], type=2, tooltip="", image="INV_Box_PetCarrier_01"},
	{action=[[/use Cat Carrier (Orange Tabby)]], type=2, tooltip="", image="INV_Box_PetCarrier_01"},
	{action=[[/use Cat Carrier (Silver Tabby)]], type=2, tooltip="", image="INV_Box_PetCarrier_01"}
	},
	["Elixirs"]={
	{action=[[/use Elixir of Minor Defense]], type=2, tooltip="Elixir of Minor Defense", image="INV_Potion_63"},
	{action=[[/use Elixir of Lion's Strength]], type=2, tooltip="Elixir of Lion's Strength", image="INV_Potion_56"},
	{action=[[/use Weak Troll's Blood Potion]], type=2, tooltip="Weak Troll's Blood Potion", image="INV_Potion_77"},
	{action=[[/use Elixir of Minor Fortitude]], type=2, tooltip="Elixir of Minor Fortitude", image="INV_Potion_42"},
	{action=[[/use Elixir of Minor Agility]], type=2, tooltip="Elixir of Minor Agility", image="INV_Potion_91"}
	},
	["Who Stinks?"]={
	{action=[[SNIFF]], type=1, tooltip="", image="INV_Misc_Birdbeck_01"},
	{action=[[STINK]], type=1, tooltip="", image="Ability_Rogue_DeviousPoisons"}
	},
	["Misc Buffs"]={
	{action=[[/use Shiny Bauble
			/script PickupInventoryItem(16);
			/run ReplaceEnchant();]], type=2, tooltip="Shiny Bauble", image="INV_Misc_Orb_03"},
	{action=[[/use Spiced Wolf Meat]], type=2, tooltip="Spiced Wolf Meat", image="INV_Misc_Food_65"},
	{action=[[/use Rough Sharpening Stone
			/script PickupInventoryItem(16);
			/run ReplaceEnchant();
				]], type=2, tooltip="Rough Sharpening Stone", image="INV_Stone_SharpeningStone_01"},
	{action=[[/use Minor Wizard Oil
			/script PickupInventoryItem(16);
			/run ReplaceEnchant();
				]], type=2, tooltip="Minor Wizard Oil", image="INV_Potion_100"},
	{action=[[/use Rough Weightstone
			/script PickupInventoryItem(16);
			/run ReplaceEnchant();
				]], type=2, tooltip="Rough Weightstone", image="INV_Stone_SharpeningStone_02"}
	},
	["Taunts"]={
	{action=[[CHICKEN]], type=1, tooltip="", image="Spell_Magic_PolymorphChicken"},
	{action=[[FLEX]], type=1, tooltip="", image="Ability_Warrior_StrengthOfArms"},
	{action=[[GLARE]], type=1, tooltip="", image="Ability_Warrior_ImprovedDisciplines"},
	{action=[[ROAR]], type=1, tooltip="", image="Ability_Warrior_BattleShout"},
	{action=[[THREATEN]], type=1, tooltip="", image="Achievement_Boss_Archimonde "},
	{action=[[TAUNT]], type=1, tooltip="", image="Ability_Warrior_WarCry"},
	{action=[[GROWL]], type=1, tooltip="", image="Racial_Orc_BerserkerStrength"},
	{action=[[Taunts2]], type=0, tooltip="More...", image="Ability_Warrior_Rampage"}
	},
	["Look"]={
	{action=[[STARE]], type=1, tooltip="", image="Spell_Holy_PowerInfusion"},
	{action=[[BLINK]], type=1, tooltip="", image="Spell_Nature_Sleep"},
	{action=[[EYE]], type=1, tooltip="", image="INV_Misc_Eye_01"},
	{action=[[GAZE]], type=1, tooltip="", image="Spell_Holy_DivineIllumination"},
	{action=[[Look2]], type=0, tooltip="More...", image="Ability_Hunter_MasterMarksman"}
	},
	["Greetings"]={
	{action=[[Greets]], type=0, tooltip="", image="INV_Misc_Toy_07"},
	{action=[[BRB]], type=1, tooltip="", image="Achievement_BG_returnXflags_def_WSG"},
	{action=[[BYE]], type=1, tooltip="", image="INV_Gauntlets_04"},
	{action=[[SALUTE]], type=1, tooltip="", image="Achievement_PVP_G_04"}
	},
	["Sus"]={
	{action=[[TALKQ]], type=1, tooltip="", image="INV_Misc_QuestionMark"},
	{action=[[PUZZLE]], type=1, tooltip="", image="Inv_Helm_Mask_ZulGurub_D_01"}
	},
	["Mounts"]={
	{action=[[/use Swift Zulian Tiger]], type=2, tooltip="Tiger", image="Ability_Mount_JungleTiger"},
	{action=[[/use Swift Razzashi Raptor]], type=2, tooltip="", image="Ability_Mount_Raptor"},
	{action=[[/use Mekgineer's Chopper]], type=2, tooltip="", image="INV_Misc_Key_06"},
	{action=[[/use Swift White Hawkstrider]], type=2, tooltip="", image="Ability_Mount_CockatriceMountElite_White"}
	},
	["Look2"]={
	{action=[[PEER]], type=1, tooltip="", image="INV_Misc_Spyglass_01"},
	{action=[[Look]], type=0, tooltip="Back...", image="Ability_Hunter_MasterMarksman"}
	},
	["Discussion"]={
	{action=[[AMAZE]], type=1, tooltip="", image="Spell_Holy_DivineIllumination"},
	{action=[[CURIOUS]], type=1, tooltip="", image="Ability_Ambush"},
	{action=[[SHRUG]], type=1, tooltip="", image="INV_Jewelcrafting_AzureHare"},
	{action=[[TALK]], type=1, tooltip="", image="Ability_Warrior_CommandingShout"},
	{action=[[WHINE]], type=1, tooltip="", image="Achievement_Character_Bloodelf_Female"},
	{action=[[LISTEN]], type=1, tooltip="", image="Ability_Hunter_Pet_Turtle"}
	},
	["Food/Drink"]={
	{action=[[DRINK]], type=1, tooltip="", image="INV_Drink_05"},
	{action=[[EAT]], type=1, tooltip="", image="INV_Misc_Food_11"},
	{action=[[THIRSTY]], type=1, tooltip="", image="Achievement_OgrimsHammer"},
	{action=[[HUNGRY]], type=1, tooltip="", image="Ability_Warrior_BattleShout"}
	},
	["Scared"]={
	{action=[[SCARED]], type=1, tooltip="", image="Ability_Rogue_SurpriseAttack"},
	{action=[[COWER]], type=1, tooltip="", image="Spell_Shadow_ConeOfSilence"},
	{action=[[PRAY]], type=1, tooltip="", image="Ability_Paladin_BeaconofLight"},
	{action=[[PANIC]], type=1, tooltip="", image="Spell_Shadow_UnstableAffliction_3"},
	{action=[[DUCK]], type=1, tooltip="", image="INV_Misc_TheGoldenCheep"}
	},
	["Body Functions"]={
	{action=[[DROOL]], type=1, tooltip="", image="Spell_Nature_UnrelentingStorm"},
	{action=[[FART]], type=1, tooltip="", image="Spell_Holiday_ToW_SpiceCloud"},
	{action=[[BURP]], type=1, tooltip="", image="Ability_BullRush"},
	{action=[[COUGH]], type=1, tooltip="", image="INV_Misc_AhnQirajTrinket_03"},
	{action=[[SPIT]], type=1, tooltip="", image="INV_Misc_Slime_01"},
	{action=[[NOSEPICK]], type=1, tooltip="", image="INV_Misc_Coin_01"},
	{action=[[SCRATCH]], type=1, tooltip="", image="INV_Misc_Bone_06"}
	},
	["Greets"]={
	{action=[[HAIL]], type=1, tooltip="", image="Achievement_BG_3flagcap_nodeaths"},
	{action=[[HELLO]], type=1, tooltip="", image="Spell_Holy_GreaterHeal"},
	{action=[[INTRODUCE]], type=1, tooltip="", image="Achievement_Reputation_04"},
	{action=[[WELCOME]], type=1, tooltip="", image="Achievement_Reputation_08"},
	{action=[[GREET]], type=1, tooltip="", image="firesglow"},
	{action=[[SALUTE]], type=1, tooltip="", image="Achievement_PVP_P_04"},
	{action=[[WAVE]], type=1, tooltip="", image="INV_Gauntlets_06"},
	{action=[[POKE]], type=1, tooltip="", image="INV_Staff_22"}
	},
	["Surprised"]={
	{action=[[BOGGLE]], type=1, tooltip="", image="INV_Elemental_Primal_Water"},
	{action=[[SURPRISED]], type=1, tooltip="", image="Achievement_Dungeon_ClassicDungeonMaster"},
	{action=[[GASP]], type=1, tooltip="", image="Ability_Creature_Disease_03"}
	},
	["Attacks"]={
	{action=[[SLAP]], type=1, tooltip="", image="Ability_Hunter_BeastSoothe"},
	{action=[[BONK]], type=1, tooltip="", image="INV_Mace_10"},
	{action=[[BITE]], type=1, tooltip="", image="Ability_Druid_Berserk"},
	{action=[[POUNCE]], type=1, tooltip="", image="Ability_Druid_SupriseAttack"}
	},
	["Disagree"]={
	{action=[[NO]], type=1, tooltip="", image="Spell_Shadow_DemonicPact"},
	{action=[[VETO]], type=1, tooltip="", image="Spell_ChargeNegative"},
	{action=[[SNUB]], type=1, tooltip="Snub", image="Achievement_Boss_GrandWidowFaerlina"}
	},
	["Flirt2"]={
	{action=[[SHAKE]], type=1, tooltip="", image="INV_Misc_Food_99"},
	{action=[[SHY]], type=1, tooltip="", image="Spell_Misc_EmotionHappy"},
	{action=[[CUDDLE]], type=1, tooltip="", image="Spell_Holy_GuardianSpirit"},
	{action=[[LICK]], type=1, tooltip="", image="Spell_Shadow_SoothingKiss"},
	{action=[[PURR]], type=1, tooltip="", image="INV_Misc_Head_Tiger_01"},
	{action=[[LOVE]], type=1, tooltip="", image="Achievement_WorldEvent_Valentine"},
	{action=[[FLIRT]], type=1, tooltip="", image="Achievement_Character_Bloodelf_Female"},
	{action=[[Flirt3]], type=0, tooltip="More...", image="Achievement_WorldEvent_Valentine"}
	},
	["Silly"]={
	{action=[[MOO]], type=1, tooltip="", image="Spell_Nature_Polymorph_Cow"},
	{action=[[JOKE]], type=1, tooltip="", image="INV_Misc_Bomb_04"},
	{action=[[TICKLE]], type=1, tooltip="", image="INV_Feather_16"},
	{action=[[TRAIN]], type=1, tooltip="Train", image="INV_Misc_Toy_10"},
	{action=[[JK]], type=1, tooltip="", image="Achievement_Boss_Mekgineer_Thermaplugg "},
	{action=[[FLOP]], type=1, tooltip="", image="Ability_Racial_Avatar"},
	{action=[[TEASE]], type=1, tooltip="", image="Racial_Troll_Berserk"}
	},
	["Professions"]={
	{action=[[/cast First Aid]], type=2, tooltip="First Aid", image="Spell_Holy_SealOfSacrifice"},
	{action=[[/cast Cooking]], type=2, tooltip="", image="INV_Misc_Food_15"},
	{action=[[/cast Fishing]], type=2, tooltip="", image="Trade_Fishing"}
	},
	["Thinking"]={
	{action=[[PUZZLE]], type=1, tooltip="", image="Spell_Shaman_Hex"},
	{action=[[PONDER]], type=1, tooltip="", image="Achievement_Boss_Auriaya_01"},
	{action=[[CONFUSED]], type=1, tooltip="", image="Spell_Frost_Stun"}
	},
	["Taunts2"]={
	{action=[[SHOUT]], type=1, tooltip="", image="Ability_Warrior_WarCry"},
	{action=[[SNARL]], type=1, tooltip="", image="Ability_Hunter_Pet_Bear"},
	{action=[[CRACK]], type=1, tooltip="", image="Ability_Paladin_BlessedHands"},
	{action=[[Taunts]], type=0, tooltip="Back...", image="Ability_Warrior_Rampage"}
	},
	["Scrolls"]={
	{action=[[/use Scroll of Spirit]], type=2, tooltip="Scroll of Spirit", image="INV_Scroll_01"},
	{action=[[/use Scroll of Protection]], type=2, tooltip="Scroll of Protection", image="INV_Scroll_07"},
	{action=[[/use Scroll of Stamina]], type=2, tooltip="Scroll of Stamina", image="INV_Scroll_07"},
	{action=[[/use Scroll of Intellect]], type=2, tooltip="Scroll of Intellect", image="INV_Scroll_01"},
	{action=[[/use Scroll of Strength]], type=2, tooltip="Scroll of Strength", image="INV_Scroll_02"},
	{action=[[/use Scroll of Agility]], type=2, tooltip="Scroll of Agility", image="INV_Scroll_02"}
	}
}

EMOTEBUTTONS_PROFILES = {
	{Name="Default - Vanilla", Decks=EMOTEBUTTONS_VT},
	{Name="Default - Extended", Decks=EMOTEBUTTONS_ET},
	{Name="Empty", Decks=EMOTEBUTTONS_MT}
}