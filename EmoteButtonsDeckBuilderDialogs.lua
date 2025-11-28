
--EMOTES MANAGER--
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

	--Scroll down to current emote
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
		EmoteButtons_AddButton(deck, EB_EmoteList[emote].Name, EBACTTYPE_EMOTE,"")
	else
		EB_CurrentActions[deck][button].action = EB_EmoteList[emote].Name;
		EB_CurrentActions[deck][button].type = EBACTTYPE_EMOTE;
	end
	if(DeckBuilderFrame:IsShown()) then
		DeckBuilderFrame_UpdateActions(DeckBuilderFrame.selectedIcon);
		DeckBuilderFrameButtons_Update();
	end
	EmoteButtons_ReloadDeck(deck)
	PlaySound("igChatScrollUp");
	EB_EmotesManager:Hide();
end

--DECK MANAGER--
NUM_DECKS_SHOWN = 8;
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
end

function DeckManagerFrameSubmitButton_OnClick()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	action = DeckManagerFrame.selectedIcon;
	len = getn(EB_CurrentActions[deck])
	if len < button then
		EmoteButtons_AddButton(deck, EmoteButtons_DeckList[action], EBACTTYPE_DECK, "")
	else
		EB_CurrentActions[deck][button].action = EmoteButtons_DeckList[action];
		EB_CurrentActions[deck][button].type = EBACTTYPE_DECK;
	end
	DeckBuilderFrame_UpdateActions();
	EmoteButtons_ReloadDeck(deck);
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

function EmoteButtons_ChangeCMDFrame_OnShow()
    DeckManagerFrame:Hide();
	IconPickerFrame:Hide();
    EB_EmotesManager:Hide();
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	len = getn(EB_CurrentActions[deck])
	if len < button or EB_CurrentActions[deck][button].type ~= EBACTTYPE_SLASHCMD then
		EmoteButtons_ChangeCMDFrame_ScrollFrame_CMDEditBox:SetText("");
	elseif (EB_CurrentActions[deck][button].type == EBACTTYPE_SLASHCMD) then
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

function EmoteButtons_ChangeCMDFrame_SubmitButton_OnClick()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	act = EmoteButtons_ChangeCMDFrame_ScrollFrame_CMDEditBox:GetText();
	len = getn(EB_CurrentActions[deck])
	if len < EmoteButtons_ConfigButton then
		EmoteButtons_AddButton(deck, act,EBACTTYPE_SLASHCMD,"")
	else
		EB_CurrentActions[deck][button].action = act;
		EB_CurrentActions[deck][button].type = EBACTTYPE_SLASHCMD;
		--EmoteButtons_OpenDeckBuilder();
	end
	if(DeckBuilderFrame:IsShown()) then
		DeckBuilderFrame_UpdateActions();
		DeckBuilderFrameButtons_Update();
	end
	EmoteButtons_ReloadDeck(deck);
	EmoteButtons_ChangeCMDFrame:Hide();
end