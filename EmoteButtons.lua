--[[

EmoteButtons - By QuippeR, upgraded by Tubtubs

Adds an expanding menu system that grants access to emotes, slash commands
and macros. Supports profiles, and export and importing of profiles.
Shift click a button, or type /eb for more options.

CHANGELOG:
Expanded left and right wings to be 8 buttons
Added far left and far right wings (increases max buttons greatly)
Added Emote, and Deck managers
Added Icon picker dialog (uses expanded icon list)
Added Deckbuilder (replaces original config window)
Advanced Config Window
-Importing/Exporting Profiles
-Reset profile and position
Macro Support
All new layout, featuring 250+ emotes and slash commands, and macros

TODO:
***Readme.md
***Clean up code, look into isolating icon picker into it's own addon. Will need wrapper functions.
Clean up EmoteButtons.lua
-DeckBuilder.lua
-DeckBuilder.xml
--Include all the relevant code, and frames. Delete replaced old frames.
--Deprecate EmoteButtonsConfig.xml
Make a 2nd reset, reset and default

NOTE: Only seems to lag with larger deck sizes. (open wings)
	--probably about how the deck lookup is handled, not fading
	DEFAULT_CHAT_FRAME:AddMessage("TEST")
]]--



--[[ Old comment header, leaving in for credits. They probably don't want to be contacted about this addon though.

EmoteButtons

author: QuippeR		<quipper@gmail.com>

Adds a menu to access emotes and slash commands.

Feel free to contact me if you've got questions, comments, requests or additions.

Shift click a button to get to the options.


]]--


--------------------------------------------------------------
--      Don't change code unless you know what you do!      --
--------------------------------------------------------------


EmoteButtons_FirstLevel =
	{"EmoteButtons_01", "EmoteButtons_02", "EmoteButtons_03", "EmoteButtons_04",
	 "EmoteButtons_05", "EmoteButtons_06", "EmoteButtons_07", "EmoteButtons_08"};
EmoteButtons_FirstLevelCount = getn(EmoteButtons_FirstLevel);

EmoteButtons_WingCount = 8;

EmoteButtons_LeftWingCount = 8;
EmoteButtons_LeftWing = 
	{"EmoteButtons_10", "EmoteButtons_11", "EmoteButtons_12",
	 "EmoteButtons_14", "EmoteButtons_15", "EmoteButtons_16",
	"EmoteButtons_18","EmoteButtons_19"};
EmoteButtons_LeftWing_Deck = "#0";

EmoteButtons_FarLeftWingCount = 8;
EmoteButtons_FarLeftWing = 
	{"EmoteButtons_30", "EmoteButtons_31", "EmoteButtons_32",
	 "EmoteButtons_34", "EmoteButtons_35", "EmoteButtons_36",
	"EmoteButtons_38","EmoteButtons_39"};
EmoteButtons_FarLeftWing_Deck = "#0";

EmoteButtons_RightWingCount = 8;
EmoteButtons_RightWing = 
	{"EmoteButtons_20", "EmoteButtons_21", "EmoteButtons_22",
	 "EmoteButtons_24", "EmoteButtons_25", "EmoteButtons_26",
	"EmoteButtons_28", "EmoteButtons_29"};
EmoteButtons_RightWing_Deck = "#0";

EmoteButtons_FarRightWingCount = 8;
EmoteButtons_FarRightWing = 
	{"EmoteButtons_40", "EmoteButtons_41", "EmoteButtons_42",
	 "EmoteButtons_44", "EmoteButtons_45", "EmoteButtons_46",
	"EmoteButtons_48","EmoteButtons_49"};
EmoteButtons_FarRightWing_Deck = "#0";

EmoteButtons_FirstLevelName = "Main"; -- Still need this constant, it's special as first level.

--Levels of emotes shown (which wings, if any are open)
EmoteButtons_Levels={["Main"]=false,["Left"]=false, ["Right"]=false,
						["FarLeft"]=false, ["FarRight"]=false }

--Used to reload this when customizing
EmoteButtons_OldLevels={["Main"]=false,["Left"]=false, ["Right"]=false,
						["FarLeft"]=false, ["FarRight"]=false }

EmoteButtons_ConfigDeck = "#0";
EmoteButtons_ConfigButton = 0;

--Needed for options menu
EmoteButtons_DeckList={}

EB_CurrentActions = {} --Taking out of saved variables for easier reference

