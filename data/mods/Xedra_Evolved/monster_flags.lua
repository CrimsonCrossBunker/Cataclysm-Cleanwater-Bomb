local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterFlag { id = "EVIL_EYE_IMMUNE_MONSTER" })

content.add(content.MonsterFlag { id = "STABILIZED_TIMELINE" })

if not content.is_mod_active("magiclysm") then
    -- A monster that uses a lot of magic, for detection magic purposes.
    content.add(content.MonsterFlag { id = "MAGIC_USER" })
end

-- Immune to shadow damage
content.add(content.MonsterFlag { id = "SHADOW_MONSTER_IMMUNE" })

-- Immune to withering damage
content.add(content.MonsterFlag { id = "WITHERINGPROOF" })
