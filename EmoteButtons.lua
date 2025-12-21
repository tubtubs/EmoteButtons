--[[

EmoteButtons - By QuippeR, upgraded by Tubtubs

Adds an expanding menu system that grants access to emotes, slash commands
and macros. Supports profiles, and export and importing of profiles.
Shift click a button, or type /eb for more options.

TODO:
*Isolate IconPicker to its own Addon
*Clean up DeckBuilder interface a bit
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
	{"EmoteButtons_11", "EmoteButtons_12", "EmoteButtons_13",
	 "EmoteButtons_14", "EmoteButtons_15", "EmoteButtons_16",
	"EmoteButtons_17","EmoteButtons_18"};

EmoteButtons_FarLeftWingCount = 8;
EmoteButtons_FarLeftWing = 
	{"EmoteButtons_31", "EmoteButtons_32", "EmoteButtons_33",
	 "EmoteButtons_34", "EmoteButtons_35", "EmoteButtons_36",
	"EmoteButtons_37","EmoteButtons_38"};

EmoteButtons_RightWingCount = 8;
EmoteButtons_RightWing = 
	{"EmoteButtons_21", "EmoteButtons_22", "EmoteButtons_23",
	 "EmoteButtons_24", "EmoteButtons_25", "EmoteButtons_26",
	"EmoteButtons_27", "EmoteButtons_28"};

EmoteButtons_FarRightWingCount = 8;
EmoteButtons_FarRightWing = 
	{"EmoteButtons_41", "EmoteButtons_42", "EmoteButtons_43",
	 "EmoteButtons_44", "EmoteButtons_45", "EmoteButtons_46",
	"EmoteButtons_47","EmoteButtons_48"};

EmoteButtons_Wings = {"", "FarLeft","FarRight","FarLeft","FarRight"}

EmoteButtons_FirstLevelName = "Main"; -- Still need this constant, it's special as first level.
EmoteButtons_Wings_Decks = {EmoteButtons_FirstLevelName,
							"#0", 	--Left
							"#0",   --Right
							"#0",  	--FarLeft
							"#0"} 	--FarRight

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
EB_EmoteList = {}

-- chat inputs
local function TextMenu(arg)
	if arg == nil or arg == "" then
		DEFAULT_CHAT_FRAME:AddMessage(EMOTEBUTTONS_SLASHHELP,1,1,1)
	else
		if arg == "resetposition" then
			EmoteButtons_ResetPosition()
		elseif arg == "resetprofile" then
			EmoteButtons_ResetProfile()
		elseif arg == "options" then
			EmoteButtons_AdvancedConfigFrame:Show();
		elseif arg == "deckbuilder" then
			EmoteButtons_OpenDeckBuilder()
		elseif arg=="mode extended" then
			EmoteButtons_ExtendedMode()
		elseif arg=="mode vanilla" then
			EmoteButtons_VanillaMode()
		else
			DEFAULT_CHAT_FRAME:AddMessage(EMOTEBUTTONS_SLASHUNKNOWN,1,0.3,0.3);
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

function EmoteButtons_VanillaMode()
	EmoteButtons_Vars.PMode=EB_VANILLA
	EB_EmoteList = EB_VanillaEmoteList;
	DEFAULT_CHAT_FRAME:AddMessage("EmoteButtons changed to vanilla mode.")
end

function EmoteButtons_ExtendedMode()
	EmoteButtons_Vars.PMode=EB_EXTENDED
	EB_EmoteList = EB_ExtendedEmoteList;
	DEFAULT_CHAT_FRAME:AddMessage("EmoteButtons changed to extended mode.")
end

function EmoteButtons_ResetPosition()
	EmoteButtons_Main:ClearAllPoints()
	EmoteButtons_Main:SetPoint("CENTER", UIParent ,"CENTER", 0, 0)
end

function EmoteButtons_ToggleFade()
	EmoteButtons_Vars.DisableFade = not EmoteButtons_Vars.DisableFade; 
end

function EmoteButtons_WipeVars()
	r = GetRealmName()
	find = 0
	find = string.find(r,"Wallcraft")
	if find==nil then
		--DEFAULT_CHAT_FRAME:AddMessage("EmoteButtons: Standard vanilla server detected...")
		if not EmoteButtons_Vars then
			EmoteButtons_Vars = {
				Main_Ratio = 42,
				Main_Shift = 0,
				Wing_Shift = 0,
				Profiles = EMOTEBUTTONS_PROFILES,
				Profile=EMOTEBUTTONS_PROFILES[1].Name,
				PMode=EB_VANILLA,
				DisableFade=true,
				PIndex=1;
			};
		elseif not EmoteButtons_Vars.PMode then --compatability for V1
			EmoteButtons_Vars = {
				Main_Ratio = 42,
				Main_Shift = 0,
				Wing_Shift = 0,
				Profiles = EMOTEBUTTONS_PROFILES,
				Profile=EMOTEBUTTONS_PROFILES[1].Name,
				PMode=EB_VANILLA,
				DisableFade=true,
				PIndex=1;
			};
		end
	else 
		--DEFAULT_CHAT_FRAME:AddMessage("EmoteButtons: Extended vanilla server detected...")
		if not EmoteButtons_Vars then
			EmoteButtons_Vars = {
				Main_Ratio = 42,
				Main_Shift = 0,
				Wing_Shift = 0,
				Profiles = EMOTEBUTTONS_PROFILES,
				Profile=EMOTEBUTTONS_PROFILES[2].Name,
				PMode=EB_EXTENDED,
				DisableFade=true,
				PIndex=2;
			};
		elseif not EmoteButtons_Vars.PMode then --compatability for V1
			EmoteButtons_Vars = {
				Main_Ratio = 42,
				Main_Shift = 0,
				Wing_Shift = 0,
				Profiles = EMOTEBUTTONS_PROFILES,
				Profile=EMOTEBUTTONS_PROFILES[2].Name,
				PMode=EB_EXTENDED,
				DisableFade=true,
				PIndex=2;
			};
		end
	end

		
	if (EmoteButtons_Vars.PMode==EB_VANILLA) then
		EB_EmoteList = EB_VanillaEmoteList;
	elseif (EmoteButtons_Vars.PMode==EB_EXTENDED) then
		EB_EmoteList = EB_ExtendedEmoteList;
	end
	--populate deck list
	EmoteButtons_DeckList = {}
	for i, v in pairs(EB_CurrentActions) do
		table.insert(EmoteButtons_DeckList,i)
	end
	table.sort(EmoteButtons_DeckList,sort_alphabetical);
end

function EmoteButtons_ToggleWing(wing)
	local i=0
	local obj;
	local wc=getglobal("EmoteButtons_"..wing.."Wing")
	--local deck = getglobal("EmoteButtons_"..wing.."Wing_Deck")
	if wing== "" then
		deck = EmoteButtons_Wings_Decks[1]
	elseif wing=="Left" then
		deck = EmoteButtons_Wings_Decks[2]
	elseif wing=="Right" then
		deck = EmoteButtons_Wings_Decks[3]
	elseif wing=="FarLeft" then
		deck = EmoteButtons_Wings_Decks[4]
	elseif wing=="FarRight" then
		deck = EmoteButtons_Wings_Decks[5]
	end

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

--runs on addon load
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

--maybe should make local?
function FadeOutFrame( frame, time )
		if (not EmoteButtons_Vars.DisableFade) then
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
	else 
		frame:EnableMouse( false );
		frame:Hide();
	end
end

--maybe should make local?
function FadeInFrame( frame, time )
	if (not EmoteButtons_Vars.DisableFade) then 
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
	else
		frame:Show();
		frame:EnableMouse( true );
	end
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
			getglobal(EmoteButtons_FirstLevel[i].."_Icon"):SetTexture(IP_ICONPATH..image);
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
			if (EB_CurrentActions[EmoteButtons_Wings_Decks[2]][i]~=nil) then
				FadeInFrame(obj, 0.1*i);
			else
				FadeOutFrame(obj, 0.1*i);
			end
		elseif (wing == "right") then
			if (EB_CurrentActions[EmoteButtons_Wings_Decks[3]][i]~=nil) then
				FadeInFrame(obj, 0.1*i);
			else
				FadeOutFrame(obj, 0.1*i);
			end
		elseif (wing == "farleft") then
			if (EB_CurrentActions[EmoteButtons_Wings_Decks[4]][i]~=nil) then
				FadeInFrame(obj, 0.1*i);
			else
				FadeOutFrame(obj, 0.1*i);
			end
		elseif (wing == "farright") then
			if (EB_CurrentActions[EmoteButtons_Wings_Decks[5]][i]~=nil) then
				FadeInFrame(obj, 0.1*i);
			else
				FadeOutFrame(obj, 0.1*i);
			end
		end
	end
end

function EmoteButtons_ClickAction(framename)
	local action = "";
	local tooltip = "";
	local acttype=0;
	local wing = "";
	local f = tonumber(string.sub(framename,14,14))
	local g = tonumber(string.sub(framename,15,15))
	--step 1 find the responsible button
	deck = EmoteButtons_Wings_Decks[f+1]
	if IsShiftKeyDown() then
		EmoteButtons_ConfigDeck = deck;
		EmoteButtons_ConfigButton = g;
		EmoteButtons_OpenDeckBuilder();
	else
		btn = EB_CurrentActions[deck][g];
		action = btn.action;
		tooltip = btn.tooltip;
		acttype = btn.type;
		if acttype==EBACTTYPE_DECK then
			wing = EmoteButtons_Wings[f+1];
			if wing == "" then
				if g < 5 then
					wing = "Left"
				else
					wing = "Right"
				end
			end
			EmoteButtons_ToggleDeck(action, wing);
		elseif acttype==EBACTTYPE_EMOTE then
			EmoteButtons_DoEmote(action);
		elseif acttype==EBACTTYPE_SLASHCMD then	
			EmoteButtons_DoAction(action);
		end
	end
end

--could be optimized?
function EmoteButtons_ToggleDeck(deck, wing)
	if wing=="Left" then
		if EmoteButtons_Wings_Decks[2]==deck then 
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
		EmoteButtons_Wings_Decks[2]=deck;
	elseif wing=="Right" then
		if EmoteButtons_Wings_Decks[3]==deck then
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
		EmoteButtons_Wings_Decks[3]=deck;
	elseif wing=="FarLeft" then		
		if EmoteButtons_Wings_Decks[4]==deck then
			EmoteButtons_ToggleWing("FarLeft");
		else
			EmoteButtons_LoadDeck(deck, wing);
			if (EmoteButtons_Levels["FarLeft"]) then
				EmoteButtons_FadeWing("farleft");
				EmoteButtons_HideTooltip();
			else
				EmoteButtons_ToggleWing("FarLeft");
			end
		end	
		EmoteButtons_Wings_Decks[4]=deck;
	elseif wing=="FarRight" then		
		if EmoteButtons_Wings_Decks[5]==deck then
			EmoteButtons_ToggleWing("FarRight");
		else
			EmoteButtons_LoadDeck(deck, wing);
			if (EmoteButtons_Levels["FarRight"]) then
				EmoteButtons_FadeWing("farright");
				EmoteButtons_HideTooltip();
			else
				EmoteButtons_ToggleWing("FarRight");
			end
		end
		EmoteButtons_Wings_Decks[5]=deck;
	end
end

function EmoteButtons_LoadDeck(deck, wing)
	local i;
	local image;
	if wing== '' then
		for i=1, getn( EB_CurrentActions[deck]) do
			image = EB_CurrentActions[deck][i].image;
			getglobal(EmoteButtons_FirstLevel[i].."_Icon"):SetTexture(IP_ICONPATH..image)
		end
	elseif wing == "Left" then
		EmoteButtons_Wings_Decks[2] = deck
		for i=1, getn( EB_CurrentActions[deck]) do
			image = EB_CurrentActions[deck][i].image;
			getglobal(EmoteButtons_LeftWing[i].."_Icon"):SetTexture(IP_ICONPATH..image)
		end
	elseif wing == "Right" then
		EmoteButtons_Wings_Decks[3] = deck
		for i=1, getn( EB_CurrentActions[deck]) do
			image = EB_CurrentActions[deck][i].image;
			getglobal(EmoteButtons_RightWing[i].."_Icon"):SetTexture(IP_ICONPATH..image)
		end
	elseif wing =="FarLeft" then
		EmoteButtons_Wings_Decks[4] = deck
		for i=1, getn( EB_CurrentActions[deck]) do
			image = EB_CurrentActions[deck][i].image;
			getglobal(EmoteButtons_FarLeftWing[i].."_Icon"):SetTexture(IP_ICONPATH..image)
		end
	elseif wing =="FarRight" then
		EmoteButtons_Wings_Decks[5] = deck
		for i=1, getn( EB_CurrentActions[deck]) do
			image = EB_CurrentActions[deck][i].image;
			getglobal(EmoteButtons_FarRightWing[i].."_Icon"):SetTexture(IP_ICONPATH..image)
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

	local f = tonumber(string.sub(framename,14,14))
	local g = tonumber(string.sub(framename,15,15))
	deck = EmoteButtons_Wings_Decks[f+1]
	side = EmoteButtons_Wings[f+1]
	if side == "" then
		if g < 5 then
			anchor = "ANCHOR_BOTTOMLEFT"
			x = -30;
		else
			anchor = "ANCHOR_BOTTOMRIGHT"
			x = 30;
		end
	elseif side=="Left" then
		anchor = "ANCHOR_BOTTOMLEFT"
		x = -30;
	elseif side=="FarLeft" then
		anchor = "ANCHOR_BOTTOMLEFT"
		x = -30;
	elseif side=="Right" then
		anchor = "ANCHOR_BOTTOMRIGHT"
		x = 30;
	elseif side=="FarRight" then
		anchor = "ANCHOR_BOTTOMRIGHT"
		x = 30;
	end
	btn = EB_CurrentActions[deck][g];
	action = btn.action;
	tooltip = btn.tooltip;
	acttype = btn.type;

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
			action = format(EB_EmoteList[found].TargetEmoteText,trg)
		elseif(found==0) then
			action = EMOTEBUTTONS_INVALIDEMOTE 
		else
			action = EB_EmoteList[found].SelfEmoteText
		end
		if string.len(action) == 0 and string.len(tooltip) == 0 then --some emotes have no text
			action = EB_EmoteList[found].SelfEmoteText
		elseif string.len(action) == 0 then
			action = EB_EmoteList[found].Name;
		end
	end
	--prioritizes showing a tooltip instead of CMD or emote text
	if string.len(tooltip) == 0 then
		fulltext = "|cFFFFFFFF"..action;
	elseif (acttype == EBACTTYPE_SLASHCMD) then
		fulltext = "|cFFFFFFFF"..tooltip;
	elseif string.len(action) == 0 then
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
		EmoteButtons_Wings_Decks[4]==deck) then 
		--EmoteButtons_ToggleWing("Left");
		EmoteButtons_ToggleWing("FarLeft");
	elseif (EmoteButtons_Levels["Left"] and 
			EmoteButtons_Wings_Decks[2]==deck) then 
		EmoteButtons_ToggleWing("Left");
	elseif (EmoteButtons_Levels["FarRight"] and
		EmoteButtons_Wings_Decks[5]==deck) then 
		--EmoteButtons_ToggleWing("Right");
		EmoteButtons_ToggleWing("FarRight");
	elseif (EmoteButtons_Levels["Right"] and
			EmoteButtons_Wings_Decks[3]==deck) then
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