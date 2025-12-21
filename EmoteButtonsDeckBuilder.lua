function EmoteButtons_AddButton(deck, act, acttype, tip)
	EmoteButtons_CloseOpenDecks();
	a = {action=act, type=acttype, 
		 tooltip=tip, image=IconPickerRandomIcon()}
	table.insert(EB_CurrentActions[deck], a);
	DeckBuilderFrameButtons_Update();
	DeckBuilderFrame_UpdateActions();
	EmoteButtons_ReOpenDecks();
end

function EmoteButtons_ReloadDeck(deck)
	if EmoteButtons_Wings_Decks[4]==deck then
		EmoteButtons_LoadDeck(deck, "FarLeft");
	elseif EmoteButtons_Wings_Decks[5]==deck then
		EmoteButtons_LoadDeck(deck, "FarRight");
	elseif EmoteButtons_Wings_Decks[2]==deck then
		EmoteButtons_LoadDeck(deck, "Left");
	elseif EmoteButtons_Wings_Decks[3]==deck then
		EmoteButtons_LoadDeck(deck, "Right");
	elseif EmoteButtons_FirstLevelName == deck then
		EmoteButtons_LoadDeck(deck, "");
	end
end

function EmoteButtons_HideAllPopups()
	StaticPopup_Hide ("EMOTEBUTTONS_DELETE_DECK_CONFIRMATION")
	StaticPopup_Hide ("EMOTEBUTTONS_NEWDECK")
	StaticPopup_Hide ("EMOTEBUTTONS_RENAMEDECK")
	StaticPopup_Hide ("EMOTEBUTTONS_NEWPROFILE")
	StaticPopup_Hide ("EMOTEBUTTONS_DUPLICATEPROFILE")
	StaticPopup_Hide ("EMOTEBUTTONS_DELETE_PROFILE_CONFIRMATION")
	StaticPopup_Hide ("EMOTEBUTTONS_RESET_PROFILE_CONFIRMATION")
	StaticPopup_Hide ("EMOTEBUTTONS_SET_PROFILE_CONFIRMATION")
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
	DeckBuilderFrame_Update();
	DeckBuilderFrame_UpdateActions();
	DeckBuilderFrameButtons_Update() 
end

function DeckBuilderFrame_OnShow()
	EmoteButtons_AdvancedConfigFrame:Hide();
	PlaySound("igCharacterInfoOpen");
end

function DeckBuilderFrame_OnHide()
	EmoteButtons_HideAllPopups();
	EB_EmotesManager:Hide();
	IconPickerFrame:Hide();
	DeckManagerFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide();
	PlaySound("igCharacterInfoClose");
end

function DeckBuilderFrameDeckActionButton_OnClick()
	PlaySound("gsTitleOptionOK");
	if DeckBuilderFrame.selectedIcon ~= 0 then
		DeckBuilderFrame.selectedAction =  this:GetID()
		EmoteButtons_ConfigButton = this:GetID()
		DeckBuilderFrame_UpdateActions(DeckBuilderFrame.selectedIcon)
	else
		this:SetChecked(nil);
	end
	EB_EmotesManager:Hide();
	DeckManagerFrame:Hide();
	IconPickerFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide();
	EmoteButtons_HideAllPopups();
	DeckBuilderFrameButtons_Update();
	DeckBuilderFrame_Update();
end

function DeckBuilderFrameDeckButton_OnClick()
	PlaySound("gsTitleOptionOK");
	DeckBuilderFrame.selectedIcon =  this:GetID() + (FauxScrollFrame_GetOffset(DeckBuilderFrame_DeckScrollFrame));
	found = DeckBuilderFrame.selectedIcon;
	DeckBuilderFrame.selectedAction = 0;
	EmoteButtons_ConfigDeck = EmoteButtons_DeckList[DeckBuilderFrame.selectedIcon];
	EB_EmotesManager:Hide();
	DeckManagerFrame:Hide();
	IconPickerFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide();
	EmoteButtons_HideAllPopups();
	DeckBuilderFrame_UpdateActions(found);
	DeckBuilderFrameButtons_Update() 
	DeckBuilderFrame_Update();
