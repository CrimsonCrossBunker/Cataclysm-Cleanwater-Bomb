local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup { id = "GROUP_MYTHOS_SPAWN", load_mode = "append" }
    :monster("mon_rat_thing_dm", 1, 1, 1, 1)
    :monster("mon_ghoul_dm", 1, 1, 1, 1)
    :monster("mon_ghast_dm", 1, 1, 1, 1)
    :monster("mon_nightgaunt_dm", 1, 1, 1, 1)
    :monster("mon_deep_one_dm", 1, 1, 1, 1))