-- chat inputs
local function TextMenu(arg)
	if arg == nil or arg == "" then
		DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Emote Buttons:|r This is help topic for |cFFFFFF00 /EmoteButtons or /EB.|r",1,1,1)
		DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Emote Buttons:|r |cFFFFFF00 /EmoteButtons deckbuilder|r - opens the deckbuilder.",1,1,1)
		DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Emote Buttons:|r |cFFFFFF00 /EmoteButtons options|r - opens the advanced config window.",1,1,1)		
		DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Emote Buttons:|r |cFFFFFF00 /EmoteButtons resetposition|r - resets position of the main button.",1,1,1)
		DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Emote Buttons:|r |cFFFFFF00 /EmoteButtons resetprofile|r - resets the current profile, and deck config to default.",1,1,1)
	else
		if arg == "resetposition" then
			EmoteButtons_ResetPosition()
		elseif arg == "resetprofile" then
			EmoteButtons_ResetProfile()
		elseif arg == "options" then
			EmoteButtons_AdvancedConfigFrame:Show();
		elseif arg == "deckbuilder" then
			--DeckBuilderFrame:Show();
			EmoteButtons_OpenDeckBuilder()
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Emote Buttons:|r unknown command",1,0.3,0.3);
		end
	end
end
-- slashcommands
SlashCmdList['EMOTEBUTTONS'] = TextMenu
SLASH_EMOTEBUTTONS1 = '/EmoteButtons'
SLASH_EMOTEBUTTONS2 = '/EB'

local function sort_alphabetical(a, b)
	return a < b
end

function EmoteButtons_ResetPosition()
	EmoteButtons_Main:ClearAllPoints()
	EmoteButtons_Main:SetPoint("CENTER", UIParent ,"CENTER", 0, 0)
end

function EmoteButtons_WipeVars()
	if not EmoteButtons_Vars then
		EmoteButtons_Vars = {
			Main_Ratio = 42,
			Main_Shift = 0,
			Wing_Shift = 0,
			Profiles = EMOTEBUTTONS_PROFILES,
			Profile=EMOTEBUTTONS_PROFILES[1].Name,
			PIndex=1;
		};
	end

	--populate deck list
	EmoteButtons_DeckList = {}
	for i, v in pairs(EB_CurrentActions) do
		table.insert(EmoteButtons_DeckList,i)
	end
	table.sort(EmoteButtons_DeckList,sort_alphabetical);
end

--potentially unused...
function EmoteButtons_Reset()
	EmoteButtons_LeftWing_Deck = "#0";
	EmoteButtons_RightWing_Deck = "#0";
	EmoteButtons_FarLeftWing_Deck = "#0";
	EmoteButtons_FarRightWing_Deck = "#0";
	EmoteButtons_ToggleFirstLevel();
	EmoteButtons_WipeVars();
end

function EmoteButtons_ToggleWing(wing)
	local i=0
	local obj;
	local wc=getglobal("EmoteButtons_"..wing.."Wing")
	local deck = getglobal("EmoteButtons_"..wing.."Wing_Deck")
	local lwc = getn(wc);
	for i=1, lwc do
		obj = getglobal(wc[i]);
		if (EmoteButtons_Levels[wing]) then
			FadeOutFrame(obj, 0.1*i);
		elseif (EB_CurrentActions[deck][i]~=nil and 
		EB_CurrentActions[deck][i].action~=nil) then
			FadeInFrame(obj,0.15*(lwc-i));
		end
	end
	--flip the flag on the way out
	EmoteButtons_Levels[wing] = not EmoteButtons_Levels[wing]
end


