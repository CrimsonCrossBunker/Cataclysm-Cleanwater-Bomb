local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

content.add(content.MonsterGroup {
    id = "GROUP_FOREST_THICK",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :group("GROUP_WILDERNESS_FOREST_MAMMAL", 375, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", 375, 1, 1, 1, { conditions = { "WINTER" } })
    :group("GROUP_WILDERNESS_FOREST_BIRD", 300, 1, 1, 1)
    :group("GROUP_WILDERNESS_FOREST_INSECT_HARMLESS", 75, 1, 1, 1, {
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_INSECT", 75, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_WILDERNESS_FOREST_REPTILE", 30, 5, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_claw_runner", 15, 4, 1, 1)
    :monster("mon_claw_runner", 6, 4, 2, 5)
    :monster("mon_claw_hunter", 6, 30, 1, 1)
    :monster("mon_claw_hunter", 2, 30, 2, 5)
    :group("GROUP_HOLLOW_TRIBAL_WARPARTY", 10, 2, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_HOLLOW_TRIBAL_HUNTPARTY", 35, 1, 1, 1, { conditions = { "DAY" } })
    :group("GROUP_HOLLOW_ZOMBIES", 40, 1, 1, 1)
    :group("GROUP_HOLLOW_ZOMBIES", 10, 1, 2, 5)
    :monster("mon_tanglevine", 5, 15, 1, 1)
    :group("GROUP_FOREST_SPIRIT", 3, 20, 1, 1)
    :group("GROUP_CHANGELING_MIRRORED_FIELD", 3, 10, 1, 1)
    :group("GROUP_CHANGELING_MIRRORED_FIELD", 1, 15, 2, 6)
    :group("GROUP_CHANGELING_STRIKE_FORCE", 1, 15, 2, 6)
    :group("GROUP_TRIFFID", 2, 15, 2, 6)
    :group("GROUP_OVERLAND_RENFIELD", 2, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FOREST", load_mode = "append" }
    :group("GROUP_WILDERNESS_FOREST_MAMMAL", 75, 1, 1, 1, {
        starts = duration(12, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL", 75, 1, 1, 1, {
        starts = duration(28, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL", 75, 1, 1, 1, {
        starts = duration(112, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL", 75, 1, 1, 1, {
        starts = duration(360, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", 75, 1, 1, 1, {
        starts = duration(12, "day"),
        conditions = { "WINTER" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", 75, 1, 1, 1, {
        starts = duration(28, "day"),
        conditions = { "WINTER" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", 75, 1, 1, 1, {
        starts = duration(112, "day"),
        conditions = { "WINTER" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", 75, 1, 1, 1, {
        starts = duration(360, "day"),
        conditions = { "WINTER" },
    })
    :monster("mon_rattlesnake_big", 15, 1, 1, 1)
    :monster("mon_rattlesnake_giant", 7, 2, 1, 1)
    :monster("mon_claw_runner", 9, 4, 1, 1)
    :monster("mon_claw_runner", 3, 4, 2, 5)
    :monster("mon_claw_hunter", 3, 30, 1, 1)
    :monster("mon_claw_hunter", 1, 30, 2, 5)
    :group("GROUP_HOLLOW_TRIBAL_WARPARTY", 50, 2, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_HOLLOW_TRIBAL_HUNTPARTY", 75, 1, 1, 1, { conditions = { "DAY" } })
    :group("GROUP_HOLLOW_ZOMBIES", 25, 1, 1, 1)
    :group("GROUP_HOLLOW_ZOMBIES", 5, 1, 2, 5))

content.add(content.MonsterGroup { id = "GROUP_SWAMP", load_mode = "append" }
    :monster("mon_lemming", 50, 1, 2, 7, {
        starts = duration(360, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_rattlesnake_big", 30, 1, 1, 1)
    :monster("mon_rattlesnake_giant", 25, 2, 1, 1)
    :monster("mon_claw_runner", 15, 4, 1, 1)
    :monster("mon_claw_runner", 5, 4, 2, 5)
    :monster("mon_claw_hunter", 6, 30, 1, 1)
    :monster("mon_claw_hunter", 2, 30, 2, 5)
    :group("GROUP_HOLLOW_ZOMBIES", 25, 1, 1, 1)
    :group("GROUP_HOLLOW_ZOMBIES", 5, 1, 2, 5))

content.add(content.MonsterGroup { id = "GROUP_RIVER", load_mode = "append", default_monster = "mon_null" }
    :group("GROUP_HOLLOW_ZOMBIES", 5, 1, 1, 1)
    :group("GROUP_HOLLOW_ZOMBIES", 1, 1, 2, 5))

content.add(content.MonsterGroup { id = "GROUP_FOREST_SPIRIT", load_mode = "append", default_monster = "mon_null" }
    :monster("mon_dryad", 200, 1, 1, 1)
    :monster("mon_dryad", 25, 1, 2, 3))

content.add(content.MonsterGroup { id = "GROUP_LIZARDFOLK_HUNTING_BAND_NONHOSTILE", load_mode = "append" }
    :monster("mon_lizardfolk_warrior", 1, 1, 1, 1)
    :monster("mon_lizardfolk_hunter", 3, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LIZARDFOLK_HUNTING_BAND_HOSTILE", load_mode = "append" }
    :monster("mon_lizardfolk_warrior_hostile", 1, 1, 1, 1)
    :monster("mon_lizardfolk_hunter_hostile", 3, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_WILDERNESS_FOREST_ZOMBIE", load_mode = "replace" }
    :monster("mon_null", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_WILDERNESS_FOREST_MAMMAL_MUTANT", load_mode = "replace" }
    :monster("mon_null", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MUTAFROGS_SWAMP", load_mode = "replace" }
    :monster("mon_null", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TRIFFID", load_mode = "append", default_monster = "mon_triffid" }
    :monster("mon_triffid_seedshaper", 25, 5, 1, 1)
    :monster("mon_triffid_vineweaver", 25, 5, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_OUTER",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :monster("mon_triffid_seedshaper", 50, 2, 1, 1)
    :monster("mon_triffid_vineweaver", 50, 2, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_HEARTGUARDS",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :monster("mon_triffid_seedshaper", 150, 2, 1, 1)
    :monster("mon_triffid_vineweaver", 150, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_CAMP_OM", load_mode = "append" }
    :monster("mon_mi_go_mindrender", 50, 20, 1, 1, { starts = duration(210, "hour") })
    :monster("mon_mi_go_lightbringer", 50, 2, 1, 1, { starts = duration(210, "hour") })
    :monster("mon_mi_go_juggernaut", 20, 70, 1, 1, { starts = duration(210, "hour") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_COMMON", load_mode = "append" }
    :monster("mon_mi_go_mindrender", 50, 2, 1, 1, { starts = duration(210, "hour") })
    :monster("mon_mi_go_lightbringer", 50, 2, 1, 1, { starts = duration(210, "hour") })
    :monster("mon_mi_go_juggernaut", 15, 8, 1, 1, { starts = duration(210, "hour") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_CAPTORS", load_mode = "append" }
    :monster("mon_mi_go_mindrender", 300, 2, 1, 1, { starts = duration(210, "hour") })
    :monster("mon_mi_go_lightbringer", 300, 2, 1, 1, { starts = duration(210, "hour") })
    :monster("mon_mi_go_juggernaut", 50, 8, 1, 1, { starts = duration(210, "hour") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_BOSS", load_mode = "append" }
    :monster("mon_mi_go_mindrender", 200, 2, 1, 1)
    :monster("mon_mi_go_mindrender", 50, 5, 2, 3)
    :monster("mon_mi_go_lightbringer", 200, 2, 1, 1)
    :monster("mon_mi_go_lightbringer", 50, 5, 2, 3)
    :monster("mon_mi_go_juggernaut", 200, 5, 1, 1)
    :monster("mon_mi_go_juggernaut", 50, 20, 2, 3))

content.add(content.MonsterGroup { id = "GROUP_HOLLOW_TRIBALS", load_mode = "append" }
    :monster("mon_hollow_tribal_warrior", 10, 1, 1, 1)
    :monster("mon_hollow_tribal_warrior", 2, 2, 1, 2)
    :monster("mon_hollow_tribal", 40, 1, 1, 1)
    :monster("mon_hollow_tribal", 8, 2, 1, 4))

content.add(content.MonsterGroup { id = "GROUP_HOLLOW_TRIBAL_WORKERS", load_mode = "append" }
    :monster("mon_hollow_tribal", 40, 1, 1, 1)
    :monster("mon_hollow_tribal", 5, 2, 1, 4))

content.add(content.MonsterGroup { id = "GROUP_HOLLOW_TRIBAL_WARPARTY", load_mode = "append" }
    :monster("mon_hollow_tribal_warrior", 20, 1, 1, 1)
    :monster("mon_hollow_tribal_warrior", 4, 2, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_HOLLOW_TRIBAL_HUNTPARTY", load_mode = "append" }
    :monster("mon_hollow_hunter", 20, 1, 1, 1)
    :monster("mon_hollow_hunter", 4, 1, 2, 5))

content.add(content.MonsterGroup { id = "GROUP_HOLLOW_TRIBAL_OUTRIDERS", load_mode = "append" }
    :monster("mon_hollow_tribal_warrior", 20, 1, 1, 1)
    :monster("mon_hollow_tribal_warrior", 4, 2, 1, 3)
    :monster("mon_hollow_hunter", 20, 1, 1, 1)
    :monster("mon_hollow_hunter", 4, 1, 2, 5))

content.add(content.MonsterGroup { id = "GROUP_HOLLOW_ZOMBIES", load_mode = "append" }
    :monster("mon_zombie", 800, 1, 1, 1)
    :monster("mon_zombie", 40, 1, 2, 5)
    :monster("mon_zombie_tough", 100, 1, 1, 1)
    :monster("mon_zombie", 10, 1, 2, 5)
    :monster("mon_zombie_rot", 200, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ANT_SURFACE", load_mode = "replace", is_animal = true }
    :monster("mon_ant_soldier", 90, 5, 1, 1)
    :group("GROUP_APHID", 40, 0, 3, 10)
    :group("GROUP_LADY_BUG", 15, 10, 1, 3)
    :monster("mon_antlion_larva", 5, 10, 1, 1)
    :monster("mon_ant_small", 852, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ACID_ANT_SURFACE", load_mode = "replace", is_animal = true }
    :monster("mon_ant_acid_soldier", 90, 5, 1, 1)
    :group("GROUP_APHID", 40, 0, 3, 10)
    :group("GROUP_LADY_BUG", 15, 10, 1, 3)
    :monster("mon_antlion_larva", 5, 10, 1, 1)
    :monster("mon_ant_acid_small", 852, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BEEHIVE", load_mode = "replace" }
    :monster("mon_bee_small", 1, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BEE", load_mode = "append" }
    :monster("mon_bee_small", 1, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIDER", load_mode = "replace" }
    :monster("mon_spider_web_small", 5, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_SPIDER_BASEMENT",
    load_mode = "replace",
    default_monster = "mon_spider_cellar_small",
}
    :monster("mon_spider_cellar_small", 30, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIDER_CELLAR_GIANT", load_mode = "replace" }
    :monster("mon_null", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIDER_TRAPDOOR", load_mode = "replace" }
    :monster("mon_spider_trapdoor_small", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIDER_WIDOW", load_mode = "replace" }
    :monster("mon_spider_widow_small", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIDER_WOLF", load_mode = "replace" }
    :monster("mon_spider_wolf_small", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIDER_JUMPING", load_mode = "replace" }
    :monster("mon_spider_jumping_small", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_WASP_NEST", load_mode = "replace" }
    :monster("mon_wasp_small", 500, 1, 1, 1, {
        ends = duration(30, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp_small", 500, 1, 2, 4, {
        starts = duration(30, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp_small_guard", 500, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_wasp_small_guard", 500, 1, 2, 4, {
        starts = duration(30, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup { id = "GROUP_WASP_FORAGER", load_mode = "replace" }
    :monster("mon_wasp_small", 1000, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_wasp_small", 500, 1, 2, 4, {
        starts = duration(30, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup { id = "GROUP_WASP_GUARD", load_mode = "replace" }
    :monster("mon_wasp_small_guard", 1000, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_wasp_small_guard", 500, 1, 2, 4, {
        starts = duration(30, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup { id = "GROUP_WASP_QUEEN", load_mode = "replace" }
    :monster("mon_wasp_queen", 1000, 50, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_WASP_PUPA",
    load_mode = "replace",
    default_monster = "mon_wasp_small",
}
    :monster("mon_dermatik", 50, 1, 1, 1)
    :monster("mon_wasp_small_guard", 500, 1, 1, 1)
    :monster("mon_wasp_small", 450, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FLY", load_mode = "replace" }
    :monster("mon_fly_small", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MOSQUITO", load_mode = "replace" }
    :monster("mon_mosquito_small", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GRASSHOPPER", load_mode = "replace" }
    :monster("mon_grasshopper_small", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LOCUST", load_mode = "replace" }
    :monster("mon_locust_small", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_WATER_STRIDER", load_mode = "replace" }
    :monster("mon_strider_small", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PRAYING_MANTIS", load_mode = "replace" }
    :monster("mon_mantis_small", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_APHID", load_mode = "replace" }
    :monster("mon_aphid_small", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LADY_BUG", load_mode = "replace" }
    :monster("mon_lady_bug", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CENTIPEDE", load_mode = "replace" }
    :monster("mon_centipede_small", 30, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_STAG_BEETLE", load_mode = "replace" }
    :monster("mon_stag_beetle_small", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BUTTERFLY", load_mode = "replace" }
    :monster("mon_butterfly", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MOTH", load_mode = "replace" }
    :monster("mon_moth", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SNAIL", load_mode = "replace" }
    :monster("mon_snail_forest", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SLUG", load_mode = "replace" }
    :monster("mon_slug_forest", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MOTH_FLY", load_mode = "replace" }
    :monster("mon_moth_fly_small", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SILVERFISH", load_mode = "replace" }
    :monster("mon_silverfish_small", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CENTIPEDE_HOUSE", load_mode = "replace" }
    :monster("mon_centipede_house_small", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CENTIPEDE", load_mode = "replace" }
    :monster("mon_centipede_small", 30, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LIZARDFOLK_RANDENC", load_mode = "append" }
    :group("GROUP_LIZARDFOLK_HUNTING_BAND_NONHOSTILE", 150, 1, 4, 6)
    :group("GROUP_LIZARDFOLK_HUNTING_BAND_HOSTILE", 150, 1, 4, 6))

-- Masters pick from here when upgrading; no dogs, bionics, or profession-types.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_INNAWOOD_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_tough", 110, 1, 1, 1)
    :monster("mon_zombie_grabber", 30, 1, 1, 1)
    :monster("mon_zombie_grappler", 90, 1, 1, 1)
    :monster("mon_zombie_hunter", 60, 1, 1, 1)
    :monster("mon_skeleton", 80, 1, 1, 1)
    :monster("mon_zombie_smoker", 30, 1, 1, 1)
    :monster("mon_zombie_shady", 30, 1, 1, 1)
    :monster("mon_zombie_gasbag", 30, 1, 1, 1)
    :monster("mon_zombie_biter", 30, 1, 1, 1)
    :monster("mon_zombie_shrieker", 90, 1, 1, 1)
    :monster("mon_zombie_acidic", 80, 1, 1, 1)
    :monster("mon_zombie_brute", 45, 1, 1, 1)
    :monster("mon_zombie_hollow", 5, 1, 1, 1)
    :monster("mon_zombie_winged", 60, 1, 1, 1)
    :monster("mon_zombie_regenerating", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_CRAWLER_INNAWOOD_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_crawler", 1, 1, 1, 1)
    :monster("mon_zombie_crawler_pupa", 500, 1, 1, 1)
    :monster("mon_zombie_crawler_pupa_decoy", 350, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_GRAB_INNAWOOD", load_mode = "append" }
    :monster("mon_zombie_grappler", 960, 0, 1, 1)
    :monster("mon_zombie_biter", 40, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SKELETON_UPGRADE_INNAWOOD", load_mode = "append" }
    :monster("mon_skeleton", 720, 1, 1, 1)
    :monster("mon_skeleton_brute", 80, 2, 1, 1)
    :monster("mon_skeleton_brute", 80, 2, 1, 1))
