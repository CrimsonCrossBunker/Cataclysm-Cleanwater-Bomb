local ccb = require("ccb")
local content = ccb.content

-- used to specials to not spawn in the raid dimension, notably faction bases
content.add(content.JsonFlag {
    id = "SKY_ISLAND_NO_RAID_SPAWN",
    name = ccb.content.text("Sky Island Spawn Prevention"),
})

-- Mainly used to have a single whitelist flag for region settings to disable all other special spawns
-- Can be used in the future for other islands to find in the home dimension?
content.add(content.JsonFlag {
    id = "SKY_ISLAND",
    name = ccb.content.text("Sky Island Specials"),
})

content.add(content.JsonFlag { id = "MEGACITY_FLAG" })
