local ccb = require("ccb")
local content = ccb.content

-- Upgrade group for classic zombies
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_UPGRADE", load_mode = "replace" }
    :monster("mon_zombie", 1000, 1, 1, 1)
    :monster("mon_zombie_cunning", 5, 1, 1, 1))
