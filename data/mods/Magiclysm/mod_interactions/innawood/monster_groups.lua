local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup { id = "GROUP_FOREST", load_mode = "append", is_animal = true }
    :group("GROUP_GOBLIN_HUNTING_PARTY", 45, 2, 4, 8, { conditions = { "NIGHT" } }))

content.add(content.MonsterGroup { id = "GROUP_GOBLIN_HUNTING_PARTY", load_mode = "append", is_animal = true }
    :monster("mon_goblin_warrior", 100, 1, 1, 1)
    :monster("mon_goblin_slinger", 50, 1, 1, 1)
    :monster("mon_goblin_bugbear", 10, 2, 1, 1)
    :monster("mon_goblin_bugbear_stalker", 3, 2, 1, 1)
    :monster("mon_goblin_mage_poison", 10, 4, 1, 1)
    :monster("mon_orc_warrior", 25, 1, 1, 1)
    :monster("mon_orc_archer", 12, 1, 1, 1)
    :monster("mon_orc_mage_blood", 5, 4, 1, 1))