end

--shouldn't actually take an argument
function DeckBuilderFrame_UpdateActions(deck)
	local deck = DeckBuilderFrame.selectedIcon;
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
		buttonicon:SetTexture(IP_ICONPATH..d[i].image)
		if ( i == DeckBuilderFrame.selectedAction  ) then
			DeckBuilderFrame_ChangeTooltipButton_Icon:SetTexture(IP_ICONPATH..d[i].image)
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
		DeckBuilderFrameDeckActionsTitle:SetText("");
		DeckBuilderFrame_DeleteDeckButton:Enable();
		DeckBuilderFrame_RenameDeckButton:Enable();
	elseif (d==0) then
		DeckBuilderFrameActionsTitle:SetText(EMOTEBUTTONS_ACTIONSTITLENODECK);
		DeckBuilderFrameDeckActionsTitle:SetText(EMOTEBUTTONS_ACTIONSTITLENODECK);
		DeckBuilderFrame_DeleteDeckButton:Disable();
		DeckBuilderFrame_RenameDeckButton:Disable();
	else
		DeckBuilderFrameDeckActionsTitle:SetText(EMOTEBUTTONS_DECKACTIONSTITLEMAIN);
		DeckBuilderFrame_DeleteDeckButton:Disable();
		DeckBuilderFrame_RenameDeckButton:Disable();
	end
	
	if ( DeckBuilderFrame.selectedAction~=0 ) then
		DeckBuilderFrame_ChangeEmoteActionButton:Enable();
		DeckBuilderFrame_ChangeCMDActionButton:Enable();
		DeckBuilderFrame_ChangeDeckActionButton:Enable();
		DeckBuilderFrameActionsTitle:SetText(EMOTEBUTTONS_ACTIONSTITLE);

		deck = EmoteButtons_DeckList[d]
		a = DeckBuilderFrame.selectedAction
		if (EB_CurrentActions[deck][a]) then
			DeckBuilderFrame_DeleteActionButton:Enable();
			DeckBuilderFrame_ChangeTooltipButton:Enable();
  			DeckBuilderFrame_ChangeTooltipButton_Icon:SetTexture(IP_ICONPATH..EB_CurrentActions[deck][a].image)
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
			DeckBuilderFrame_ChangeTooltipButton_Icon:SetTexture("")
			DeckBuilderFrame_MoveDownButton:Disable();
			DeckBuilderFrame_MoveUpButton:Disable();
		end
	else
		DeckBuilderFrame_ChangeTooltipButton:Disable();
		DeckBuilderFrame_ChangeTooltipButton_Icon:SetTexture("")
		DeckBuilderFrame_ChangeDeckActionButton:Disable();
		DeckBuilderFrame_ChangeEmoteActionButton:Disable();
		DeckBuilderFrame_ChangeCMDActionButton:Disable();
		DeckBuilderFrame_DeleteActionButton:Disable();
		DeckBuilderFrame_MoveDownButton:Disable();
		DeckBuilderFrame_MoveUpButton:Disable();
		if (d~=0) then
			DeckBuilderFrameActionsTitle:SetText(EMOTEBUTTONS_ACTIONSTITLEDISABLED);
		end
	end
end

function DeckBuilderFrame_DeleteActionButton_OnClick()
	PlaySound("igCharacterInfoClose");
	EmoteButtons_CloseOpenDecks();
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	table.remove(EB_CurrentActions[deck], DeckBuilderFrame.selectedAction);
	EmoteButtons_ReloadDeck(deck);
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
		StaticPopupDialogs["EMOTEBUTTONS_DELETE_DECK_CONFIRMATION"] = {
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
			if found == 1 then
				ReloadUI()
			else
				DeckBuilderFrame.selectedAction = 0;
				DeckBuilderFrame.selectedIcon = 0;
				DeckBuilderFrame_Update();
				DeckBuilderFrame_UpdateActions();
				DeckBuilderFrameButtons_Update();
			end
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
		}
		StaticPopup_Show("EMOTEBUTTONS_DELETE_DECK_CONFIRMATION")

	end
