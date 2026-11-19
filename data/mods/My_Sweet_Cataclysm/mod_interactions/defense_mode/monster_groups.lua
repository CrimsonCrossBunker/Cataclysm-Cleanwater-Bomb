local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup { id = "GROUP_SWEET_HORDE", load_mode = "append" }
    :monster("mon_marshmallow_guy_dm", 1, 1, 1, 1)
    :monster("mon_marshmallow_buff_dm", 1, 1, 1, 1)
    :monster("mon_marshmallow_guy_armored_dm", 1, 1, 1, 1)
    :monster("mon_marshmallow_buff_armored_dm", 1, 1, 1, 1)
    :monster("mon_gummy_dm", 1, 1, 1, 1)
    :monster("mon_gummy_gator_dm", 1, 1, 1, 1)
    :monster("mon_cracker_dm", 1, 1, 1, 1)
    :monster("mon_cookie_dm", 1, 1, 1, 1)
    :monster("mon_cookie_hydra_dm", 1, 1, 1, 1)
    :monster("mon_spider_gum_dm", 1, 1, 1, 1)
    :monster("mon_gum_spider_wolf_dm", 1, 1, 1, 1)
    :monster("mon_licorice_snake_dm", 1, 1, 1, 1))
