local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

content.add(content.MonsterGroup { id = "GROUP_NECROPOLIS", load_mode = "append" }
    :monster("mon_zombie", 899, 1, 1, 1)
    :monster("mon_irradiated_wanderer_1", 90, 1, 1, 1)
    :monster("mon_irradiated_wanderer_2", 10, 1, 1, 1)
    :monster("mon_irradiated_wanderer_3", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NECROPOLIS_SEWERS", load_mode = "append" }
    :monster("mon_irradiated_wanderer_1", 848, 1, 1, 1)
    :monster("mon_irradiated_wanderer_2", 40, 1, 1, 1)
    :monster("mon_irradiated_wanderer_3", 10, 1, 1, 1)
    :monster("mon_irradiated_wanderer_4", 1, 1, 1, 1)
    :monster("mon_charred_nightmare", 1, 1, 1, 1)
    :monster("mon_centipede_giant", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NECROPOLIS_VAULT", load_mode = "append" }
    :monster("mon_irradiated_wanderer_1", 40, 1, 1, 1)
    :monster("mon_irradiated_wanderer_2", 910, 1, 1, 1)
    :monster("mon_irradiated_wanderer_3", 40, 1, 1, 1)
    :monster("mon_irradiated_wanderer_4", 5, 1, 1, 1)
    :monster("mon_charred_nightmare", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NECROPOLIS_VAULT2", load_mode = "append" }
    :monster("mon_irradiated_wanderer_2", 30, 1, 1, 1)
    :monster("mon_irradiated_wanderer_3", 920, 1, 1, 1)
    :monster("mon_irradiated_wanderer_4", 30, 1, 1, 1)
    :monster("mon_charred_nightmare", 20, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NECROPOLIS_VAULT3", load_mode = "append" }
    :monster("mon_irradiated_wanderer_4", 890, 1, 1, 1)
    :monster("mon_irradiated_wanderer_3", 20, 1, 1, 1)
    :monster("mon_charred_nightmare", 90, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NECROPOLIS_SWIMMING", load_mode = "append" }
    :monster("mon_sewer_fish", 995, 1, 1, 1)
    :monster("mon_irradiated_wanderer_2", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NECROPOLIS_ROBOT", load_mode = "append" }
    :monster("mon_tankbot", 20, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ROBOT", load_mode = "append" }
    :monster("mon_tripod", 110, 0, 1, 1)
    :monster("mon_chickenbot", 60, 0, 1, 1)
    :monster("mon_tankbot", 20, 0, 1, 1))

-- Used in the military bunker
content.add(content.MonsterGroup { id = "GROUP_MIL_BASE", load_mode = "append" }
    :monster("mon_tripod", 5, 0, 1, 1)
    :monster("mon_chickenbot", 5, 0, 1, 1)
    :monster("mon_tankbot", 5, 0, 1, 1)
    :monster("mon_zombie_bio_op", 20, 50, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MAYBE_MIL", load_mode = "append" }
    :monster("mon_tripod", 5, 0, 1, 1)
    :monster("mon_chickenbot", 5, 0, 1, 1)
    :monster("mon_tankbot", 5, 0, 1, 1)
    :monster("mon_zombie_bio_op", 20, 50, 1, 1))

-- Used in the military bunker, LIXA and Hub01 convoy ambush
content.add(content.MonsterGroup { id = "GROUP_MIL_STRONG", load_mode = "append" }
    :monster("mon_tripod", 5, 0, 1, 1)
    :monster("mon_chickenbot", 5, 0, 1, 1)
    :monster("mon_tankbot", 5, 0, 1, 1)
    :monster("mon_zombie_bio_op", 20, 50, 1, 1))

-- Lots of hazmats and burners.
content.add(content.MonsterGroup { id = "GROUP_MIL_MASS_GRAVE", load_mode = "append" }
    :monster("mon_zombie_soldier", 10, 1, 1, 1)
    :monster("mon_zombie_flamer", 20, 1, 1, 1, { starts = duration(20, "day") })
    :monster("mon_zombie_hazmat", 20, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NETHER_REALITY_TEAR_FIELD", load_mode = "append" }
    :monster("mon_staring_eye", 100, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NETHER", load_mode = "append" }
    :monster("mon_staring_eye", 120, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NETHER_PORTAL", load_mode = "append" }
    :monster("mon_staring_eye", 200, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_WILDERNESS_FOREST_ZOMBIE", load_mode = "append" }
    :monster("mon_zpider_mass", 1, 10, 1, 1))