end

function DeckBuilderFrame_AddDeckButton_OnClick()
	local accept = function()
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
	end
	-- Make a popup, show it
	StaticPopupDialogs["EMOTEBUTTONS_NEWDECK"]={
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
	StaticPopup_Show("EMOTEBUTTONS_NEWDECK");
	getglobal(getglobal(StaticPopup_Visible("EMOTEBUTTONS_NEWDECK")):GetName().."EditBox"):SetText("");
end

function DeckBuilderFrame_MoveUpButton_OnClick()
	PlaySound("igCharacterInfoOpen");
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	temp = EB_CurrentActions[deck][button-1]
	EB_CurrentActions[deck][button-1]=EB_CurrentActions[deck][button]
	EB_CurrentActions[deck][button] = temp
	DeckBuilderFrame.selectedAction = button-1;
	EmoteButtons_ConfigButton = button - 1;
	DeckBuilderFrameButtons_Update();
	DeckBuilderFrame_UpdateActions();
	EmoteButtons_ReloadDeck(deck)
	EmoteButtons_CloseOpenDecks();
	EmoteButtons_ReOpenDecks();
	EmoteButtons_ChangeCMDFrame:Hide();
	EmoteButtons_HideAllPopups()
	EB_EmotesManager:Hide();
	IconPickerFrame:Hide();
	DeckManagerFrame:Hide();
end

function DeckBuilderFrame_MoveDownButton_OnClick()
	PlaySound("igCharacterInfoOpen");
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	temp = EB_CurrentActions[deck][button+1]
	EB_CurrentActions[deck][button+1]=EB_CurrentActions[deck][button]
	EB_CurrentActions[deck][button] = temp
	DeckBuilderFrame.selectedAction = button+1;
	EmoteButtons_ConfigButton = button +1;
	DeckBuilderFrameButtons_Update();
	DeckBuilderFrame_UpdateActions();
	EmoteButtons_ReloadDeck(deck)
	EmoteButtons_CloseOpenDecks();
	EmoteButtons_ReOpenDecks();
	EmoteButtons_ChangeCMDFrame:Hide();
	EmoteButtons_HideAllPopups()
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
				EmoteButtons_ReloadDeck(deck)
				EmoteButtons_CloseOpenDecks();
				EmoteButtons_ReOpenDecks();
				DEFAULT_CHAT_FRAME:AddMessage("Deck rename success!");
			--EB_CurrentActions[EmoteButtons_ConfigDeck][EmoteButtons_ConfigButton].tooltip = editBox:GetText();
			--EmoteButtons_OpenDeckBuilder();
		end
		this:GetParent():Hide();
	end
	StaticPopupDialogs["EMOTEBUTTONS_RENAMEDECK"]={
		text=TEXT(EMOTEBUTTONS_RENAMEDECKTITLE),
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

function DeckBuilderFrame_IconPickerOkay(icon,text)
    local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
    EB_CurrentActions[deck][button].image = icon;
    EmoteButtons_ReloadDeck(deck);
	EB_CurrentActions[deck][button].tooltip = text;
    DeckBuilderFrame_UpdateActions();
end

function DeckBuilderFrame_ChangeTooltipButton_OnClick()
	local deck = EmoteButtons_ConfigDeck;
	local button = EmoteButtons_ConfigButton;
	txt = EB_CurrentActions[deck][button].tooltip
	icon = EB_CurrentActions[deck][button].image
	anchor = {
		Point="RIGHT",
		RelativeTo = "DeckBuilderFrame",
		RelativePoint = "TOPRIGHT",
		x=300,
		y=90;
	};
	f = DeckBuilderFrame_IconPickerOkay
	IconPickerForceShow(icon,txt,f,anchor)
	DeckManagerFrame:Hide();
    EmoteButtons_ChangeCMDFrame:Hide();
	EB_EmotesManager:Hide();
	EmoteButtons_HideAllPopups()
end