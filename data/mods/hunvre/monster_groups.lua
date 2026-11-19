local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup { id = "euzhvil_group", load_mode = "append" }
    :monster("mon_euzhvil_chaser", 1, 1, 1, 1)
    :monster("mon_euzhvil_bound", 1, 1, 1, 1)
    :monster("mon_euzhvil_bully", 1, 1, 1, 1)
    :monster("mon_euzhvil_suffocating", 1, 1, 1, 1))
