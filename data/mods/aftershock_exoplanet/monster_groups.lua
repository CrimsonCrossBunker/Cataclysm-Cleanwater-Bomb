local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

content.add(content.MonsterGroup { id = "AFS_GROUP_FAUNA_TUNNELS", load_mode = "append" }
    :group("AFS_GROUP_FAUNA_HERBIVORE", 70, 0, 1, 2)
    :group("AFS_GROUP_FAUNA_PREDATORS_LOW_RISK", 25, 0, 1, 2)
    :group("AFS_GROUP_FAUNA_PREDATORS_MEDIUM_RISK", 5, 0, 1, 2))

content.add(content.MonsterGroup { id = "AFS_GROUP_FAUNA_HERBIVORE", load_mode = "append" }
    :monster("afs_runner", 350, 0, 1, 1)
    :monster("afs_grazer", 250, 0, 1, 4)
    :monster("afs_mon_hevel", 200, 0, 6, 12))

content.add(content.MonsterGroup { id = "AFS_GROUP_FAUNA_PREDATORS_LOW_RISK", load_mode = "append" }
    :monster("afs_mon_garlander", 90, 0, 1, 1)
    :group("AFS_GROUP_FAUNA_PREDATORS_MEDIUM_RISK", 10, 0, 1, 2))

content.add(content.MonsterGroup { id = "AFS_GROUP_FAUNA_PREDATORS_MEDIUM_RISK", load_mode = "append" }
    :monster("afs_titanis", 350, 0, 1, 1)
    :monster("afs_venandi", 250, 0, 1, 2)
    :monster("afs_mon_boatman", 200, 0, 2, 8))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE", load_mode = "append" }
    :monster("mon_afs_headless_horror", 20, 2, 1, 1, { starts = duration(67, "day") })
    :monster("mon_zombie_upliftedbear", 5, 10, 1, 1, { starts = duration(181, "day") })
    :monster("mon_uplifted_ape_zed", 8, 10, 1, 1, { starts = duration(181, "day") }))

content.add(content.MonsterGroup { id = "GROUP_CRYO_LAB", load_mode = "append" }
    :monster("mon_mutant_cryo", 940, 2, 1, 1)
    :monster("mon_cryokinetic", 8, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_MID", load_mode = "append" }
    :monster("mon_afs_headless_horror", 10, 20, 1, 1)
    :monster("mon_zombie_upliftedbear", 3, 10, 1, 1, { starts = duration(181, "day") })
    :monster("mon_uplifted_ape_zed", 5, 10, 1, 1, { starts = duration(181, "day") }))

content.add(content.MonsterGroup { id = "GROUP_PrepNet", load_mode = "append", is_animal = true }
    :monster("mon_cat", 100, 0, 1, 1)
    :monster("mon_cat", 20, 10, 2, 8)
    :monster("afs_mon_cyber_mastiff", 644, 10, 1, 1)
    :monster("afs_mon_cyber_mastiff", 15, 25, 1, 6)
    :monster("afs_mon_cyber_mastiff_pup", 1, 25, 1, 3)
    :monster("mon_chicken", 50, 10, 1, 16)
    :monster("mon_cow", 50, 25, 1, 8)
    :monster("mon_horse", 50, 25, 1, 4)
    :monster("mon_sheep", 50, 25, 1, 12))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_COMMON", load_mode = "append" }
    :monster("afs_mon_migoturret", 120, 1, 1, 1))

-- Mi-go base defenders for major boss battles.
content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_BOSS", load_mode = "append" }
    :monster("afs_mon_migoturret", 150, 1, 2, 3))

