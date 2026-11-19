local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup { id = "GROUP_FERAL_PSYCHIC_DM", load_mode = "append" }
    :monster("mon_feral_human_bio_dm", 1, 2, 1, 1)
    :monster("mon_feral_human_clair_dm", 1, 1, 1, 1)
    :monster("mon_feral_human_pyrokin_dm", 1, 3, 1, 1)
    :monster("mon_feral_human_telekin_dm", 1, 2, 1, 1)
    :monster("mon_feral_human_teep_dm", 1, 1, 1, 1)
    :monster("mon_feral_human_porter_dm", 1, 1, 1, 1)
    :monster("mon_feral_human_vita_dm", 1, 1, 1, 1))
