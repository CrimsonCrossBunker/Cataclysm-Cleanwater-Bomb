local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup { id = "GROUP_EGG_MARSHMALLOW", load_mode = "append" }
    :monster("mon_marshmallow_kid", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_SMORES", load_mode = "append" }
    :monster("mon_marshmallow_kid_armored", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_GUMMY", load_mode = "append" }
    :monster("mon_gummy_cub", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_GUMMY_GATOR", load_mode = "append" }
    :monster("mon_gummy_gator", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_CRACKER", load_mode = "append" }
    :monster("mon_small_cracker", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_CRACKER_ROE", load_mode = "append" }
    :monster("mon_cracker_lbass", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_COOKIE", load_mode = "append" }
    :monster("mon_cookie", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_COOKIE_EGG", load_mode = "append" }
    :monster("mon_cookie_hydra_youth", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_GUM", load_mode = "append" }
    :monster("mon_spider_gum_baby", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_CAFFGUM", load_mode = "append" }
    :monster("mon_gum_spider_wolf_baby", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_CHOC_COW", load_mode = "append" }
    :monster("mon_cow_calf_choc", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_LICORICE", load_mode = "append" }
    :monster("mon_licorice_snake_hatchling", 1, 1, 1, 1))