function EmoteButtons_Init()
	local i;
	for i = 1, EmoteButtons_FirstLevelCount do
		CreateFrame("Button", EmoteButtons_FirstLevel[i], EmoteButtons_Main, "EmoteButtons_template");
	end
	for i = 1, EmoteButtons_LeftWingCount do
		CreateFrame("Button", EmoteButtons_LeftWing[i], EmoteButtons_Main, "EmoteButtons_template");
	end
	for i = 1, EmoteButtons_RightWingCount do
		CreateFrame("Button", EmoteButtons_RightWing[i], EmoteButtons_Main, "EmoteButtons_template");
	end
	for i = 1, EmoteButtons_FarLeftWingCount do
		CreateFrame("Button", EmoteButtons_FarLeftWing[i], EmoteButtons_Main, "EmoteButtons_template");
	end
	for i = 1, EmoteButtons_FarRightWingCount do
		CreateFrame("Button", EmoteButtons_FarRightWing[i], EmoteButtons_Main, "EmoteButtons_template");
	end

	UIErrorsFrame:AddMessage(EMOTEBUTTONS_INIT_TEXT, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

--ran on addon load
function EmoteButtons_LoadedVars()
	EmoteButtons_WipeVars();
	EB_CurrentActions = EmoteButtons_Vars.Profiles[EmoteButtons_Vars.PIndex].Decks
	EmoteButtons_AdvancedConfigFrame_SetMainShift:SetValue(EmoteButtons_Vars.Main_Shift);
	EmoteButtons_AdvancedConfigFrame_SetMainSize:SetValue(EmoteButtons_Vars.Main_Ratio);
	EmoteButtons_ArrangeFrames();
end

function EmoteButtons_ArrangeFrames()

	local i, obj, correction;

	--button size
	local mra = EmoteButtons_Vars.Main_Ratio;
	--icon size inside the button
	local mri = floor(0.6*mra);
	--main deck distance from center
	local mr = floor(mra*1.29);
	--main deck shift in degrees
	local ms = EmoteButtons_Vars.Main_Shift;
	--main deck correction to get eclipse
	local mrc = floor(mr/5);
	--wings distance from center
	local wr = floor(mra*2.29);
	--wings shift in degrees
	local ws = EmoteButtons_Vars.Wing_Shift;
	--far wings distance from center
	local fwr = floor(mra*3.29);

	--main button
	obj=EmoteButtons_Main;
	obj:SetWidth(mra);
	obj:SetHeight(mra);
	obj = getglobal(obj:GetName().."_Icon");
	obj:SetWidth(mri);
	obj:SetHeight(mri);

	--main deck
	local size = EmoteButtons_FirstLevelCount+2;
	local deg = floor(360/size);
	local shift = 0;
	for i=1, size-1 do
		if i ~= size/2 then
			if (i == 1) or (i == (size/2-1)) then
				correction = mrc;
			elseif (i == (size/2+1)) or (i == size - 1) then
				correction = - mrc;
			else
				correction = 0;
			end
			obj = getglobal(EmoteButtons_FirstLevel[i+shift]);
			obj:SetPoint("CENTER", EmoteButtons_Main, "CENTER", - mr*sin(i*deg+ms)+correction*cos(ms),mr*cos(i*deg+ms)+correction*sin(ms));
			obj:SetWidth(mra);
			obj:SetHeight(mra);
			obj = getglobal(obj:GetName().."_Icon");
			obj:SetWidth(mri);
			obj:SetHeight(mri);
		else
			shift = -1;
		end
	end
	
	--left wing
	size = EmoteButtons_LeftWingCount+3;
	--deg = floor(180/size+1)
	deg = 20
	shift = -1;
	for i=1, size-3 do
		obj = getglobal(EmoteButtons_LeftWing[i]);
		obj:SetPoint("CENTER", EmoteButtons_Main, "CENTER", - wr*sin(i*deg+ws),wr*cos(i*deg+ws));
		obj:SetWidth(mra);
		obj:SetHeight(mra);
		obj = getglobal(obj:GetName().."_Icon");
		obj:SetWidth(mri);
		obj:SetHeight(mri);
	end

	--right wing
	size = EmoteButtons_RightWingCount+3;
	deg = 20
	shift = -1;
	for i=1, size-3 do
		obj = getglobal(EmoteButtons_RightWing[i]);
		obj:SetPoint("CENTER", EmoteButtons_Main, "CENTER", wr*sin(i*deg-ws),wr*cos(i*deg-ws));
		obj:SetWidth(mra);
		obj:SetHeight(mra);
		obj = getglobal(obj:GetName().."_Icon");
		obj:SetWidth(mri);
		obj:SetHeight(mri);
	end

	--far left wing
	size = EmoteButtons_FarLeftWingCount+3;
	--deg = floor(180/size+1)
	deg = 20
	shift = -1;
	for i=1, size-3 do
		obj = getglobal(EmoteButtons_FarLeftWing[i]);
		obj:SetPoint("CENTER", EmoteButtons_Main, "CENTER", - fwr*sin(i*deg+ws),fwr*cos(i*deg+ws));
		obj:SetWidth(mra);
		obj:SetHeight(mra);
		obj = getglobal(obj:GetName().."_Icon");
		obj:SetWidth(mri);
		obj:SetHeight(mri);
	end

	--far right wing
	size = EmoteButtons_FarRightWingCount+3;
	deg = 20
	shift = -1;
	for i=1, size-3 do
		obj = getglobal(EmoteButtons_FarRightWing[i]);
		obj:SetPoint("CENTER", EmoteButtons_Main, "CENTER", fwr*sin(i*deg-ws),fwr*cos(i*deg-ws));
		obj:SetWidth(mra);
		obj:SetHeight(mra);
		obj = getglobal(obj:GetName().."_Icon");
		obj:SetWidth(mri);
		obj:SetHeight(mri);
	end
end

--Test code, considered re-arranging for different button quantities.
--Might experiment, and enable later now that it's easier to test with deck manager.
function ReArrangeLeftWing()
	local i, obj, correction;

	--button size
	local mra = EmoteButtons_Vars.Main_Ratio;
	--icon size inside the button
	local mri = floor(0.6*mra);
	--main deck distance from center
	local mr = floor(mra*1.29);
	--main deck shift in degrees
	local ms = EmoteButtons_Vars.Main_Shift;
	--main deck correction to get eclipse
	local mrc = floor(mr/5);
	--wings distance from center
	local wr = floor(mra*2.29);
	--wings shift in degrees
	local ws = EmoteButtons_Vars.Wing_Shift;

	--left wing
	real_size = 0
	for i=1, getn(EmoteButtons_LeftWing) do
		if (EB_CurrentActions[EmoteButtons_LeftWing_Deck][i]~=nil) then
			real_size = real_size+1
		else
			break
		end
	end
	size = real_size+3;
	deg = floor((180)/real_size)
	--deg = 20
	shift = -1;
	for i=1, size-3 do
		obj = getglobal(EmoteButtons_LeftWing[i]);
		obj:SetPoint("CENTER", EmoteButtons_Main, "CENTER", - wr*sin(i*deg+ws),wr*cos(i*deg+ws));
		obj:SetWidth(mra);
		obj:SetHeight(mra);
		obj = getglobal(obj:GetName().."_Icon");
		obj:SetWidth(mri);
		obj:SetHeight(mri);
	end
end

--maybe should make local?
function FadeOutFrame( frame, time )
	local fadeInfo = {}
	fadeInfo.mode = "OUT"
	fadeInfo.timeToFade = time
	fadeInfo.startAlpha = frame:GetAlpha()
	fadeInfo.endAlpha = 0
	fadeInfo.finishedFunc = FadeFinished
	fadeInfo.finishedArg1 = frame

	frame.fadeMode = "OUT"
	UIFrameFade( frame, fadeInfo );
	frame:EnableMouse( false );
end

--maybe should make local?
function FadeInFrame( frame, time )
	local fadeInfo = {}
	fadeInfo.mode = "IN"
	fadeInfo.timeToFade = time
	fadeInfo.startAlpha = 0
	fadeInfo.endAlpha = 1
	fadeInfo.finishedFunc = FadeFinished
	fadeInfo.finishedArg1 = frame

	frame.fadeMode = "IN"
	UIFrameFade( frame, fadeInfo );
	frame:Show();
	frame:EnableMouse( true );
end

function EmoteButtons_FadeIn(frame, time, alpha)
	local fadeInfo = {}
	fadeInfo.mode = "IN"
	fadeInfo.timeToFade = time
	fadeInfo.startAlpha = frame:GetAlpha()
	fadeInfo.endAlpha = alpha
	fadeInfo.finishedFunc = nil
	fadeInfo.finishedArg1 = frame

	frame.fadeMode = "IN"
	UIFrameFade( frame, fadeInfo );
end

function EmoteButtons_FadeOut( frame, time, alpha )
	local fadeInfo = {}
	fadeInfo.mode = "OUT"
	fadeInfo.timeToFade = time
	fadeInfo.startAlpha = frame:GetAlpha()
	fadeInfo.endAlpha = alpha
	fadeInfo.finishedFunc = nil
	fadeInfo.finishedArg1 = frame

	frame.fadeMode = "OUT"
	UIFrameFade( frame, fadeInfo );
end

function FadeFinished( frame )
	if ( frame.fadeMode == "OUT" ) then
		frame:Hide()
	end
	frame.fadeMode = nil
end

function EmoteButtons_ToggleFirstLevel()
	local i=0;
	local image;
	local obj;
	local flc = getn(EB_CurrentActions[EmoteButtons_FirstLevelName]);
	if EmoteButtons_Levels["FarLeft"] then
		EmoteButtons_ToggleWing("FarLeft");
	end
	if EmoteButtons_Levels["FarRight"] then
		EmoteButtons_ToggleWing("FarRight");
	end
	if EmoteButtons_Levels["Left"] then
		EmoteButtons_ToggleWing("Left");
	end
	if EmoteButtons_Levels["Right"] then
		EmoteButtons_ToggleWing("Right");
	end

	
	for i=1, flc do
		obj = getglobal(EmoteButtons_FirstLevel[i]);
		if EmoteButtons_Levels["Main"] then
			FadeOutFrame(obj,0.1*i);
		else
			image = EB_CurrentActions[EmoteButtons_FirstLevelName][i].image;
			getglobal(EmoteButtons_FirstLevel[i].."_Icon"):SetTexture("Interface\\Icons\\"..image);
			FadeInFrame(obj,0.15*(flc-i));
		end
	end
	EmoteButtons_Levels["Main"] = not EmoteButtons_Levels["Main"]
end

function EmoteButtons_FadeWing(wing)
	local i=0;
	local obj;
	local wingT, wingC;
	if wing == "left" then
		wingT=EmoteButtons_LeftWing;
	elseif wing == "right" then
		wingT=EmoteButtons_RightWing;
	elseif wing =="farleft" then	
		wingT = EmoteButtons_FarLeftWing;
	elseif wing =="farright" then	
		wingT = EmoteButtons_FarRightWing;
	end

	wingC=getn(wingT);
	for i=1, wingC do
		obj=getglobal(wingT[i]);
		if (wing == "left") then
			if (EB_CurrentActions[EmoteButtons_LeftWing_Deck][i]~=nil) then
				FadeInFrame(obj, 0.1*i);
			else
				FadeOutFrame(obj, 0.1*i);
			end
		elseif (wing == "right") then
			if (EB_CurrentActions[EmoteButtons_RightWing_Deck][i]~=nil) then
				FadeInFrame(obj, 0.1*i);
			else
				FadeOutFrame(obj, 0.1*i);
			end
		elseif (wing == "farleft") then
			if (EB_CurrentActions[EmoteButtons_FarLeftWing_Deck][i]~=nil) then
				FadeInFrame(obj, 0.1*i);
			else
				FadeOutFrame(obj, 0.1*i);
			end
		elseif (wing == "farright") then
			if (EB_CurrentActions[EmoteButtons_FarRightWing_Deck][i]~=nil) then
				FadeInFrame(obj, 0.1*i);
			else
				FadeOutFrame(obj, 0.1*i);
			end
		end
	end
end

function EmoteButtons_ClickAction(framename)
	local i;
	local found = 0;
	local action = "";
	local tooltip = "";
	local wing = "";

	for i=1, EmoteButtons_FirstLevelCount do
		if EmoteButtons_FirstLevel[i] == framename then
			found = i;
		end
	end
	if found~=0 then
		action = EB_CurrentActions[EmoteButtons_FirstLevelName][found].action;
		tooltip = EB_CurrentActions[EmoteButtons_FirstLevelName][found].tooltip;
		acttype = EB_CurrentActions[EmoteButtons_FirstLevelName][found].type;
		--generate wing dynamically instead of hard coding.
		--Just the indexes of left/right sides, a little better
		if found < 5 then
			wing = "Left"
		else
			wing = "Right"
		end
	--configure
		if IsShiftKeyDown() then
			EmoteButtons_ConfigDeck = EmoteButtons_FirstLevelName;
			EmoteButtons_ConfigButton = found;
			EmoteButtons_OpenDeckBuilder();
		elseif acttype==EBACTTYPE_DECK then
			EmoteButtons_ToggleDeck(action, wing);
		elseif acttype==EBACTTYPE_EMOTE then
			EmoteButtons_DoEmote(action);
		elseif acttype==EBACTTYPE_SLASHCMD then	
			EmoteButtons_DoAction(action);
		end
	else
		for i=1, EmoteButtons_LeftWingCount do
			if EmoteButtons_LeftWing[i] == framename then
				found = i;
			end
		end
		if found~=0 then
			action = EB_CurrentActions[EmoteButtons_LeftWing_Deck][found].action;		
			acttype = EB_CurrentActions[EmoteButtons_LeftWing_Deck][found].type;		

			if IsShiftKeyDown() then
				EmoteButtons_ConfigDeck = EmoteButtons_LeftWing_Deck;
				EmoteButtons_ConfigButton = found;
				EmoteButtons_OpenDeckBuilder();
			elseif acttype==EBACTTYPE_DECK then
				EmoteButtons_ToggleDeck(action, "FarLeft");
			elseif acttype==EBACTTYPE_EMOTE then
				EmoteButtons_DoEmote(action);
			elseif acttype==EBACTTYPE_SLASHCMD then	
				EmoteButtons_DoAction(action);
			end
		else
			for i=1, EmoteButtons_RightWingCount do
				if EmoteButtons_RightWing[i] == framename then
					found = i;
				end
			end
			if found ~= 0 then
				action = EB_CurrentActions[EmoteButtons_RightWing_Deck][found].action;		
				acttype = EB_CurrentActions[EmoteButtons_RightWing_Deck][found].type;
				if IsShiftKeyDown() then
					EmoteButtons_ConfigDeck = EmoteButtons_RightWing_Deck;
					EmoteButtons_ConfigButton = found;
					EmoteButtons_OpenDeckBuilder();
				elseif acttype==EBACTTYPE_DECK then
					EmoteButtons_ToggleDeck(action, "FarRight");
				elseif acttype==EBACTTYPE_EMOTE then
					EmoteButtons_DoEmote(action);
				elseif acttype==EBACTTYPE_SLASHCMD then	
					EmoteButtons_DoAction(action);
				end
			else
				for i=1, EmoteButtons_FarLeftWingCount do
					if EmoteButtons_FarLeftWing[i] == framename then
						found = i;
					end
				end
				if found~=0 then
					action = EB_CurrentActions[EmoteButtons_FarLeftWing_Deck][found].action;		
					acttype = EB_CurrentActions[EmoteButtons_FarLeftWing_Deck][found].type;	

					if IsShiftKeyDown() then
						EmoteButtons_ConfigDeck = EmoteButtons_FarLeftWing_Deck;
						EmoteButtons_ConfigButton = found;
						EmoteButtons_OpenDeckBuilder();
					elseif acttype==EBACTTYPE_DECK then
						EmoteButtons_ToggleDeck(action, "FarLeft");
					elseif acttype==EBACTTYPE_EMOTE then
						EmoteButtons_DoEmote(action);
					elseif acttype==EBACTTYPE_SLASHCMD then	
						EmoteButtons_DoAction(action);
					end		
				else
					for i=1, EmoteButtons_FarRightWingCount do
						if EmoteButtons_FarRightWing[i] == framename then
							found = i;
						end		
					end

					if found~=0 then
						action = EB_CurrentActions[EmoteButtons_FarRightWing_Deck][found].action;
						acttype = EB_CurrentActions[EmoteButtons_FarRightWing_Deck][found].type;	
					end
					if IsShiftKeyDown() then
						EmoteButtons_ConfigDeck = EmoteButtons_FarRightWing_Deck;
						EmoteButtons_ConfigButton = found;
						EmoteButtons_OpenDeckBuilder();
					elseif acttype==EBACTTYPE_DECK then
						EmoteButtons_ToggleDeck(action, "FarRight");
					elseif acttype==EBACTTYPE_EMOTE then
						EmoteButtons_DoEmote(action);
					elseif acttype==EBACTTYPE_SLASHCMD then	
						EmoteButtons_DoAction(action);
					end		
				end
			end
		end
	end
end

function EmoteButtons_ToggleDeck(deck, wing)
	if wing=="Left" then
		if EmoteButtons_LeftWing_Deck==deck then
			if(EmoteButtons_Levels["FarLeft"]) then
				EmoteButtons_ToggleWing("FarLeft");
			end
			EmoteButtons_ToggleWing("Left");
		else
			EmoteButtons_LoadDeck(deck, wing); 
			if (EmoteButtons_Levels["Left"]) then
				if(EmoteButtons_Levels["FarLeft"]) then
					EmoteButtons_ToggleWing("FarLeft");
				end
				EmoteButtons_FadeWing("left");
			else
				EmoteButtons_ToggleWing("Left");
			end
		end
	elseif wing=="Right" then
		if EmoteButtons_RightWing_Deck==deck then
			if(EmoteButtons_Levels["FarRight"]) then
				EmoteButtons_ToggleWing("FarRight");
			end
			EmoteButtons_ToggleWing("Right");
		else
			EmoteButtons_LoadDeck(deck, wing);
			if (EmoteButtons_Levels["Right"]) then
				if(EmoteButtons_Levels["FarRight"]) then
					EmoteButtons_ToggleWing("FarRight");
				end
				EmoteButtons_FadeWing("right");
			else
				EmoteButtons_ToggleWing("Right");
			end
		end
	elseif wing=="FarLeft" then		
		if EmoteButtons_FarLeftWing_Deck==deck then
			EmoteButtons_ToggleWing("FarLeft");
		else
			EmoteButtons_LoadDeck(deck, wing);
			if (EmoteButtons_Levels["FarLeft"]) then
				EmoteButtons_FadeWing("farleft");
			else
				EmoteButtons_ToggleWing("FarLeft");
			end
		end	
	elseif wing=="FarRight" then		
		if EmoteButtons_FarRightWing_Deck==deck then
			EmoteButtons_ToggleWing("FarRight");
		else
			EmoteButtons_LoadDeck(deck, wing);
			if (EmoteButtons_Levels["FarRight"]) then
				EmoteButtons_FadeWing("farright");
			else
				EmoteButtons_ToggleWing("FarRight");
			end
		end	
	end
end

function EmoteButtons_LoadDeck(deck, wing)
	local i;
	local image;
	if wing== '' then
		for i=1, getn( EB_CurrentActions[deck]) do
			image = EB_CurrentActions[deck][i].image;
			getglobal(EmoteButtons_FirstLevel[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	elseif wing == "Left" then
		EmoteButtons_LeftWing_Deck = deck
		for i=1, getn( EB_CurrentActions[deck]) do
			image = EB_CurrentActions[deck][i].image;
			getglobal(EmoteButtons_LeftWing[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	elseif wing == "Right" then
		EmoteButtons_RightWing_Deck = deck
		for i=1, getn( EB_CurrentActions[deck]) do
			image = EB_CurrentActions[deck][i].image;
			getglobal(EmoteButtons_RightWing[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	elseif wing =="FarLeft" then
		EmoteButtons_FarLeftWing_Deck = deck
		for i=1, getn( EB_CurrentActions[deck]) do
			image = EB_CurrentActions[deck][i].image;
			getglobal(EmoteButtons_FarLeftWing[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	elseif wing =="FarRight" then
		EmoteButtons_FarRightWing_Deck = deck
		for i=1, getn( EB_CurrentActions[deck]) do
			image = EB_CurrentActions[deck][i].image;
			getglobal(EmoteButtons_FarRightWing[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	end
end

function EmoteButtons_DoAction(text)
	for w in string.gfind(text, "([^\r\n]+)") do
		EmoteButtons_EditBox:SetText(w);
		ChatEdit_SendText(EmoteButtons_EditBox);
	end
end

function EmoteButtons_DoEmote(text)
	DoEmote(text);
end

function EmoteButtons_ShowTooltip(framename)
	local i,x,anchor;
	local found = 0;
	local tooltip = "";
	local action = "";
	local setup = EMOTEBUTTONS_SETTINGSWARN;
	local fulltext = "";
	for i=1, EmoteButtons_FirstLevelCount do
		if EmoteButtons_FirstLevel[i] == framename then
			found = i;
		end
	end
	if found~=0 then
		tooltip = EB_CurrentActions[EmoteButtons_FirstLevelName][found].tooltip;
		action = EB_CurrentActions[EmoteButtons_FirstLevelName][found].action;
		acttype = EB_CurrentActions[EmoteButtons_FirstLevelName][found].type;
		if found>floor(EmoteButtons_FirstLevelCount/2) then
			anchor = "ANCHOR_BOTTOMRIGHT"
			x = 30;
		else
			anchor = "ANCHOR_BOTTOMLEFT"
			x = -30;
		end
	else
		for i=1, EmoteButtons_LeftWingCount do
			if EmoteButtons_LeftWing[i] == framename then
				found = i;
			end
		end
		if found~=0 then
			tooltip = EB_CurrentActions[EmoteButtons_LeftWing_Deck][found].tooltip;
			action = EB_CurrentActions[EmoteButtons_LeftWing_Deck][found].action;
			acttype = EB_CurrentActions[EmoteButtons_LeftWing_Deck][found].type;
			anchor = "ANCHOR_BOTTOMLEFT"
			x = -30;
		else
			for i=1, EmoteButtons_RightWingCount do
				if EmoteButtons_RightWing[i] == framename then
					found = i;
				end
			end

			if found ~=0 then
				tooltip = EB_CurrentActions[EmoteButtons_RightWing_Deck][found].tooltip;
				action = EB_CurrentActions[EmoteButtons_RightWing_Deck][found].action;
				acttype = EB_CurrentActions[EmoteButtons_RightWing_Deck][found].type;
				anchor = "ANCHOR_BOTTOMRIGHT"
				x = 30;
			else

				for i=1, EmoteButtons_FarLeftWingCount do
					if EmoteButtons_FarLeftWing[i] == framename then
						found = i;
					end
				end
				
				if found ~=0 then
					tooltip = EB_CurrentActions[EmoteButtons_FarLeftWing_Deck][found].tooltip;
					action = EB_CurrentActions[EmoteButtons_FarLeftWing_Deck][found].action;
					acttype = EB_CurrentActions[EmoteButtons_FarLeftWing_Deck][found].type;
					anchor = "ANCHOR_BOTTOMLEFT"
					x = -30;
				else
					for i=1, EmoteButtons_FarRightWingCount do
						if EmoteButtons_FarRightWing[i] == framename then
							found = i;
						end
					end
					
					if found ~=0 then
						tooltip = EB_CurrentActions[EmoteButtons_FarRightWing_Deck][found].tooltip;
						action = EB_CurrentActions[EmoteButtons_FarRightWing_Deck][found].action;
						acttype = EB_CurrentActions[EmoteButtons_FarRightWing_Deck][found].type;
						anchor = "ANCHOR_BOTTOMLEFT"
						x = -30;
					end
				end	
			end	
		end
	end

	if (acttype == EBACTTYPE_EMOTE) then
		trg = UnitName("target");
		plr = UnitName("player");
		action = string.upper(action); --Emotelist is all upper, don't want to change that.
		found = 0;
		for i=1, getn(EB_EmoteList) do
			if EB_EmoteList[i].Name == action then
				found = i;
				break;
			end
		end
		if (found ~= 0 and EB_EmoteList[found] and trg and trg ~= plr) then
			--fulltext = "|cFFFFFFFF"..tooltip.."|n|r".. trg;
			action = format(EB_EmoteList[found].TargetEmoteText,trg)
			--fulltext = "|cFFFFFFFF"..tooltip.."|n|r".. format(EB_EmoteList[found].TargetEmoteText,trg);
		else
			--fulltext = "|cFFFFFFFF"..tooltip.."|n|r".. "EMOTE";
			action = EB_EmoteList[found].SelfEmoteText
			--fulltext = "|cFFFFFFFF"..tooltip.."|n|r".. EB_EmoteList[found].SelfEmoteText;
		end

	end
	--prioritizes showing a tooltip instead of CMD or emote text
	if string.len(tooltip) == 0 then
		fulltext = "|cFFFFFFFF"..action;
	elseif (acttype == EBACTTYPE_SLASHCMD) then
		fulltext = "|cFFFFFFFF"..tooltip;
	else
		fulltext = "|cFFFFFFFF"..tooltip.."|n|r"..action;
	end

	--Adds tooltip about customization if deckbuilder is open
	GameTooltip:SetOwner(getglobal(framename), anchor);
	if DeckBuilderFrame:IsShown() then
		fulltext = fulltext..setup;
	end
	GameTooltip:SetText(fulltext);
	GameTooltip:Show();
end

function EmoteButtons_HideTooltip()
	GameTooltip:Hide();
end

function EmoteButtons_OpenDeckBuilder()
	DeckBuilderFrame:Show();
	DeckBuilderFrame_ScrollToSelected();
	IconPickerFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide(); 
end

--Rotation and size slider
function EmoteButtons_SliderChanged(sender, units)
	local val = "err";
	if sender=="EmoteButtons_AdvancedConfigFrame_SetMainShift" then
		val = EmoteButtons_AdvancedConfigFrame_SetMainShift:GetValue();
		EmoteButtons_Vars.Main_Shift = val;
		EmoteButtons_Vars.Wing_Shift = val;
	else
		val = EmoteButtons_AdvancedConfigFrame_SetMainSize:GetValue();
		EmoteButtons_Vars.Main_Ratio = val;
	end
	getglobal(sender.."Value"):SetText(val..units);
	EmoteButtons_ArrangeFrames();

end

function EmoteButtons_CloseOpenDecks()
	local deck = EmoteButtons_ConfigDeck;
	EmoteButtons_SaveOpenDecks();
	if(EmoteButtons_Levels["Main"] and
		EmoteButtons_FirstLevelName == deck) then
		EmoteButtons_ToggleFirstLevel();
	elseif(EmoteButtons_Levels["FarLeft"] and 
		EmoteButtons_FarLeftWing_Deck==deck) then 
		--EmoteButtons_ToggleWing("Left");
		EmoteButtons_ToggleWing("FarLeft");
	elseif (EmoteButtons_Levels["Left"] and 
			EmoteButtons_LeftWing_Deck==deck) then 
		EmoteButtons_ToggleWing("Left");
	elseif (EmoteButtons_Levels["FarRight"] and
		EmoteButtons_FarRightWing_Deck==deck) then 
		--EmoteButtons_ToggleWing("Right");
		EmoteButtons_ToggleWing("FarRight");
	elseif (EmoteButtons_Levels["Right"] and
			EmoteButtons_RightWing_Deck==deck) then
		EmoteButtons_ToggleWing("Right");
	end
end

function EmoteButtons_ReOpenDecks()
	if(EmoteButtons_OldLevels["Main"] and
		not EmoteButtons_Levels["Main"]) then
		EmoteButtons_ToggleFirstLevel();
	end
	if(EmoteButtons_OldLevels["FarLeft"] and
		not EmoteButtons_Levels["FarLeft"]) then 
		--EmoteButtons_ToggleWing("Left");
		EmoteButtons_ToggleWing("FarLeft");
	elseif (EmoteButtons_OldLevels["Left"] and
		not EmoteButtons_Levels["Left"]) then 
		EmoteButtons_ToggleWing("Left");
	end
	if (EmoteButtons_OldLevels["FarRight"] and
		not EmoteButtons_Levels["FarRight"]) then 
		--EmoteButtons_ToggleWing("Right");
		EmoteButtons_ToggleWing("FarRight");
	elseif (EmoteButtons_OldLevels["Right"] and
		not EmoteButtons_Levels["Right"]) then
		EmoteButtons_ToggleWing("Right");
	end

end

function EmoteButtons_SaveOpenDecks()
	EmoteButtons_OldLevels["Main"]=EmoteButtons_Levels["Main"]
	EmoteButtons_OldLevels["Left"]=EmoteButtons_Levels["Left"]
	EmoteButtons_OldLevels["FarLeft"]=EmoteButtons_Levels["FarLeft"]
	EmoteButtons_OldLevels["Right"]=EmoteButtons_Levels["Right"]
	EmoteButtons_OldLevels["FarRight"]=EmoteButtons_Levels["FarRight"]
end