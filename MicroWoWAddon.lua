local DEBUG = true;

local AddonFrame = CreateFrame("Frame", "MicroWoWAddonFrame");
AddonFrame:RegisterEvent("GOSSIP_SHOW");
AddonFrame:RegisterEvent("QUEST_DETAIL");
AddonFrame:RegisterEvent("QUEST_COMPLETE");
AddonFrame:RegisterEvent("QUEST_PROGRESS");

AddonFrame:SetScript("OnEvent", function(self, event, ...)
	if (event == "GOSSIP_SHOW") 		then HandleGossipShow()
	elseif 	(event == "QUEST_DETAIL") 	or 
			(event == "QUEST_COMPLETE") or 
			(event == "QUEST_PROGRESS") 
			then ShowQuestID(QuestFrame, nil, "ANCHOR_RIGHT", 0, -32)
	end
end)

QuestMapDetailsScrollFrame:HookScript("OnShow", function(self)
	local questIndex = GetQuestLogSelection();
	local questInfo = { GetQuestLogTitle(questIndex) };
	local questID = questInfo[8];
	ShowQuestID(self, questID, "ANCHOR_RIGHT", 28, 0)
end)

function HandleGossipShow()
	local availableQuests = { GetGossipAvailableQuests() };
	local activeQuests = { GetGossipActiveQuests() };
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
			
			if DEBUG then
				print("-- DEBUG GOSSIP SHOW --");
				print("Old text length: " .. parentFrameText:len());
				print("New text length: " .. newText:len());
			end
		end
	end
	
	for key, val in pairs(activeQuests) do
		if (key % 7 == 0) then
			local questId = val;
			local parentFrame = _G["GossipTitleButton" .. i + 1];
			local parentFrameText = parentFrame:GetText();
			if (parentFrameText ~= nil) then
				local newText = '[' .. questId .. '] ' .. parentFrameText;
				parentFrame:SetText(newText);

				if (newText:len() > maxCharsPerLine) then
					parentFrame:SetHeight(parentFrame:GetHeight() + increaseLineHeightBase);
				end
				
				i=i+1
				
				if DEBUG then
					print("-- DEBUG GOSSIP SHOW --");
					print("Old text length: " .. parentFrameText:len());
					print("New text length: " .. newText:len());
				end
			end
		end
	end
end

function ShowQuestID(p_ParentFrame, p_QuestID, p_Anchor, p_OffsetX, p_OffsetY)
	local frameName = "MicroQuestTooltip" .. "." .. p_ParentFrame:GetName();
	local tooltipFrame = _G[frameName] or CreateFrame("GameTooltip", frameName, p_ParentFrame, "GameTooltipTemplate");
	local questID = p_QuestID;
	if (questID == nil) then questID = GetQuestID(); end;
	
	tooltipFrame:SetOwner(p_ParentFrame, p_Anchor, p_OffsetX, p_OffsetY);
	tooltipFrame:ClearLines();
	tooltipFrame:AddDoubleLine("QuestID:", questID);
	tooltipFrame:Show();
end

