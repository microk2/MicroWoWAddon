MWA.Commands = {}

-- Generate script template and copy the template in the clipboard
MWA.Commands.Script = {
    name = "script",
    alias = "scr",
    callback = function(args)
        local guid = UnitGUID("target")
        local name = GetUnitName("target", false)
        if name == nil then
            print("You must select a target.")
            return
        end

        name = string.lower(name)

        if guid then
            local unitType = strsplit("-", guid)
            if unitType == "Creature" or unitType == "Vehicle" then
                local _, _, _, _, _, npcId, _ = strsplit("-", guid)
                local scriptName = "struct npc_" .. string.gsub(name, "%s+", "_") .. npcId .. " : public ScriptedAI\n};"
                MWA.Utils.CopyToClipboard("asd")
            end
        end
    end
}
