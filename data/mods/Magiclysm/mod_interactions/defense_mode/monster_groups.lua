local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup { id = "GROUP_LIZARDFOLK_DM", load_mode = "append" }
    :monster("mon_lizardfolk_warrior_dm", 900, 1, 1, 1)
    :monster("mon_lizardfolk_warrior_dm", 20, 1, 2, 4)
    :monster("mon_lizardfolk_hunter_dm", 30, 4, 1, 2)
    :monster("mon_lizardfolk_shaman_dm", 10, 30, 1, 1)
    :monster("mon_lizardfolk_chieftan_dm", 10, 50, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GOLEM_DM", load_mode = "append" }
    :monster("mon_plasticgolem_dm", 965, 1, 1, 1)
    :monster("mon_claygolem_dm", 20, 1, 1, 1)
    :monster("mon_stonegolem_dm", 10, 1, 1, 1)
    :monster("mon_irongolem_dm", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GOBLIN_DM", load_mode = "append" }
    :monster("mon_goblin_warrior_dm", 900, 1, 1, 1)
    :monster("mon_goblin_warrior_dm", 35, 1, 2, 4)
    :monster("mon_goblin_slinger_dm", 65, 1, 2, 4))

content.add(content.MonsterGroup { id = "GROUP_ORC_DM", load_mode = "append" }
    :monster("mon_orc_warrior_dm", 960, 5, 1, 1)
    :monster("mon_orc_archer_dm", 25, 7, 1, 1)
    :monster("mon_orc_blood_warrior_dm", 15, 5, 1, 1))
