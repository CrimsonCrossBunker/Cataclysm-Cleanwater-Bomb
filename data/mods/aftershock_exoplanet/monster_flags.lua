local ccb = require("ccb")
local content = ccb.content

if not content.is_mod_active("mindovermatter") then
    -- Immune to telekinetic damage
    content.add(content.MonsterFlag { id = "TELEKIN_IMMUNE" })
end

if not content.is_mod_active("mindovermatter") then
    -- This monster is part of a hive mind
    content.add(content.MonsterFlag { id = "HIVE_MIND" })
end
