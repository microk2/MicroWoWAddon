MWA.Core = {}

MWA.Core.CreateQuestIDFrame = function (parentFrame, questId, anchor, offsetX, offsetY)
    local questFrameName = MWA.Defines.AddonName .. "." .. parentFrame:GetName()
    local tooltipFrame = _G[questFrameName] or CreateFrame("GameTooltip", questFrameName, parentFrame, "GameTooltipTemplate")
    tooltipFrame:SetOwner(parentFrame, anchor, offsetX, offsetY)
	tooltipFrame:ClearLines()
	tooltipFrame:AddDoubleLine("QuestID:", questId)
	tooltipFrame:Show()

    local WoWHeadBtnName = questFrameName .. "." .. "WoWHeadBtn"
    local WowHeadBtn = _G[WoWHeadBtnName] or CreateFrame("Button", WoWHeadBtnName, parentFrame, "UIPanelButtonTemplate")
    WowHeadBtn:SetPoint("CENTER", tooltipFrame, "BOTTOM", 0, -20)
	WowHeadBtn:SetWidth(tooltipFrame:GetWidth())
	WowHeadBtn:SetHeight(30)
	WowHeadBtn:SetText("WoWHead Link")

    WowHeadBtn:SetScript("OnClick", function(self) 
       MWA.Core.CreateEditBoxFrame("WoWHead Quest Link", "https://www.wowhead.com/quest=" .. questId, 400, 200)
    end)
end

MWA.Core.CreateEditBoxFrame = function(title, text, sizeX, sizeY)
    local editBoxFrameName = MWA.Defines.AddonName .. "." .. "EditBoxFrame";
    local editBox = _G[editBoxFrameName] or CreateFrame("Frame", editBoxFrameName, UIParent, "DialogBoxFrame")
	editBox:SetSize(sizeX, sizeY)
	editBox:SetPoint("CENTER", UIParent, "CENTER")
    editBox:SetBackdropBorderColor(0, 0.44, 0.87, 0.5)
    editBox:Show()

    local inputFieldName = editBox:GetName() .. "." .. "InputField"
    local inputFieldFrame = _G[inputFieldName] or CreateFrame("EditBox", inputFieldName, editBox, "InputBoxTemplate")
    inputFieldFrame:SetParent(editBox)
    inputFieldFrame:SetSize(editBox:GetWidth() - 100, 100)
	inputFieldFrame:SetPoint("CENTER", editBox)
    inputFieldFrame:SetText(text)
    inputFieldFrame:SetFocus()

    local titleFrameName = editBox:GetName() .. "." .. "Title"
    local titleFrame = _G[titleFrameName] or CreateFrame("Frame", titleFrameName, editBox)
    titleFrame:SetParent(editBox)
    titleFrame:SetSize(editBox:GetWidth(), 30)
    titleFrame:SetPoint("TOP", editBox, 0, -40)
    titleFrame.text = titleFrame:CreateFontString(nil, "ARTWORK") 
    titleFrame.text:SetFont("Fonts\\ARIALN.ttf", 20, "OUTLINE")
    titleFrame.text:SetPoint("CENTER", 0, 0)
    titleFrame.text:SetText(title)
    titleFrame:Show()
end