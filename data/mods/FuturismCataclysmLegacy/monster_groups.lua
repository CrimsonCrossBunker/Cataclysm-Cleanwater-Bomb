local ccb = require("ccb")
local content = ccb.content

content.add(content.MonsterGroup { id = "GROUP_LAB_MAINTENANCE", load_mode = "append" }
    :monster("mon_fcl_eyebot", 5, 1, 1, 1))

-- For monsters, spawned by hallucinator effects.  Must represent the awful monsters the player want never see.  Put here every asshole you want.
content.add(content.MonsterGroup { id = "GROUP_YOUR_FEARS", load_mode = "append" }
    :monster("mon_fcl_riotbot", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "FCL_GROUP_AUG_CLINIC", load_mode = "append" }
    :monster("mon_broken_cyborg", 100, 1, 1, 1)
    :monster("mon_prototype_cyborg", 100, 2, 1, 1)
    :group("FCL_GROUP_ROBOT_CIVIL_SECURITY", 50, 2, 1, 2))

content.add(content.MonsterGroup {
    id = "FCL_GROUP_MEALGRUB_FARM",
    load_mode = "append",
    default_monster = "mon_zombie",
}
    :monster("mon_zombie", 450, 1, 1, 1)
    :monster("mon_zombie_scientist", 120, 1, 1, 1)
    :group("GROUP_ZOMBIE", 300, 1, 1, 1)
    :group("FCL_GROUP_ROBOT_CIVIL_SECURITY", 65, 2, 1, 2)
    :monster("mon_zombie_static", 3, 5, 1, 1)
    :monster("mon_zombie_electric", 2, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_COMMON", load_mode = "append" }
    :monster("fcl_mon_migoturret", 120, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_BOSS", load_mode = "append" }
    :monster("fcl_mon_migoturret", 150, 1, 2, 3))

content.add(content.MonsterGroup { id = "GROUP_ROBOT", load_mode = "append" }
    :monster("mon_fcl_copbot", 0, 0, 1, 1)
    :monster("mon_fcl_molebot", 40, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "FCL_GROUP_ROBOT_CIVIL_SECURITY",
    load_mode = "append",
    default_monster = "mon_fcl_copbot",
}
    :monster("mon_fcl_eyebot", 40, 40, 1, 1)
    :monster("mon_fcl_copbot", 100, 40, 1, 1)
    :monster("mon_fcl_riotbot", 100, 100, 1, 1))

content.add(content.MonsterGroup { id = "FCL_GROUP_UTILIBOT_SITE", load_mode = "append" }
    :monster("mon_utilibot_hostile", 50, 0, 1, 1)
    :monster("mon_utilibot_const", 50, 0, 1, 1))
