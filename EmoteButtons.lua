﻿--[[

Tubtubs
Looking to expand this EmoteButtons addon to include support for future expansions emotes.


TODO:
Expand the left/right wing to a size of 8. [CHECK]
Make the wings dynamically sized (can have less than 8 buttons) [CHECK]
Add another level of depth to the buttons [CHECK]
Might try to make it possible to do a more page too. Hmmm. [CHECK]
Add action type to the button info, so they can be: Emotes, slash commands, or accessing a Deck [check]
--Implement action types [check]
Emote list, used for generating tooltip previews of what the emote will say in chat [CHECK]
Need to dynamically generate deck lists from the localization table, itll be easier to manage like that. [check]
Add image to button info, instead of randomized icons -- might do this last, could tie into how I display config options [in progress]

Make the decks and buttons customizable
--Add new icon picker [check]
----Get current icon in the icon picker [CHECK]
--Add slash command config window
--Add deck manager 
--Add emote manager [check]
---Add search to emote manager
---Add full border around scroll area
----just did popup's for now, may make a full blown manager soon. [check]
--Advanced config window with import/export presets, maybe config mode.
----command to reset position, or everything
--Escape to close, should be possible without textbox [check]
---It is, can I make it so it doesn't close both - just one then the other?
--Main config window needs a delete button
--How to add new elements to decks?

Tech Debt/TODO LIST:
 --Changed EmoteButtons_Vars.Actions to EMOTEBUTTONS_SE, so I could replace references to EMOTEBUTTONS_SE with actions now I suppose.
	This hasn't had any un-intended issues... YET. It may need tweeking to be more dynamic later, but we'll get there with the config later.

DEPARTING NOTES: 
	Have left side wing setup to handle 0-8 arguments. Maybe I can arrange where they are more dynamically, so theyre closer
	to center, even if theres fewer than 8 items in a deck.
	Didn't like the way they look. Might work on how the sit later, might be neat for them to sit in the middle.
	But its a little touchy, and I wasn't happy with the results.

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

EmoteButtons_ConfigDeck = "#0";
EmoteButtons_ConfigButton = 0;

--needed hack
EmoteButtons_CanChangeSlider = false;

--image slider
EmoteButtons_ImageSlideCenter = floor(EmoteButtons_ImageCount/2);
EmoteButtons_LastSlide = 0;

function EmoteButtons_WipeVars()
	local i,j;
	local inr = EmoteButtons_ImageCount;
	EmoteButtons_Vars = {
		Actions = EMOTEBUTTONS_SE,
		Main_Ratio = 42,
		Main_Shift = 0,
		Wing_Shift = 0,
};

	for i, v in pairs(EmoteButtons_Vars.Actions) do
		for j, v in pairs(EmoteButtons_Vars.Actions[i]) do
			EmoteButtons_Vars.Actions[i][j].image = EmoteButtons_ImageList[math.random(inr)];
		end
	end
end

EmoteButtons_WipeVars();

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
	
	EmoteButtons_ConfigMain_SetMainShiftTitle:SetText(EMOTEBUTTONS_ROTATION);
	EmoteButtons_ConfigMain_SetMainSizeTitle:SetText(EMOTEBUTTONS_SIZE);

	UIErrorsFrame:AddMessage(EMOTEBUTTONS_INIT_TEXT, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);

end

function EmoteButtons_LoadedVars()

	EmoteButtons_ConfigMain_SetMainShift:SetValue(EmoteButtons_Vars.Main_Shift);
	EmoteButtons_ConfigMain_SetMainSize:SetValue(EmoteButtons_Vars.Main_Ratio);


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
		if (EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][i]~=nil) then
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
	local flc = getn(EmoteButtons_FirstLevel);
	if (getglobal(EmoteButtons_FarLeftWing[1])):IsShown() then
		EmoteButtons_ToggleFarLeftWing();
	end
	if (getglobal(EmoteButtons_FarRightWing[1])):IsShown() then
		EmoteButtons_ToggleFarRightWing();
	end
	if (getglobal(EmoteButtons_LeftWing[1])):IsShown() then
		EmoteButtons_ToggleLeftWing();
	end
	if (getglobal(EmoteButtons_RightWing[1])):IsShown() then
		EmoteButtons_ToggleRightWing();
	end

	
	for i=1, flc do
		obj = getglobal(EmoteButtons_FirstLevel[i]);
		if EmoteButtons_Levels["Main"] then
			FadeOutFrame(obj,0.1*i);
		else
			image = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][i].image;
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
		elseif (EmoteButtons_Vars.Actions[EmoteButtons_FarLeftWing_Deck][i]~=nil and 
		EmoteButtons_Vars.Actions[EmoteButtons_FarLeftWing_Deck][i].action~=nil) then
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
		elseif (EmoteButtons_Vars.Actions[EmoteButtons_FarRightWing_Deck][i]~=nil and 
		EmoteButtons_Vars.Actions[EmoteButtons_FarRightWing_Deck][i].action~=nil) then
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
		elseif (EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][i]~=nil and 
		EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][i].action~=nil) then
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
		elseif (EmoteButtons_Vars.Actions[EmoteButtons_RightWing_Deck][i]~=nil and 
		EmoteButtons_Vars.Actions[EmoteButtons_RightWing_Deck][i].action~=nil) then
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
			if (EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][i]~=nil) then
				FadeInFrame(obj, 0.1*i);
			else
				FadeOutFrame(obj, 0.1*i);
			end
		elseif (wing == "right") then
			if (EmoteButtons_Vars.Actions[EmoteButtons_RightWing_Deck][i]~=nil) then
				FadeInFrame(obj, 0.1*i);
			else
				FadeOutFrame(obj, 0.1*i);
			end
		elseif (wing == "farleft") then
			if (EmoteButtons_Vars.Actions[EmoteButtons_FarLeftWing_Deck][i]~=nil) then
				FadeInFrame(obj, 0.1*i);
			else
				FadeOutFrame(obj, 0.1*i);
			end
		elseif (wing == "farright") then
			if (EmoteButtons_Vars.Actions[EmoteButtons_FarRightWing_Deck][i]~=nil) then
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
		action = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][found].action;
		tooltip = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][found].tooltip;
		acttype = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][found].type;
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
			action = EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][found].action;		
			acttype = EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][found].type;		

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
				action = EmoteButtons_Vars.Actions[EmoteButtons_RightWing_Deck][found].action;		
				acttype = EmoteButtons_Vars.Actions[EmoteButtons_RightWing_Deck][found].type;
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
					action = EmoteButtons_Vars.Actions[EmoteButtons_FarLeftWing_Deck][found].action;		
					acttype = EmoteButtons_Vars.Actions[EmoteButtons_FarLeftWing_Deck][found].type;	

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
						action = EmoteButtons_Vars.Actions[EmoteButtons_FarRightWing_Deck][found].action;
						acttype = EmoteButtons_Vars.Actions[EmoteButtons_FarRightWing_Deck][found].type;	
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
	if deck== EmoteButtons_FirstLevelName then
		for i=1, EmoteButtons_FirstLevelCount do
			image = EmoteButtons_Vars.Actions[deck][i].image;
			getglobal(EmoteButtons_FirstLevel[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	elseif wing == "Left" then
		EmoteButtons_LeftWing_Deck = deck
		for i=1, getn( EmoteButtons_Vars.Actions[deck]) do
			image = EmoteButtons_Vars.Actions[deck][i].image;
			getglobal(EmoteButtons_LeftWing[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	elseif wing == "Right" then
		EmoteButtons_RightWing_Deck = deck
		for i=1, getn( EmoteButtons_Vars.Actions[deck]) do
			image = EmoteButtons_Vars.Actions[deck][i].image;
			getglobal(EmoteButtons_RightWing[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	elseif wing =="FarLeft" then
		EmoteButtons_FarLeftWing_Deck = deck
		for i=1, getn( EmoteButtons_Vars.Actions[deck]) do
			image = EmoteButtons_Vars.Actions[deck][i].image;
			getglobal(EmoteButtons_FarLeftWing[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	elseif wing =="FarRight" then
		EmoteButtons_FarRightWing_Deck = deck
		for i=1, getn( EmoteButtons_Vars.Actions[deck]) do
			image = EmoteButtons_Vars.Actions[deck][i].image;
			getglobal(EmoteButtons_FarRightWing[i].."_Icon"):SetTexture("Interface\\Icons\\"..image)
		end
	end
end

function EmoteButtons_DoAction(text)
	EmoteButtons_EditBox:SetText(text);
	ChatEdit_SendText(EmoteButtons_EditBox);
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
		tooltip = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][found].tooltip;
		action = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][found].action;
		acttype = EmoteButtons_Vars.Actions[EmoteButtons_FirstLevelName][found].type;
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
			tooltip = EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][found].tooltip;
			action = EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][found].action;
			acttype = EmoteButtons_Vars.Actions[EmoteButtons_LeftWing_Deck][found].type;
			anchor = "ANCHOR_BOTTOMLEFT"
			x = -30;
		else
			for i=1, EmoteButtons_RightWingCount do
				if EmoteButtons_RightWing[i] == framename then
					found = i;
				end
			end

			if found ~=0 then
				tooltip = EmoteButtons_Vars.Actions[EmoteButtons_RightWing_Deck][found].tooltip;
				action = EmoteButtons_Vars.Actions[EmoteButtons_RightWing_Deck][found].action;
				acttype = EmoteButtons_Vars.Actions[EmoteButtons_RightWing_Deck][found].type;
				anchor = "ANCHOR_BOTTOMRIGHT"
				x = 30;
			else

				for i=1, EmoteButtons_FarLeftWingCount do
					if EmoteButtons_FarLeftWing[i] == framename then
						found = i;
					end
				end
				
				if found ~=0 then
					tooltip = EmoteButtons_Vars.Actions[EmoteButtons_FarLeftWing_Deck][found].tooltip;
					action = EmoteButtons_Vars.Actions[EmoteButtons_FarLeftWing_Deck][found].action;
					acttype = EmoteButtons_Vars.Actions[EmoteButtons_FarLeftWing_Deck][found].type;
					anchor = "ANCHOR_BOTTOMLEFT"
					x = -30;
				else
					for i=1, EmoteButtons_FarRightWingCount do
						if EmoteButtons_FarRightWing[i] == framename then
							found = i;
						end
					end
					
					if found ~=0 then
						tooltip = EmoteButtons_Vars.Actions[EmoteButtons_FarRightWing_Deck][found].tooltip;
						action = EmoteButtons_Vars.Actions[EmoteButtons_FarRightWing_Deck][found].action;
						acttype = EmoteButtons_Vars.Actions[EmoteButtons_FarRightWing_Deck][found].type;
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
		DEFAULT_CHAT_FRAME:AddMessage(format("%s",found));
		if (found ~= 0 and EB_EmoteList[found] and trg and trg ~= plr) then
			--fulltext = "|cFFFFFFFF"..tooltip.."|n|r".. trg;
			fulltext = "|cFFFFFFFF"..tooltip.."|n|r".. format(EB_EmoteList[found].TargetEmoteText,trg);
		else
			--fulltext = "|cFFFFFFFF"..tooltip.."|n|r".. "EMOTE";
			fulltext = "|cFFFFFFFF"..tooltip.."|n|r".. EB_EmoteList[found].SelfEmoteText;
		end
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
	local action = EmoteButtons_Vars.Actions[deck][button].action;
	local tooltip = EmoteButtons_Vars.Actions[deck][button].tooltip;
	local image = EmoteButtons_Vars.Actions[deck][button].image;

	
	--EmoteButtons_ConfigMain_ButtonName:SetText(deck.." - "..EMOTEBUTTONS_BUTTON.." "..button);

	--EmoteButtons_ConfigMain_Action:SetText(action);
	--EmoteButtons_ConfigMain_Tooltip:SetText(tooltip);
	EmoteButton_Icon:SetTexture("Interface\\Icons\\"..image);
	EmoteButtons_ConfigMain:Show();
	EB_EmotesManager:Hide();
	DeckCFGFrame:Hide();
    --EmoteButtons_PopupImageSelector(); 
end

function EmoteButtons_SliderChanged(sender, units)
	local val = "err";
	if sender=="EmoteButtons_ConfigMain_SetMainShift" then
		val = EmoteButtons_ConfigMain_SetMainShift:GetValue();
		EmoteButtons_Vars.Main_Shift = val;
		EmoteButtons_Vars.Wing_Shift = val;
	else
		val = EmoteButtons_ConfigMain_SetMainSize:GetValue();
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
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip = editBox:GetText();
			EmoteButtons_UpdateConfig();
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip = editBox:GetText();
			EmoteButtons_UpdateConfig();
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_CHANGETOOLTIP");
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGETOOLTIP")):GetName().."EditBox"):SetText(EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip);
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
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type = EBACTTYPE_EMOTE;
			EmoteButtons_UpdateConfig();
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type = EBACTTYPE_EMOTE;
			EmoteButtons_UpdateConfig();
			this:GetParent():Hide();
		end,
		EditBoxOnEscapePressed=function()
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	--StaticPopup_Show("EMOTEBUTTONS_CHANGEEMOTE");

	if (EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type == EBACTTYPE_EMOTE) then 
		txt = EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action;
	else
		txt = "";
	end
	EB_EmotesManager:Show();

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
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type = EBACTTYPE_DECK;
			EmoteButtons_UpdateConfig();
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type = EBACTTYPE_DECK;
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

	if (EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type == EBACTTYPE_DECK) then 
		txt = EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action;
	else
		txt = "";
	end

	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGEDECK")):GetName().."EditBox"):SetText(txt);
end

function EmoteButtons_ChangeCommand()
	StaticPopupDialogs["EMOTEBUTTONS_CHANGECOMMAND"]={
		text=TEXT(EMOTEBUTTONS_CHANGECOMMAND),
		button1=TEXT(ACCEPT),
		button2=TEXT(CANCEL),
		hasEditBox=1,
		maxLetters=255,
		OnAccept=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type = EBACTTYPE_SLASHCMD;
			EmoteButtons_UpdateConfig();
		end,
		EditBoxOnEnterPressed=function()
			local editBox=getglobal(this:GetParent():GetName().."EditBox");
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = editBox:GetText();
			EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type = EBACTTYPE_SLASHCMD;
			EmoteButtons_UpdateConfig();
			this:GetParent():Hide();
		end,
		EditBoxOnEscapePressed=function()
			this:GetParent():Hide();
		end,
		timeout=0,
		exclusive=1
	};
	StaticPopup_Show("EMOTEBUTTONS_CHANGECOMMAND");

	if (EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].type == EBACTTYPE_SLASHCMD) then 
		txt = EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action;
	else
		txt = "";
	end

	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_CHANGECOMMAND")):GetName().."EditBox"):SetText(txt);
end

function EmoteButtons_SetDeck(number)
	if number <= EmoteButtons_DecksCount then
		EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].action = "Deck "..number;		
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
	while i<EmoteButtons_ImageCount and EmoteButtons_ImageList[i]~=EmoteButtons_Vars.Actions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].image do
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
		EmoteButtons_Vars.Actions[deck][button].image = EmoteButtons_ImageList[pos];
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

NUM_ICONS_SHOWN = 20;
NUM_ICONS_PER_ROW = 5;
NUM_ICON_ROWS = 4;
ICON_ROW_HEIGHT = 36;

function DeckCFGFrame_OnShow()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	DeckCFGFrame_Update();
	PlaySound("igCharacterInfoOpen");
	DeckCFGEditBox:SetFocus();
	DeckCFGOkayButton_Update();
	DeckCFGEditBox:SetText(EmoteButtons_Vars.Actions[deck][button].tooltip);
	--Disable buttons on the other window?

	--Scroll down to current icon
	local image = EmoteButtons_Vars.Actions[deck][button].image;
	DEFAULT_CHAT_FRAME:AddMessage(format("IMAGE: %s", EmoteButtons_Vars.Actions[deck][button].image))
	image = string.lower(image);
	local found = 0
	-- Find the index of the image
	local numMacroIcons = GetNumMacroIcons();
	local t = ""
	for i=1, numMacroIcons do
		t = GetMacroIconInfo(i);
		t = string.lower(t);
		if t == "interface\\icons\\"..image then
			found = i;
		end
	end
	-- 36 per row
	--Made an edge case, cuz I couldn't maths
	--Without modulus check multiples of 5 would end up on the next row
	if (found ~= 0) then
		if (math.mod(found,5) == 0 ) then
			offset = floor((found-1)/5)*36;
				innerIndex=5;
		else
			offset = floor(found/5)*36;
			innerIndex=math.mod(found,5); 
		end
		DeckCFGScrollFrame:SetVerticalScroll(offset);
		getglobal("DeckCFGButton"..innerIndex):SetChecked(1);
		DeckCFGFrame.selectedIcon = found;
	end



end

function DeckCFGFrame_OnHide()
	DeckCFGFrame:Hide();
	PlaySound("igCharacterInfoClose");
end

function DeckCFG_Update()
	DEFAULT_CHAT_FRAME:AddMessage("OKAY!");
end 

function DeckCFGButton_OnClick()
	DeckCFGFrame.selectedIcon =  this:GetID() + (FauxScrollFrame_GetOffset(DeckCFGScrollFrame) * NUM_ICONS_PER_ROW)
	DeckCFGOkayButton_Update();
	DeckCFGFrame_Update();
end

function DeckCFGOkayButton_Update() 
	if ( (strlen(DeckCFGEditBox:GetText()) > 0) and DeckCFGFrame.selectedIcon ) then
		DeckCFGOkayButton:Enable();
	else
		DeckCFGOkayButton:Disable();
	end
	if ( DeckCFGFrame.mode == "edit" and (strlen(DeckCFGEditBox:GetText()) > 0) ) then
		DeckCFGOkayButton:Enable();
	end
end

function DeckCFGOkayButton_OnClick()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	icon = GetMacroIconInfo(DeckCFGFrame.selectedIcon)
	EmoteButton_Icon:SetTexture(icon);
	icon = string.sub(icon, 17, -1)
	EmoteButtons_Vars.Actions[deck][button].image = icon
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
	EmoteButtons_Vars.Actions[deck][button].tooltip = 	DeckCFGEditBox:GetText();
	DeckCFGFrame:Hide();
end

 -- Don't rename this constant

function DeckCFGFrame_Update()
	local numMacroIcons = GetNumMacroIcons();
	local DeckCFGIcon, DeckCFGButton;
	local DeckCFGOffset = FauxScrollFrame_GetOffset(DeckCFGScrollFrame);
	local index;
	
	-- Icon list
	for i=1, NUM_ICONS_SHOWN do
		DeckCFGIcon = getglobal("DeckCFGButton"..i.."Icon");
		DeckCFGButton = getglobal("DeckCFGButton"..i);
		index = (DeckCFGOffset * NUM_ICONS_PER_ROW) + i;
		if ( index <= numMacroIcons ) then
			DeckCFGIcon:SetTexture(GetMacroIconInfo(index));
			DeckCFGButton:Show();
		else
			DeckCFGIcon:SetTexture("");
			DeckCFGButton:Hide();
		end
		if ( index == DeckCFGFrame.selectedIcon ) then
			DeckCFGButton:SetChecked(1);
		else
			DeckCFGButton:SetChecked(nil);
		end
	end
	
	-- Scrollbar stuff
	FauxScrollFrame_Update(DeckCFGScrollFrame, ceil(numMacroIcons / NUM_ICONS_PER_ROW) , NUM_ICON_ROWS, ICON_ROW_HEIGHT );
end

function CFGLabelEditOnShow()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	CFGLabelEdit:SetText(EmoteButtons_Vars.Actions[deck][button].tooltip);
end

function CFGLabelEditOnEnter()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	EmoteButtons_Vars.Actions[deck][button].tooltip = CFGLabelEdit:GetText();
	CFGLabelEdit:ClearFocus();
end

function CFGLabelEditOnEscape()
	CFGLabelEdit:ClearFocus();
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	CFGLabelEdit:SetText(EmoteButtons_Vars.Actions[deck][button].tooltip);
end

NUM_EMOTES_SHOWN = 8;
EMOTE_ROW_HEIGHT = 36;

function EmotesManager_OnShow()

	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	EmoteManagerFrame_Update();
	PlaySound("igCharacterInfoOpen");
	--Disable buttons on the other window?

	--Scroll down to current icon
	if (EmoteButtons_Vars.Actions[deck][button].type == EBACTTYPE_EMOTE) then 
		local emote = EmoteButtons_Vars.Actions[deck][button].action;
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
		-- 36 per row
		--Made an edge case, cuz I couldn't maths
		--Without modulus check multiples of 5 would end up on the next row
		--if (math.mod(found,5) == 0 ) then
		--	offset = floor((found-1)/5)*36;
		--		innerIndex=5;
		--else
		--	offset = floor(found/5)*36;
		--	innerIndex=math.mod(found,5); 
		--end
		--innerIndex = floor(found/NUM_EMOTES_SHOWN)
		DEFAULT_CHAT_FRAME:AddMessage(format("Found: %s",found));
		EB_EmotesManager_SelectedEmote:SetText(EB_EmoteList[found].Name);
		EB_EmotesManager_PreviewEmote1:SetText(EB_EmoteList[found].TargetEmoteText);
		EB_EmotesManager_PreviewEmote2:SetText(EB_EmoteList[found].SelfEmoteText);
		EB_EmotesManager_ScrollFrame:SetVerticalScroll(floor((found-1)*8));
		getglobal("EB_EmotesManager_Button".."1"):SetChecked(1);
		EB_EmotesManager.selectedIcon = found;
		EmoteManagerFrame_Update();
	else
		for i=1, NUM_EMOTES_SHOWN do
			getglobal("EB_EmotesManager_Button"..i):SetChecked(0);
		end
			EB_EmotesManager_SelectedEmote:SetText("");
		EB_EmotesManager_PreviewEmote1:SetText("");
		EB_EmotesManager_PreviewEmote2:SetText("");
		EB_EmotesManager_ScrollFrame:SetVerticalScroll(0);
		EB_EmotesManager.selectedIcon = 0;
		EmoteManagerFrame_Update();
	end
	EmoteManagerSubmitButton_Update();
end

function EmoteManagerButton_OnClick()
	EB_EmotesManager.selectedIcon =  this:GetID() + (FauxScrollFrame_GetOffset(EB_EmotesManager_ScrollFrame));
	found = EB_EmotesManager.selectedIcon;
	EmoteManagerSubmitButton_Update() 
	DEFAULT_CHAT_FRAME:AddMessage(format("Selected Icon: %s",EB_EmotesManager.selectedIcon));
	EB_EmotesManager_SelectedEmote:SetText(EB_EmoteList[found].Name);
	EB_EmotesManager_PreviewEmote1:SetText(EB_EmoteList[found].TargetEmoteText);
	EB_EmotesManager_PreviewEmote2:SetText(EB_EmoteList[found].SelfEmoteText);
	EmoteManagerFrame_Update();
end

function EmoteManagerFrame_Update()
	local numEmotes = getn(EB_EmoteList);
	local EmoteManager_ButtonText,EmoteManager_Button;
	local DeckCFGOffset = FauxScrollFrame_GetOffset(EB_EmotesManager_ScrollFrame);
	DEFAULT_CHAT_FRAME:AddMessage(format("OFFSET: %s",EB_EmotesManager_ScrollFrame:GetVerticalScroll()))
	local index;
		DEFAULT_CHAT_FRAME:AddMessage("Updates");

	-- Icon list
	for i=1, NUM_EMOTES_SHOWN do
		EmoteManager_ButtonText = getglobal("EB_EmotesManager_Button"..i.."Name");
		EmoteManager_Button = getglobal("EB_EmotesManager_Button"..i);
		index = (DeckCFGOffset) + i;
		DEFAULT_CHAT_FRAME:AddMessage(format("index: %s", index));
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
	EmoteButtons_Vars.Actions[deck][button].action = EB_EmoteList[emote].Name;
	EmoteButtons_Vars.Actions[deck][button].type = EBACTTYPE_EMOTE;
	if EmoteButtons_FarLeftWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarLeft");
	end
	if EmoteButtons_FarRightWing_Deck==deck then
		EmoteButtons_LoadDeck(deck, "FarRight");
	end
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
	EB_EmotesManager:Hide();
end