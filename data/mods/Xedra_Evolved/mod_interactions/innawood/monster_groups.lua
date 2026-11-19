local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup { id = "GROUP_RENFIELD_UPGRADE_INNAWOOD", load_mode = "append" }
    :monster("mon_renfield_innawood", 950, 1, 1, 1)
    :monster("mon_renfield_abomination", 50, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FOREST", load_mode = "append", is_animal = true }
    :group("GROUP_CHANGELING_MIRRORED_FIELD", 10, 10, 1, 1)
    :group("GROUP_CHANGELING_MIRRORED_FIELD", 3, 15, 2, 6)
    :group("GROUP_CHANGELING_STRIKE_FORCE", 3, 15, 2, 6)
    :group("GROUP_OVERLAND_RENFIELD", 10, 5, 1, 1))

-- Current SPRING first DAY count is X.
content.add(content.MonsterGroup { id = "GROUP_SWAMP", load_mode = "append", is_animal = true }
    :group("GROUP_CHANGELING_MIRRORED_FIELD", 5, 10, 1, 1)
    :group("GROUP_CHANGELING_MIRRORED_FIELD", 1, 15, 2, 6)
    :group("GROUP_CHANGELING_STRIKE_FORCE", 1, 15, 2, 6)
    :group("GROUP_OVERLAND_RENFIELD", 10, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_OVERLAND_RENFIELD", load_mode = "append" }
    :monster("mon_renfield_innawood", 200, 1, 1, 1)
    :monster("mon_renfield_innawood", 50, 1, 2, 5))

content.add(content.MonsterGroup { id = "GROUP_CAVE_VAMPIRE", load_mode = "append" }
    :monster("mon_renfield_innawood", 200, 1, 1, 1)
    :monster("mon_renfield_innawood", 50, 1, 1, 3)
    :group("GROUP_VAMPIRE_MOROI_TYPES_INNAWOOD", 35, 1, 1, 1)
    :monster("mon_vampire_strigoi", 25, 1, 1, 1)
    :monster("mon_vampire_strigoi", 5, 1, 2, 4)
    :monster("xe_mon_bat", 100, 1, 2, 4)
    :monster("mon_bat_giant", 35, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_VAMPIRE_MOROI_TYPES_INNAWOOD", load_mode = "append" }
    :monster("mon_vampire_moroi_fast_innawood", 10, 1, 1, 1)
    :monster("mon_vampire_moroi_tough_innawood", 20, 1, 1, 1)
    :monster("mon_vampire_moroi_animalistic_innawood", 25, 1, 1, 1)
    :monster("mon_vampire_moroi_stealthy_innawood", 15, 1, 1, 1))
