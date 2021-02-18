local AddonFrame = CreateFrame("Frame", "MicroWoWAddonFrame");
AddonFrame:RegisterEvent("GOSSIP_SHOW");
AddonFrame:RegisterEvent("QUEST_DETAIL");

AddonFrame:SetScript("OnEvent", function(self, event, ...)
	if (event == "GOSSIP_SHOW") 		then HandleGossipShow()
	elseif (event == "QUEST_DETAIL") 	then HandleQuestDetail()
	end
end)

function HandleGossipShow()
	local availableQuests = { GetGossipAvailableQuests() };
	local i = 1;
	local maxCharsPerLine = 52;
	local increaseLineHeightBase = 10;
	
	for key, val in pairs(availableQuests) do
		if (key % 8 == 0) then
			local questId = val;
			local parentFrame = _G["GossipTitleButton" .. i];
			local parentFrameText = parentFrame:GetText();
			local newText = '[' .. questId .. '] ' .. parentFrameText;
			parentFrame:SetText(newText);

			if (newText:len() > maxCharsPerLine) then
				parentFrame:SetHeight(parentFrame:GetHeight() + increaseLineHeightBase);
			end
			
			i=i+1
		end
	end
end

function HandleQuestDetail()
	local frame = CreateFrame("Frame", "MicroQuestIDFrame", QuestFrame);
	frame:SetPoint("TOP", 0, -30)
	frame:SetSize(200, 20)
	
	local frameText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frameText:SetPoint("CENTER")
	frameText:SetText("QuestID: " .. GetQuestID())
		
	frame:SetScript("OnHide", function(self)
		self:Hide();
	end);
end