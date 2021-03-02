local DEBUG = false;

local AddonFrame = CreateFrame("Frame", "MicroWoWAddonFrame");
AddonFrame:RegisterEvent("GOSSIP_SHOW");
AddonFrame:RegisterEvent("QUEST_DETAIL");
AddonFrame:RegisterEvent("QUEST_COMPLETE");
AddonFrame:RegisterEvent("QUEST_PROGRESS");

AddonFrame:SetScript("OnEvent", function(self, event, ...)
	if (event == "GOSSIP_SHOW") then
		HandleGossipShow()
	elseif 	(event == "QUEST_DETAIL") or (event == "QUEST_COMPLETE") or (event == "QUEST_PROGRESS") then		
		ShowQuestID(QuestFrame, nil, "ANCHOR_RIGHT", 0, -32, true)
	end
end)

-- Add the questID tooltip to Map & Quest log frame
QuestMapDetailsScrollFrame:HookScript("OnShow", function(self)
	local questIndex = GetQuestLogSelection();
	local questInfo = { GetQuestLogTitle(questIndex) };
	local questID = questInfo[8];
	ShowQuestID(self, questID, "ANCHOR_RIGHT", 28, 0, true)
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

function ShowQuestID(p_ParentFrame, p_QuestID, p_Anchor, p_OffsetX, p_OffsetY, p_LinkBtn)
	local frameName = "MicroQuestTooltip" .. "." .. p_ParentFrame:GetName();
	local tooltipFrame = _G[frameName] or CreateFrame("GameTooltip", frameName, p_ParentFrame, "GameTooltipTemplate");
	local questID = p_QuestID;
	if (questID == nil) then questID = GetQuestID(); end;
	
	tooltipFrame:SetOwner(p_ParentFrame, p_Anchor, p_OffsetX, p_OffsetY);
	tooltipFrame:ClearLines();
	tooltipFrame:AddDoubleLine("QuestID:", questID);
	tooltipFrame:Show();
	
	if (p_LinkBtn == nil) or (p_LinkBtn ~= true) then return end;
	
	local freakzBtnName = frameName .. "." .. "FreakzBtn";
	local freakzButton = _G[freakzBtnName] or CreateFrame("Button", freakzBtnName, p_ParentFrame, "UIPanelButtonTemplate");
	freakzButton:SetPoint("CENTER", tooltipFrame, "BOTTOM", 0, -20)
	freakzButton:SetWidth(tooltipFrame:GetWidth())
	freakzButton:SetHeight(30)
	freakzButton:SetText("WoW Freakz Link")
	
	local wowheadBtnName = frameName .. "." .. "WoWHeadBtn";
	local wowheadBtn = _G[wowheadBtnName] or CreateFrame("Button", wowheadBtnName, p_ParentFrame, "UIPanelButtonTemplate");
	wowheadBtn:SetPoint("CENTER", freakzButton, "BOTTOM", 0, -20)
	wowheadBtn:SetWidth(tooltipFrame:GetWidth())
	wowheadBtn:SetHeight(30)
	wowheadBtn:SetText("WoW Head Link")
	
	freakzButton:SetScript("OnClick", function(self)
		CreateLink("WoWFreakz", questID);
	end);
	
	wowheadBtn:SetScript("OnClick", function(self)
		CreateLink("WoWHead", questID);
	end);
end

function CreateLink(p_Server, p_QuestID)
	local link;
	if (p_Server == "WoWFreakz") then
		link = "https://www.wow-freakz.com/quest_helper.php?quest=" .. p_QuestID;
	elseif (p_Server == "WoWHead") then
		link = "https://www.wowhead.com/quest=" .. p_QuestID;
	end	
	-- Create an editBox frame from where you copy the link
	print (link)
end
