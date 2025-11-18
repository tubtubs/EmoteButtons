--[[

Tubtubs
Looking to expand this EmoteButtons addon to include support for future expansions emotes.


CHANGELOG:
Expanded left and right wings to be 8 buttons
Added far left and far right wings (increases max buttons greatly)
Added Emote, and Deck managers
Added Icon picker dialog (uses expanded icon list)
Added Deckbuilder (replaces original config window)
Advanced Config Window
-Importing/Exporting Profiles
Macro Support
All new default deck layout, featuring 250+ emotes and slash commands, and macros

TODO:
Setup Default Profile[CHECK]
-Could always use refinement, want to shuffle some buttons around
-CMD isnt auto filled if its first or last? [FIXED]
-Still a test output somewhere when opening/closing rightwing? [check]
-Tighten up UI constraints [check]
--closing iconpicker/CMD prompt when other action or deck is picked
--updating okay button in iconpicker when changing categories
-Rename deck[Check]
-Move button up or down [Check]
-Random icon button would be REALLY cool [CHECK]
-Clean up visuals on deckbuilder, move deck/action items down and maybe add border [CHECK]
Macro Support (lol) [CHECK]
*-Save profiles by default, don't really care for save prompts
--Removed save prompt, and made changes immediately permanent
*Could also move around some icons in the icon list. 
--Some professions might be missing icons that could be there
--Would need to force searching MISC last if there's overlap
--Rockets/Clusters should be in engineering...
--Some faction tabards in misc
--Feathers could be in Inscription, but I think theyre fine in misc
--Glyphs in inscription?

***Clean up code, look into isolating icon picker into it's own addon. Will need wrapper functions.
Clean up EmoteButtons.lua
-DeckBuilder.lua
-DeckBuilder.xml
--Include all the relevant code, and frames. Delete replaced old frames.
--Deprecate EmoteButtonsConfig.xml
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

--needed hack
EmoteButtons_CanChangeSlider = false;

--image slider
EmoteButtons_ImageSlideCenter = floor(EmoteButtons_ImageCount/2);
EmoteButtons_LastSlide = 0;

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
			ResetPosition()
		elseif arg == "resetprofile" then
			ResetProfile()
		elseif arg == "options" then
			EmoteButtons_AdvancedConfigFrame:Show();
		elseif arg == "deckbuilder" then
			--DeckBuilderFrame:Show();
			EmoteButtons_UpdateConfig()
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Emote Buttons:|r unknown command",1,0.3,0.3);
		end
	end
end
-- slashcommands
SlashCmdList['EMOTEBUTTONS'] = TextMenu
SLASH_EMOTEBUTTONS1 = '/EmoteButtons'
SLASH_EMOTEBUTTONS2 = '/EB'

function HideAllPopupsFrames()
	StaticPopup_Hide ("EMOTEBUTTONS_CHANGECOMMAND")
	StaticPopup_Hide ("DELETE_DECK_CONFIRMATION")
	StaticPopup_Hide ("EMOTEBUTTONS_CHANGETOOLTIP")
	StaticPopup_Hide ("RESET_PROFILE_CONFIRMATION")
	StaticPopup_Hide ("EMOTEBUTTONS_NEWPROFILE")
	StaticPopup_Hide ("EMOTEBUTTONS_DUPLICATEPROFILE")
	StaticPopup_Hide ("DELETE_PROFILE_CONFIRMATION")
	StaticPopup_Hide ("SET_PROFILE_CONFIRMATION")
	StaticPopup_Hide ("SAVE_PROFILE_CONFIRMATION")
	StaticPopup_Hide ("EMOTEBUTTONS_NEWDECK")
	StaticPopup_Hide ("SET_PROFILE_CONFIRMATION")
	StaticPopup_Hide ("EMOTEBUTTONS_RENAMEDECK")
end

function sort_alphabetical(a, b)
	return a < b
end

function EmoteButtons_WipeVars()
	local i,j;
	local inr = EmoteButtons_ImageCount;
	if not EmoteButtons_Vars then
		EmoteButtons_Vars = {
			--Actions = EMOTEBUTTONS_PROFILES[1].Decks,
			Main_Ratio = 42,
			Main_Shift = 0,
			Wing_Shift = 0,
			Profiles = EMOTEBUTTONS_PROFILES,
			Profile=EMOTEBUTTONS_PROFILES[1].Name,
			PIndex=1;
		};

--		for i, v in pairs(EB_CurrentActions) do
--			for j, v in pairs(EB_CurrentActions[i]) do
--				EB_CurrentActions[i][j].image = EmoteButtons_ImageList[math.random(inr)];
--			end
--		end
	end

	EmoteButtons_DeckList = {}
	for i, v in pairs(EB_CurrentActions) do
		table.insert(EmoteButtons_DeckList,i)
	end

	table.sort(EmoteButtons_DeckList,sort_alphabetical);

end

--EmoteButtons_WipeVars();

function EmoteButtons_Reset()
	EmoteButtons_LeftWing_Deck = "#0";
	EmoteButtons_RightWing_Deck = "#0";
	EmoteButtons_FarLeftWing_Deck = "#0";
	EmoteButtons_FarRightWing_Deck = "#0";
	EmoteButtons_ToggleFirstLevel();
	EmoteButtons_WipeVars();
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
		EmoteButtons_ToggleFarLeftWing();
	end
	if EmoteButtons_Levels["FarRight"] then
		EmoteButtons_ToggleFarRightWing();
	end
	if EmoteButtons_Levels["Left"] then
		EmoteButtons_ToggleLeftWing();
	end
	if EmoteButtons_Levels["Right"] then
		EmoteButtons_ToggleRightWing();
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

function EmoteButtons_ToggleFarLeftWing()
	local i=0
	local obj;
	local lwc = getn(EmoteButtons_FarLeftWing);
	for i=1, lwc do
		obj = getglobal(EmoteButtons_FarLeftWing[i]);
		if (EmoteButtons_Levels["FarLeft"]) then
			FadeOutFrame(obj, 0.1*i);
		elseif (EB_CurrentActions[EmoteButtons_FarLeftWing_Deck][i]~=nil and 
		EB_CurrentActions[EmoteButtons_FarLeftWing_Deck][i].action~=nil) then
			FadeInFrame(obj,0.15*(lwc-i));
		end
	end
	--flip the flag on the way out
	EmoteButtons_Levels["FarLeft"] = not EmoteButtons_Levels["FarLeft"]
end

function EmoteButtons_ToggleFarRightWing()
	local i=0
	local obj;
	local lwc = getn(EmoteButtons_FarRightWing);
	for i=1, lwc do
		obj = getglobal(EmoteButtons_FarRightWing[i]);
		if (EmoteButtons_Levels["FarRight"]) then
			FadeOutFrame(obj, 0.1*i);
		elseif (EB_CurrentActions[EmoteButtons_FarRightWing_Deck][i]~=nil and 
		EB_CurrentActions[EmoteButtons_FarRightWing_Deck][i].action~=nil) then
			FadeInFrame(obj,0.15*(lwc-i));
		end
	end
	--flip the flag on the way out
	EmoteButtons_Levels["FarRight"] = not EmoteButtons_Levels["FarRight"]
end

function EmoteButtons_ToggleLeftWing()
	local i=0
	local obj;
	local lwc = getn(EmoteButtons_LeftWing);
	for i=1, lwc do
		obj = getglobal(EmoteButtons_LeftWing[i]);
		if (EmoteButtons_Levels["Left"]) then
			FadeOutFrame(obj, 0.1*i);
		elseif (EB_CurrentActions[EmoteButtons_LeftWing_Deck][i]~=nil and 
		EB_CurrentActions[EmoteButtons_LeftWing_Deck][i].action~=nil) then
			FadeInFrame(obj,0.15*(lwc-i));
		end
	end
	--flip the flag on the way out
	EmoteButtons_Levels["Left"] = not EmoteButtons_Levels["Left"]
end

function EmoteButtons_ToggleRightWing()
	local i=0
	local obj;
	local rwc = getn(EmoteButtons_RightWing);
	for i=1, rwc do
		obj = getglobal(EmoteButtons_RightWing[i]);
		if (EmoteButtons_Levels["Right"]) then
			FadeOutFrame(obj, 0.1*i);
		elseif (EB_CurrentActions[EmoteButtons_RightWing_Deck][i]~=nil and 
		EB_CurrentActions[EmoteButtons_RightWing_Deck][i].action~=nil) then
			FadeInFrame(obj,0.15*(rwc-i));
		end
	end
	--flip the flag on the way out
	EmoteButtons_Levels["Right"] = not EmoteButtons_Levels["Right"]
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
			EmoteButtons_UpdateConfig();
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
				EmoteButtons_UpdateConfig();
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
					EmoteButtons_UpdateConfig();
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
						EmoteButtons_UpdateConfig();
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
						EmoteButtons_UpdateConfig();
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
				EmoteButtons_ToggleFarLeftWing();
			end
			EmoteButtons_ToggleLeftWing();
		else
			EmoteButtons_LoadDeck(deck, wing); 
			if (EmoteButtons_Levels["Left"]) then
				if(EmoteButtons_Levels["FarLeft"]) then
					EmoteButtons_ToggleFarLeftWing();
				end
				EmoteButtons_FadeWing("left");
			else
				EmoteButtons_ToggleLeftWing();
			end
		end
	elseif wing=="Right" then
		if EmoteButtons_RightWing_Deck==deck then
			if(EmoteButtons_Levels["FarRight"]) then
				EmoteButtons_ToggleFarRightWing();
			end
			EmoteButtons_ToggleRightWing();
		else
			EmoteButtons_LoadDeck(deck, wing);
			if (EmoteButtons_Levels["Right"]) then
				if(EmoteButtons_Levels["FarRight"]) then
					EmoteButtons_ToggleFarRightWing();
				end
				EmoteButtons_FadeWing("right");
			else
				EmoteButtons_ToggleRightWing();
			end
		end
	elseif wing=="FarLeft" then		
		if EmoteButtons_FarLeftWing_Deck==deck then
			EmoteButtons_ToggleFarLeftWing();
		else
			EmoteButtons_LoadDeck(deck, wing);
			if (EmoteButtons_Levels["FarLeft"]) then
				EmoteButtons_FadeWing("farleft");
			else
				EmoteButtons_ToggleFarLeftWing();
			end
		end	
	elseif wing=="FarRight" then		
		if EmoteButtons_FarRightWing_Deck==deck then
			EmoteButtons_ToggleFarRightWing();
		else
			EmoteButtons_LoadDeck(deck, wing);
			if (EmoteButtons_Levels["FarRight"]) then
				EmoteButtons_FadeWing("farright");
			else
				EmoteButtons_ToggleFarRightWing();
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
	if string.len(tooltip) == 0 then
		fulltext = "|cFFFFFFFF"..action;
	elseif (acttype == EBACTTYPE_SLASHCMD) then
		fulltext = "|cFFFFFFFF"..tooltip;
	else
		fulltext = "|cFFFFFFFF"..tooltip.."|n|r"..action;
	end


	GameTooltip:SetOwner(getglobal(framename), anchor);
	if EmoteButtons_Config:IsShown() then
		fulltext = fulltext..setup;
	end
	GameTooltip:SetText(fulltext);
	GameTooltip:Show();
end

function EmoteButtons_HideTooltip()
	GameTooltip:Hide();
end

function EmoteButtons_UpdateConfig()
	local i;
	local found = 0;
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
--	local action = EB_CurrentActions[deck][button].action;
--	local tooltip = EB_CurrentActions[deck][button].tooltip;
--	local image = EB_CurrentActions[deck][button].image;

	
	--EmoteButtons_ConfigMain_ButtonName:SetText(deck.." - "..EMOTEBUTTONS_BUTTON.." "..button);

	--EmoteButtons_ConfigMain_Action:SetText(action);
	--EmoteButtons_ConfigMain_Tooltip:SetText(tooltip);
	--EmoteButton_Icon:SetTexture("Interface\\Icons\\"..image);
	DeckBuilderFrame:Show();
	DeckBuilderFrame_ScrollToSelected();
	--EB_EmotesManager:Hide();

	IconPickerFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide();
    --EmoteButtons_PopupImageSelector(); 
end

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

function EmoteButtons_ChangeTooltip()
	StaticPopupDialogs["EMOTEBUTTONS_CHANGETOOLTIP"]={
		text=TEXT(EMOTEBUTTONS_CHANGELABEL),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=200,
		OnAccept=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip = editBox:GetText();
			EmoteButtons_UpdateConfig();
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip = editBox:GetText();
			EmoteButtons_UpdateConfig();
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_CHANGETOOLTIP");
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGETOOLTIP")):GetName().."EditBox"):SetText(EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip);
end


function EmoteButtons_ChangeEmote()
	StaticPopupDialogs["EMOTEBUTTONS_CHANGEEMOTE"]={
		text=TEXT(EMOTEBUTTONS_CHANGEEMOTE),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=255,
		OnAccept=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type = EBACTTYPE_EMOTE;
			--EmoteButtons_UpdateConfig();
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type = EBACTTYPE_EMOTE;
			--EmoteButtons_UpdateConfig();
			this:GetParent():Hide();
		end,
		EditBoxOnEscapePressed=function()
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_CHANGEEMOTE");

	if (EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type == EBACTTYPE_EMOTE) then 
		txt = EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action;
	else
		txt = "";
	end
	--getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGEEMOTE")):GetName().."EditBox"):SetText(txt);
end

function EmoteButtons_ChangeDeck()
	StaticPopupDialogs["EMOTEBUTTONS_CHANGEDECK"]={
		text=TEXT(EMOTEBUTTONS_CHANGEDECK),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=255,
		OnAccept=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type = EBACTTYPE_DECK;
			EmoteButtons_UpdateConfig();
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type = EBACTTYPE_DECK;
			EmoteButtons_UpdateConfig();
			this:GetParent():Hide();
		end,
		EditBoxOnEscapePressed=function()
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_CHANGEDECK");

	if (EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type == EBACTTYPE_DECK) then 
		txt = EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action;
	else
		txt = "";
	end

	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGEDECK")):GetName().."EditBox"):SetText(txt);
end

function EmoteButtons_CloseOpenDecks()
	local deck = EmoteButtons_ConfigDeck;
	EmoteButtons_SaveOpenDecks();
	if(EmoteButtons_Levels["Main"] and
		EmoteButtons_FirstLevelName == deck) then
		EmoteButtons_ToggleFirstLevel();
	elseif(EmoteButtons_Levels["FarLeft"] and 
		EmoteButtons_FarLeftWing_Deck==deck) then 
		--EmoteButtons_ToggleLeftWing();
		EmoteButtons_ToggleFarLeftWing();
	elseif (EmoteButtons_Levels["Left"] and 
			EmoteButtons_LeftWing_Deck==deck) then 
		EmoteButtons_ToggleLeftWing();
	elseif (EmoteButtons_Levels["FarRight"] and
		EmoteButtons_FarRightWing_Deck==deck) then 
		--EmoteButtons_ToggleRightWing();
		EmoteButtons_ToggleFarRightWing();
	elseif (EmoteButtons_Levels["Right"] and
			EmoteButtons_RightWing_Deck==deck) then
		EmoteButtons_ToggleRightWing();
	end
end

function EmoteButtons_ReOpenDecks()
	if(EmoteButtons_OldLevels["Main"] and
		not EmoteButtons_Levels["Main"]) then
		EmoteButtons_ToggleFirstLevel();
	end
	if(EmoteButtons_OldLevels["FarLeft"] and
		not EmoteButtons_Levels["FarLeft"]) then 
		--EmoteButtons_ToggleLeftWing();
		EmoteButtons_ToggleFarLeftWing();
	elseif (EmoteButtons_OldLevels["Left"] and
		not EmoteButtons_Levels["Left"]) then 
		EmoteButtons_ToggleLeftWing();
	end
	if (EmoteButtons_OldLevels["FarRight"] and
		not EmoteButtons_Levels["FarRight"]) then 
		--EmoteButtons_ToggleRightWing();
		EmoteButtons_ToggleFarRightWing();
	elseif (EmoteButtons_OldLevels["Right"] and
		not EmoteButtons_Levels["Right"]) then
		EmoteButtons_ToggleRightWing();
	end

end

function EmoteButtons_SaveOpenDecks()
	EmoteButtons_OldLevels["Main"]=EmoteButtons_Levels["Main"]
	EmoteButtons_OldLevels["Left"]=EmoteButtons_Levels["Left"]
	EmoteButtons_OldLevels["FarLeft"]=EmoteButtons_Levels["FarLeft"]
	EmoteButtons_OldLevels["Right"]=EmoteButtons_Levels["Right"]
	EmoteButtons_OldLevels["FarRight"]=EmoteButtons_Levels["FarRight"]
end

function EmoteButtonsPrompt_ChangeCommand()

end

function EmoteButtons_ChangeCommand()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;

	local accept = function() 
		local editBox=getglobal(this:GetParent():GetName().."EditBox");
	len = getn(EB_CurrentActions[EmoteButtons_ConfigDeck])
	if len < EmoteButtons_ConfigButton then
		EmoteButtons_CloseOpenDecks();
		icon = IconPickerRandomIcon();
		a = {action=editBox:GetText(), type=EBACTTYPE_SLASHCMD, tooltip=""
			, image = icon}
		table.insert(EB_CurrentActions[EmoteButtons_ConfigDeck], a);
		EmoteButtons_ReOpenDecks();
	else
		EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
		EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type = EBACTTYPE_SLASHCMD;
		--EmoteButtons_UpdateConfig();
	end
	if(DeckBuilderFrame:IsShown()) then
		DeckBuilderFrame_UpdateActions(DeckBuilderFrame.selectedIcon);
		DeckBuilderFrameButtons_Update();
	end
	if EmoteButtons_FarLeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarLeft");
	elseif EmoteButtons_FarRightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarRight");
	elseif EmoteButtons_LeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Left");
	elseif EmoteButtons_RightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Right");
	elseif EmoteButtons_FirstLevelName == deck then
		EmoteButtons_LoadDeck(deck, "");
	end
	this:GetParent():Hide();
end
	
	StaticPopupDialogs["EMOTEBUTTONS_CHANGECOMMAND"]={
		text=TEXT(EMOTEBUTTONS_CHANGECOMMAND),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=255,
		OnAccept=accept,
		EditBoxOnEnterPressed=accept,
		EditBoxOnEscapePressed=function()
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_CHANGECOMMAND");
	len = getn(EB_CurrentActions[EmoteButtons_ConfigDeck])
	if (len >= EmoteButtons_ConfigButton
		and EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type == EBACTTYPE_SLASHCMD) then 
		txt = EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action;
	else
		txt = "";
	end
		getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGECOMMAND")):GetName().."EditBox"):SetHeight(200);
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGECOMMAND")):GetName().."EditBox"):SetWidth(200);
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGECOMMAND")):GetName().."EditBox"):SetMultiLine(true);
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGECOMMAND")):GetName().."EditBox"):SetText(txt);
end

function EmoteButtons_SetDeck(number)
	if number <= EmoteButtons_DecksCount then
		EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = "Deck "..number;		
		EmoteButtons_UpdateConfig();
		EmoteButtons_SelectAction:Hide();
	end
end

function EmoteButtons_SetAction()
	if EmoteButtons_ConfigDeck == EmoteButtons_FirstLevelName then
		if EmoteButtons_SelectAction:IsShown() then
			EmoteButtons_SelectAction:Hide();
		else
			EmoteButtons_SelectAction:Show();
		end
	else
		EmoteButtons_ChangeEmote();
	end

end

function EmoteButtons_PopupImageSelector()
	local i, parent, x, y, pos, f, t;
	i = 1;
	while i<EmoteButtons_ImageCount and EmoteButtons_ImageList[i]~=EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].image do
		i = i + 1;
	end
	if (EmoteButtons_ImageSelect1~=nil) then
		EmoteButtons_NormalizeImages();
		EmoteButtons_ImageSelected(nil);
		EmoteButtons_ImageSlideCenter = i;
		if not (EmoteButtons_ImageSelect1:IsShown()) then
			EmoteButtons_ImageSelect1:Show();
		end
	else
	for i=1, EmoteButtons_ImageCount do
		parent = "EmoteButtons_ImageSelect"..(i-1);
		if (i==1) then
			f = CreateFrame("Button","EmoteButtons_ImageSelect1", UIParent, "EmoteButtons_SelectImage_Init");
		else
			f = CreateFrame("Button","EmoteButtons_ImageSelect"..i, getglobal(parent) , "EmoteButtons_SelectImage_template");
		end
		f:SetFrameStrata("HIGH");
		f:SetWidth(16);
		f:SetHeight(16);
		
		t = f:CreateTexture(nil,"BACKGROUND");
		t:SetTexture("Interface\\Icons\\"..EmoteButtons_ImageList[i]);
		t:SetAllPoints(f);
		f.texture = t;
		
		if (i==1) then
			f:SetPoint("CENTER", "UIParent", "CENTER", -((EmoteButtons_ImageSlideCenter)*16+112), 0);
		else
			f:SetPoint("LEFT","EmoteButtons_ImageSelect"..i-1, "RIGHT",0,0);
		end
		f:SetID(i);
		f:Show();
	end
	EmoteButtons_ImageSlideCenter = i;
	end
	EmoteButtons_SlideImageSelector(EmoteButtons_ImageSlideCenter);
end

function EmoteButtons_RegisterForSlide(number)
	if abs(EmoteButtons_ImageSlideCenter-number)<20 then
		EmoteButtons_SlideNumber = number;
	end
end

function EmoteButtons_SlideImageUpdate()
	if (EmoteButtons_LastSlide+1)<floor(GetTime()*17) and EmoteButtons_SlideNumber then
		EmoteButtons_SlideImageSelector();
	end
end

function EmoteButtons_SlideImageSelector()
	local i,offset;
	local number = EmoteButtons_SlideNumber;
	local obj;
	local moved=false;

	if number == nil then
		number = EmoteButtons_ImageSlideCenter;
	end
	if (number+3<EmoteButtons_ImageSlideCenter) or (number<4 and EmoteButtons_ImageSlideCenter>1)then
		EmoteButtons_ImageSlideCenter = EmoteButtons_ImageSlideCenter - 1;
		moved=true;
	elseif (number-3>EmoteButtons_ImageSlideCenter) or (number>EmoteButtons_ImageCount-4 and EmoteButtons_ImageSlideCenter<EmoteButtons_ImageCount) then
		EmoteButtons_ImageSlideCenter = EmoteButtons_ImageSlideCenter + 1;
		moved=true;
	end
	for i=-4, 4 do
		obj=getglobal("EmoteButtons_ImageSelect"..EmoteButtons_ImageSlideCenter+i);
		if obj~=nil then
			obj:SetWidth(16*(5-abs(i)));
			obj:SetHeight(16*(5-abs(i)));
		end
	end
	number = EmoteButtons_ImageSlideCenter;

	obj=getglobal("EmoteButtons_ImageSelect"..EmoteButtons_ImageSlideCenter-19);
	if obj~=nil then
		EmoteButtons_ImageSelect1:SetAlpha(255);
		EmoteButtons_ImageSelect1:SetAlpha(0);
		obj:SetAlpha(255);
		
	end
	obj=getglobal("EmoteButtons_ImageSelect"..EmoteButtons_ImageSlideCenter+20);
	if obj~=nil then
		getglobal("EmoteButtons_ImageSelect"..EmoteButtons_ImageSlideCenter+19):SetAlpha(255);
		obj:SetAlpha(0);
	end

    if number==4 then
        offset=104;
    elseif number==3 then
        offset=80;
    elseif number==2 then
        offset=40;
    elseif number==1 then
        offset=-16;
    else
        offset=112;
    end
	EmoteButtons_SlideNumber = nil;
	EmoteButtons_ImageSelect1:SetPoint("CENTER", "UIParent", "CENTER", -((EmoteButtons_ImageSlideCenter)*16+offset), 0);
	EmoteButtons_LastSlide = floor(GetTime()*17);
end

function EmoteButtons_ImageSelected(number)
	local pos = number;
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;

	if pos ~= nil then
		EB_CurrentActions[deck][button].image = EmoteButtons_ImageList[pos];
		if EmoteButtons_LeftWing_Deck==deck then
			EmoteButtons_LoadDeck(deck, "Left");
		end
		if EmoteButtons_RightWing_Deck==deck then
			EmoteButtons_LoadDeck(deck, "Right");
		end
		if EmoteButtons_FirstLevelName == deck then
			EmoteButtons_LoadDeck(deck, "");
		end
		PlaySound("igChatScrollUp");

	EmoteButtons_NormalizeImages();
        EmoteButtons_ImageSlideCenter = pos;
        EmoteButtons_PopupImageSelector();
	end
end

function EmoteButtons_SlideImageMouseLeave(number)
	if EmoteButtons_SlideNumber==number then
		EmoteButtons_SlideNumber = nil;
	end
end

function EmoteButtons_NormalizeImages()
	local i, obj;
	for i=-4, 4 do
		obj=getglobal("EmoteButtons_ImageSelect"..EmoteButtons_ImageSlideCenter+i);
		if obj~=nil then
			obj:SetWidth(16);
			obj:SetHeight(16);
		end
	end
	if EmoteButtons_ImageSelect1~=nil then
		EmoteButtons_ImageSelect1:SetAlpha(255);
	end
end

function EmoteButtons_HideSelector()
	EmoteButtons_NormalizeImages();
	EmoteButtons_ImageSelect1:Hide();
end

function EmoteButtons_OnHide()
	StaticPopup_Hide ("EMOTEBUTTONS_CHANGECOMMAND")
	EB_EmotesManager:Hide();
	IconPickerFrame:Hide();
	DeckManagerFrame:Hide();
end

NUM_EMOTES_SHOWN = 8;
EMOTE_ROW_HEIGHT = 36;

function EmotesManager_OnShow()
	DeckManagerFrame:Hide();
	IconPickerFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide();
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	EmoteManagerFrame_Update();
	PlaySound("igCharacterInfoOpen");
	--Disable buttons on the other window?

	--Scroll down to current icon
	len = getn(EB_CurrentActions[deck])
	if len < button or EB_CurrentActions[deck][button].type ~= EBACTTYPE_EMOTE then
		for i=1, NUM_EMOTES_SHOWN do
			getglobal("EB_EmotesManager_Button"..i):SetChecked(0);
		end
		EB_EmotesManager_SelectedEmote:SetText("");
		EB_EmotesManager_PreviewEmote1:SetText("");
		EB_EmotesManager_PreviewEmote2:SetText("");
		EB_EmotesManager_ScrollFrame:SetVerticalScroll(0);
		EB_EmotesManager.selectedIcon = 0;
		EmoteManagerFrame_Update();
	elseif (EB_CurrentActions[deck][button].type == EBACTTYPE_EMOTE) then 
		local emote = EB_CurrentActions[deck][button].action;
		local found = 0
		-- Find the index of the emote
		local numEmotes = getn(EB_EmoteList);
		local t = ""
		for i=1, numEmotes do
			t = EB_EmoteList[i].Name;
			if t == emote then
				found = i;
				break;
			end
		end
		EB_EmotesManager_SelectedEmote:SetText(EB_EmoteList[found].Name);
		EB_EmotesManager_PreviewEmote1:SetText(EB_EmoteList[found].TargetEmoteText);
		EB_EmotesManager_PreviewEmote2:SetText(EB_EmoteList[found].SelfEmoteText);
		EB_EmotesManager_ScrollFrame:SetVerticalScroll(floor((found-1)*8));
		getglobal("EB_EmotesManager_Button".."1"):SetChecked(1);
		EB_EmotesManager.selectedIcon = found;
		EmoteManagerFrame_Update();
	end
	EmoteManagerSubmitButton_Update();
end

function EmoteManagerButton_OnClick()
	EB_EmotesManager.selectedIcon =  this:GetID() + (FauxScrollFrame_GetOffset(EB_EmotesManager_ScrollFrame));
	found = EB_EmotesManager.selectedIcon;
	EmoteManagerSubmitButton_Update() 
	EB_EmotesManager_SelectedEmote:SetText(EB_EmoteList[found].Name);
	EB_EmotesManager_PreviewEmote1:SetText(EB_EmoteList[found].TargetEmoteText);
	EB_EmotesManager_PreviewEmote2:SetText(EB_EmoteList[found].SelfEmoteText);
	EmoteManagerFrame_Update();
end

function EmoteManagerFrame_Update()
	local numEmotes = getn(EB_EmoteList);
	local EmoteManager_ButtonText,EmoteManager_Button;
	local DeckCFGOffset = FauxScrollFrame_GetOffset(EB_EmotesManager_ScrollFrame);
	local index;
	-- Emote list
	for i=1, NUM_EMOTES_SHOWN do
		EmoteManager_ButtonText = getglobal("EB_EmotesManager_Button"..i.."Name");
		EmoteManager_Button = getglobal("EB_EmotesManager_Button"..i);
		index = (DeckCFGOffset) + i;
		if ( index <= numEmotes) then
			EmoteManager_Button:Show();
			EmoteManager_ButtonText:SetText(format("%s",EB_EmoteList[index].Name))
		else
			EmoteManager_Button:Hide();
		end
		if ( index == EB_EmotesManager.selectedIcon  ) then
			EmoteManager_Button:SetChecked(1);
		else
			EmoteManager_Button:SetChecked(nil);
		end
	end
	
	-- Scrollbar stuff
	FauxScrollFrame_Update(EB_EmotesManager_ScrollFrame, numEmotes , NUM_EMOTES_SHOWN, NUM_EMOTES_SHOWN);
	-- numEmotes is max entries, NUM_EMOTES_SHOWN is the number of lines, last one is supposed to be pixel size
	-- But it works best if I just shove number of elements in there. My scroll area isn't litterally moving,
	-- I'm merely switching out the elements every time a scroll event happens.
end

function EmoteManagerSubmitButton_Update() 
	if ( EB_EmotesManager.selectedIcon~=0 ) then
		EB_EmotesManager_SubmitButton:Enable();
	else
		EB_EmotesManager_SubmitButton:Disable();
	end
end


function EmoteManagerSubmitButton_OnClick() 
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	emote = EB_EmotesManager.selectedIcon;
	len = getn(EB_CurrentActions[deck])
	if len < button then
		EmoteButtons_CloseOpenDecks();
		icon = IconPickerRandomIcon();

		a = {action=EB_EmoteList[emote].Name, type=EBACTTYPE_EMOTE, tooltip=""
			, image = icon }

		table.insert(EB_CurrentActions[deck], a);
		EmoteButtons_ReOpenDecks();
	else
		EB_CurrentActions[deck][button].action = EB_EmoteList[emote].Name;
		EB_CurrentActions[deck][button].type = EBACTTYPE_EMOTE;
	end
	if(DeckBuilderFrame:IsShown()) then
		DeckBuilderFrame_UpdateActions(DeckBuilderFrame.selectedIcon);
		DeckBuilderFrameButtons_Update();
	end
	if EmoteButtons_FarLeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarLeft");
	elseif EmoteButtons_FarRightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarRight");
	elseif EmoteButtons_LeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Left");
	elseif EmoteButtons_RightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Right");
	elseif EmoteButtons_FirstLevelName == deck then
		EmoteButtons_LoadDeck(deck, "");
	end
	PlaySound("igChatScrollUp");
	EB_EmotesManager:Hide();
end

--DeckManager Functions

NUM_DECKS_SHOWN = 8;
CURRENT_DECK = "";

function DeckManagerFrameUpdateText()
	DeckManagerFrame_SelectedDeck:SetText("LOL");
	DeckManagerFrame_DeckButtonTooltip:SetText("LOL");
	DeckManagerFrame_DeckButtonAction:SetText("LOL");
	DeckManagerFrame_DeckButtonActionType:SetText("LOL");
end

function DeckManagerFrame_OnShow()
	EB_EmotesManager:Hide();
	IconPickerFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide();
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;

	len = getn(EB_CurrentActions[deck])
	if len < button or EB_CurrentActions[deck][button].type ~= EBACTTYPE_DECK then
		DeckManagerFrame.selectedIcon = 0;
		DeckManagerFrame_DeckScrollFrame:SetVerticalScroll(0);
		PlaySound("igCharacterInfoOpen");
		for i=1,  8 do
				button = getglobal("DeckManagerFrame_DeckActionButton"..i);
				buttontxt = getglobal("DeckManagerFrame_DeckActionButton"..i.."Name");
				buttonicon = getglobal("DeckManagerFrame_DeckActionButton"..i.."Icon");

				buttonicon:SetTexture("Interface\\Buttons\\UI-EmptySlot-Disabled");
				buttontxt:SetText("");
				button:SetChecked(0);
		end
	elseif (EB_CurrentActions[deck][button].type == EBACTTYPE_DECK) then 
		local action = EB_CurrentActions[deck][button].action;
		local found = 0
		-- Find the index of the action
		local numDecks = getn(EmoteButtons_DeckList);
		local t = ""
		for i=1, numDecks do
			t = EmoteButtons_DeckList[i];
			if t == action then
				found = i;
				break;
			end
		end
		if found > 8 then
			DeckManagerFrame_DeckScrollFrame:SetVerticalScroll((found)*7);
		else
			DeckManagerFrame_DeckScrollFrame:SetVerticalScroll(0);
		end --only scroll down if its past first page, glitches out less than 8 entries with no scroll bar
		getglobal("DeckManagerFrame_DeckActionButton".."1"):SetChecked(1);
		DeckManagerFrame.selectedIcon = found;
		DeckManagerFrame_UpdateActions(found);
	end
	DeckManagerFrame_Update();	
	DeckManagerFrameSubmitButton_Update();
	--Disable buttons on the other window?
	--Decided against scrolling down to current Deck
end

function DeckManagerFrameSubmitButton_OnClick()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	action = DeckManagerFrame.selectedIcon;
	len = getn(EB_CurrentActions[deck])
	if len < button then
			EmoteButtons_CloseOpenDecks();
		icon = IconPickerRandomIcon();
		a = {action=EmoteButtons_DeckList[action], type=EBACTTYPE_DECK, tooltip=""
			, image=icon}
		table.insert(EB_CurrentActions[deck], a);
		DeckBuilderFrameButtons_Update();
		DeckBuilderFrame_UpdateActions(DeckBuilderFrame.selectedIcon);
		EmoteButtons_ReOpenDecks();
	else
		EB_CurrentActions[deck][button].action = EmoteButtons_DeckList[action];
		EB_CurrentActions[deck][button].type = EBACTTYPE_DECK;
	end
	if(DeckBuilderFrame:IsShown()) then
		DeckBuilderFrame_UpdateActions(DeckBuilderFrame.selectedIcon);
	end
	if EmoteButtons_FarLeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarLeft");
	elseif EmoteButtons_FarRightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarRight");
	elseif EmoteButtons_LeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Left");
	elseif EmoteButtons_RightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Right");
	elseif EmoteButtons_FirstLevelName == deck then
		EmoteButtons_LoadDeck(deck, "");
	end
	PlaySound("igChatScrollUp");
	DeckManagerFrame:Hide();
end

function DeckManagerFrameSubmitButton_Update() 
	if ( DeckManagerFrame.selectedIcon~=0 ) then
		DeckManagerFrame_SubmitButton:Enable();
	else
		DeckManagerFrame_SubmitButton:Disable();
	end
end


function DeckManagerFrameDeckActionButton_OnClick()
	DeckManagerFrame.selectedAction =  this:GetID() + (FauxScrollFrame_GetOffset(DeckManagerFrame_DeckScrollFrame));
	DeckManagerFrame_Update();
end

function DeckManagerFrame_UpdateActions(deck)
	deck_tag = EmoteButtons_DeckList[deck]
	d = EB_CurrentActions[deck_tag]
	for i=1, getn(d) do
		buttontxt = getglobal("DeckManagerFrame_DeckActionButton"..i.."Name");
		button = getglobal("DeckManagerFrame_DeckActionButton"..i);
		buttonicon = getglobal("DeckManagerFrame_DeckActionButton"..i.."Icon");
		button:SetChecked(0);


		if d[i].type == EBACTTYPE_DECK then
			txt = "DECK: ";
		elseif d[i].type == EBACTTYPE_EMOTE then
			txt = "Emote: ";
		elseif d[i].type == EBACTTYPE_SLASHCMD then
			txt = "SLASH CMD: ";
		end
		txt = txt .. d[i].action 
		txt = txt .. " Tooltip: " .. d[i].tooltip
		buttontxt:SetText(txt);
		buttonicon:SetTexture("Interface\\Icons\\"..d[i].image)
	end
	if getn(d) ~= 8 then
		for i=getn(d)+1, 8 do
			button = getglobal("DeckManagerFrame_DeckActionButton"..i);
			buttontxt = getglobal("DeckManagerFrame_DeckActionButton"..i.."Name");
			buttonicon = getglobal("DeckManagerFrame_DeckActionButton"..i.."Icon");
			buttonicon:SetTexture("Interface\\Buttons\\UI-EmptySlot-Disabled");

			buttontxt:SetText("Empty");
			button:SetChecked(0);
		end
	end
end

function DeckManagerFrame_Update()
	local numDecks = getn(EmoteButtons_DeckList);
	local DeckManagerFrame_DeckButtonText, DeckManagerFrame_DeckButton;
	local DeckManagerOffset = FauxScrollFrame_GetOffset(DeckManagerFrame_DeckScrollFrame);
	local index;
		-- Deck list
	for i=1, NUM_DECKS_SHOWN do
		DeckManagerFrame_DeckButtonText = getglobal("DeckManagerFrame_DeckButton"..i.."Name");
		DeckManagerFrame_DeckButton = getglobal("DeckManagerFrame_DeckButton"..i);
		index = (DeckManagerOffset) + i;
		if ( index <= numDecks) then
			DeckManagerFrame_DeckButton:Show();
			DeckManagerFrame_DeckButtonText:SetText(format("%s",EmoteButtons_DeckList[index]))
		else
			DeckManagerFrame_DeckButton:Hide();
		end
		if ( index == DeckManagerFrame.selectedIcon  ) then
			DeckManagerFrame_DeckButton:SetChecked(1);
		else
			DeckManagerFrame_DeckButton:SetChecked(nil);
		end
	end
	
	-- Scrollbar stuff
	FauxScrollFrame_Update(DeckManagerFrame_DeckScrollFrame, numDecks , NUM_DECKS_SHOWN, NUM_DECKS_SHOWN);
	-- numEmotes is max entries, NUM_EMOTES_SHOWN is the number of lines, last one is supposed to be pixel size
	-- But it works best if I just shove number of elements in there. My scroll area isn't litterally moving,
	-- I'm merely switching out the elements every time a scroll event happens.
end

function DeckManagerFrameDeckButton_OnClick()
	DeckManagerFrame.selectedIcon =  this:GetID() + (FauxScrollFrame_GetOffset(DeckManagerFrame_DeckScrollFrame));
	found = DeckManagerFrame.selectedIcon;
	DeckManagerFrame.selectedAction = 0;
	DeckManagerFrame_UpdateActions(found);
	DeckManagerFrameSubmitButton_Update() 
	DeckManagerFrame_Update();
end 

-- Deck Builder --

function DeckBuilderFrame_ScrollToSelected()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	found = 0
	for i=1, getn(EmoteButtons_DeckList) do
		d = EmoteButtons_DeckList[i]
		if (d==deck) then
			found = i;
		end
	end
	DeckBuilderFrame.selectedIcon = found;
	DeckBuilderFrame.selectedAction = button;
	if (found > 8 ) then
		DeckBuilderFrame_DeckScrollFrame:SetVerticalScroll(found*7);
	else
		DeckBuilderFrame_DeckScrollFrame:SetVerticalScroll(1)
	end -- only scroll if its past the first page, not worth it otherwise.
	PlaySound("igCharacterInfoOpen");
	DeckBuilderFrame_Update();
	DeckBuilderFrame_UpdateActions();
	DeckBuilderFrameButtons_Update() 
end

function DeckBuilderFrame_OnShow()
	EmoteButtons_AdvancedConfigFrame:Hide();
end

function DeckBuilderFrame_OnHide()
	StaticPopup_Hide ("EMOTEBUTTONS_CHANGECOMMAND")
	StaticPopup_Hide ("DELETE_DECK_CONFIRMATION")
	EB_EmotesManager:Hide();
	IconPickerFrame:Hide();
	DeckManagerFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide();
end

function DeckBuilderFrameDeckActionButton_OnClick()
	if DeckBuilderFrame.selectedIcon ~= 0 then
		DeckBuilderFrame.selectedAction =  this:GetID()
		EmoteButtons_ConfigButton = this:GetID()
		DeckBuilderFrame_UpdateActions(DeckBuilderFrame.selectedIcon)
	else
		this:SetChecked(nil);
		--getglobal("DeckBuilderFrame_DeckActionButton"..this:GetID())
	end
	EB_EmotesManager:Hide();
	DeckManagerFrame:Hide();
	IconPickerFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide();
	HideAllPopupsFrames();
	--StaticPopup_Hide ("EMOTEBUTTONS_CHANGECOMMAND")
	--StaticPopup_Hide ("DELETE_DECK_CONFIRMATION")
	DeckBuilderFrameButtons_Update();
	DeckBuilderFrame_Update();
end

function DeckBuilderFrameDeckButton_OnClick()
	DeckBuilderFrame.selectedIcon =  this:GetID() + (FauxScrollFrame_GetOffset(DeckBuilderFrame_DeckScrollFrame));
	found = DeckBuilderFrame.selectedIcon;
	DeckBuilderFrame.selectedAction = 0;
	EmoteButtons_ConfigDeck = EmoteButtons_DeckList[DeckBuilderFrame.selectedIcon];
	EB_EmotesManager:Hide();
	DeckManagerFrame:Hide();
	IconPickerFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide();
	HideAllPopupsFrames();
	--StaticPopup_Hide ("EMOTEBUTTONS_CHANGECOMMAND")
	--StaticPopup_Hide ("DELETE_DECK_CONFIRMATION")
	DeckBuilderFrame_UpdateActions(found);
	DeckBuilderFrameButtons_Update() 
	DeckBuilderFrame_Update();
end

function DeckBuilderFrame_UpdateActions(deck)
	deck = DeckBuilderFrame.selectedIcon;
	if (deck == 0 ) then
		d={}
		emptyTxt = ""
	else	
		deck_tag = EmoteButtons_DeckList[deck]
		d = EB_CurrentActions[deck_tag]
		emptyTxt = "Empty"
	end
	for i=1, getn(d) do
		buttontxt = getglobal("DeckBuilderFrame_DeckActionButton"..i.."Name");
		button = getglobal("DeckBuilderFrame_DeckActionButton"..i);
		buttonicon = getglobal("DeckBuilderFrame_DeckActionButton"..i.."Icon");

		if d[i].type == EBACTTYPE_DECK then
			txt = "DECK: ";
		elseif d[i].type == EBACTTYPE_EMOTE then
			txt = "EMOTE: ";
		elseif d[i].type == EBACTTYPE_SLASHCMD then
			txt = "CMD: ";
		end
		txt = txt .. d[i].action 
		txt = txt .. " Tooltip: " .. d[i].tooltip
		buttontxt:SetText(txt);
		buttonicon:SetTexture("Interface\\Icons\\"..d[i].image)
		if ( i == DeckBuilderFrame.selectedAction  ) then
			button:SetChecked(1);
		else
			button:SetChecked(nil);
		end
	end
	if getn(d) ~= 8 then
		for i=getn(d)+1, 8 do
			button = getglobal("DeckBuilderFrame_DeckActionButton"..i);
			buttontxt = getglobal("DeckBuilderFrame_DeckActionButton"..i.."Name");
			buttonicon = getglobal("DeckBuilderFrame_DeckActionButton"..i.."Icon");
			buttonicon:SetTexture("Interface\\Buttons\\UI-EmptySlot-Disabled");

			buttontxt:SetText(emptyTxt);
			if ( i == DeckBuilderFrame.selectedAction  ) then
				button:SetChecked(1);
			else
				button:SetChecked(nil);
			end
		end
	end
end

function DeckBuilderFrame_Update()
	local numDecks = getn(EmoteButtons_DeckList);
	local DeckBuilderFrame_DeckButtonText, DeckBuilderFrame_DeckButton;
	local DeckBuilderOffset = FauxScrollFrame_GetOffset(DeckBuilderFrame_DeckScrollFrame);
	local index;
		-- Deck list
	for i=1, NUM_DECKS_SHOWN do
		DeckBuilderFrame_DeckButtonText = getglobal("DeckBuilderFrame_DeckButton"..i.."Name");
		DeckBuilderFrame_DeckButton = getglobal("DeckBuilderFrame_DeckButton"..i);
		index = (DeckBuilderOffset) + i;
		if ( index <= numDecks) then
			DeckBuilderFrame_DeckButton:Show();
			DeckBuilderFrame_DeckButtonText:SetText(format("%s",EmoteButtons_DeckList[index]))
		else
			DeckBuilderFrame_DeckButton:Hide();
		end
		if ( index == DeckBuilderFrame.selectedIcon  ) then
			DeckBuilderFrame_DeckButton:SetChecked(1);
		else
			DeckBuilderFrame_DeckButton:SetChecked(nil);
		end
	end
	
	-- Scrollbar stuff
	FauxScrollFrame_Update(DeckBuilderFrame_DeckScrollFrame, numDecks , NUM_DECKS_SHOWN, NUM_DECKS_SHOWN);
	-- numEmotes is max entries, NUM_EMOTES_SHOWN is the number of lines, last one is supposed to be pixel size
	-- But it works best if I just shove number of elements in there. My scroll area isn't litterally moving,
	-- I'm merely switching out the elements every time a scroll event happens.
end

function DeckBuilderFrameButtons_Update() 
	d = DeckBuilderFrame.selectedIcon
	if ( d~=0 and EmoteButtons_DeckList[d] ~= EmoteButtons_FirstLevelName) then
		DeckBuilderFrame_DeleteDeckButton:Enable();
		DeckBuilderFrame_RenameDeckButton:Enable();
	else
		DeckBuilderFrame_DeleteDeckButton:Disable();
		DeckBuilderFrame_RenameDeckButton:Disable();
	end
	
	if ( DeckBuilderFrame.selectedAction~=0 ) then
		DeckBuilderFrame_ChangeEmoteActionButton:Enable();
		DeckBuilderFrame_ChangeCMDActionButton:Enable();
		DeckBuilderFrame_ChangeDeckActionButton:Enable();


		deck = EmoteButtons_DeckList[d]
		a = DeckBuilderFrame.selectedAction


		if (EB_CurrentActions[deck][a]) then
			DeckBuilderFrame_DeleteActionButton:Enable();
			DeckBuilderFrame_ChangeTooltipButton:Enable();
			l = getn(EB_CurrentActions[deck])
			--find first and last actions and disable move up or move down
			if (l==1) then --if its just 1 element, totally un-needed
				DeckBuilderFrame_MoveDownButton:Disable();
				DeckBuilderFrame_MoveUpButton:Disable();
			elseif (a==1) then --if its first element, but more than 1
				DeckBuilderFrame_MoveDownButton:Enable();
				DeckBuilderFrame_MoveUpButton:Disable();
			elseif (a==l) then --last selected, but more than 1
				DeckBuilderFrame_MoveDownButton:Disable();
				DeckBuilderFrame_MoveUpButton:Enable();
			else
				DeckBuilderFrame_MoveDownButton:Enable();
				DeckBuilderFrame_MoveUpButton:Enable();
			end

		else
			DeckBuilderFrame_DeleteActionButton:Disable();
			DeckBuilderFrame_ChangeTooltipButton:Disable();
			DeckBuilderFrame_MoveDownButton:Disable();
			DeckBuilderFrame_MoveUpButton:Disable();
		end
	else
		DeckBuilderFrame_ChangeTooltipButton:Disable();
		DeckBuilderFrame_ChangeDeckActionButton:Disable();
		DeckBuilderFrame_ChangeEmoteActionButton:Disable();
		DeckBuilderFrame_ChangeCMDActionButton:Disable();
		DeckBuilderFrame_DeleteActionButton:Disable();
		DeckBuilderFrame_MoveDownButton:Disable();
		DeckBuilderFrame_MoveUpButton:Disable();
	end
end

function DeckBuilderFrame_DeleteActionButton_OnClick()
	EmoteButtons_CloseOpenDecks();
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	table.remove(EB_CurrentActions[deck], DeckBuilderFrame.selectedAction);
	if EmoteButtons_FarLeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarLeft");
	elseif EmoteButtons_FarRightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarRight");
	elseif EmoteButtons_LeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Left");
	elseif EmoteButtons_RightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Right");
	elseif EmoteButtons_FirstLevelName == deck then
		EmoteButtons_LoadDeck(deck, "");
	end
	--reset deck builder action buttons and what not
	DeckBuilderFrame.selectedAction = 0;
	DeckBuilderFrame_UpdateActions();
	DeckBuilderFrameButtons_Update();
	DeckBuilderFrame_UpdateActions(DeckBuilderFrame.selectedIcon);
	EmoteButtons_ReOpenDecks()
end

function DeckBuilderFrame_DeleteDeckButton_OnClick()
    --check if the deck is used in any other decks...
	local deck = EmoteButtons_ConfigDeck;
	if deck == EmoteButtons_FirstLevelName then
		DEFAULT_CHAT_FRAME:AddMessage("Cannot delete Main deck")
	else
		found = 0
		for i=1, getn(EmoteButtons_DeckList) do
			d = EmoteButtons_DeckList[i]
			for n=1, getn(EB_CurrentActions[d]) do
				if(EB_CurrentActions[d][n].type == EBACTTYPE_DECK and
					EB_CurrentActions[d][n].action == deck) then
					found = 1
				end			
			end
		end
		txt = "Do you want to delete the deck " .. deck .. "?"
		if found == 1 then
			txt = txt .. " This deck is used by other decks, these buttons will be deleted."
		end
		confirmation = 0 
		StaticPopupDialogs["DELETE_DECK_CONFIRMATION"] = {
		text = txt,
		button1 = "Yes",
		button2 = "No",
		OnAccept = function()
			if found == 1 then --need to delete the other buttons relying on it first...
				for i=1, getn(EmoteButtons_DeckList) do
					d = EmoteButtons_DeckList[i]
					l=getn(EB_CurrentActions[d])
					for n=1, l do
						if (n>getn(EB_CurrentActions[d])) then
							break
						end
						if(EB_CurrentActions[d][n].type == EBACTTYPE_DECK and
							EB_CurrentActions[d][n].action == deck) then
							--found = 1
							table.remove(EB_CurrentActions[d], n)
							DEFAULT_CHAT_FRAME:AddMessage(format("Deleting from deck:%s index:%s", d, n))
							--array just got smaller...
						end			
					end
				end
			end
			DEFAULT_CHAT_FRAME:AddMessage(format("Deleting deck... %s", deck))
			EB_CurrentActions[deck] = nil;
			table.remove(EmoteButtons_DeckList, DeckBuilderFrame.selectedIcon);
			--DeckBuilderFrame_OnShow();
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
		}
		StaticPopup_Show("DELETE_DECK_CONFIRMATION")

	end
end

function DeckBuilderFrame_AddDeckButton_OnClick()
	-- Make a popup, show it
	StaticPopupDialogs["EMOTEBUTTONS_NEWDECK"]={
		text=TEXT(EMOTEBUTTONS_NEWDECK),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=200,
		OnAccept=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			local newDeck = editBox:GetText();
			--Try to find it in the current deck list...
			found = 0
			for i=1, getn(EmoteButtons_DeckList) do
				if EmoteButtons_DeckList[i] == newDeck then
					found = 1
				end
			end
			if found == 1 then
				DEFAULT_CHAT_FRAME:AddMessage("Deck name already in use!");
			else
				EB_CurrentActions[newDeck] = {};
				table.insert(EmoteButtons_DeckList, newDeck);
				table.sort(EmoteButtons_DeckList,sort_alphabetical);
				DEFAULT_CHAT_FRAME:AddMessage("Deck add success!");
				--Sort potentially messes up indexes on deck list, so need to reset deck selection
				DeckBuilderFrame.selectedAction = 0;
				DeckBuilderFrame.selectedIcon = 0;
				DeckBuilderFrame_Update();
				DeckBuilderFrame_UpdateActions(0);
				DeckBuilderFrameButtons_Update();
			end
			--EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip = editBox:GetText();
			--EmoteButtons_UpdateConfig();
			this:GetParent():Hide();
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			local newDeck = editBox:GetText();
			--Try to find it in the current deck list...
			found = 0
			for i=1, getn(EmoteButtons_DeckList) do
				if EmoteButtons_DeckList[i] == newDeck then
					found = 1
				end
			end
			if found == 1 then
				DEFAULT_CHAT_FRAME:AddMessage("Deck name already in use!");
			else
				EB_CurrentActions[newDeck] = {};
				table.insert(EmoteButtons_DeckList, newDeck);
				table.sort(EmoteButtons_DeckList,sort_alphabetical);
				DEFAULT_CHAT_FRAME:AddMessage("Deck add success!");
				--Sort potentially messes up indexes on deck list, so need to reset deck selection
				DeckBuilderFrame.selectedAction = 0;
				DeckBuilderFrame.selectedIcon = 0;
				DeckBuilderFrame_Update();
				DeckBuilderFrame_UpdateActions(0);
				DeckBuilderFrameButtons_Update();
			end
			this:GetParent():Hide();
		end,
		EditBoxOnEscapePressed=function()
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_NEWDECK");
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_NEWDECK")):GetName().."EditBox"):SetText("");
end

function DeckBuilderFrame_MoveUpButton_OnClick()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	temp = EB_CurrentActions[deck][button-1]
	EB_CurrentActions[deck][button-1]=EB_CurrentActions[deck][button]
	EB_CurrentActions[deck][button] = temp
	DeckBuilderFrame.selectedAction = button-1;
	EmoteButtons_ConfigButton = button - 1;
	DeckBuilderFrameButtons_Update();
	DeckBuilderFrame_UpdateActions();
	if EmoteButtons_FarLeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarLeft");
	elseif EmoteButtons_FarRightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarRight");
	elseif EmoteButtons_LeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Left");
	elseif EmoteButtons_RightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Right");
	elseif EmoteButtons_FirstLevelName == deck then
		EmoteButtons_LoadDeck(deck, "");
	end
	EmoteButtons_CloseOpenDecks();
	EmoteButtons_ReOpenDecks();
	EmoteButtons_ChangeCMDFrame:Hide();
	HideAllPopupsFrames()
	EB_EmotesManager:Hide();
	IconPickerFrame:Hide();
	DeckManagerFrame:Hide();
end

function DeckBuilderFrame_MoveDownButton_OnClick()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	temp = EB_CurrentActions[deck][button+1]
	EB_CurrentActions[deck][button+1]=EB_CurrentActions[deck][button]
	EB_CurrentActions[deck][button] = temp
	DeckBuilderFrame.selectedAction = button+1;
	EmoteButtons_ConfigButton = button +1;
	DeckBuilderFrameButtons_Update();
	DeckBuilderFrame_UpdateActions();
	if EmoteButtons_FarLeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarLeft");
	elseif EmoteButtons_FarRightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarRight");
	elseif EmoteButtons_LeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Left");
	elseif EmoteButtons_RightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Right");
	elseif EmoteButtons_FirstLevelName == deck then
		EmoteButtons_LoadDeck(deck, "");
	end
	EmoteButtons_CloseOpenDecks();
	EmoteButtons_ReOpenDecks();
	EmoteButtons_ChangeCMDFrame:Hide();
	HideAllPopupsFrames()
	EB_EmotesManager:Hide();
	IconPickerFrame:Hide();
	DeckManagerFrame:Hide();
end

function DeckBuilderFrame_RenameDeckButton_OnClick()
	local deck = EmoteButtons_ConfigDeck;
	local accept = function()
		local editBox=getglobal(this:GetParent():GetName().."EditBox");
		local newDeck = editBox:GetText();
			found = 0
			for i=1, getn(EmoteButtons_DeckList) do
				if EmoteButtons_DeckList[i] == newDeck then
					found = 1
				end
			end
			if found == 1 then
				DEFAULT_CHAT_FRAME:AddMessage("Deck name already in use!");
			else
				--Add new entry...
				EB_CurrentActions[newDeck] = EB_CurrentActions[deck];
				table.insert(EmoteButtons_DeckList, newDeck);
				--Delete old entry...
				EB_CurrentActions[deck] = nil;
				for i=1, getn(EmoteButtons_DeckList) do
					if EmoteButtons_DeckList[i] == deck then
						found = i
					end
				end
				table.remove(EmoteButtons_DeckList,found)
				table.sort(EmoteButtons_DeckList,sort_alphabetical);
				--Updated old entries in other decks...
				for i=1, getn(EmoteButtons_DeckList) do
					d = EmoteButtons_DeckList[i]
					l=getn(EB_CurrentActions[d])
					for n=1, l do
						if (n>getn(EB_CurrentActions[d])) then
							break
						end
						if(EB_CurrentActions[d][n].type == EBACTTYPE_DECK and
							EB_CurrentActions[d][n].action == deck) then
							EB_CurrentActions[d][n].action = newDeck;
							--DEFAULT_CHAT_FRAME:AddMessage(format("Updating deck:%s index:%s", d, n))
						end			
					end
				end
				--Sort potentially messes up indexes on deck list, so need to reset deck selection
				DeckBuilderFrame.selectedAction = 0;
				DeckBuilderFrame.selectedIcon = 0;
				DeckBuilderFrame_Update();
				DeckBuilderFrame_UpdateActions();
				DeckBuilderFrameButtons_Update();
				--Reload relevant decks, and re-fresh all buttons
				if EmoteButtons_FarLeftWing_Deck==deck then
					EmoteButtons_LoadDeck(newDeck, "FarLeft");
				elseif EmoteButtons_FarRightWing_Deck==deck then
					EmoteButtons_LoadDeck(newDeck, "FarRight");
				elseif EmoteButtons_LeftWing_Deck==deck then
					EmoteButtons_LoadDeck(newDeck, "Left");
				elseif EmoteButtons_RightWing_Deck==deck then
					EmoteButtons_LoadDeck(newDeck, "Right");
				end
				EmoteButtons_CloseOpenDecks();
				EmoteButtons_ReOpenDecks();
				DEFAULT_CHAT_FRAME:AddMessage("Deck rename success!");
			--EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip = editBox:GetText();
			--EmoteButtons_UpdateConfig();
		end
		this:GetParent():Hide();
	end
	StaticPopupDialogs["EMOTEBUTTONS_RENAMEDECK"]={
		text=TEXT(EMOTEBUTTONS_NEWDECK),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=200,
		OnAccept=accept,
		EditBoxOnEnterPressed=accept,
		EditBoxOnEscapePressed=function()
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	if deck == EmoteButtons_FirstLevelName then
			DEFAULT_CHAT_FRAME:AddMessage("Cannnot rename Main deck.")
	else
	StaticPopup_Show("EMOTEBUTTONS_RENAMEDECK");
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_RENAMEDECK")):GetName().."EditBox"):SetText(deck);
	end
end

function EmoteButtons_AdvancedConfigFrame_OnShow()
	DeckBuilderFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide();
	HideAllPopupsFrames()
	EB_EmotesManager:Hide();
	IconPickerFrame:Hide();
	DeckManagerFrame:Hide();
	EmoteButtons_AdvancedConfigFrame_SetMainShiftTitle:SetText(EMOTEBUTTONS_ROTATION);
	EmoteButtons_AdvancedConfigFrame_SetMainSizeTitle:SetText(EMOTEBUTTONS_SIZE);
end

function SaveProfile()
	index = 0;
	for i=1, getn(EmoteButtons_Vars.Profiles) do
		if EmoteButtons_Vars.Profiles[i].Name==EmoteButtons_Vars.Profile then
			index = i;
		end
	end
	StaticPopupDialogs["SAVE_PROFILE_CONFIRMATION"] = {
	text = "Do you want to save your current decks config to the profile " .. EmoteButtons_Vars.Profiles[index].Name .. "?",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		EmoteButtons_Vars.Profiles[index].Decks = EB_CurrentActions;
		--table.remove(EmoteButtons_Vars.Profiles, index);
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("SAVE_PROFILE_CONFIRMATION")
end

function SetProfile(index)
	StaticPopupDialogs["SET_PROFILE_CONFIRMATION"] = {
	text = "Do you want to set your current decks config to the profile " .. EmoteButtons_Vars.Profiles[index].Name .. "?",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
	--EB_CurrentActions = EmoteButtons_Vars.Profiles[index].Decks;
	EmoteButtons_Vars.PIndex = index;
	EB_CurrentActions = EmoteButtons_Vars.Profiles[EmoteButtons_Vars.PIndex].Decks;
	EmoteButtons_Vars.Profile = EmoteButtons_Vars.Profiles[index].Name;	
	ReloadUI();	--table.remove(EmoteButtons_Vars.Profiles, index);
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("SET_PROFILE_CONFIRMATION")
 -- Ask to save the current profile before switching.

	--
end

--Did this onshow, instead of load since my variables weren't loaded on time for on load.
--Might just need to change when the AddonLoaded event is called?
function ProfileSetDropDown_OnShow()
	for i=1, getn(EmoteButtons_Vars.Profiles) do
		info = {};
		info.text       = EmoteButtons_Vars.Profiles[i].Name;
		info.value      = i;
		if (EmoteButtons_Vars.Profiles[i].Name == EmoteButtons_Vars.Profile) then
			info.checked =true;
		else
			info.checked=false;
		end
		info.func =  function() 
			--SaveProfile(); Profiles now save by default.
			SetProfile(this.value) 
		end
		UIDropDownMenu_AddButton(info);
	end
end

function EmoteButtons_AdvancedConfigFrame_ProfileSetDropdownButton_OnClick()
	ToggleDropDownMenu(1, nil, EmoteButtons_AdvancedConfigFrame_ProfileSetDropdownButton, EmoteButtons_AdvancedConfigFrame_ProfileSetDropdownButton, 0, 0);
end

function DeleteProfile(index)
	StaticPopupDialogs["DELETE_PROFILE_CONFIRMATION"] = {
	text = "Do you want to delete the profile " .. EmoteButtons_Vars.Profiles[index].Name .. "?",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		table.remove(EmoteButtons_Vars.Profiles, index);

	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("DELETE_PROFILE_CONFIRMATION")
end

function ProfileDeleteDropDown_OnShow()
	for i=1, getn(EmoteButtons_Vars.Profiles) do
		info = {};
		info.text       = EmoteButtons_Vars.Profiles[i].Name;
		info.value      = i;
		if (EmoteButtons_Vars.Profiles[i].Name == EmoteButtons_Vars.Profile) then
			info.checked =true;
		else -- only add if its not currently in use...
			info.checked=false;
			info.func =  function() 
				DeleteProfile(this.value) 
			end
			UIDropDownMenu_AddButton(info);
		end
	end
end

function EmoteButtons_AdvancedConfigFrame_ProfileDeleteDropdownButton_OnClick()
	ToggleDropDownMenu(1, nil, EmoteButtons_AdvancedConfigFrame_ProfileDeleteDropdownButton, EmoteButtons_AdvancedConfigFrame_ProfileDeleteDropdownButton, 0, 0);
end

function DuplicateProfile(index)
	--prompt for a new name
	--make a new profile, use that name and old deck
	--need to test if its by ref or by val?
		local accept = function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			local newProfile = editBox:GetText();
			--Try to find it in the current deck list...
			found = 0
			for i=1, getn(EmoteButtons_Vars.Profiles) do
				if EmoteButtons_Vars.Profiles[i].Name == newProfile then
					found = 1
				end
			end
			if found == 1 then
				--Play an error sound?
				DEFAULT_CHAT_FRAME:AddMessage("Profile name already in use!");
			else
				--need to generate new deck instead of referencing old one.
				--better copy it!
				a = {Name=newProfile, Decks=EmoteButtons_Vars.Profiles[index].Decks} --need to set it to the deck we clicked earlier...
				table.insert(EmoteButtons_Vars.Profiles,a)
				DEFAULT_CHAT_FRAME:AddMessage(format("Profile %s added successfully!",newProfile));
			end
			this:GetParent():Hide();
		end
	StaticPopupDialogs["EMOTEBUTTONS_DUPLICATEPROFILE"]={
		text=TEXT(EMOTEBUTTONS_NEWPROFILE),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=200,
		OnAccept=accept,
		EditBoxOnEnterPressed=accept,
		EditBoxOnEscapePressed=function()
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_DUPLICATEPROFILE");
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_DUPLICATEPROFILE")):GetName().."EditBox"):SetText("");
end


function ProfileDuplicateDropDown_OnShow()
	for i=1, getn(EmoteButtons_Vars.Profiles) do
		info = {};
		info.text       = EmoteButtons_Vars.Profiles[i].Name;
		info.value      = i;
		if (EmoteButtons_Vars.Profiles[i].Name == EmoteButtons_Vars.Profile) then
			info.checked =true;
		else
			info.checked=false;
		end
		info.func =  function() 
			DuplicateProfile(this.value) 
		end
		UIDropDownMenu_AddButton(info);
	end
end

function EmoteButtons_AdvancedConfigFrame_ProfileDuplicateDropdownButton_OnClick()
	ToggleDropDownMenu(1, nil, EmoteButtons_AdvancedConfigFrame_ProfileDuplicateDropdownButton, EmoteButtons_AdvancedConfigFrame_ProfileDuplicateDropdownButton, 0, 0);
end

function EmoteButtons_AdvancedConfigFrame_ProfileCreateButton_OnClick()
	local accept = function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			local newProfile = editBox:GetText();
			--Try to find it in the current deck list...
			found = 0
			for i=1, getn(EmoteButtons_Vars.Profiles) do
				if EmoteButtons_Vars.Profiles[i].Name == newProfile then
					found = 1
				end
			end
			if found == 1 then
				--Play an error sound?
				DEFAULT_CHAT_FRAME:AddMessage("Profile name already in use!");
			else
				a = {Name=newProfile, Decks=EMOTEBUTTONS_MT}
				table.insert(EmoteButtons_Vars.Profiles,a)
				DEFAULT_CHAT_FRAME:AddMessage(format("Profile %s added successfully!",newProfile));
			end
		end
	StaticPopupDialogs["EMOTEBUTTONS_NEWPROFILE"]={
		text=TEXT(EMOTEBUTTONS_NEWPROFILE),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=200,
		OnAccept=accept,
		EditBoxOnEnterPressed=accept,
		EditBoxOnEscapePressed=function()
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_NEWPROFILE");
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_NEWPROFILE")):GetName().."EditBox"):SetText("");
end

function ResetPosition()
	EmoteButtons_Main:ClearAllPoints()
	EmoteButtons_Main:SetPoint("CENTER", UIParent ,"CENTER", 0, 0)
end

function ResetProfile()
	index = 0;
	for i=1, getn(EmoteButtons_Vars.Profiles) do
		if EmoteButtons_Vars.Profiles[i].Name==EmoteButtons_Vars.Profile then
			index = i;
		end
	end
	StaticPopupDialogs["RESET_PROFILE_CONFIRMATION"] = {
	text = "Do you want to reset the current decks config in the profile " .. EmoteButtons_Vars.Profiles[index].Name .. "?",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		EmoteButtons_Vars.Profiles[index].Decks = EMOTEBUTTONS_SE;
		EB_CurrentActions = EMOTEBUTTONS_SE;
		ReloadUI();
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("RESET_PROFILE_CONFIRMATION")
end

function ImportProfile()
	EmoteButtons_ImportProfileFrame:Show();
end

function EmoteButtons_ImportProfileFrame_SubmitButton_OnClick()
	l = EmoteButtons_ImportProfileFrame_ScrollFrame_ImportEditBox:GetText();
	f = loadstring(l);
	a,b = f();
	b.Decks = a;
	--check for profile name conflicts, offer to rename.	
	p = b.Name;
	found = 0
	for i=1, getn(EmoteButtons_Vars.Profiles) do
		if EmoteButtons_Vars.Profiles[i].Name == p then
			found = i
		end
	end

	-- Now offer to rename it,
	if found == 0 then
		insert(EmoteButtons_Vars.Profiles,b)
		DEFAULT_CHAT_FRAME:AddMessage(format("Profile %s added successfully!",b.Name));

	else
	local accept = function()
		local editBox=getglobal(this:GetParent():GetName().."EditBox");
		local newProfile = editBox:GetText();
		--Try to find it in the current deck list...
		found = 0
		for i=1, getn(EmoteButtons_Vars.Profiles) do
			if EmoteButtons_Vars.Profiles[i].Name == newProfile then
				found = 1
			end
		end
		if found == 1 then
			--Play an error sound?
			DEFAULT_CHAT_FRAME:AddMessage("Profile name already in use!");
		else
			b.Name = newProfile;
			table.insert(EmoteButtons_Vars.Profiles,b);
			DEFAULT_CHAT_FRAME:AddMessage(format("Profile %s added successfully!",newProfile));
		end
		this:GetParent():Hide();
	end
	StaticPopupDialogs["EMOTEBUTTONS_IMPORTPROFILE"]={
	text=TEXT("Profile with this name found already, please rename it."),
	button1=TEXT(ACCEPT),
	button2=TEXT(CANCEL),
	hasEditBox=1,
	maxLetters=200,
	OnAccept=accept,
	EditBoxOnEnterPressed=accept,
	EditBoxOnEscapePressed=function()
		this:GetParent():Hide();
	end,
	timeout=0,
	exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_IMPORTPROFILE");
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_IMPORTPROFILE")):GetName().."EditBox"):SetText("");
	end
	EmoteButtons_ImportProfileFrame:Hide();
end

---How do I want it to look on export? Like valid lua table probably.
--

function ExportProfile()
--TempDecks = {
--    ["DECK"] = {
--		{action = "ACTION", type="TYPE", tooltip="TOOLTIP",image="IMAGE"},
--		{action = "ACTION", type="TYPE", tooltip="TOOLTIP",image="IMAGE"}
--	}
--}

--TempProfile = {Name = "Name", Decks = "TempDecks"}
--insert it later
--
	--Load Decks for export.
	TempDecks = "return {\n"

	deck_counter = 1;
	for i,v in pairs(EB_CurrentActions) do
		deck =  i
		TempDecks = format("%s[\"%s\"]={\n",TempDecks, deck);
		act_counter = 1
		for j,v in pairs (EB_CurrentActions[i]) do
			act = EB_CurrentActions[i][j].action
			actType = EB_CurrentActions[i][j].type
			tip = EB_CurrentActions[i][j].tooltip
			img = EB_CurrentActions[i][j].image
			TempDecks = format(
				"%s{action=[[%s]], type=%s, tooltip=\"%s\", image=\"%s\"}",
				TempDecks,act,actType,tip,img
			)
			--does it get a comma, or just a newline?
			if (act_counter == getn(EB_CurrentActions[i])) then
				TempDecks = format("%s\n",TempDecks);	
			else
				TempDecks = format("%s,\n",TempDecks);	
			end
			act_counter = act_counter + 1;
		end
		if (deck_counter == getn(EmoteButtons_DeckList)) then
			TempDecks = format("%s}\n",TempDecks);	
		else
			TempDecks = format("%s},\n",TempDecks);	
		end
		deck_counter = deck_counter + 1;
	end
	TempDecks = format("%s}\n", TempDecks)
	TempProfile = format(",{Name = \"%s\", Decks=TempDecks}\n",
							EmoteButtons_Vars.Profile)
	EmoteButtons_ExportProfileFrame_ScrollFrame_ExportEditBox:SetText(TempDecks..TempProfile)
	EmoteButtons_ExportProfileFrame:Show();
end

function EmoteButtons_ChangeCMDFrame_SubmitButton_OnClick()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	act = EmoteButtons_ChangeCMDFrame_ScrollFrame_CMDEditBox:GetText();
	len = getn(EB_CurrentActions[deck])
	if len < EmoteButtons_ConfigButton then
		EmoteButtons_CloseOpenDecks();
		icon = IconPickerRandomIcon();
		a = {action=act, type=EBACTTYPE_SLASHCMD, tooltip=""
			, image = icon}
		table.insert(EB_CurrentActions[EmoteButtons_ConfigDeck], a);
		EmoteButtons_ReOpenDecks();
	else
		EB_CurrentActions[deck][button].action = act;
		EB_CurrentActions[deck][button].type = EBACTTYPE_SLASHCMD;
		--EmoteButtons_UpdateConfig();
	end
	if(DeckBuilderFrame:IsShown()) then
		DeckBuilderFrame_UpdateActions();
		DeckBuilderFrameButtons_Update();
	end
	if EmoteButtons_FarLeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarLeft");
	elseif EmoteButtons_FarRightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarRight");
	elseif EmoteButtons_LeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Left");
	elseif EmoteButtons_RightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "Right");
	elseif EmoteButtons_FirstLevelName == deck then
		EmoteButtons_LoadDeck(deck, "");
	end
	EmoteButtons_ChangeCMDFrame:Hide();
end

function EmoteButtons_ChangeCMDFrame_OnShow()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	acttype = EB_CurrentActions[deck][button].type
	if (acttype == EBACTTYPE_SLASHCMD) then
		act = EB_CurrentActions[deck][button].action
		EmoteButtons_ChangeCMDFrame_ScrollFrame_CMDEditBox:SetText(act);
	end
end

function EmoteButtons_ChangeCMDFrame_SubmitButton_Update()
	txt = EmoteButtons_ChangeCMDFrame_ScrollFrame_CMDEditBox:GetText();
	if string.len(txt) > 0 then
		EmoteButtons_ChangeCMDFrame_SubmitButton:Enable();
	else
		EmoteButtons_ChangeCMDFrame_SubmitButton:Disable();
	end
end