content.add(content.MonsterGroup { id = "GROUP_FOREST", load_mode = "append", is_animal = true }
    :monster("mon_uplifted_bear", 1, 10, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_zombie_upliftedbear", 1, 10, 1, 1, { starts = duration(181, "day") })
    :monster("mon_uplifted_ape_zed", 1, 10, 1, 1, { starts = duration(181, "day") })
    :monster("afs_mon_boatman", 1, 20, 2, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("afs_mon_garlander", 3, 10, 2, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("afs_mon_rabbit", 1, 10, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN", "WINTER" } })
    :monster("afs_titanis", 4, 10, 1, 1)
    :monster("afs_runner", 1, 10, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN", "WINTER" } })
    :monster("afs_grazer", 1, 10, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN", "WINTER" } })
    :monster("mon_uplifted_bear", 3, 10, 1, 1, { conditions = { "NIGHT", "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_uplifted_ape", 1, 10, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN", "WINTER" } })
    :monster("mon_uplifted_ape", 3, 10, 2, 4, { conditions = { "NIGHT", "SPRING", "SUMMER", "AUTUMN", "WINTER" } }))

content.add(content.MonsterGroup { id = "GROUP_CAVE", load_mode = "append" }
    :monster("mon_uplifted_bear", 50, 10, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_PARK_SCENIC", load_mode = "append" }
    :monster("mon_zombie_upliftedbear", 10, 1, 2, 3, { starts = duration(181, "day") })
    :monster("mon_uplifted_ape_zed", 10, 1, 2, 3, { starts = duration(181, "day") }))

content.add(content.MonsterGroup { id = "AFS_GROUP_AUG_CLINIC", load_mode = "append" }
    :monster("mon_broken_cyborg", 100, 1, 1, 1)
    :monster("mon_prototype_cyborg", 100, 2, 1, 1)
    :group("AFS_GROUP_ROBOT_MODERATE_RISK", 50, 2, 1, 2))

-- Brute upgrades
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_BRUTE", load_mode = "append" }
    :monster("mon_zombie_upliftedbear", 112, 10, 1, 1)
    :monster("mon_uplifted_ape_zed", 100, 10, 1, 1)
    :monster("mon_zombie_oliphant", 70, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SWAMP", load_mode = "append", is_animal = true }
    :monster("afs_mon_hevel", 1, 10, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN", "WINTER" } })
    :monster("afs_venandi", 1, 10, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN", "WINTER" } })
    :monster("afs_grazer", 1, 10, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN", "WINTER" } }))

content.add(content.MonsterGroup { id = "GROUP_RUINS", load_mode = "append" }
    :monster("afs_mon_reaver", 25, 0, 1, 3)
    :monster("afs_mon_reaver_rifle", 25, 0, 1, 1))

content.add(content.MonsterGroup { id = "AFS_GROUP_MOXIE_LOW_RISK", load_mode = "append" }
    :monster("mon_moxie_scavenger", 350, 1, 1, 1)
    :monster("mon_moxie_scavenger", 250, 1, 2, 4)
    :monster("mon_moxie_regenerator", 200, 1, 1, 2)
    :monster("mon_moxie_infested", 150, 1, 1, 2)
    :monster("mon_moxie_grabby", 100, 1, 1, 1)
    :monster("mon_moxie_bloodhound", 50, 1, 1, 2))

content.add(content.MonsterGroup { id = "AFS_GROUP_MOXIE_MEDIUM_RISK", load_mode = "append" }
    :monster("mon_moxie_scavenger", 250, 1, 3, 4)
    :monster("mon_moxie_infested", 250, 1, 3, 4)
    :monster("mon_moxie_grabby", 200, 1, 1, 1)
    :monster("mon_moxphore_emetic", 100, 1, 1, 2)
    :monster("mon_moxie_elder", 50, 1, 1, 1)
    :monster("mon_moxie_spartan", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "AFS_GROUP_RUIN_MOXIE", load_mode = "append" }
    :monster("mon_human_biomachine", 70, 0, 1, 2)
    :monster("mon_human_biomachine", 20, 0, 5, 6)
    :group("AFS_GROUP_MOXIE_LOW_RISK", 100, 0, 1, 2))

-- Neutral bots from the original colony.
content.add(content.MonsterGroup { id = "AFS_GROUP_ROBOT_NEUTRAL_OLD", load_mode = "append" }
    :monster("mon_utilibot_const", 550, 0, 1, 1)
    :monster("mon_utilibot_const", 250, 0, 1, 2)
    :monster("mon_utilibot_fire", 100, 0, 1, 1)
    :monster("mon_hazmatbot", 100, 0, 1, 2)
    :monster("mon_mech_horse", 15, 0, 1, 1))

-- Neutral bots from the original colony.  Specifcally those suited for use in a domestic or residental settings.
content.add(content.MonsterGroup { id = "AFS_GROUP_ROBOT_NEUTRAL_OLD_DOMESTIC", load_mode = "append" }
    :monster("mon_utilibot", 550, 0, 1, 1)
    :monster("mon_utilibot_fire", 200, 0, 1, 1)
    :monster("mon_utilibot_butler", 10, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "AFS_GROUP_ROBOT_LOW_RISK",
    load_mode = "append",
    default_monster = "mon_skitterbot_rat",
}
    :monster("mon_bloodhound_drone", 100, 0, 1, 2)
    :monster("mon_manhack", 200, 0, 1, 2)
    :monster("mon_skitterbot", 200, 0, 1, 1)
    :monster("mon_skitterbot_rat", 500, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "AFS_GROUP_ROBOT_MODERATE_RISK",
    load_mode = "append",
    default_monster = "mon_advbot_laser",
}
    :monster("mon_advbot_laser", 100, 40, 1, 1)
    :monster("mon_old_imaginifer_laser", 100, 100, 1, 1)
    :monster("mon_old_imaginifer", 100, 100, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_PIRATE__BOT_AMBUSH",
    load_mode = "append",
    default_monster = "mon_manhack",
}
    :monster("mon_bloodhound_drone", 500, 50, 1, 2)
    :monster("mon_manhack", 200, 4, 1, 2)
    :monster("mon_skitterbot", 200, 20, 1, 1)
    :monster("mon_scavbot_needle", 100, 70, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_ROBOT_FARM_HOSTILE",
    load_mode = "append",
    default_monster = "mon_manhack",
}
    :monster("mon_utilibot_hostile", 100, 70, 1, 1)
    :monster("mon_fumigator", 200, 4, 1, 2)
    :monster("mon_skitterbot", 200, 20, 1, 1)
    :monster("mon_scavbot_needle", 3, 70, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_ROBOT_COPS_HOSTILE",
    load_mode = "append",
    default_monster = "mon_manhack",
}
    :monster("mon_zenit", 50, 100, 1, 1)
    :monster("mon_skitterbot", 200, 20, 1, 1)
    :monster("mon_afs_eyebot", 200, 4, 1, 1)
    :monster("mon_afs_copbot", 100, 70, 1, 1)
    :monster("mon_uica_imaginifer_police", 100, 50, 1, 1)
    :monster("mon_afs_riotbot", 50, 100, 1, 1))
