
function EmoteButtons_SetProfile(index)
	StaticPopupDialogs["EMOTEBUTTONS_SET_PROFILE_CONFIRMATION"] = {
	text = "Do you want to set your current decks config to the profile " .. EmoteButtons_Vars.Profiles[index].Name .. "?",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
	EmoteButtons_Vars.PIndex = index;
	EB_CurrentActions = EmoteButtons_Vars.Profiles[EmoteButtons_Vars.PIndex].Decks;
	EmoteButtons_Vars.Profile = EmoteButtons_Vars.Profiles[index].Name;	
	ReloadUI();	
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("EMOTEBUTTONS_SET_PROFILE_CONFIRMATION")

end

function EmoteButtons_DeleteProfile(index)
	StaticPopupDialogs["EMOTEBUTTONS_DELETE_PROFILE_CONFIRMATION"] = {
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
	StaticPopup_Show("EMOTEBUTTONS_DELETE_PROFILE_CONFIRMATION")
end

function EmoteButtons_AdvancedConfigFrame_OnShow()
	DeckBuilderFrame:Hide();
	EmoteButtons_ChangeCMDFrame:Hide();
	EmoteButtons_HideAllPopups()
	EB_EmotesManager:Hide();
	IconPickerFrame:Hide();
	DeckManagerFrame:Hide();
	EmoteButtons_AdvancedConfigFrame_SetMainShiftTitle:SetText(EMOTEBUTTONS_ROTATION);
	EmoteButtons_AdvancedConfigFrame_SetMainSizeTitle:SetText(EMOTEBUTTONS_SIZE);
end

--Did this onshow, instead of load since my variables weren't loaded on time for on load.
--Might just need to change when the AddonLoaded event is called?
function EmoteButtons_ProfileSetDropDown_OnShow()
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
			EmoteButtons_SetProfile(this.value) 
		end
		UIDropDownMenu_AddButton(info);
	end
end

function EmoteButtons_AdvancedConfigFrame_ProfileSetDropdownButton_OnClick()
	ToggleDropDownMenu(1, nil, EmoteButtons_AdvancedConfigFrame_ProfileSetDropdownButton, EmoteButtons_AdvancedConfigFrame_ProfileSetDropdownButton, 0, 0);
end

function EmoteButtons_ProfileDeleteDropDown_OnShow()
	for i=1, getn(EmoteButtons_Vars.Profiles) do
		info = {};
		info.text       = EmoteButtons_Vars.Profiles[i].Name;
		info.value      = i;
		if (EmoteButtons_Vars.Profiles[i].Name == EmoteButtons_Vars.Profile) then
			info.checked =true;
		else -- only add if its not currently in use...
			info.checked=false;
			info.func =  function() 
				EmoteButtons_DeleteProfile(this.value) 
			end
			UIDropDownMenu_AddButton(info);
		end
	end
end

function EmoteButtons_AdvancedConfigFrame_ProfileDeleteDropdownButton_OnClick()
	ToggleDropDownMenu(1, nil, EmoteButtons_AdvancedConfigFrame_ProfileDeleteDropdownButton, EmoteButtons_AdvancedConfigFrame_ProfileDeleteDropdownButton, 0, 0);
end

function EmoteButtons_DuplicateProfile(index)
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

function EmoteButtons_ProfileDuplicateDropDown_OnShow()
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
			EmoteButtons_DuplicateProfile(this.value) 
		end
		UIDropDownMenu_AddButton(info);
	end
end

function EmoteButtons_AdvancedConfigFrame_ProfileDuplicateDropdownButton_OnClick()
	ToggleDropDownMenu(1, nil, EmoteButtons_AdvancedConfigFrame_ProfileDuplicateDropdownButton, 
	EmoteButtons_AdvancedConfigFrame_ProfileDuplicateDropdownButton, 0, 0);
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

function EmoteButtons_ResetProfile()
	index = 0;
	for i=1, getn(EmoteButtons_Vars.Profiles) do
		if EmoteButtons_Vars.Profiles[i].Name==EmoteButtons_Vars.Profile then
			index = i;
		end
	end
	StaticPopupDialogs["EMOTEBUTTONS_RESET_PROFILE_CONFIRMATION"] = {
	text = "Do you want to reset the current decks config in the profile " .. EmoteButtons_Vars.Profiles[index].Name .. " to defaults?",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		EmoteButtons_Vars.Profiles[index].Decks = EMOTEBUTTONS_T;
		EB_CurrentActions = EmoteButtons_Vars.Profiles[index].Decks;
		ReloadUI();
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("EMOTEBUTTONS_RESET_PROFILE_CONFIRMATION")
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

function EmoteButtons_ExportProfile()
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
