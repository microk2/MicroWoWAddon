QuestFrame:HookScript("OnShow", function(self)
	local frame = CreateFrame("Frame", "MicroQuestIDFrame", self);
	frame:SetPoint("TOP", 0, -30)
	frame:SetSize(200, 20)
	
	local frameText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	frameText:SetPoint("CENTER")
	frameText:SetText("QuestID: " .. GetQuestID())
		
	frame:SetScript("OnHide", function(self)
		self:Hide();
	end);
end);

GossipGreetingScrollChildFrame:RegisterEvent("GOSSIP_SHOW");
GossipGreetingScrollChildFrame:HookScript("OnEvent", function(self, event, ...)
	if (event == "GOSSIP_SHOW") then
		local availableQuests = { GetGossipAvailableQuests() };
		local i = 1;
		for key, val in pairs(availableQuests) do
			if (key % 8 == 0) then
				local questId = val;
				local parentFrame = _G["GossipTitleButton" .. i];
				local parentFrameText = parentFrame:GetText();
				local maxCharsPerLine = 39;
				parentFrame:SetText('[' .. questId .. '] ' .. parentFrameText);
				if (parentFrameText:len() > maxCharsPerLine) then
					parentFrame:SetHeight(25);
				end
				i=i+1
			end
		end
	end	
end);