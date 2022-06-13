local AddonFrame = CreateFrame("Frame", "MicroWoWAddonFrame");
AddonFrame:RegisterEvent("GOSSIP_SHOW");
AddonFrame:RegisterEvent("QUEST_DETAIL");
AddonFrame:RegisterEvent("QUEST_COMPLETE");
AddonFrame:RegisterEvent("QUEST_PROGRESS");

AddonFrame:SetScript("OnEvent", function(self, event, ...)
	if 	(event == "QUEST_DETAIL") or (event == "QUEST_COMPLETE") or (event == "QUEST_PROGRESS") then
		MWA.Core.CreateQuestIDFrame(MWA.Defines.Frames.QuestFrame, GetQuestID(), "ANCHOR_RIGHT", 0, -32)
	end
end)