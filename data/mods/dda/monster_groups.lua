local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

content.add(content.MonsterGroup { id = "GROUP_ANIMALPOUND_CATS", load_mode = "append" }
    :monster("mon_null", 580, 1, 1, 1)
    :monster("mon_cat", 100, 0, 1, 1)
    :monster("mon_cat_tabby", 200, 0, 1, 1)
    :monster("mon_cat_longhair", 100, 0, 1, 1)
    :monster("mon_cat_black", 100, 0, 1, 1)
    :monster("mon_cat_calico", 100, 0, 1, 1)
    :monster("mon_cat_maine_coon", 50, 0, 1, 1)
    :monster("mon_cat_siamese", 50, 0, 1, 1)
    :monster("mon_cat_persian", 50, 0, 1, 1)
    :monster("mon_cat_bengal", 50, 0, 1, 1)
    :monster("mon_cat_devon_rex", 50, 0, 1, 1)
    :monster("mon_cat_sphynx", 10, 0, 1, 1)
    :monster("mon_cat_chonker", 10, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ANIMALPOUND_DOGS", load_mode = "append" }
    :monster("mon_zombie_dog", 250, 0, 1, 1)
    :monster("mon_dog_zombie_rot", 375, 0, 1, 1)
    :monster("mon_dog", 75, 0, 1, 1)
    :monster("mon_dog_bull", 75, 0, 1, 1)
    :monster("mon_dog_pitbullmix", 100, 0, 1, 1)
    :monster("mon_dog_chihuahua", 75, 0, 1, 1)
    :monster("mon_dog_gshepherd", 35, 0, 1, 1)
    :monster("mon_dog_samoyed", 15, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ANIMALSHELTER_DOGS", load_mode = "append" }
    :monster("mon_zombie_dog", 200, 0, 1, 1)
    :monster("mon_dog_zombie_rot", 100, 0, 1, 1)
    :group("GROUP_STRAY_DOGS", 700, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ANIMALSHELTER_OTHER", load_mode = "append" }
    :monster("mon_null", 5, 1, 1, 1)
    :monster("mon_ferret", 2, 0, 1, 1)
    :monster("mon_chicken", 1, 0, 1, 1)
    :monster("mon_rabbit", 3, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ARCADE", load_mode = "append" }
    :monster("mon_null", 400, 1, 1, 1)
    :monster("mon_zombie_child", 600, 1, 2, 5))

content.add(content.MonsterGroup { id = "CAMPERS", load_mode = "append" }
    :monster("mon_null", 500, 1, 1, 1)
    :monster("mon_zombie", 100, 1, 1, 2)
    :monster("mon_zombie_child", 100, 1, 1, 2)
    :monster("mon_zombie_rot", 100, 1, 1, 2)
    :monster("mon_zombie_dog", 200, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_COLLAPSED_TOWER", load_mode = "append" }
    :monster("mon_zombie", 600, 1, 1, 1)
    :monster("mon_zombie_gasbag_immobile", 150, 1, 1, 4)
    :monster("mon_zombie_gasbag_crawler", 150, 3, 1, 2)
    :monster("mon_zombie_scissorlimbs", 50, 9, 1, 2)
    :monster("mon_zombie_gasbag_impaler", 50, 6, 1, 4))

content.add(content.MonsterGroup { id = "GROUP_COLLAPSED_TOWER_BASEMENT", load_mode = "append" }
    :monster("mon_zombie_gasbag_immobile", 650, 1, 1, 1)
    :monster("mon_zombie_hanging_innards", 50, 1, 1, 1)
    :monster("mon_zombie_giant_heart", 50, 1, 1, 1)
    :monster("mon_zombie_gasbag_crawler", 150, 3, 1, 2)
    :monster("mon_zombie_scissorlimbs", 50, 9, 1, 2)
    :monster("mon_zombie_gasbag_impaler", 50, 6, 1, 4))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_SEWER", load_mode = "append" }
    :monster("mon_zombie_technician", 850, 3, 1, 1)
    :monster("mon_zombie_static", 150, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_NUCLEAR_INDUSTRY", load_mode = "append" }
    :monster("mon_zombie_technician", 450, 3, 1, 1)
    :monster("mon_zombie_hazmat", 250, 3, 1, 1)
    :monster("mon_zombie_electric", 100, 5, 1, 1)
    :monster("mon_skitterbot", 100, 5, 1, 1)
    :monster("mon_zombie_cop", 100, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MAPGEN_POOL", load_mode = "append" }
    :monster("mon_null", 1, 1, 1, 1)
    :monster("mon_zombie_swimmer_base", 4, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SEWAGE_TREATMENT", load_mode = "append", is_animal = true }
    :monster("mon_sewer_fish", 300, 0, 2, 6)
    :monster("mon_sewer_snake", 240, 0, 1, 1)
    :monster("mon_sewer_rat", 310, 0, 1, 1)
    :monster("mon_sewer_rat", 100, 0, 3, 6)
    :monster("mon_albino_penguin", 5, 5, 3, 9)
    :group("GROUP_FROGS_SEWER", 250, 1, 1, 1)
    :monster("mon_zombullfrog", 10, 2, 1, 1)
    :monster("mon_frog_mother", 5, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_STANDING_STONES", load_mode = "append" }
    :monster("mon_null", 900, 1, 1, 1)
    :monster("mon_darkman", 100, 1, 1, 1, { conditions = { "NIGHT" } }))

content.add(content.MonsterGroup { id = "GROUP_INSECT_ZOO", load_mode = "append" }
    :group("GROUP_WILDERNESS_SWAMP_INSECT", 2, 1, 1, 1)
    :group("GROUP_WILDERNESS_FOREST_INSECT", 8, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PETTING_ZOO", load_mode = "append" }
    :monster("mon_goat_kid", 2, 1, 1, 1)
    :monster("mon_goat", 7, 1, 1, 1)
    :monster("mon_zombie_goat", 1, 1, 1, 1)
    :monster("mon_chicken_chick", 1, 1, 1, 1)
    :monster("mon_chicken", 9, 1, 1, 1)
    :monster("mon_duck", 9, 1, 1, 1)
    :monster("mon_duck_chick", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LLAMA_ZOO", load_mode = "append" }
    :monster("mon_llama", 7, 1, 1, 1)
    :monster("mon_zllama", 2, 1, 1, 1)
    :monster("mon_llama_calf", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_COYOTES_ZOO", load_mode = "append" }
    :monster("mon_coyote", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TIGERS_ZOO", load_mode = "append" }
    :monster("mon_tiger", 8, 1, 1, 1)
    :monster("mon_ziger", 2, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_COUGARS_ZOO", load_mode = "append" }
    :monster("mon_cougar", 7, 1, 1, 1)
    :monster("mon_cougar_kitten", 1, 1, 1, 1)
    :monster("mon_zougar", 2, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FROGS_ZOO", load_mode = "append" }
    :monster("mon_leo_frog", 10, 1, 1, 1)
    :monster("mon_pattern_frog", 10, 1, 1, 1)
    :monster("mon_bullfrog_frog", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIDERS_ZOO", load_mode = "append" }
    :group("GROUP_SPIDER", 1, 1, 1, 1)
    :group("GROUP_SPIDER_TRAPDOOR", 1, 1, 1, 1)
    :group("GROUP_SPIDER_WIDOW", 1, 1, 1, 1)
    :group("GROUP_SPIDER_WOLF", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SNAKES_ZOO", load_mode = "append" }
    :monster("mon_rattlesnake", 9, 1, 1, 1)
    :monster("mon_rattlesnake_s", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FOXES_ZOO", load_mode = "append" }
    :monster("mon_fox_gray", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_REINDEERS_ZOO", load_mode = "append" }
    :group("GROUP_REINDEERS", 9, 1, 1, 1)
    :monster("mon_zeindeer", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BEARS_ZOO", load_mode = "append" }
    :group("GROUP_BEARS", 9, 1, 1, 1)
    :monster("mon_zombear", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MOOSE_ZOO", load_mode = "append" }
    :group("GROUP_MOOSE", 9, 1, 1, 1)
    :monster("mon_zoose", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PIGS_ZOO", load_mode = "append" }
    :group("GROUP_PIGS", 950, 1, 1, 1)
    :monster("mon_zombie_pig", 50, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ALIEN_MEADOW", load_mode = "append" }
    :monster("mon_nether_unviable_butterfly", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ALIEN_TRAP_TREE", load_mode = "append" }
    :monster("mon_nether_unviable_butterfly", 5, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLES_ALL",
    load_mode = "append",
    default_monster = "mon_peeper_tadpole",
}
    :monster("mon_leo_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_bullfrog_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_fowler_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_freedom_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_peeper_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_gray_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_mink_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_pickerel_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_green_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_wood_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_spade_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_pattern_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_strange_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_foul_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_odd_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_vocal_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_shift_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLES_SEWER",
    load_mode = "append",
    default_monster = "mon_leo_tadpole",
}
    :monster("mon_leo_tadpole", 60, 1, 4, 8, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_bullfrog_tadpole", 60, 1, 4, 8, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_fowler_tadpole", 60, 1, 4, 8, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_freedom_tadpole", 60, 1, 4, 8, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_mink_tadpole", 60, 1, 4, 8, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_pickerel_tadpole", 60, 1, 4, 8, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_green_tadpole", 60, 1, 4, 8, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_pattern_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_strange_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_foul_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_odd_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLES_RIVER",
    load_mode = "append",
    default_monster = "mon_bullfrog_tadpole",
}
    :monster("mon_leo_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_bullfrog_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_mink_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_green_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_pattern_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_strange_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLES_SWAMP",
    load_mode = "append",
    default_monster = "mon_bullfrog_tadpole",
}
    :monster("mon_leo_tadpole", 60, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_bullfrog_tadpole", 60, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_fowler_tadpole", 60, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_freedom_tadpole", 60, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_peeper_tadpole", 60, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_gray_tadpole", 60, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_mink_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_pickerel_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_green_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_wood_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_spade_tadpole", 100, 1, 6, 12, { conditions = { "SPRING", "SUMMER" } })
    :monster("mon_pattern_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_strange_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_foul_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_odd_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_vocal_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") })
    :monster("mon_shift_bigtad", 10, 1, 1, 4, { starts = duration(112, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_ALL",
    load_mode = "append",
    default_monster = "mon_peeper_frog",
}
    :monster("mon_leo_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_pattern_frog", 20, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_bullfrog_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_strange_frog", 20, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_fowler_toad", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_foul_toad", 20, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_freedom_toad", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_odd_toad", 20, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_peeper_frog", 100, 1, 2, 6, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_vocal_frog", 20, 1, 2, 6, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_gray_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_shift_frog", 20, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_mink_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_tail_frog", 20, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_pickerel_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_palette_frog", 20, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_green_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_wood_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_spade_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_leo_worm", 2, 1, 1, 2, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_green_worm", 2, 1, 1, 2, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wood_worm", 2, 1, 1, 2, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_NATURAL",
    load_mode = "append",
    default_monster = "mon_peeper_frog",
}
    :monster("mon_leo_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_bullfrog_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_fowler_toad", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_freedom_toad", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_peeper_frog", 100, 1, 2, 6, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_gray_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_mink_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_pickerel_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_green_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_wood_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_spade_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } }))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_SEWER",
    load_mode = "append",
    default_monster = "mon_bullfrog_frog",
}
    :monster("mon_leo_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_pattern_frog", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_bullfrog_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_strange_frog", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_fowler_toad", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_foul_toad", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_freedom_toad", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_odd_toad", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_mink_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_tail_frog", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_pickerel_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_palette_frog", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_green_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_leo_worm", 40, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_green_worm", 40, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_wood_worm", 40, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } }))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_FOREST",
    load_mode = "append",
    default_monster = "mon_peeper_frog",
}
    :monster("mon_leo_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_pattern_frog", 20, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_bullfrog_frog", 20, 1, 1, 2, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_strange_frog", 20, 1, 1, 2, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_fowler_toad", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_foul_toad", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_freedom_toad", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_odd_toad", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_peeper_frog", 100, 1, 2, 6, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_vocal_frog", 40, 1, 2, 6, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_gray_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_shift_frog", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_pickerel_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_palette_frog", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_green_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_wood_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_spade_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_leo_worm", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_green_worm", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wood_worm", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_SWAMP",
    load_mode = "append",
    default_monster = "mon_bullfrog_frog",
}
    :monster("mon_leo_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_pattern_frog", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_bullfrog_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_strange_frog", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_fowler_toad", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_foul_toad", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_freedom_toad", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_odd_toad", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_peeper_frog", 60, 1, 2, 6, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_vocal_frog", 40, 1, 2, 6, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_gray_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_shift_frog", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_mink_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_tail_frog", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_pickerel_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_palette_frog", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_green_frog", 60, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_wood_frog", 60, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_leo_worm", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_green_worm", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wood_worm", 40, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_RIVER",
    load_mode = "append",
    default_monster = "mon_bullfrog_frog",
}
    :monster("mon_leo_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_pattern_frog", 50, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_bullfrog_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_strange_frog", 50, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_mink_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_tail_frog", 50, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_green_frog", 100, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_leo_worm", 50, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_green_worm", 50, 1, 1, 4, {
        starts = duration(56, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_ALL",
    load_mode = "append",
    default_monster = "mon_strange_bigfrog",
}
    :monster("mon_pattern_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") })
    :monster("mon_pattern_giganfrog", 30, 1, 1, 2, { starts = duration(120, "day") })
    :monster("mon_strange_bigfrog", 100, 1, 1, 4, { starts = duration(64, "day") })
    :monster("mon_strange_giganfrog", 40, 1, 1, 3, { starts = duration(120, "day") })
    :monster("mon_strange_megafrog", 10, 1, 1, 1, { starts = duration(480, "day") })
    :monster("mon_foul_bigfrog", 100, 1, 1, 4, { starts = duration(60, "day") })
    :monster("mon_foul_giganfrog", 40, 1, 1, 4, { starts = duration(120, "day") })
    :monster("mon_foul_megafrog", 20, 1, 1, 2, { starts = duration(240, "day") })
    :monster("mon_odd_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") })
    :monster("mon_odd_giganfrog", 40, 1, 1, 2, { starts = duration(120, "day") })
    :monster("mon_odd_megafrog", 10, 1, 1, 1, { starts = duration(240, "day") })
    :monster("mon_jumbo_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") })
    :monster("mon_vocal_bigfrog", 100, 1, 1, 5, { starts = duration(60, "day") })
    :monster("mon_shift_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_BIG",
    load_mode = "append",
    default_monster = "mon_strange_bigfrog",
}
    :monster("mon_pattern_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") })
    :monster("mon_strange_bigfrog", 100, 1, 1, 4, { starts = duration(60, "day") })
    :monster("mon_foul_bigfrog", 100, 1, 1, 4, { starts = duration(60, "day") })
    :monster("mon_odd_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") })
    :monster("mon_jumbo_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") })
    :monster("mon_vocal_bigfrog", 100, 1, 1, 5, { starts = duration(60, "day") })
    :monster("mon_shift_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_GIANT",
    load_mode = "append",
    default_monster = "mon_strange_giganfrog",
}
    :monster("mon_pattern_giganfrog", 30, 1, 1, 2, { starts = duration(120, "day") })
    :monster("mon_strange_giganfrog", 40, 1, 1, 3, { starts = duration(120, "day") })
    :monster("mon_foul_giganfrog", 40, 1, 1, 4, { starts = duration(120, "day") })
    :monster("mon_odd_giganfrog", 40, 1, 1, 2, { starts = duration(120, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_MEGA",
    load_mode = "append",
    default_monster = "mon_strange_megafrog",
}
    :monster("mon_strange_megafrog", 10, 1, 1, 1, { starts = duration(240, "day") })
    :monster("mon_foul_megafrog", 20, 1, 1, 2, { starts = duration(240, "day") })
    :monster("mon_odd_megafrog", 10, 1, 1, 1, { starts = duration(240, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_PATTERN",
    load_mode = "append",
    default_monster = "mon_pattern_bigfrog",
}
    :monster("mon_pattern_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") })
    :monster("mon_pattern_giganfrog", 30, 1, 1, 2, { starts = duration(120, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_STRANGE",
    load_mode = "append",
    default_monster = "mon_strange_bigfrog",
}
    :monster("mon_strange_bigfrog", 100, 1, 1, 4, { starts = duration(60, "day") })
    :monster("mon_strange_giganfrog", 40, 1, 1, 3, { starts = duration(120, "day") })
    :monster("mon_strange_megafrog", 10, 1, 1, 1, { starts = duration(240, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_FOUL",
    load_mode = "append",
    default_monster = "mon_foul_bigfrog",
}
    :monster("mon_foul_bigfrog", 100, 1, 1, 4, { starts = duration(60, "day") })
    :monster("mon_foul_giganfrog", 40, 1, 1, 4, { starts = duration(120, "day") })
    :monster("mon_foul_megafrog", 20, 1, 1, 2, { starts = duration(240, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_ODD",
    load_mode = "append",
    default_monster = "mon_odd_bigfrog",
}
    :monster("mon_odd_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") })
    :monster("mon_odd_giganfrog", 40, 1, 1, 2, { starts = duration(120, "day") })
    :monster("mon_odd_megafrog", 10, 1, 1, 1, { starts = duration(240, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_VOCAL",
    load_mode = "append",
    default_monster = "mon_jumbo_bigfrog",
}
    :monster("mon_jumbo_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") })
    :monster("mon_vocal_bigfrog", 100, 1, 1, 3, { starts = duration(60, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_SEWER",
    load_mode = "append",
    default_monster = "mon_strange_bigfrog",
}
    :group("GROUP_MUTAFROGS_PATTERN", 100, 1, 1, 1)
    :group("GROUP_MUTAFROGS_STRANGE", 100, 1, 1, 1)
    :group("GROUP_MUTAFROGS_FOUL", 40, 1, 1, 1)
    :group("GROUP_MUTAFROGS_ODD", 40, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_FOREST",
    load_mode = "append",
    default_monster = "mon_odd_bigfrog",
}
    :group("GROUP_MUTAFROGS_PATTERN", 40, 1, 1, 1)
    :group("GROUP_MUTAFROGS_STRANGE", 20, 1, 1, 1)
    :group("GROUP_MUTAFROGS_FOUL", 100, 1, 1, 1)
    :group("GROUP_MUTAFROGS_ODD", 100, 1, 1, 1)
    :group("GROUP_MUTAFROGS_VOCAL", 100, 1, 1, 1)
    :monster("mon_shift_bigfrog", 30, 1, 1, 3, { starts = duration(60, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_SWAMP",
    load_mode = "append",
    default_monster = "mon_strange_bigfrog",
}
    :group("GROUP_MUTAFROGS_PATTERN", 100, 1, 1, 1)
    :group("GROUP_MUTAFROGS_STRANGE", 100, 1, 1, 1)
    :group("GROUP_MUTAFROGS_FOUL", 100, 1, 1, 1)
    :group("GROUP_MUTAFROGS_ODD", 100, 1, 1, 1)
    :group("GROUP_MUTAFROGS_VOCAL", 100, 1, 1, 1)
    :monster("mon_shift_bigfrog", 30, 1, 1, 3, { starts = duration(60, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTAFROGS_RIVER",
    load_mode = "append",
    default_monster = "mon_strange_bigfrog",
}
    :group("GROUP_MUTAFROGS_PATTERN", 60, 1, 1, 1)
    :group("GROUP_MUTAFROGS_STRANGE", 100, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLE_LEO",
    load_mode = "append",
    default_monster = "mon_leo_frog",
}
    :monster("mon_leo_frog", 90, 1, 1, 1)
    :monster("mon_pattern_frog", 9, 1, 1, 1)
    :monster("mon_leo_worm", 1, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLE_BULLFROG",
    load_mode = "append",
    default_monster = "mon_bullfrog_frog",
}
    :monster("mon_bullfrog_frog", 90, 1, 1, 1)
    :monster("mon_strange_frog", 10, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLE_FOWLER",
    load_mode = "append",
    default_monster = "mon_fowler_toad",
}
    :monster("mon_fowler_toad", 90, 1, 1, 1)
    :monster("mon_foul_toad", 10, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLE_FREEDOM",
    load_mode = "append",
    default_monster = "mon_freedom_toad",
}
    :monster("mon_freedom_toad", 90, 1, 1, 1)
    :monster("mon_odd_toad", 10, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLE_PEEPER",
    load_mode = "append",
    default_monster = "mon_peeper_frog",
}
    :monster("mon_peeper_frog", 90, 1, 1, 1)
    :monster("mon_vocal_frog", 10, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLE_GRAY",
    load_mode = "append",
    default_monster = "mon_gray_frog",
}
    :monster("mon_gray_frog", 90, 1, 1, 1)
    :monster("mon_shift_frog", 10, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLE_PICKEREL",
    load_mode = "append",
    default_monster = "mon_pickerel_frog",
}
    :monster("mon_pickerel_frog", 90, 1, 1, 1)
    :monster("mon_palette_frog", 10, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLE_GREEN",
    load_mode = "append",
    default_monster = "mon_green_frog",
}
    :monster("mon_green_frog", 99, 1, 1, 1)
    :monster("mon_green_worm", 1, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TADPOLE_WOOD",
    load_mode = "append",
    default_monster = "mon_wood_frog",
}
    :monster("mon_wood_frog", 99, 1, 1, 1)
    :monster("mon_wood_worm", 1, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_BIGTAD_VOCAL",
    load_mode = "append",
    default_monster = "mon_jumbo_bigfrog",
}
    :monster("mon_jumbo_bigfrog", 50, 1, 1, 1)
    :monster("mon_vocal_bigfrog", 50, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_UPGRADE_PATTERN",
    load_mode = "append",
    default_monster = "mon_pattern_bigfrog",
}
    :monster("mon_pattern_bigfrog", 100, 1, 1, 1)
    :monster("mon_pattern_giganfrog", 30, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_UPGRADE_STRANGE",
    load_mode = "append",
    default_monster = "mon_strange_bigfrog",
}
    :monster("mon_strange_bigfrog", 100, 1, 1, 1)
    :monster("mon_strange_giganfrog", 40, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_UPGRADE_STRANGE_MEGA",
    load_mode = "append",
    default_monster = "mon_strange_giganfrog",
}
    :monster("mon_strange_giganfrog", 100, 1, 1, 1)
    :monster("mon_strange_megafrog", 10, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_UPGRADE_FOUL",
    load_mode = "append",
    default_monster = "mon_foul_bigfrog",
}
    :monster("mon_foul_bigfrog", 100, 1, 1, 1)
    :monster("mon_foul_giganfrog", 40, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_UPGRADE_FOUL_MEGA",
    load_mode = "append",
    default_monster = "mon_foul_giganfrog",
}
    :monster("mon_foul_giganfrog", 100, 1, 1, 1)
    :monster("mon_foul_megafrog", 30, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_UPGRADE_ODD",
    load_mode = "append",
    default_monster = "mon_odd_bigfrog",
}
    :monster("mon_odd_bigfrog", 100, 1, 1, 1)
    :monster("mon_odd_giganfrog", 40, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_UPGRADE_ODD_MEGA",
    load_mode = "append",
    default_monster = "mon_odd_giganfrog",
}
    :monster("mon_odd_giganfrog", 100, 1, 1, 1)
    :monster("mon_odd_megafrog", 10, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_UPGRADE_VOCAL",
    load_mode = "append",
    default_monster = "mon_vocal_frog",
}
    :monster("mon_vocal_frog", 100, 1, 1, 1)
    :monster("mon_vocal_bigfrog", 50, 1, 1, 1)
    :monster("mon_jumbo_bigfrog", 50, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_FROGS_UPGRADE_SHIFT",
    load_mode = "append",
    default_monster = "mon_shift_frog",
}
    :monster("mon_shift_frog", 70, 1, 1, 1)
    :monster("mon_shift_bigfrog", 30, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GOO", load_mode = "append" }
    :monster("mon_blob_small", 200, 0, 1, 1)
    :monster("mon_blob_small", 100, 0, 2, 12)
    :monster("mon_blob", 693, 3, 5, 10)
    :monster("mon_blob_large", 5, 6, 5, 10)
    :monster("mon_blob_brain", 1, 10, 1, 1)
    :monster("mon_shoggoth", 1, 10, 1, 1))

-- GROUP_GOO has a shoggoth, which isn't even the same faction as blobs. Also removes brain blob.
content.add(content.MonsterGroup { id = "GROUP_SLIME", load_mode = "append" }
    :monster("mon_blob_small", 200, 0, 1, 1)
    :monster("mon_blob_small", 100, 0, 2, 12)
    :monster("mon_blob", 695, 3, 5, 10)
    :monster("mon_blob_large", 5, 6, 5, 10))

content.add(content.MonsterGroup { id = "GROUP_ANT", load_mode = "append", is_animal = true }
    :monster("mon_ant_larva", 40, 0, 1, 1)
    :monster("mon_ant_soldier", 90, 5, 1, 1)
    :monster("mon_ant_small", 870, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ANT_SURFACE", load_mode = "append", is_animal = true }
    :monster("mon_ant_soldier", 90, 5, 1, 1)
    :group("GROUP_APHID", 40, 0, 3, 10)
    :group("GROUP_LADY_BUG", 15, 10, 1, 3)
    :monster("mon_antlion_larva", 5, 10, 1, 1)
    :monster("mon_antlion_giant", 3, 10, 1, 1)
    :monster("mon_ant_small", 852, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ACID_ANT", load_mode = "append", is_animal = true }
    :monster("mon_ant_acid_larva", 35, 0, 1, 1)
    :monster("mon_ant_acid_soldier", 100, 5, 1, 1)
    :monster("mon_ant_acid_small", 865, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ACID_ANT_SURFACE", load_mode = "append", is_animal = true }
    :monster("mon_ant_acid_soldier", 90, 5, 1, 1)
    :group("GROUP_APHID", 40, 0, 3, 10)
    :group("GROUP_LADY_BUG", 15, 10, 1, 3)
    :monster("mon_antlion_larva", 5, 10, 1, 1)
    :monster("mon_antlion_giant", 3, 10, 1, 1)
    :monster("mon_ant_acid_small", 852, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BEEHIVE", load_mode = "append" }
    :monster("mon_bee_small", 1, 0, 1, 1)
    :monster("mon_bee", 1, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BEE", load_mode = "append" }
    :monster("mon_bee_small", 1, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DERMATIK", load_mode = "append" }
    :monster("mon_dermatik", 1, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_DERMATIK_INCUB",
    load_mode = "append",
    default_monster = "mon_dermatik_incubator_deer",
}
    :monster("mon_dermatik_incubator_spider", 500, 1, 1, 1)
    :monster("mon_dermatik_incubator_dog", 100, 1, 1, 1)
    :monster("mon_dermatik_incubator_deer", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ROACH", load_mode = "append", is_animal = true }
    :monster("mon_large_cockroach", 975, 0, 1, 1, { starts = duration(45, "day") })
    :monster("mon_pregnant_giant_cockroach", 5, 2, 1, 1, { starts = duration(45, "day") })
    :monster("mon_giant_cockroach_nymph", 20, 0, 1, 1, { starts = duration(45, "day") }))

content.add(content.MonsterGroup { id = "GROUP_PLAGUE_ROACH", load_mode = "append", is_animal = true }
    :monster("mon_skittering_plague", 975, 0, 1, 1, { starts = duration(45, "day") })
    :monster("mon_plague_vector", 5, 2, 1, 1, { starts = duration(45, "day") })
    :monster("mon_plague_nymph", 20, 0, 1, 1, { starts = duration(45, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SPIDER", load_mode = "append" }
    :monster("mon_spider_web_small", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_spider_web", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_spider_web_mega", 2, 1, 1, 1, { starts = duration(288, "day") }))

-- `monster` ignores group-level pack size, so numbers are set in mapgen
content.add(content.MonsterGroup {
    id = "GROUP_SPIDER_BASEMENT",
    load_mode = "append",
    default_monster = "mon_spider_cellar_small",
}
    :monster("mon_spider_cellar_small", 30, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_spider_cellar_giant", 22, 1, 1, 1, {
        starts = duration(120, "day"),
        ends = duration(288, "day"),
    })
    :monster("mon_spider_cellar_mom", 8, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_spider_cellar_giant", 20, 1, 1, 1, { starts = duration(288, "day") })
    :monster("mon_spider_cellar_mega", 10, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SPIDER_CELLAR_GIANT", load_mode = "append" }
    :monster("mon_spider_cellar_giant", 5, 1, 1, 1)
    :monster("mon_spider_cellar_mom", 2, 1, 1, 1)
    :monster("mon_spider_cellar_mega", 3, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIDER_TRAPDOOR", load_mode = "append" }
    :monster("mon_spider_trapdoor_small", 5, 1, 1, 1, {
        starts = duration(45, "day"),
        ends = duration(180, "day"),
    })
    :monster("mon_spider_trapdoor_giant", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_spider_trapdoor_mega", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SPIDER_WIDOW", load_mode = "append" }
    :monster("mon_spider_widow_small", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_spider_widow_giant", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_spider_widow_mega", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SPIDER_WOLF", load_mode = "append" }
    :monster("mon_spider_wolf_small", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_spider_wolf_giant", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_spider_wolf_mega", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SPIDER_JUMPING", load_mode = "append" }
    :monster("mon_spider_jumping_small", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_spider_jumping_giant", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_spider_jumping_mega", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_WASP_NEST", load_mode = "append" }
    :monster("mon_wasp_small", 500, 1, 1, 1, {
        ends = duration(30, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp_small", 500, 1, 2, 4, {
        starts = duration(30, "day"),
        ends = duration(90, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp_small_guard", 500, 1, 1, 1, {
        ends = duration(30, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp_small_guard", 500, 1, 2, 4, {
        starts = duration(30, "day"),
        ends = duration(90, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp", 500, 1, 1, 1, {
        starts = duration(30, "day"),
        ends = duration(90, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp", 500, 1, 2, 4, {
        starts = duration(90, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp_guard", 500, 1, 1, 1, {
        starts = duration(30, "day"),
        ends = duration(90, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp_guard", 500, 1, 2, 4, {
        starts = duration(90, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup { id = "GROUP_WASP_FORAGER", load_mode = "append" }
    :monster("mon_wasp_small", 1000, 1, 1, 1, {
        ends = duration(30, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp_small", 500, 1, 2, 4, {
        starts = duration(30, "day"),
        ends = duration(90, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp", 1000, 1, 1, 1, {
        starts = duration(60, "day"),
        ends = duration(120, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp", 1000, 1, 2, 4, {
        starts = duration(120, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup { id = "GROUP_WASP_GUARD", load_mode = "append" }
    :monster("mon_wasp_small_guard", 1000, 1, 1, 1, {
        ends = duration(30, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp_small_guard", 500, 1, 2, 4, {
        starts = duration(30, "day"),
        ends = duration(90, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp_guard", 500, 1, 1, 1, {
        starts = duration(30, "day"),
        ends = duration(90, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_wasp_guard", 500, 1, 2, 4, {
        starts = duration(90, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup { id = "GROUP_WASP_QUEEN", load_mode = "append" }
    :monster("mon_wasp_queen", 1000, 50, 1, 1, { ends = duration(120, "day") })
    :monster("mon_wasp_mega", 1000, 50, 1, 1, { starts = duration(60, "day") }))

content.add(content.MonsterGroup { id = "GROUP_WASP_PUPA", load_mode = "append", default_monster = "mon_wasp" }
    :monster("mon_dermatik", 50, 1, 1, 1)
    :monster("mon_wasp_guard", 500, 1, 1, 1)
    :monster("mon_wasp", 450, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_WORM", load_mode = "append" }
    :monster("mon_worm_small", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_worm", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_graboid", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_FLY", load_mode = "append" }
    :monster("mon_fly_small", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_fly", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_fly_mega", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MOSQUITO", load_mode = "append" }
    :monster("mon_mosquito_small", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_mosquito_giant", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_mosquito_mega", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_GRASSHOPPER", load_mode = "append" }
    :monster("mon_grasshopper_small", 1, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_grasshopper_giant", 1, 1, 1, 1, { starts = duration(120, "day") }))

content.add(content.MonsterGroup { id = "GROUP_LOCUST", load_mode = "append" }
    :monster("mon_locust_small", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_locust", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_locust_mega", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_WATER_STRIDER", load_mode = "append" }
    :monster("mon_strider_small", 1, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_strider_giant", 1, 1, 1, 1, { starts = duration(120, "day") }))

content.add(content.MonsterGroup { id = "GROUP_PRAYING_MANTIS", load_mode = "append" }
    :monster("mon_mantis_small", 5, 1, 1, 1, { ends = duration(252, "day") })
    :monster("mon_mantis_giant", 5, 1, 1, 1, { starts = duration(168, "day") })
    :monster("mon_mantis_mega", 5, 1, 1, 1, { starts = duration(336, "day") }))

content.add(content.MonsterGroup { id = "GROUP_APHID", load_mode = "append" }
    :monster("mon_aphid_small", 1, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_aphid", 1, 1, 1, 1, { starts = duration(120, "day") }))

content.add(content.MonsterGroup { id = "GROUP_LADY_BUG", load_mode = "append" }
    :monster("mon_lady_bug", 1, 1, 1, 1, { starts = duration(45, "day"), ends = duration(252, "day") })
    :monster("mon_lady_bug_giant", 1, 1, 1, 1, { starts = duration(168, "day") }))

content.add(content.MonsterGroup { id = "GROUP_CENTIPEDE", load_mode = "append" }
    :monster("mon_centipede_small", 30, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_centipede_giant", 22, 1, 1, 1, { starts = duration(120, "day"), ends = duration(288, "day") })
    :monster("mon_centipede_mom", 8, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_centipede_giant", 20, 1, 1, 1, { starts = duration(288, "day") })
    :monster("mon_centipede_mega", 10, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_STAG_BEETLE", load_mode = "append" }
    :monster("mon_stag_beetle_small", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(360, "day") })
    :monster("mon_stag_beetle_giant", 5, 1, 1, 1, { starts = duration(240, "day") })
    :monster("mon_stag_beetle_mega", 2, 1, 1, 1, { starts = duration(480, "day") }))

content.add(content.MonsterGroup { id = "GROUP_BUTTERFLY", load_mode = "append" }
    :monster("mon_butterfly", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_butterfly_giant", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_butterfly_titan", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MOTH", load_mode = "append" }
    :monster("mon_moth", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_moth_giant", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_moth_titan", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SNAIL", load_mode = "append" }
    :monster("mon_snail_forest", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_snail_small", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_snail_giant", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SLUG", load_mode = "append" }
    :monster("mon_slug_forest", 5, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_slug_small", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_slug_giant", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MOTH_FLY", load_mode = "append" }
    :monster("mon_moth_fly_small", 1, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_moth_fly", 1, 1, 1, 1, { starts = duration(120, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SILVERFISH", load_mode = "append" }
    :monster("mon_silverfish_small", 1, 1, 1, 1, { starts = duration(45, "day"), ends = duration(180, "day") })
    :monster("mon_silverfish", 1, 1, 1, 1, { starts = duration(120, "day") }))

content.add(content.MonsterGroup { id = "GROUP_CENTIPEDE_HOUSE", load_mode = "append" }
    :monster("mon_centipede_house_small", 1, 1, 1, 1, {
        starts = duration(45, "day"),
        ends = duration(180, "day"),
    })
    :monster("mon_centipede_house", 1, 1, 1, 1, { starts = duration(120, "day") }))

-- Invertebrate friends that like dark and moist places.  Put them in basements, subways, sewers, etc.
content.add(content.MonsterGroup { id = "GROUP_BUGS_SUBTERRANEAN", load_mode = "append" }
    :group("GROUP_FLY", 25, 1, 1, 1)
    :group("GROUP_ROACH", 20, 1, 1, 1)
    :group("GROUP_MOTH_FLY", 20, 1, 1, 1)
    :group("GROUP_SILVERFISH", 20, 1, 1, 1)
    :group("GROUP_SPIDER_BASEMENT", 15, 1, 1, 1)
    :group("GROUP_CENTIPEDE_HOUSE", 15, 1, 1, 1)
    :group("GROUP_MOTH", 10, 1, 1, 1)
    :group("GROUP_SLUG", 10, 1, 1, 1)
    :group("GROUP_CENTIPEDE", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CENTIPEDE_MOM_SUMMON", load_mode = "append" }
    :monster("mon_centipede_small", 67, 1, 1, 1)
    :monster("mon_centipede_larva", 33, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIDER_MOM_SUMMON", load_mode = "append" }
    :monster("mon_spider_cellar_small", 67, 1, 1, 1)
    :monster("mon_spider_cellar_giant_s", 33, 1, 1, 1))

-- An enemy that caught an interdimensional ride along with an Exodii.
content.add(content.MonsterGroup { id = "GROUP_Exodii_Stowaway", load_mode = "append" }
    :monster("mon_zomborg", 850, 1, 1, 1)
    :monster("mon_zomborg", 100, 10, 1, 2)
    :monster("mon_zomborg", 50, 20, 4, 6))

-- A small Exodii scouting unit or party.
content.add(content.MonsterGroup { id = "GROUP_Exodii_Scout_Small", load_mode = "append" }
    :monster("mon_exodii_quad", 800, 1, 1, 1)
    :monster("mon_exodii_quad", 100, 20, 1, 2)
    :monster("mon_exodii_worker", 100, 10, 1, 3))

content.add(content.MonsterGroup {
    id = "GROUP_FISH",
    load_mode = "append",
    default_monster = "mon_fish_whitefish",
    is_animal = true,
}
    :monster("mon_fish_eel", 25, 3, 1, 3)
    :monster("mon_fish_eel", 50, 3, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_bowfin", 25, 3, 1, 3)
    :monster("mon_fish_bowfin", 50, 3, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_bullhead", 25, 3, 1, 3)
    :monster("mon_fish_bullhead", 50, 3, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_carp", 10, 10, 1, 3)
    :monster("mon_fish_carp", 15, 10, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_pike", 15, 8, 1, 3)
    :monster("mon_fish_pike", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_sbass", 25, 3, 1, 3)
    :monster("mon_fish_sbass", 50, 3, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_perch", 30, 3, 1, 3)
    :monster("mon_fish_perch", 55, 3, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_salmon", 15, 8, 4, 6)
    :monster("mon_fish_salmon", 20, 8, 4, 6, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_brown_trout", 15, 8, 1, 3)
    :monster("mon_fish_brown_trout", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_brook_trout", 15, 8, 1, 3)
    :monster("mon_fish_brook_trout", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_lake_trout", 15, 8, 1, 3)
    :monster("mon_fish_lake_trout", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_rainbow_trout", 15, 8, 1, 3)
    :monster("mon_fish_rainbow_trout", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_kokanee_salmon", 15, 8, 1, 3)
    :monster("mon_fish_kokanee_salmon", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_walleye", 15, 8, 1, 3)
    :monster("mon_fish_walleye", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_pumpkinseed", 15, 8, 1, 3)
    :monster("mon_fish_pumpkinseed", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_redbreast", 15, 8, 1, 3)
    :monster("mon_fish_redbreast", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_green_sunfish", 15, 8, 1, 3)
    :monster("mon_fish_green_sunfish", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_rock_bass", 15, 8, 1, 3)
    :monster("mon_fish_rock_bass", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_calico_bass", 15, 8, 1, 3)
    :monster("mon_fish_calico_bass", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_warmouth", 15, 8, 1, 3)
    :monster("mon_fish_warmouth", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_channel_catfish", 15, 8, 1, 3)
    :monster("mon_fish_channel_catfish", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_white_catfish", 15, 8, 1, 3)
    :monster("mon_fish_white_catfish", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_muskellunge", 15, 8, 1, 3)
    :monster("mon_fish_muskellunge", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_white_sucker", 15, 8, 1, 3)
    :monster("mon_fish_white_sucker", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_grass_carp", 15, 8, 1, 3)
    :monster("mon_fish_grass_carp", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_fallfish", 15, 8, 1, 3)
    :monster("mon_fish_fallfish", 20, 8, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_lbass", 25, 3, 1, 3)
    :monster("mon_fish_lbass", 50, 3, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_pbass", 25, 3, 1, 3)
    :monster("mon_fish_pbass", 50, 3, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_bluegill", 25, 3, 1, 3)
    :monster("mon_fish_bluegill", 50, 3, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_whitefish", 30, 2, 4, 6)
    :monster("mon_fish_whitefish", 55, 2, 4, 6, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_pickerel", 15, 10, 1, 3)
    :monster("mon_fish_pickerel", 20, 10, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_dragonfly_naiad", 10, 3, 1, 2, {
        ends = duration(12, "day"),
        conditions = { "SPRING", "SUMMER" },
    })
    :monster("mon_dragonfly_naiad", 30, 3, 1, 3, { conditions = { "SPRING", "SUMMER" } })
    :group("GROUP_WATER_STRIDER", 35, 3, 3, 6))

content.add(content.MonsterGroup { id = "GROUP_STOCKED_POND", load_mode = "append", is_animal = true }
    :monster("mon_fish_rainbow_trout", 50, 3, 1, 3)
    :monster("mon_fish_rainbow_trout", 100, 3, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_sbass", 25, 3, 1, 3)
    :monster("mon_fish_sbass", 50, 3, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_perch", 30, 3, 1, 3)
    :monster("mon_fish_perch", 55, 3, 1, 3, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_fish_salmon", 15, 8, 4, 6)
    :monster("mon_fish_salmon", 20, 8, 4, 6, { conditions = { "DAWN", "DUSK" } }))

content.add(content.MonsterGroup { id = "GROUP_RAZORCLAW", load_mode = "append", is_animal = true }
    :monster("mon_razorclaw", 667, 0, 1, 1)
    :monster("mon_razorclaw", 333, 0, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_CRAYFISH", load_mode = "append" }
    :monster("mon_crayfish_small", 5, 1, 1, 1, { ends = duration(180, "day") })
    :monster("mon_giant_crayfish", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_crayfish_mega", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup { id = "GROUP_FUNGI", load_mode = "append", default_monster = "mon_spore" }
    :monster("mon_spore", 200, 0, 1, 1)
    :monster("mon_fungaloid", 400, 0, 1, 1)
    :monster("mon_fungaloid_shambler", 200, 0, 1, 1)
    :monster("mon_fungaloid_young", 200, 0, 1, 1)
    :monster("mon_whisper_fungus", 10, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FUNGI_FUNGALOID", load_mode = "append" }
    :monster("mon_fungaloid", 500, 0, 1, 1)
    :monster("mon_fungaloid_shambler", 250, 0, 1, 1)
    :monster("mon_fungaloid_young", 250, 0, 2, 3)
    :monster("mon_whisper_fungus", 10, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FUNGI_TOWER", load_mode = "append" }
    :monster("mon_fungal_tendril", 755, 0, 1, 1)
    :monster("mon_fungaloid", 10, 0, 1, 1)
    :monster("mon_fungaloid_shambler", 30, 0, 1, 1)
    :monster("mon_fungaloid_young", 30, 0, 1, 1)
    :monster("mon_zombie_fungus", 75, 0, 1, 1)
    :monster("mon_boomer_fungus", 50, 0, 1, 1)
    :monster("mon_zombie_child_fungus", 50, 0, 1, 1)
    :monster("mon_whisper_fungus", 10, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FUNGI_FLOWERS", load_mode = "append" }
    :monster("mon_fungal_blossom", 680, 0, 1, 1)
    :monster("mon_fungaloid", 20, 0, 1, 1)
    :monster("mon_fungaloid_shambler", 50, 0, 1, 1)
    :monster("mon_fungaloid_young", 50, 0, 1, 1)
    :monster("mon_zombie_fungus", 100, 0, 1, 1)
    :monster("mon_boomer_fungus", 50, 0, 1, 1)
    :monster("mon_zombie_child_fungus", 50, 0, 1, 1)
    :monster("mon_whisper_fungus", 10, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FUNGI_ZOMBIE", load_mode = "append" }
    :monster("mon_fungal_blossom", 200, 0, 1, 1)
    :monster("mon_fungaloid", 100, 0, 1, 1)
    :monster("mon_fungaloid_shambler", 50, 0, 1, 1)
    :monster("mon_whisper_fungus", 50, 0, 1, 1)
    :monster("mon_zombie_fungus", 100, 0, 1, 1)
    :monster("mon_boomer_fungus", 100, 0, 1, 1)
    :monster("mon_zombie_child_fungus", 50, 0, 1, 1)
    :monster("mon_zombie_gasbag_fungus", 100, 0, 1, 1)
    :monster("mon_zombie_smoker_fungus", 50, 0, 1, 1)
    :monster("mon_skeleton_fungus", 50, 0, 1, 1)
    :monster("mon_zombie_runner_fungal", 50, 0, 1, 1)
    :monster("mon_zombie_rot_fungal", 50, 0, 1, 1)
    :monster("mon_zombie_tough_fungal", 50, 0, 1, 1)
    :monster("mon_zombie_crawler_fungal", 50, 0, 1, 1)
    :monster("mon_zombie_fat_fungus", 50, 0, 1, 1)
    :monster("mon_beekeeper_fungal", 50, 0, 1, 1)
    :monster("mon_zombie_fungus_acidic", 50, 0, 1, 1)
    :monster("mon_zombie_dog_fungus", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FUNGI_QUEEN", load_mode = "append" }
    :monster("mon_fungaloid_queen", 1000, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_KRAKEN", load_mode = "append", is_animal = true }
    :monster("mon_octupus_stalker_spawn", 40, 0, 1, 1)
    :monster("mon_kraken_guard", 90, 5, 1, 1)
    :monster("mon_octupus_stalker", 870, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_KRAKEN_SURFACE", load_mode = "append", is_animal = true }
    :monster("mon_kraken_guard", 90, 5, 1, 1)
    :monster("mon_octupus_stalker_spawn", 5, 10, 1, 1)
    :monster("mon_octupus_stalker", 852, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_LAB",
    load_mode = "append",
    default_monster = "mon_zombie_scientist",
}
    :monster("mon_blob_small", 25, 0, 1, 4)
    :monster("mon_feral_labsecurity_9mm", 18, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 18, 2, 1, 1)
    :monster("mon_feral_scientist_scalpel", 20, 0, 1, 1)
    :monster("mon_zombie", 200, 0, 1, 3)
    :monster("mon_zombie_fat", 100, 0, 1, 3)
    :monster("mon_zombie_tough", 100, 2, 1, 3)
    :monster("mon_zombie_crawler", 100, 0, 1, 1)
    :monster("mon_zombie_labsecurity", 400, 2, 1, 3)
    :monster("mon_zombie_scientist", 500, 1, 1, 1)
    :monster("mon_zombie_scientist", 200, 1, 1, 5)
    :monster("mon_zombie_technician", 100, 2, 1, 1)
    :monster("mon_feral_human_tool", 25, 1, 1, 1)
    :monster("mon_zombie_thorny", 50, 5, 1, 1)
    :monster("mon_zombie_hazmat", 100, 0, 1, 1)
    :monster("mon_science_bot", 50, 15, 1, 1)
    :monster("mon_mutant_experimental", 50, 3, 1, 1)
    :monster("mon_skitterbot", 85, 0, 1, 1)
    :monster("mon_skitterbot", 85, 0, 2, 3)
    :monster("mon_skitterbot", 1, 0, 8, 12)
    :monster("mon_secubot", 1, 10, 1, 1)
    :monster("mon_zombie_armored", 5, 5, 1, 1)
    :monster("mon_zombie_electric", 50, 3, 1, 1)
    :monster("mon_zombie_necro", 15, 15, 1, 1)
    :monster("mon_zombie_brute_shocker", 10, 5, 1, 1)
    :monster("mon_mole_cricket", 20, 3, 1, 1)
    :monster("mon_lab_rat", 30, 20, 4, 8))

content.add(content.MonsterGroup {
    id = "GROUP_LAB_SURFACE",
    load_mode = "append",
    default_monster = "mon_zombie_scientist",
}
    :monster("mon_feral_labsecurity_9mm", 18, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 18, 2, 1, 1)
    :monster("mon_feral_scientist_scalpel", 20, 0, 1, 1)
    :monster("mon_zombie_labsecurity", 400, 2, 1, 3)
    :monster("mon_zombie_scientist", 600, 1, 1, 1)
    :monster("mon_zombie_scientist", 400, 1, 1, 5)
    :monster("mon_zombie_technician", 100, 2, 1, 1)
    :monster("mon_feral_human_tool", 25, 1, 1, 1)
    :monster("mon_zombie_hazmat", 200, 1, 1, 1)
    :monster("mon_zombie_necro", 15, 5, 1, 1)
    :monster("mon_zombie_electric", 50, 2, 1, 1)
    :monster("mon_science_bot", 80, 5, 1, 1)
    :monster("mon_secubot", 1, 5, 1, 1)
    :monster("mon_zombie", 100, 1, 1, 3)
    :monster("mon_zombie_fat", 20, 1, 1, 3)
    :monster("mon_zombie_tough", 40, 2, 1, 3)
    :monster("mon_zombie_brute", 10, 5, 1, 1)
    :monster("mon_zombie_crawler", 50, 1, 1, 1)
    :monster("mon_mutant_experimental", 3, 1, 1, 1)
    :monster("mon_skitterbot", 85, 1, 1, 1)
    :monster("mon_skitterbot", 85, 1, 2, 3)
    :monster("mon_skitterbot", 10, 1, 8, 12)
    :monster("mon_blob_small", 10, 1, 1, 4)
    :monster("mon_zombie_armored", 5, 5, 1, 1)
    :monster("mon_zombie_brute_shocker", 5, 5, 1, 1)
    :monster("mon_lab_rat", 50, 20, 4, 8))

content.add(content.MonsterGroup {
    id = "GROUP_LAB_SECURITY",
    load_mode = "append",
    default_monster = "mon_zombie_labsecurity",
}
    :monster("mon_feral_labsecurity_9mm", 22, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 22, 2, 1, 1)
    :monster("mon_zombie_labsecurity", 700, 2, 1, 1)
    :monster("mon_science_bot", 50, 4, 1, 1)
    :monster("mon_skitterbot", 85, 0, 1, 1)
    :monster("mon_skitterbot", 85, 0, 2, 3)
    :monster("mon_skitterbot", 1, 0, 8, 12)
    :monster("mon_tazer_hack", 20, 1, 1, 5)
    :monster("mon_secubot", 1, 10, 1, 1)
    :monster("mon_talon_m202a1", 1, 15, 1, 1)
    :monster("mon_zombie_armored", 5, 8, 1, 1)
    :monster("mon_zombie_electric", 50, 3, 1, 1)
    :monster("mon_zombie_necro", 15, 15, 1, 1)
    :monster("mon_zombie_brute_shocker", 10, 5, 1, 1))

-- Mostly scientists, lab personnel and regular zombies.
content.add(content.MonsterGroup {
    id = "GROUP_LAB_FEMA",
    load_mode = "append",
    default_monster = "mon_zombie_scientist",
}
    :monster("mon_feral_labsecurity_9mm", 18, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 18, 2, 1, 1)
    :monster("mon_feral_scientist_scalpel", 20, 8, 1, 1)
    :monster("mon_zombie", 75, 0, 1, 1)
    :monster("mon_zombie_fat", 75, 0, 1, 1)
    :monster("mon_zombie_tough", 75, 2, 1, 1)
    :monster("mon_zombie_crawler", 75, 0, 1, 1)
    :monster("mon_zombie_labsecurity", 200, 2, 1, 2)
    :monster("mon_zombie_scientist", 24, 1, 1, 1)
    :monster("mon_zombie_scientist", 200, 1, 1, 3)
    :monster("mon_zombie_technician", 100, 2, 1, 1)
    :monster("mon_feral_human_tool", 25, 1, 1, 1)
    :monster("mon_zombie_hazmat", 100, 0, 1, 1)
    :monster("mon_zombie_electric", 10, 3, 1, 1)
    :monster("mon_zombie_brute", 5, 5, 1, 1)
    :monster("mon_zombie_brute_shocker", 5, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB_CYBORG", load_mode = "append" }
    :monster("mon_prototype_cyborg", 400, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_LAB_MUTANT_BOSS",
    load_mode = "append",
    default_monster = "mon_mutant_evolved",
}
    :monster("mon_mutant_evolved", 150, 1, 1, 1)
    :monster("mon_mutant_antler", 250, 1, 1, 1)
    :monster("mon_mutant_arthropod", 300, 1, 1, 1)
    :monster("mon_mutant_mollusk", 150, 1, 1, 1)
    :monster("mon_mutant_camouflaged", 150, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MICROLAB", load_mode = "append" }
    :monster("mon_blob_small", 40, 0, 3, 6)
    :monster("mon_feral_labsecurity_9mm", 18, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 18, 2, 1, 1)
    :monster("mon_feral_scientist_scalpel", 20, 0, 1, 1)
    :monster("mon_zombie_scientist", 482, 0, 1, 1)
    :monster("mon_zombie_scientist", 40, 0, 1, 5)
    :monster("mon_science_bot", 40, 2, 1, 1)
    :monster("mon_zombie_labsecurity", 40, 0, 2, 3)
    :monster("mon_zombie_hazmat", 40, 1, 1, 3)
    :monster("mon_tazer_hack", 20, 1, 1, 5)
    :monster("mon_mutant_experimental", 10, 0, 1, 3)
    :monster("mon_skitterbot", 10, 0, 2, 3)
    :monster("mon_zombie_phase_skulker", 10, 0, 2, 3)
    :monster("mon_secubot", 2, 5, 1, 1)
    :monster("mon_zombie", 40, 1, 2, 7)
    :monster("mon_zombie_fat", 40, 1, 2, 4)
    :monster("mon_zombie_tough", 20, 2, 2, 4)
    :monster("mon_zombie_crawler", 10, 1, 1, 1)
    :monster("mon_zombie_technician", 10, 2, 1, 1)
    :monster("mon_feral_human_tool", 15, 1, 1, 1)
    :monster("mon_zombie_armored", 1, 5, 1, 1)
    :monster("mon_zombie_electric", 10, 3, 1, 1)
    :monster("mon_zombie_necro", 1, 15, 1, 1)
    :monster("mon_zombie_brute_shocker", 1, 5, 1, 1)
    :monster("mon_mole_cricket", 2, 3, 1, 1)
    :monster("mon_lab_rat", 20, 20, 2, 8))

content.add(content.MonsterGroup { id = "GROUP_SERUM_LAB", load_mode = "append" }
    :monster("mon_feral_labsecurity_9mm", 18, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 18, 2, 1, 1)
    :monster("mon_feral_scientist_scalpel", 20, 0, 1, 1)
    :monster("mon_feral_serum_user_locutus", 5, 0, 1, 1)
    :monster("mon_feral_serum_user_noonien", 5, 2, 1, 1)
    :monster("mon_feral_serum_user_armus", 5, 2, 1, 1)
    :monster("mon_feral_serum_user_landru", 5, 2, 1, 1)
    :monster("mon_feral_serum_user_lore", 5, 0, 1, 1)
    :monster("mon_feral_serum_user_anaximander", 5, 2, 1, 1)
    :monster("mon_zombie_scientist", 482, 0, 1, 1)
    :monster("mon_zombie_scientist", 40, 0, 1, 5)
    :monster("mon_science_bot", 40, 2, 1, 1)
    :monster("mon_zombie_labsecurity", 40, 0, 2, 3)
    :monster("mon_zombie_hazmat", 40, 1, 1, 3)
    :monster("mon_tazer_hack", 20, 1, 1, 5)
    :monster("mon_skitterbot", 10, 0, 2, 3)
    :monster("mon_secubot", 2, 5, 1, 1)
    :monster("mon_zombie", 40, 1, 2, 7)
    :monster("mon_zombie_fat", 40, 1, 2, 4)
    :monster("mon_zombie_tough", 20, 2, 2, 4)
    :monster("mon_zombie_crawler", 10, 1, 1, 1)
    :monster("mon_zombie_technician", 10, 2, 1, 1)
    :monster("mon_feral_human_tool", 15, 1, 1, 1)
    :monster("mon_zombie_armored", 1, 5, 1, 1)
    :monster("mon_zombie_electric", 10, 3, 1, 1)
    :monster("mon_zombie_necro", 1, 15, 1, 1)
    :monster("mon_zombie_brute_shocker", 1, 5, 1, 1)
    :monster("mon_mole_cricket", 2, 3, 1, 1)
    :monster("mon_lab_rat", 20, 20, 2, 8))

content.add(content.MonsterGroup {
    id = "GROUP_DISTORTED_MICROLAB",
    load_mode = "append",
    default_monster = "mon_zombie_scientist",
}
    :monster("mon_zombie_phase_skulker", 100, 0, 2, 3)
    :monster("mon_yugg", 20, 0, 1, 1)
    :monster("mon_gelatin", 80, 0, 1, 1)
    :monster("mon_flaming_eye", 20, 0, 1, 1)
    :monster("mon_kreck", 110, 0, 1, 1)
    :monster("mon_gozu", 100, 0, 1, 1)
    :monster("mon_shoggoth", 20, 0, 1, 1)
    :monster("mon_flying_polyp", 100, 0, 1, 1)
    :monster("mon_hunting_horror", 100, 0, 1, 1)
    :monster("mon_unseen_hunter", 100, 1, 1, 1, { starts = duration(30, "day") })
    :monster("mon_darkman", 50, 0, 1, 1)
    :monster("mon_zombie_hazmat", 40, 1, 1, 3)
    :monster("mon_breather_hub", 100, 0, 1, 1)
    :monster("mon_zombie_armored", 10, 5, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_MEATLAB", load_mode = "append" }
    :monster("mon_null", 360, 1, 1, 1)
    :monster("mon_amalgamation_swarmer", 200, 1, 1, 2)
    :monster("mon_meat_cocoon_tiny", 200, 1, 1, 2)
    :monster("mon_meat_cocoon_small", 80, 1, 1, 1)
    :monster("mon_amalgamation_spotter", 80, 1, 1, 1)
    :monster("mon_amalgamation_corroder", 80, 1, 1, 1)
    :monster("mon_amalgamation_jumper", 40, 1, 1, 2)
    :monster("mon_amalgamation_soldier", 40, 1, 1, 1, { starts = duration(28, "day") })
    :monster("mon_amalgamation_zapper", 40, 1, 1, 1, { starts = duration(56, "day") })
    :monster("mon_jabberwock", 40, 1, 1, 1, { starts = duration(28, "day") }))

content.add(content.MonsterGroup { id = "GROUP_LAB_BASIC_SECURITY", load_mode = "append" }
    :monster("mon_feral_labsecurity_9mm", 18, 12, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 18, 2, 1, 2)
    :monster("mon_zombie_labsecurity", 830, 0, 1, 1)
    :monster("mon_zombie_labsecurity", 40, 0, 2, 3)
    :monster("mon_zombie_hazmat", 10, 1, 1, 2)
    :monster("mon_zombie", 30, 1, 2, 4)
    :monster("mon_zombie_fat", 20, 1, 1, 2)
    :monster("mon_zombie_tough", 20, 2, 1, 1)
    :monster("mon_zombie_crawler", 10, 1, 1, 1)
    :monster("mon_zombie_technician", 3, 5, 1, 1)
    :monster("mon_feral_human_tool", 1, 1, 1, 1)
    :monster("mon_zombie_necro", 1, 15, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB_MILITARY", load_mode = "append" }
    :monster("mon_feral_labsecurity_9mm", 12, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 12, 2, 1, 1)
    :monster("mon_zombie_labsecurity", 5, 0, 2, 3)
    :monster("mon_zombie_hazmat", 5, 1, 1, 3)
    :monster("mon_zombie_armored", 3, 15, 1, 1)
    :monster("mon_zombie_soldier", 913, 0, 1, 1)
    :monster("mon_zombie_soldier", 25, 0, 1, 4))

content.add(content.MonsterGroup { id = "GROUP_LAB_MAINTENANCE", load_mode = "append" }
    :monster("mon_zombie_technician", 819, 1, 1, 1)
    :monster("mon_feral_human_tool", 25, 1, 1, 1)
    :monster("mon_zombie_hazmat", 20, 1, 1, 3)
    :monster("mon_feral_human_pipe", 18, 8, 1, 3)
    :monster("mon_feral_human_crowbar", 18, 8, 1, 3)
    :monster("mon_hazmatbot", 7, 1, 1, 2)
    :monster("mon_zombie", 30, 1, 1, 3)
    :monster("mon_zombie_fat", 30, 1, 1, 1)
    :monster("mon_zombie_tough", 20, 2, 1, 1)
    :monster("mon_zombie_crawler", 5, 1, 1, 1)
    :monster("mon_zombie_electric", 3, 5, 1, 1)
    :monster("mon_zombie_static", 15, 3, 1, 1)
    :monster("mon_zombie_brute_shocker", 10, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB_RESEARCHERS", load_mode = "append" }
    :monster("mon_zombie_technician", 5, 5, 1, 1)
    :monster("mon_feral_human_tool", 1, 5, 1, 1)
    :monster("mon_zombie_hazmat", 5, 1, 1, 1)
    :monster("mon_feral_scientist_scalpel", 20, 0, 1, 3)
    :monster("mon_zombie_scientist", 895, 0, 1, 1)
    :monster("mon_zombie_scientist", 30, 0, 1, 3)
    :monster("mon_tazer_hack", 5, 3, 1, 1)
    :monster("mon_zombie", 10, 1, 1, 3)
    :monster("mon_zombie_fat", 10, 1, 1, 1)
    :monster("mon_zombie_tough", 10, 2, 1, 1)
    :monster("mon_zombie_crawler", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB_HOSPITAL", load_mode = "append" }
    :monster("mon_zombie_medical", 20, 0, 1, 2)
    :monster("mon_zombie_medical_brute", 10, 3, 1, 1)
    :monster("mon_zombie_technician", 5, 5, 1, 1)
    :monster("mon_feral_human_tool", 2, 5, 1, 1)
    :monster("mon_zombie_hazmat", 5, 1, 1, 1)
    :monster("mon_feral_scientist_scalpel", 10, 1, 1, 2)
    :monster("mon_zombie_scientist", 900, 1, 1, 1)
    :monster("mon_zombie", 10, 1, 1, 3)
    :monster("mon_zombie_fat", 10, 1, 1, 1)
    :monster("mon_zombie_tough", 10, 2, 1, 1)
    :monster("mon_zombie_crawler", 5, 1, 1, 1)
    :monster("mon_zombie_static", 5, 3, 1, 1)
    :monster("mon_zombie_brute_shocker", 10, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_RATKIN_LAB", load_mode = "append" }
    :monster("mon_lab_ratkin", 250, 1, 2, 6)
    :monster("mon_black_ratkin", 200, 1, 2, 6)
    :monster("mon_big_rat", 150, 1, 2, 6)
    :monster("mon_zap_rat", 100, 1, 1, 3)
    :monster("mon_tunnel_rat", 90, 1, 2, 5)
    :monster("mon_pack_rat", 80, 1, 1, 3)
    :monster("mon_teke_mouse", 70, 1, 1, 2)
    :monster("mon_mausketeer", 60, 1, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_COWS_DAIRY", load_mode = "append", is_animal = true, is_safe = true }
    :monster("mon_null", 850, 1, 1, 1)
    :monster("mon_cow", 100, 10, 1, 1, { ends = duration(28, "day") })
    :monster("mon_cow", 50, 5, 1, 1, { starts = duration(28, "day") })
    :monster("mon_cow_calf", 50, 1, 1, 1, { ends = duration(28, "day") })
    :monster("mon_cow_calf", 25, 1, 1, 1, { starts = duration(28, "day") }))

content.add(content.MonsterGroup { id = "GROUP_COWS", load_mode = "append", is_animal = true }
    :monster("mon_cow", 150, 2, 1, 1)
    :monster("mon_cow_calf", 50, 1, 1, 1, { ends = duration(28, "day") })
    :monster("mon_cow_calf", 25, 1, 1, 1, { starts = duration(28, "day") }))

content.add(content.MonsterGroup { id = "GROUP_BEARS", load_mode = "append", is_animal = true }
    :monster("mon_bear", 150, 2, 1, 1)
    :monster("mon_bear_cub", 50, 1, 1, 1, { ends = duration(124, "day"), conditions = { "SPRING", "SUMMER" } })
    :monster("mon_bear_cub", 25, 1, 1, 1, { starts = duration(124, "day"), conditions = { "SPRING", "SUMMER" } }))

content.add(content.MonsterGroup { id = "GROUP_BOARS", load_mode = "append", is_animal = true }
    :monster("mon_boar_wild", 150, 2, 1, 1)
    :monster("mon_boar_wild_piglet", 50, 1, 1, 6, { ends = duration(56, "day") })
    :monster("mon_boar_wild_piglet", 25, 1, 1, 6, { starts = duration(56, "day") }))

content.add(content.MonsterGroup { id = "GROUP_PIGS", load_mode = "append", is_animal = true }
    :monster("mon_pig", 150, 2, 1, 1)
    :monster("mon_pig_piglet", 25, 1, 1, 2, { ends = duration(28, "day") })
    :monster("mon_pig_piglet", 12, 1, 1, 2, { starts = duration(28, "day") }))

content.add(content.MonsterGroup { id = "GROUP_SHEEPS", load_mode = "append", is_animal = true }
    :monster("mon_sheep", 150, 2, 1, 1)
    :monster("mon_sheep_lamb", 25, 1, 1, 1, { ends = duration(28, "day"), conditions = { "SPRING", "SUMMER" } })
    :monster("mon_sheep_lamb", 12, 1, 1, 1, { starts = duration(28, "day"), conditions = { "SPRING", "SUMMER" } }))

content.add(content.MonsterGroup { id = "GROUP_DEERS", load_mode = "append", is_animal = true }
    :monster("mon_deer", 150, 2, 1, 1)
    :monster("mon_deer_fawn", 25, 1, 1, 1, {
        ends = duration(28, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_deer_fawn", 12, 1, 1, 1, {
        starts = duration(28, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup { id = "GROUP_REINDEERS", load_mode = "append", is_animal = true }
    :monster("mon_reindeer", 150, 2, 1, 1)
    :monster("mon_reindeer_fawn", 25, 1, 1, 3, {
        ends = duration(28, "day"),
        conditions = { "AUTUMN", "WINTER", "SPRING" },
    })
    :monster("mon_reindeer_fawn", 12, 1, 1, 3, {
        starts = duration(28, "day"),
        conditions = { "AUTUMN", "WINTER", "SPRING" },
    }))

-- Mutant deer are better prepared to protect/escape with their spawn than normal deer, so, contrary to normal wildlife, their spawn becomes more common as time goes on.
content.add(content.MonsterGroup { id = "GROUP_DEER_MUT_SPIDERS", load_mode = "append", is_animal = true }
    :monster("mon_deer_mutant_spider", 150, 2, 1, 1)
    :monster("mon_deer_mutant_spider_fawn", 12, 1, 1, 1, {
        ends = duration(124, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_deer_mutant_spider_fawn", 25, 1, 1, 1, {
        starts = duration(124, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup { id = "GROUP_WOLFS", load_mode = "append", is_animal = true }
    :monster("mon_wolf", 150, 2, 1, 1)
    :monster("mon_wolf_pup", 25, 1, 1, 2, { ends = duration(124, "day"), conditions = { "SPRING", "SUMMER" } })
    :monster("mon_wolf_pup", 12, 1, 1, 2, { starts = duration(124, "day"), conditions = { "SPRING", "SUMMER" } }))

content.add(content.MonsterGroup { id = "GROUP_COUGARS", load_mode = "append", is_animal = true }
    :monster("mon_cougar", 150, 2, 1, 1)
    :monster("mon_cougar_kitten", 25, 1, 1, 2, {
        ends = duration(124, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_cougar_kitten", 12, 1, 1, 2, {
        starts = duration(124, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

content.add(content.MonsterGroup { id = "GROUP_HORSES", load_mode = "append", is_animal = true }
    :monster("mon_horse", 150, 2, 1, 1)
    :monster("mon_horse_foal", 50, 1, 1, 1, { ends = duration(124, "day") })
    :monster("mon_horse_foal", 25, 1, 1, 1, { starts = duration(124, "day") }))

content.add(content.MonsterGroup { id = "GROUP_HORSES_STABLES", load_mode = "append", is_animal = true }
    :monster("mon_null", 50, 1, 1, 1)
    :group("GROUP_HORSES", 50, 1, 1, 1, { ends = duration(56, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MOOSE", load_mode = "append", is_animal = true }
    :group("GROUP_MOOSE_NORMAL", 19, 1, 1, 1)
    :group("GROUP_TUSKED_MOOSE", 1, 1, 1, 1, { starts = duration(3832, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MOOSE_NORMAL", load_mode = "append", is_animal = true }
    :monster("mon_moose", 150, 2, 1, 1)
    :monster("mon_moose_calf", 50, 1, 1, 1, { ends = duration(124, "day"), conditions = { "AUTUMN", "WINTER" } })
    :monster("mon_moose_calf", 25, 1, 1, 1, { starts = duration(124, "day"), conditions = { "AUTUMN", "WINTER" } }))

-- Same as mutant deer.
content.add(content.MonsterGroup { id = "GROUP_TUSKED_MOOSE", load_mode = "append", is_animal = true }
    :monster("mon_tusked_moose", 150, 2, 1, 1)
    :monster("mon_tusked_moose_calf", 25, 1, 1, 1, {
        ends = duration(280, "day"),
        conditions = { "SPRING", "SUMMER" },
    })
    :monster("mon_tusked_moose_calf", 50, 1, 1, 1, {
        starts = duration(280, "day"),
        conditions = { "SPRING", "SUMMER" },
    }))

-- Not doing the whole weird thing with timers and weight halving for babies as the groups above me did. I have no idea what's that hoping to accomplish and nobody else seems to either.
content.add(content.MonsterGroup { id = "GROUP_COYOTE", load_mode = "append", is_animal = true }
    :monster("mon_coyote", 38, 1, 1, 1)
    :monster("mon_coyote_mutant_shark", 1, 1, 1, 1, { starts = duration(1080, "day") })
    :monster("mon_coyote_mutant_venom", 1, 1, 1, 1, { starts = duration(1080, "day") }))

content.add(content.MonsterGroup { id = "GROUP_BEAVER", load_mode = "append", is_animal = true }
    :monster("mon_beaver", 38, 1, 1, 1)
    :monster("mon_beaver_mutant_avian", 1, 1, 1, 1, { starts = duration(2920, "day") })
    :monster("mon_beaver_mutant_huge", 1, 1, 1, 1, { starts = duration(2920, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_STRAY_DOGS",
    load_mode = "append",
    default_monster = "mon_dog",
    is_animal = true,
}
    :group("GROUP_PET_DOGS", 90, 0, 1, 1)
    :monster("mon_dog_mutant_mongrel", 7, 0, 1, 1)
    :monster("mon_dog_incorporeal", 1, 0, 1, 1)
    :monster("mon_dog_telekenetic", 1, 0, 1, 1)
    :monster("mon_dog_antimemetic", 1, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_STRAY_CATS",
    load_mode = "append",
    default_monster = "mon_cat",
    is_animal = true,
}
    :group("GROUP_PET_CATS", 97, 0, 1, 1)
    :monster("mon_cat_void", 1, 0, 1, 1)
    :monster("mon_cat_liquid", 1, 0, 1, 1)
    :monster("mon_cat_mutant_prism", 1, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_PET_DOGS",
    load_mode = "append",
    default_monster = "mon_dog",
    is_animal = true,
}
    :monster("mon_dog", 50, 0, 1, 1)
    :monster("mon_dog_pup", 5, 0, 1, 1)
    :monster("mon_dog_bull", 50, 0, 1, 1)
    :monster("mon_dog_bull_pup", 5, 0, 1, 1)
    :monster("mon_dog_pitbullmix", 50, 0, 1, 1)
    :monster("mon_dog_pitbullmix_pup", 5, 0, 1, 1)
    :monster("mon_dog_beagle", 50, 0, 1, 1)
    :monster("mon_dog_beagle_pup", 5, 0, 1, 1)
    :monster("mon_dog_bcollie", 50, 0, 1, 1)
    :monster("mon_dog_bcollie_pup", 5, 0, 1, 1)
    :monster("mon_dog_boxer", 50, 0, 1, 1)
    :monster("mon_dog_boxer_pup", 5, 0, 1, 1)
    :monster("mon_dog_chihuahua", 50, 0, 1, 1)
    :monster("mon_dog_chihuahua_pup", 5, 0, 1, 1)
    :monster("mon_dog_dachshund", 50, 0, 1, 1)
    :monster("mon_dog_dachshund_pup", 5, 0, 1, 1)
    :monster("mon_dog_gshepherd", 50, 0, 1, 1)
    :monster("mon_dog_gshepherd_pup", 5, 0, 1, 1)
    :monster("mon_dog_gpyrenees", 50, 0, 1, 1)
    :monster("mon_dog_gpyrenees_pup", 5, 0, 1, 1)
    :monster("mon_dog_rottweiler", 50, 0, 1, 1)
    :monster("mon_dog_rottweiler_pup", 5, 0, 1, 1)
    :monster("mon_dog_auscattle", 50, 0, 1, 1)
    :monster("mon_dog_auscattle_pup", 5, 0, 1, 1)
    :monster("mon_dog_samoyed", 50, 0, 1, 1)
    :monster("mon_dog_samoyed_pup", 5, 0, 1, 1)
    :monster("mon_dog_wad", 50, 0, 1, 1)
    :monster("mon_dog_wad_pup", 5, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_MUTANT_PET_DOGS",
    load_mode = "append",
    default_monster = "mon_dog_mutant_mongrel",
    is_animal = true,
}
    :monster("mon_dog_mutant_mongrel", 13, 0, 1, 1)
    :monster("mon_dog_mutant_thrasher", 2, 0, 1, 1)
    :monster("mon_dog_mutant_mauler", 2, 0, 1, 1)
    :monster("mon_dog_mutant_loper", 2, 0, 1, 1)
    :monster("mon_dog_mutant_wyrmhound", 1, 2, 1, 1))

-- Persian, Devon Rex, and sphynx cats are not really fit to survive without human assistance and will die off eventually. Persians will overheat in the summer and have trouble breathing because of their flat faces and sphynx cats and Devons will freeze in the cold season.
content.add(content.MonsterGroup {
    id = "GROUP_PET_CATS",
    load_mode = "append",
    default_monster = "mon_cat",
    is_animal = true,
}
    :monster("mon_cat", 100, 0, 1, 1)
    :monster("mon_cat_kitten", 5, 0, 1, 1)
    :monster("mon_cat_tabby", 200, 0, 1, 1)
    :monster("mon_cat_tabby_kitten", 5, 0, 1, 1)
    :monster("mon_cat_longhair", 50, 0, 1, 1)
    :monster("mon_cat_longhair_kitten", 5, 0, 1, 1)
    :monster("mon_cat_siamese", 30, 0, 1, 1)
    :monster("mon_cat_siamese_kitten", 3, 0, 1, 1)
    :monster("mon_cat_persian", 20, 0, 1, 1, { ends = duration(360, "day") })
    :monster("mon_cat_persian_kitten", 2, 0, 1, 1, { ends = duration(360, "day") })
    :monster("mon_cat_calico", 50, 0, 1, 1)
    :monster("mon_cat_calico_kitten", 4, 0, 1, 1)
    :monster("mon_cat_maine_coon", 50, 0, 1, 1)
    :monster("mon_cat_maine_coon_kitten", 5, 0, 1, 1)
    :monster("mon_cat_bengal", 50, 0, 1, 1)
    :monster("mon_cat_bengal_kitten", 5, 0, 1, 1)
    :monster("mon_cat_devon_rex", 10, 0, 1, 1, { ends = duration(612, "day") })
    :monster("mon_cat_devon_rex_kitten", 1, 0, 1, 1, { ends = duration(612, "day") })
    :monster("mon_cat_sphynx", 10, 0, 1, 1, { ends = duration(612, "day") })
    :monster("mon_cat_sphynx_kitten", 1, 0, 1, 1, { ends = duration(612, "day") })
    :monster("mon_cat_chonker", 10, 0, 1, 1)
    :monster("mon_cat_chonker_kitten", 1, 0, 1, 1)
    :monster("mon_cat_black", 80, 0, 1, 1)
    :monster("mon_cat_black_kitten", 5, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_PETS",
    load_mode = "append",
    default_monster = "mon_dog",
    is_animal = true,
}
    :group("GROUP_PET_CATS", 1, 0, 1, 1)
    :group("GROUP_PET_DOGS", 1, 0, 1, 1)
    :monster("mon_ferret", 1, 0, 1, 1)
    :monster("mon_rabbit", 1, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_RABBIT_WILD",
    load_mode = "append",
    default_monster = "mon_wild_rabbit",
    is_animal = true,
}
    :monster("mon_wild_rabbit", 893, 0, 1, 1)
    :monster("mon_hare", 106, 0, 1, 1)
    :monster("mon_rabbit", 1, 0, 1, 1))

-- Mi-go raiding parties spawning in the vicinity of a mi-go camp.  Puts slavers later on and keeps large groups from spawning until the player can deal with them.
content.add(content.MonsterGroup { id = "GROUP_MI-GO_CAMP_OM", load_mode = "append" }
    :monster("mon_mi_go", 530, 1, 1, 1)
    :monster("mon_mi_go", 100, 20, 2, 4)
    :monster("mon_mi_go", 100, 10, 4, 8)
    :monster("mon_mi_go", 100, 2, 3, 6, { starts = duration(30, "day") })
    :monster("mon_mi_go_slaver", 30, 10, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_slaver", 30, 20, 1, 2, { starts = duration(45, "day") })
    :monster("mon_mi_go_scout", 100, 50, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_myrmidon", 10, 50, 1, 1, { starts = duration(45, "day") }))

-- Basic mi-go base defenders.
content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_COMMON", load_mode = "append" }
    :monster("mon_mi_go", 100, 1, 2, 4)
    :monster("mon_mi_go", 100, 3, 2, 4)
    :monster("mon_mi_go_guard", 550, 1, 1, 1)
    :monster("mon_mi_go_guard", 50, 1, 1, 2)
    :monster("mon_mi_go_guard", 30, 3, 1, 2)
    :monster("mon_mi_go_slaver", 20, 4, 1, 2, { starts = duration(35, "day") })
    :monster("mon_mi_go_scout", 100, 2, 1, 1, { starts = duration(35, "day") }))

-- Mi-go base defenders for rooms where captives are being held.
content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_CAPTORS", load_mode = "append" }
    :monster("mon_mi_go_guard", 700, 1, 1, 1)
    :monster("mon_mi_go_guard", 50, 1, 1, 2)
    :monster("mon_mi_go_guard", 50, 3, 2, 4)
    :monster("mon_mi_go_surgeon", 100, 2, 1, 1)
    :monster("mon_mi_go_surgeon", 100, 4, 1, 2))

-- Mi-go base defenders for major boss battles.
content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_BOSS", load_mode = "append" }
    :monster("mon_mi_go_guard", 620, 1, 1, 1)
    :monster("mon_mi_go_guard", 70, 3, 2, 5)
    :monster("mon_mi_go_myrmidon", 30, 6, 1, 2, { starts = duration(35, "day") })
    :monster("mon_mi_go_scout", 100, 3, 1, 2))

-- Mi-go scout tower prisoner room.
content.add(content.MonsterGroup { id = "GROUP_MI-GO_SCOUT_TOWER", load_mode = "append" }
    :monster("mon_mi_go_surgeon", 100, 3, 1, 1)
    :monster("mon_mi_go_guard", 100, 6, 1, 1)
    :monster("mon_mi_go", 700, 1, 1, 1)
    :monster("mon_mi_go", 100, 2, 3, 4))

-- 50% chance military zombie or robot
content.add(content.MonsterGroup { id = "GROUP_MAYBE_MIL", load_mode = "append" }
    :monster("mon_null", 925, 1, 1, 1)
    :monster("mon_zombie_soldier", 35, 1, 1, 1)
    :monster("mon_dispatch", 10, 50, 1, 1)
    :monster("mon_dispatch_military", 5, 80, 1, 1)
    :monster("mon_talon_m202a1", 15, 50, 1, 1)
    :monster("mon_feral_soldier", 15, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MIL_WEAK", load_mode = "append" }
    :monster("mon_zombie_soldier", 645, 1, 1, 1)
    :monster("mon_zombie_soldier", 150, 2, 1, 4)
    :monster("mon_zombie_military_pilot", 5, 1, 1, 1)
    :monster("mon_feral_soldier", 15, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MIL_STRONG", load_mode = "append" }
    :monster("mon_zombie_soldier", 565, 1, 1, 1)
    :monster("mon_zombie_soldier", 100, 2, 1, 4)
    :monster("mon_zombie_soldier", 150, 2, 2, 6)
    :monster("mon_zombie_military_pilot", 5, 1, 1, 1)
    :monster("mon_zombie_armored", 10, 5, 1, 1)
    :monster("mon_feral_soldier", 15, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MIL_HELIPAD", load_mode = "append" }
    :monster("mon_zombie_soldier", 645, 1, 1, 1)
    :monster("mon_zombie_soldier", 150, 2, 1, 4)
    :monster("mon_zombie_milbase_personnel", 100, 1, 1, 1)
    :monster("mon_zombie_military_pilot", 45, 1, 1, 1)
    :monster("mon_feral_soldier", 15, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MIL_PILOT", load_mode = "append" }
    :monster("mon_zombie_military_pilot", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MIL_PASSENGER", load_mode = "append" }
    :monster("mon_zombie_soldier", 245, 1, 1, 1)
    :monster("mon_zombie_hazmat", 25, 1, 1, 1)
    :monster("mon_zombie_soldier_blackops_1", 5, 1, 1, 1)
    :monster("mon_zombie_armored", 1, 5, 1, 1)
    :monster("mon_zombie_scientist", 20, 1, 1, 1)
    :monster("mon_zombie_medical", 6, 1, 1, 1)
    :monster("mon_zombie", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MIL_BASE", load_mode = "append" }
    :monster("mon_zombie_soldier", 580, 1, 1, 1)
    :monster("mon_zombie_soldier", 100, 2, 1, 1)
    :monster("mon_zombie_soldier_acid_1", 15, 5, 1, 1)
    :monster("mon_zombie_kevlar_1", 50, 10, 1, 1)
    :monster("mon_zombie_military_pilot", 5, 1, 1, 1)
    :monster("mon_zombie_milbase_personnel", 40, 1, 1, 1)
    :monster("mon_zombie_soldier_blackops_1", 15, 10, 1, 1)
    :monster("mon_zombie_armored", 5, 5, 1, 1)
    :monster("mon_zombie_scorched", 25, 1, 1, 1)
    :monster("mon_zombie_hazmat", 25, 1, 1, 1)
    :monster("mon_zombie", 10, 1, 1, 1)
    :monster("mon_feral_soldier", 15, 1, 1, 1))

-- Civilians with soldiers and burned ones.
content.add(content.MonsterGroup { id = "GROUP_MIL_BASE_CIVILIAN", load_mode = "append" }
    :monster("mon_zombie", 415, 1, 1, 1)
    :monster("mon_zombie_fat", 60, 2, 1, 1)
    :monster("mon_zombie_child", 30, 1, 1, 1)
    :monster("mon_zombie_tough", 40, 3, 1, 1)
    :monster("mon_zombie_rot", 20, 2, 1, 1)
    :monster("mon_zombie_crawler", 10, 2, 1, 1)
    :monster("mon_zombie_runner", 40, 5, 1, 4)
    :monster("mon_zombie_brainless", 20, 1, 1, 1)
    :monster("mon_zombie_cop", 20, 2, 1, 1)
    :monster("mon_zombie_hazmat", 10, 2, 1, 1)
    :monster("mon_zombie_fireman", 5, 2, 1, 1)
    :monster("mon_dog_zombie_cop", 2, 2, 1, 1)
    :monster("mon_zombie_dog", 5, 2, 1, 1)
    :monster("mon_dog_zombie_rot", 5, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 5, 2, 1, 1)
    :monster("mon_feral_swimmer_kickboard", 1, 2, 1, 1, {
        ends = duration(660, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_zombie_static", 30, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 1, 25, 1, 1)
    :monster("mon_zombie_survivor", 1, 25, 1, 1)
    :monster("mon_zombie_survivor_elite", 1, 25, 1, 1, { starts = duration(240, "day") })
    :monster("mon_zombie_scorched", 25, 2, 1, 1)
    :monster("mon_zombie_soldier", 200, 2, 1, 1)
    :monster("mon_zombie_milbase_personnel", 50, 1, 1, 1)
    :monster("mon_zombie_military_pilot", 5, 1, 1, 1)
    :monster("mon_feral_soldier", 75, 1, 1, 1))

-- Civilians with soldiers, doctors and burned ones. More hazmat.
content.add(content.MonsterGroup { id = "GROUP_MIL_BASE_HOSPITAL", load_mode = "append" }
    :monster("mon_zombie", 50, 2, 1, 1)
    :monster("mon_zombie_fat", 60, 2, 1, 1)
    :monster("mon_zombie_child", 40, 1, 1, 1)
    :monster("mon_zombie_tough", 40, 3, 1, 1)
    :monster("mon_zombie_rot", 20, 2, 1, 1)
    :monster("mon_zombie_crawler", 10, 2, 1, 1)
    :monster("mon_zombie_runner", 40, 5, 1, 4)
    :monster("mon_zombie_brainless", 20, 1, 1, 1)
    :monster("mon_zombie_cop", 20, 2, 1, 1)
    :monster("mon_zombie_hazmat", 100, 2, 1, 1)
    :monster("mon_zombie_fireman", 20, 2, 1, 1)
    :monster("mon_dog_zombie_cop", 5, 2, 1, 1)
    :monster("mon_zombie_dog", 10, 2, 1, 1)
    :monster("mon_dog_zombie_rot", 5, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 10, 2, 1, 1)
    :monster("mon_feral_swimmer_kickboard", 1, 2, 1, 1, {
        ends = duration(660, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_zombie_static", 30, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 1, 25, 1, 1)
    :monster("mon_zombie_survivor", 1, 25, 1, 1)
    :monster("mon_zombie_survivor_elite", 1, 25, 1, 1, { starts = duration(240, "day") })
    :monster("mon_zombie_scorched", 25, 1, 1, 1)
    :monster("mon_zombie_soldier", 322, 2, 1, 1)
    :monster("mon_zombie_milbase_personnel", 50, 1, 1, 1)
    :monster("mon_zombie_military_pilot", 20, 1, 1, 1)
    :monster("mon_zombie_scientist", 100, 1, 1, 1)
    :monster("mon_feral_soldier", 75, 1, 1, 1))

-- no children, 40% tech personel 20% civilian personel (med, fire, cook, clercs etc), 20% uniformed zombie, 10% army pilots, and 10% military zeds
content.add(content.MonsterGroup { id = "GROUP_AIRCRAFT_CARRIER", load_mode = "append" }
    :monster("mon_zombie_technician", 15, 1, 1, 1)
    :monster("mon_feral_sailor_lug_wrench", 15, 1, 1, 1)
    :monster("mon_zombie_officer", 6, 1, 1, 1)
    :monster("mon_zombie_sailor", 10, 1, 1, 1)
    :monster("mon_zombie_fireman", 6, 1, 1, 1)
    :monster("mon_zombie_medical", 6, 1, 1, 1)
    :monster("mon_zombie_fat", 6, 1, 1, 1)
    :monster("mon_zombie_marine", 6, 1, 1, 1)
    :monster("mon_zombie_crawler", 6, 1, 1, 1)
    :monster("mon_zombie_brainless", 6, 1, 1, 1)
    :monster("mon_zombie_sailor", 18, 1, 1, 1)
    :monster("mon_zombie_military_pilot", 18, 1, 1, 1)
    :monster("mon_zombie_sailor", 6, 1, 1, 1)
    :monster("mon_zombie_military_pilot", 6, 1, 1, 1)
    :monster("mon_zombie_marine", 15, 5, 2, 4)
    :monster("mon_zombie_marine_upgrade", 2, 10, 1, 1)
    :monster("mon_feral_officer", 2, 10, 1, 1, { starts = duration(60, "day") })
    :monster("mon_feral_sailor_wrench", 6, 1, 1, 1)
    :monster("mon_feral_sailor_mop", 6, 1, 1, 1)
    :monster("mon_feral_sailor_axe", 6, 1, 1, 1)
    :monster("mon_feral_marine_bayonet", 6, 1, 1, 1)
    :monster("mon_feral_sailor_wrench", 6, 1, 1, 1)
    :monster("mon_feral_marine_bayonet", 6, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_AIRCRAFT_CARRIER_TECHNICIANS", load_mode = "append" }
    :monster("mon_zombie_technician", 67, 1, 1, 1)
    :monster("mon_feral_sailor_lug_wrench", 67, 1, 1, 1)
    :monster("mon_zombie_sailor", 12, 1, 1, 1)
    :monster("mon_zombie_fireman", 6, 1, 1, 1)
    :monster("mon_zombie_officer", 6, 1, 1, 1)
    :monster("mon_zombie_medical", 6, 1, 1, 1)
    :monster("mon_zombie_fat", 6, 1, 1, 1)
    :monster("mon_feral_sailor_wrench", 6, 1, 1, 1)
    :monster("mon_feral_sailor_mop", 6, 1, 1, 1)
    :monster("mon_feral_sailor_axe", 6, 1, 1, 1)
    :monster("mon_feral_marine_bayonet", 6, 1, 1, 1)
    :monster("mon_feral_sailor_wrench", 6, 1, 1, 1)
    :monster("mon_feral_officer", 3, 1, 1, 1))

-- Lots of hazmats.
content.add(content.MonsterGroup { id = "GROUP_MIL_MASS_GRAVE", load_mode = "append" }
    :monster("mon_zombie_soldier", 10, 1, 1, 1)
    :monster("mon_zombie_hazmat", 20, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NULL", load_mode = "append", is_safe = true }
    :monster("mon_null", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BLACK_ROAD", load_mode = "append" }
    :monster("mon_zombie", 407, 1, 1, 1)
    :monster("mon_zombie", 1, 7, 5, 20)
    :monster("mon_zombie", 1, 13, 15, 40)
    :monster("mon_zombie", 1, 20, 25, 60)
    :monster("mon_zombie", 75, 0, 1, 1)
    :monster("mon_zombie_fat", 75, 2, 1, 1)
    :monster("mon_zombie_fat", 3, 7, 3, 5)
    :monster("mon_zombie_tough", 75, 3, 1, 1)
    :monster("mon_zombie_child", 75, 1, 1, 1)
    :monster("mon_zombie_rot", 50, 3, 1, 1)
    :monster("mon_zombie_crawler", 25, 3, 1, 1)
    :monster("mon_zombie_dog", 20, 2, 1, 1)
    :monster("mon_zombie_dog", 1, 4, 3, 5)
    :monster("mon_zombie_dog", 1, 16, 5, 8)
    :monster("mon_zombie_dog", 1, 24, 8, 12)
    :monster("mon_dog_zombie_cop", 5, 4, 1, 1)
    :monster("mon_dog_zombie_rot", 5, 5, 1, 1)
    :monster("mon_zombie_soldier", 10, 2, 1, 1)
    :monster("mon_zombie_cop", 20, 3, 1, 1)
    :monster("mon_zombie_swat", 10, 3, 1, 1)
    :monster("mon_zombie_hazmat", 10, 3, 1, 1)
    :monster("mon_zombie_fireman", 10, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 10, 5, 1, 1)
    :monster("mon_feral_swimmer_kickboard", 1, 5, 1, 1, {
        ends = duration(660, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_zombie_static", 10, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 1, 25, 1, 1)
    :monster("mon_zombie_survivor", 1, 25, 1, 1)
    :monster("mon_zombie_survivor_elite", 1, 25, 1, 1, { starts = duration(240, "day") })
    :monster("mon_beekeeper", 1, 5, 1, 1)
    :monster("mon_zombie_technician", 1, 12, 1, 1)
    :monster("mon_feral_human_tool", 1, 6, 1, 1)
    :monster("mon_zombie_runner", 20, 5, 1, 4)
    :monster("mon_feral_human_pipe", 4, 1, 2, 3)
    :monster("mon_feral_human_crowbar", 4, 1, 2, 3)
    :monster("mon_feral_human_axe", 2, 2, 1, 2)
    :monster("mon_feral_jackboot", 1, 25, 1, 3, { starts = duration(240, "day") })
    :monster("mon_zombie_brainless", 65, 1, 1, 1))

-- Nonsense ferals for the mansion escape challenge scenario, shouldn't be used for general spawns
content.add(content.MonsterGroup { id = "GROUP_MANSION_START", load_mode = "append" }
    :group("GROUP_MANSION_PURSUERS", 1600, 1, 1, 1)
    :monster("mon_feral_fancy_rapier", 200, 1, 1, 1)
    :monster("mon_feral_fancy_rapier_fake", 300, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MANSION_PURSUERS", load_mode = "append" }
    :monster("mon_feral_maid_broom", 600, 1, 1, 1)
    :monster("mon_feral_maid_candlestick", 600, 1, 1, 1)
    :monster("mon_feral_maid_knife", 400, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MANSION_ARMORED", load_mode = "append" }
    :monster("mon_feral_armored_mace", 100, 1, 1, 1)
    :monster("mon_feral_armored_battleaxe", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CHUD", load_mode = "append" }
    :monster("mon_chud", 875, 0, 1, 1)
    :monster("mon_crawler", 35, 0, 1, 1))

-- Z-2 subways, some lost nether things but otherwise mostly normal mobs
content.add(content.MonsterGroup {
    id = "GROUP_SUBWAY",
    load_mode = "append",
    default_monster = "mon_silverfish_small",
}
    :group("GROUP_NETHER_UNVIABLE", 300, 0, 1, 1)
    :group("GROUP_BUGS_SUBTERRANEAN", 750, 1, 1, 1)
    :monster("mon_mutant_experimental", 50, 2, 1, 3, { ends = duration(56, "day") })
    :monster("mon_mutant_experimental", 50, 2, 2, 5, { starts = duration(56, "day") })
    :monster("mon_sludge_crawler", 50, 1, 1, 1)
    :monster("mon_unseen_hunter", 50, 2, 1, 1, { starts = duration(7, "day") })
    :monster("mon_dog_thing", 20, 2, 1, 1)
    :group("GROUP_STRAY_DOGS", 10, 2, 1, 1)
    :monster("mon_blank", 20, 2, 1, 4)
    :monster("mon_kreck", 20, 2, 1, 4)
    :monster("mon_gracke", 20, 2, 1, 4)
    :monster("mon_hunting_horror", 20, 2, 1, 3)
    :monster("mon_shoggoth", 10, 3, 1, 1, { starts = duration(7, "day") }))

-- Normal subway, extra spawns underneath a city
content.add(content.MonsterGroup { id = "GROUP_SUBWAY_CITY", load_mode = "append", default_monster = "mon_chud" }
    :monster("mon_chud", 90, 1, 1, 1)
    :monster("mon_chud", 400, 1, 2, 3)
    :monster("mon_zombie_survivor", 100, 3, 1, 3, { starts = duration(7, "day") })
    :monster("mon_zombie_survivor_elite", 100, 4, 1, 3, { starts = duration(30, "day") })
    :monster("mon_zombie_technician", 100, 2, 1, 2)
    :monster("mon_zombie_shady", 200, 2, 1, 3))

-- Lower subway with eldritch nasties and lab escapees
-- 1W 42, 1M 180, 1,5M 270, 2M 360, 3M 540, sum 930
content.add(content.MonsterGroup { id = "GROUP_SUBWAY_LAB", load_mode = "append", default_monster = "mon_kreck" }
    :group("GROUP_BUGS_SUBTERRANEAN", 75, 1, 1, 1)
    :monster("mon_kreck", 200, 1, 1, 1)
    :monster("mon_unseen_hunter", 200, 1, 1, 1, { starts = duration(24, "hour"), ends = duration(60, "day") })
    :monster("mon_unseen_hunter", 200, 1, 1, 2, { starts = duration(60, "day") })
    :monster("mon_mutant_experimental", 250, 1, 1, 3, { ends = duration(28, "day") })
    :monster("mon_mutant_experimental", 250, 1, 2, 5, {
        starts = duration(28, "day"),
        ends = duration(112, "day"),
    })
    :monster("mon_mutant_experimental", 300, 1, 3, 6, { starts = duration(112, "day") })
    :monster("mon_mi_go", 100, 1, 1, 4, { ends = duration(60, "day") })
    :monster("mon_mi_go_scout", 100, 2, 1, 1, { starts = duration(60, "day") })
    :monster("mon_mi_go_myrmidon", 70, 2, 1, 2, { starts = duration(90, "day") })
    :monster("mon_sludge_crawler", 50, 1, 1, 1)
    :monster("mon_dog_thing", 50, 1, 1, 1)
    :monster("mon_thing", 50, 1, 1, 1)
    :monster("mon_flying_polyp", 50, 1, 1, 2)
    :monster("mon_hunting_horror", 50, 1, 1, 2)
    :monster("mon_gozu", 50, 1, 1, 1)
    :monster("mon_shoggoth", 30, 2, 1, 1)
    :monster("mon_albino_penguin", 20, 1, 2, 4)
    :monster("mon_darkman", 10, 2, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_DOMESTIC",
    load_mode = "append",
    default_monster = "mon_dog",
    is_animal = true,
}
    :group("GROUP_PET_CATS", 100, 0, 1, 1)
    :group("GROUP_PET_CATS", 20, 10, 2, 8)
    :group("GROUP_PET_DOGS", 15, 25, 1, 6)
    :monster("mon_dog_bull", 1, 25, 1, 3)
    :monster("mon_dog_auscattle", 1, 25, 1, 3)
    :monster("mon_dog_pitbullmix", 13, 25, 1, 3)
    :monster("mon_dog_beagle", 4, 25, 1, 6)
    :monster("mon_dog_bcollie", 2, 25, 1, 3)
    :monster("mon_dog_boxer", 4, 25, 1, 3)
    :monster("mon_dog_chihuahua", 6, 25, 1, 3)
    :monster("mon_dog_dachshund", 2, 25, 1, 3)
    :monster("mon_dog_gshepherd", 3, 25, 1, 3)
    :monster("mon_dog_samoyed", 1, 25, 1, 3)
    :group("GROUP_BIRD_DOMESTIC", 50, 5, 1, 12)
    :group("GROUP_COWS", 50, 25, 1, 8)
    :group("GROUP_HORSES", 50, 25, 1, 4)
    :group("GROUP_PIGS", 10, 25, 1, 6)
    :group("GROUP_PIGS", 10, 25, 1, 6, { ends = duration(12, "day") })
    :group("GROUP_PIGS", 10, 25, 1, 6, { ends = duration(28, "day") })
    :group("GROUP_PIGS", 10, 25, 1, 6, { ends = duration(112, "day") })
    :group("GROUP_PIGS", 10, 25, 1, 6, { ends = duration(360, "day") })
    :group("GROUP_SHEEPS", 50, 25, 1, 12)
    :monster("mon_goat", 25, 25, 1, 12)
    :monster("mon_llama", 50, 25, 1, 8)
    :monster("mon_zombie_pig", 10, 25, 1, 5, { starts = duration(12, "day") })
    :monster("mon_zombie_pig", 10, 25, 1, 5, { starts = duration(28, "day") })
    :monster("mon_zombie_pig", 10, 25, 1, 5, { starts = duration(112, "day") })
    :monster("mon_zombie_pig", 10, 25, 1, 5, { starts = duration(360, "day") })
    :monster("mon_giant_cockroach", 10, 1, 1, 2)
    :monster("mon_pregnant_giant_cockroach", 1, 3, 1, 1)
    :monster("mon_giant_cockroach_nymph", 5, 1, 1, 1)
    :monster("mon_woodlouse", 10, 1, 1, 5)
    :monster("mon_woodlouse_manca", 5, 1, 1, 1)
    :monster("mon_ferret", 10, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_BIRD_DOMESTIC",
    load_mode = "append",
    default_monster = "mon_chicken",
    is_animal = true,
}
    :monster("mon_chicken", 14, 1, 1, 4)
    :monster("mon_duck_domestic", 6, 1, 1, 3)
    :monster("mon_goose", 3, 1, 1, 2)
    :monster("mon_turkey_domestic", 1, 1, 1, 2)
    :monster("mon_guinea_fowl", 1, 1, 1, 3))

content.add(content.MonsterGroup {
    id = "GROUP_BIRD_DOMESTIC_WATERFOWL",
    load_mode = "append",
    default_monster = "mon_duck_domestic",
    is_animal = true,
}
    :monster("mon_duck_domestic", 2, 1, 1, 6)
    :monster("mon_goose", 1, 1, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_SAFE", load_mode = "append", is_animal = true, is_safe = true }
    :monster("mon_null", 679, 1, 1, 1)
    :monster("mon_bat", 10, 1, 1, 1)
    :monster("mon_bobcat", 10, 1, 1, 1)
    :group("GROUP_BIRD_DOMESTIC", 20, 1, 1, 1)
    :monster("mon_chipmunk", 10, 1, 1, 1)
    :monster("mon_crow", 10, 1, 1, 1)
    :monster("mon_raven", 10, 1, 1, 1)
    :monster("mon_bluejay", 5, 1, 1, 1)
    :monster("mon_cardinal", 5, 1, 1, 1)
    :monster("mon_sparrow", 10, 1, 1, 1)
    :monster("mon_chickadee", 5, 1, 1, 1)
    :monster("mon_waxwing", 5, 1, 1, 1)
    :monster("mon_robin", 10, 1, 1, 1)
    :monster("mon_pigeon", 10, 1, 1, 1)
    :monster("mon_deer", 10, 1, 1, 1)
    :monster("mon_duck", 10, 1, 1, 1)
    :group("GROUP_STRAY_CATS", 10, 1, 1, 1)
    :group("GROUP_STRAY_DOGS", 10, 1, 1, 1)
    :monster("mon_fox_gray", 10, 1, 1, 1)
    :monster("mon_fox_red", 10, 1, 1, 1)
    :monster("mon_goose_canadian", 10, 1, 1, 1)
    :monster("mon_groundhog", 10, 1, 1, 1)
    :group("GROUP_RABBIT_WILD", 10, 1, 1, 1)
    :monster("mon_squirrel_red", 10, 1, 1, 1)
    :monster("mon_weasel", 10, 1, 1, 1)
    :monster("mon_turkey", 10, 1, 1, 1)
    :monster("mon_raccoon", 10, 1, 1, 1)
    :monster("mon_opossum", 10, 1, 1, 1)
    :monster("mon_sewer_rat", 10, 1, 1, 1)
    :monster("mon_black_rat", 10, 1, 1, 1)
    :group("GROUP_COWS", 10, 1, 1, 1)
    :group("GROUP_HORSES", 10, 1, 1, 1)
    :group("GROUP_PIGS", 10, 1, 1, 1)
    :group("GROUP_SHEEPS", 10, 1, 1, 1)
    :monster("mon_goat", 10, 1, 1, 1)
    :monster("mon_lemming", 10, 1, 1, 1)
    :monster("mon_llama", 10, 1, 1, 1)
    :monster("mon_woodlouse", 10, 1, 1, 1)
    :monster("mon_cicada_nymph", 10, 1, 1, 1)
    :group("GROUP_FROGS_NATURAL", 10, 1, 1, 1))

-- 50-50% chance of zombies/bugs, no mixing enemies in the same spawn
content.add(content.MonsterGroup { id = "GROUP_BASEMENT_HOUSE", load_mode = "append" }
    :group("GROUP_HOUSE", 55, 1, 2, 6)
    :group("GROUP_FLY", 10, 1, 1, 5)
    :group("GROUP_ROACH", 5, 1, 1, 5)
    :group("GROUP_MOTH_FLY", 5, 1, 1, 3)
    :group("GROUP_SILVERFISH", 10, 1, 1, 4)
    :group("GROUP_SPIDER_BASEMENT", 5, 1, 1, 3)
    :group("GROUP_CENTIPEDE_HOUSE", 5, 1, 1, 4)
    :group("GROUP_MOTH", 5, 1, 1, 2)
    :group("GROUP_SLUG", 5, 1, 1, 4)
    :group("GROUP_CENTIPEDE", 5, 1, 1, 3))

content.add(content.MonsterGroup { id = "DUMP_ANIMALS", load_mode = "append" }
    :monster("mon_null", 378, 1, 1, 1)
    :group("GROUP_FLY", 100, 1, 1, 1)
    :group("GROUP_ROACH", 50, 1, 1, 1)
    :group("GROUP_MOTH_FLY", 50, 1, 1, 1)
    :monster("mon_crow", 75, 1, 1, 1)
    :monster("mon_raven", 75, 1, 1, 1)
    :monster("mon_pigeon", 100, 1, 1, 1, { conditions = { "DAWN", "DUSK", "DAY", "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_pigeon", 50, 1, 1, 1, { conditions = { "DAWN", "DUSK", "DAY", "WINTER" } })
    :monster("mon_fox_gray", 15, 1, 1, 1)
    :monster("mon_fox_red", 15, 1, 1, 1)
    :group("GROUP_STRAY_DOGS", 15, 2, 1, 1)
    :monster("mon_black_rat", 100, 1, 1, 1)
    :monster("mon_opossum", 15, 1, 1, 1)
    :monster("mon_raccoon", 15, 1, 1, 1)
    :group("GROUP_WORM", 20, 1, 1, 1)
    :monster("mon_wasp_small", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PEST", load_mode = "append" }
    :monster("mon_crow", 760, 1, 1, 1)
    :monster("mon_bat", 20, 0, 6, 12, { conditions = { "DAWN", "DUSK", "NIGHT", "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_SPIDER_WIDOW", 30, 1, 2, 4)
    :group("GROUP_ROACH", 50, 1, 1, 3)
    :group("GROUP_FLY", 50, 1, 1, 3)
    :group("GROUP_MOTH_FLY", 35, 1, 1, 3)
    :monster("mon_black_rat", 30, 1, 4, 8)
    :monster("mon_wasp_small", 50, 1, 2, 4)
    :monster("mon_zombie_child", 20, 1, 2, 6)
    :monster("mon_zombie", 20, 1, 2, 6)
    :monster("mon_zombie_rot", 10, 1, 1, 5)
    :monster("mon_beekeeper", 10, 1, 1, 5)
    :monster("mon_woodlouse", 30, 1, 4, 8))

content.add(content.MonsterGroup { id = "GROUP_SEWER", load_mode = "append" }
    :monster("mon_null", 370, 0, 1, 1)
    :monster("mon_zombie_crawler", 75, 0, 1, 1)
    :monster("mon_raccoon", 100, 0, 1, 1)
    :group("GROUP_BUGS_SUBTERRANEAN", 175, 1, 1, 1)
    :monster("mon_blob_sewer", 100, 1, 1, 1)
    :monster("mon_sewer_rat", 100, 0, 3, 12)
    :group("GROUP_STRAY_CATS", 20, 1, 1, 1)
    :group("GROUP_TADPOLES_SEWER", 5, 1, 1, 1)
    :group("GROUP_FROGS_SEWER", 5, 1, 1, 1)
    :group("GROUP_MUTAFROGS_SEWER", 5, 1, 1, 1))

-- for veterinarian
content.add(content.MonsterGroup { id = "GROUP_VETS", load_mode = "append" }
    :monster("mon_null", 948, 1, 1, 1)
    :monster("mon_zombie_dog", 15, 1, 1, 1)
    :monster("mon_dog_zombie_rot", 15, 3, 1, 1)
    :monster("mon_squirrel", 1, 0, 1, 1)
    :group("GROUP_STRAY_CATS", 10, 0, 1, 1)
    :group("GROUP_STRAY_DOGS", 10, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BUNKER", load_mode = "append" }
    :monster("mon_zombie_armored", 25, 20, 2, 6)
    :monster("mon_zombie_soldier", 600, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SCI", load_mode = "append" }
    :monster("mon_zombie_scientist", 1, 0, 1, 1))

-- For Compromised Shelter scenario.
content.add(content.MonsterGroup { id = "GROUP_INFESTED_SPAWN", load_mode = "append" }
    :monster("mon_zombie", 250, 2, 2, 3)
    :monster("mon_zombie_runner", 150, 3, 1, 1)
    :monster("mon_zombie_fat", 200, 1, 1, 1)
    :monster("mon_zombie_child", 200, 1, 1, 2)
    :monster("mon_zombie_paramilitary", 100, 2, 1, 1)
    :monster("mon_zombie_survivor", 200, 2, 1, 1, { starts = duration(120, "day") }))

-- For monsters, spawned by hallucinator effects.  Must represent the awful monsters the player want never see.  Put here every asshole you want.
content.add(content.MonsterGroup { id = "GROUP_YOUR_FEARS", load_mode = "append" }
    :monster("mon_wasp_small", 1, 1, 1, 1)
    :monster("mon_wasp", 1, 1, 1, 1)
    :monster("mon_secubot", 1, 1, 1, 1)
    :monster("mon_feral_militia", 1, 1, 1, 1)
    :monster("mon_plague_vector", 1, 1, 1, 1)
    :monster("mon_skittering_plague", 1, 1, 1, 1)
    :monster("mon_centipede_giant", 1, 1, 1, 1)
    :monster("mon_mosquito_mega", 1, 1, 1, 1)
    :monster("mon_spider_web_mega", 1, 1, 1, 1)
    :monster("mon_ant_soldier", 1, 1, 1, 1)
    :monster("mon_ant_soldier_mega", 1, 1, 1, 1)
    :monster("mon_mantis_mega", 1, 1, 1, 1)
    :monster("mon_lady_bug_giant", 1, 1, 1, 1)
    :monster("mon_mi_go_guard", 1, 1, 1, 1)
    :monster("mon_mi_go_scout", 1, 1, 1, 1)
    :monster("mon_shrapnel_swarm", 1, 1, 1, 1)
    :monster("mon_flaming_eye", 1, 1, 1, 1)
    :monster("mon_flying_polyp", 1, 1, 1, 1)
    :monster("mon_unseen_hunter", 1, 1, 1, 1)
    :monster("mon_hound_tindalos", 1, 1, 1, 1)
    :monster("mon_shoggoth", 1, 1, 1, 1)
    :monster("mon_vortex", 1, 1, 1, 1)
    :monster("mon_shifting_mass", 1, 1, 1, 1)
    :monster("mon_impossible_shape", 1, 1, 1, 1)
    :monster("mon_dog_zombie_hulk", 1, 1, 1, 1)
    :monster("mon_zombear_skeleton", 1, 1, 1, 1)
    :monster("mon_zoose_brute", 1, 1, 1, 1)
    :monster("mon_zombie_nullfield", 1, 1, 1, 1)
    :monster("mon_zombie_urchin", 1, 1, 1, 1)
    :monster("mon_devourer", 1, 1, 1, 1)
    :monster("mon_zombie_hulk", 1, 1, 1, 1)
    :monster("mon_zombie_necro", 1, 1, 1, 1)
    :monster("mon_zombie_necro_boomer", 1, 1, 1, 1)
    :monster("mon_skeleton_electric", 1, 1, 1, 1)
    :monster("mon_skeleton_hulk", 1, 1, 1, 1)
    :monster("mon_zombie_kevlar_2", 1, 1, 1, 1)
    :monster("mon_zombie_soldier_blackops_1", 1, 1, 1, 1)
    :monster("mon_zombie_survivor_elite", 1, 1, 1, 1)
    :monster("mon_zombear", 1, 1, 1, 1)
    :monster("mon_zoose", 1, 1, 1, 1)
    :monster("mon_zombull", 1, 1, 1, 1)
    :monster("mon_zeindeer", 1, 1, 1, 1, { event = "christmas" })
    :monster("mon_zombie_medical_regenerating", 1, 1, 1, 1)
    :monster("mon_zombie_brute_winged", 1, 1, 1, 1)
    :monster("mon_spawn_raptor", 1, 1, 1, 1)
    :monster("mon_spawn_raptor_shady", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BEEKEEPER", load_mode = "append" }
    :monster("mon_beekeeper", 1, 0, 1, 1))

-- Normally for the time until mutants start spawning we take the growth time of a mutant baby with default evolution rates. But because rattlesnakes follow the mutation logic of invertebrates, we assume there were some mildly oversized variations at the start of the Cataclysm already.
content.add(content.MonsterGroup { id = "GROUP_RATTLESNAKE", load_mode = "append" }
    :monster("mon_rattlesnake", 19, 1, 1, 1)
    :monster("mon_rattlesnake_big", 1, 1, 1, 1))

-- Special group with hardcoded reference in basecamp::hunting_results. Does not actually spawn anywhere, used solely to determine returns from camp hunting mission.
-- This group always has a chance of being the result, regardless of mission type.
content.add(content.MonsterGroup { id = "GROUP_CAMP_HUNTING", load_mode = "append" }
    :monster("mon_null", 20, 1, 1, 1, { conditions = { "WINTER" } })
    :monster("mon_null", 5, 1, 1, 1, { starts = duration(14, "day") })
    :monster("mon_null", 5, 1, 1, 1, { starts = duration(28, "day") })
    :monster("mon_null", 6, 1, 1, 1, { starts = duration(90, "day") })
    :monster("mon_null", 8, 1, 1, 1, { starts = duration(180, "day") })
    :monster("mon_null", 10, 1, 1, 1, { starts = duration(365, "day") })
    :group("GROUP_BEAVER", 10, 1, 1, 1)
    :monster("mon_fox_red", 10, 1, 1, 1)
    :monster("mon_fox_gray", 10, 1, 1, 1)
    :monster("mon_mink", 5, 1, 1, 1)
    :monster("mon_muskrat", 10, 1, 1, 1)
    :monster("mon_otter", 10, 1, 1, 1)
    :monster("mon_duck", 10, 1, 1, 1))

-- Special group with hardcoded reference in basecamp::hunting_results. Does not actually spawn anywhere, used solely to determine returns from camp hunting mission.
-- This group can only be picked from when the trapping mission is used, in addition to GROUP_CAMP_HUNTING.
content.add(content.MonsterGroup { id = "GROUP_CAMP_TRAPPING", load_mode = "append" }
    :monster("mon_null", 80, 1, 1, 1, { conditions = { "WINTER" } })
    :monster("mon_null", 10, 1, 1, 1, { starts = duration(14, "day") })
    :monster("mon_null", 15, 1, 1, 1, { starts = duration(28, "day") })
    :monster("mon_null", 25, 1, 1, 1, { starts = duration(90, "day") })
    :monster("mon_null", 35, 1, 1, 1, { starts = duration(180, "day") })
    :monster("mon_null", 60, 1, 1, 1, { starts = duration(365, "day") })
    :monster("mon_black_rat", 40, 1, 1, 1)
    :monster("mon_chipmunk", 30, 1, 1, 1)
    :monster("mon_groundhog", 30, 1, 1, 1)
    :group("GROUP_RABBIT_WILD", 30, 1, 1, 1)
    :monster("mon_lemming", 40, 1, 1, 1)
    :monster("mon_opossum", 10, 1, 1, 1)
    :monster("mon_squirrel", 20, 1, 1, 1)
    :monster("mon_weasel", 20, 1, 1, 1)
    :monster("mon_grouse", 10, 1, 1, 1)
    :monster("mon_pheasant", 10, 1, 1, 1)
    :monster("mon_turkey", 20, 1, 1, 1))

-- Special group with hardcoded reference in basecamp::hunting_results. Does not actually spawn anywhere, used solely to determine returns from camp hunting mission.
-- This group can only be picked from when the hunt large animals mission is used, in addition to GROUP_CAMP_HUNTING.
content.add(content.MonsterGroup { id = "GROUP_CAMP_HUNTING_LARGE", load_mode = "append" }
    :monster("mon_null", 10, 1, 1, 1, { conditions = { "WINTER" } })
    :monster("mon_null", 2, 1, 1, 1, { starts = duration(14, "day") })
    :monster("mon_null", 4, 1, 1, 1, { starts = duration(28, "day") })
    :monster("mon_null", 6, 1, 1, 1, { starts = duration(90, "day") })
    :monster("mon_null", 8, 1, 1, 1, { starts = duration(180, "day") })
    :monster("mon_null", 10, 1, 1, 1, { starts = duration(365, "day") })
    :monster("mon_grouse", 2, 1, 1, 1)
    :monster("mon_pheasant", 2, 1, 1, 1)
    :monster("mon_turkey", 10, 1, 1, 1)
    :monster("mon_bear", 1, 1, 1, 1)
    :monster("mon_cougar", 5, 1, 1, 1)
    :monster("mon_cow", 1, 1, 1, 1)
    :monster("mon_coyote", 15, 1, 1, 1)
    :monster("mon_deer", 2, 1, 1, 1)
    :monster("mon_moose", 1, 1, 1, 1)
    :monster("mon_pig", 1, 1, 1, 1))

-- Hardcoded reference in debug() (debug_menu.cpp). Used for debugging, duh.
content.add(content.MonsterGroup { id = "GROUP_DEBUG_EXACTLY_ONE", load_mode = "append" }
    :monster("mon_zombie", 1, 1, 1, 1))

-- The refugee center mission 1 enemy is chosen from here
content.add(content.MonsterGroup {
    id = "GROUP_REFUGEE_BOSS_ZOMBIE",
    load_mode = "append",
    default_monster = "mon_zombie_tough",
}
    :monster("mon_zombie_tough", 333, 1, 1, 1)
    :monster("mon_zombie_acidic", 333, 1, 1, 1)
    :monster("mon_zombie_electric", 333, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CROW_MUTANT", load_mode = "append" }
    :monster("mon_crow_mutant_small", 650, 1, 1, 1)
    :monster("mon_crow_mutant", 350, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CENTIPEDE_ADULT", load_mode = "append" }
    :monster("mon_centipede_giant", 9, 1, 1, 1)
    :monster("mon_centipede_mom", 1, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_CENTIPEDE_GIANT",
    load_mode = "append",
    default_monster = "mon_centipede_mom",
}
    :monster("mon_centipede_mom", 45, 1, 1, 1)
    :monster("mon_centipede_giant", 50, 1, 1, 1)
    :monster("mon_centipede_mega", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CENTIPEDE_MOM", load_mode = "append" }
    :monster("mon_centipede_giant", 65, 1, 1, 1)
    :monster("mon_centipede_mom", 25, 1, 1, 1)
    :monster("mon_centipede_mega", 10, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_MUTANT_EVOLVED",
    load_mode = "append",
    default_monster = "mon_mutant_evolved",
}
    :monster("mon_mutant_evolved", 1, 1, 1, 1)
    :monster("mon_mutant_antler", 450, 1, 1, 1)
    :monster("mon_mutant_mollusk", 220, 1, 1, 1)
    :monster("mon_mutant_arthropod", 180, 1, 1, 1)
    :monster("mon_mutant_evolved", 80, 1, 1, 1)
    :monster("mon_mutant_camouflaged", 60, 1, 1, 1)
    :monster("mon_mutant_alpha", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_RATKIN_EVOLVED", load_mode = "append" }
    :monster("mon_zap_rat", 300, 1, 1, 1)
    :monster("mon_tunnel_rat", 250, 1, 1, 1)
    :monster("mon_pack_rat", 200, 1, 1, 1)
    :monster("mon_teke_mouse", 150, 1, 1, 1)
    :monster("mon_mausketeer", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "REPRODUCTION_MUT_MOOSE", load_mode = "append" }
    :monster("mon_moose_calf", 19, 1, 1, 1)
    :monster("mon_tusked_moose_calf", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "REPRODUCTION_MUT_COYOTE", load_mode = "append" }
    :monster("mon_coyote_pup", 38, 1, 1, 1)
    :monster("mon_coyote_pup_mutant_shark", 1, 1, 1, 1)
    :monster("mon_coyote_pup_mutant_venom", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "REPRODUCTION_MUT_BEAVER", load_mode = "append" }
    :monster("mon_beaver_kit", 38, 1, 1, 1)
    :monster("mon_beaver_mutant_avian_kit", 1, 1, 1, 1)
    :monster("mon_beaver_mutant_huge_kit", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "REPRODUCTION_MUT_RATTLESNAKE", load_mode = "append" }
    :monster("mon_rattlesnake_s", 19, 1, 1, 1)
    :monster("mon_rattlesnake_big_s", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BREATHER", load_mode = "append" }
    :monster("mon_breather", 990, 1, 1, 1)
    :monster("mon_breather", 10, 2, 2, 4))

content.add(content.MonsterGroup { id = "GROUP_BREATHER_HUB", load_mode = "append" }
    :monster("mon_breather_hub", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CHURCH_BLANK", load_mode = "append" }
    :monster("mon_blank", 1, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DARK_WYRM", load_mode = "append" }
    :monster("mon_dark_wyrm", 1, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_NETHER_REALITY_TEAR_FIELD",
    load_mode = "append",
    default_monster = "mon_blank",
}
    :monster("mon_flying_polyp", 100, 0, 1, 1)
    :monster("mon_hunting_horror", 100, 0, 1, 1)
    :monster("mon_unseen_hunter", 100, 1, 1, 1, { starts = duration(30, "day") })
    :monster("mon_yugg", 100, 0, 1, 1)
    :monster("mon_star_vampire", 50, 0, 1, 1)
    :monster("mon_star_vampire_coiling", 50, 0, 1, 1)
    :monster("mon_gelatin", 100, 0, 1, 1)
    :monster("mon_flaming_eye", 100, 0, 1, 1)
    :monster("mon_kreck", 100, 0, 1, 1)
    :monster("mon_gracke", 100, 0, 1, 1)
    :monster("mon_blank", 100, 0, 1, 1)
    :monster("mon_nether_huntsman", 100, 0, 1, 1)
    :monster("mon_beetle_solar_starving_reverberation", 50, 0, 1, 1)
    :monster("mon_beetle_solar_reverberation", 100, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NETHER", load_mode = "append", default_monster = "mon_blank" }
    :monster("mon_blank", 135, 0, 1, 1)
    :monster("mon_flying_polyp", 25, 0, 1, 1)
    :monster("mon_hunting_horror", 240, 0, 1, 1)
    :monster("mon_unseen_hunter", 50, 0, 1, 1, { starts = duration(120, "day") })
    :monster("mon_yugg", 70, 0, 1, 1)
    :monster("mon_gelatin", 120, 0, 1, 1)
    :monster("mon_flaming_eye", 120, 0, 1, 1)
    :monster("mon_star_vampire", 7, 0, 1, 1)
    :monster("mon_star_vampire_coiling", 7, 0, 1, 1)
    :monster("mon_kreck", 210, 0, 1, 1)
    :monster("mon_gozu", 25, 0, 1, 1)
    :monster("mon_shoggoth", 5, 0, 1, 1)
    :monster("mon_nether_huntsman", 15, 0, 1, 1)
    :monster("mon_beetle_solar_reverberation", 100, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_NETHER_CAPTURED",
    load_mode = "append",
    default_monster = "mon_gracke",
}
    :monster("mon_gelatin", 250, 0, 1, 1)
    :monster("mon_mi_go", 250, 0, 1, 1)
    :monster("mon_mi_go_scout", 250, 0, 1, 1, { starts = duration(60, "day") })
    :monster("mon_kreck", 250, 0, 1, 1)
    :monster("mon_gracke", 250, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_NETHER_UNVIABLE",
    load_mode = "append",
    default_monster = "mon_nether_unviable_bug",
}
    :monster("mon_nether_unviable_bug", 4, 0, 2, 6)
    :monster("mon_nether_unviable_chunk", 3, 0, 2, 4)
    :monster("mon_nether_unviable_root", 3, 0, 2, 4)
    :monster("mon_nether_unviable_butterfly", 2, 0, 1, 1)
    :monster("mon_nether_unviable_stomper", 1, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_NETHER_PORTAL",
    load_mode = "append",
    default_monster = "mon_gracke",
}
    :monster("mon_gelatin", 200, 0, 1, 1)
    :monster("mon_flaming_eye", 200, 0, 1, 1)
    :monster("mon_kreck", 200, 0, 1, 1)
    :monster("mon_gracke", 200, 0, 1, 1)
    :monster("mon_unseen_hunter", 100, 0, 1, 1, { starts = duration(120, "day") })
    :monster("mon_blank", 200, 0, 1, 1)
    :group("GROUP_NETHER_UNVIABLE", 500, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPIRAL", load_mode = "append" }
    :monster("mon_human_snail", 740, 0, 1, 1)
    :monster("mon_twisted_body", 180, 0, 1, 1)
    :monster("mon_vortex", 80, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TINDALOS", load_mode = "append" }
    :monster("mon_hound_tindalos", 1, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_NETHER_CORPSE",
    load_mode = "append",
    default_monster = "mon_gracke",
}
    :monster("mon_gelatin", 100, 0, 1, 1)
    :monster("mon_kreck", 150, 0, 1, 1)
    :monster("mon_gracke", 150, 0, 1, 1)
    :monster("mon_unseen_hunter", 75, 0, 1, 1, { starts = duration(60, "day") })
    :monster("mon_blank", 100, 0, 1, 1)
    :monster("mon_star_vampire", 25, 0, 1, 1)
    :monster("mon_star_vampire_coiling", 25, 0, 1, 1)
    :monster("mon_shoggoth", 30, 0, 1, 1)
    :monster("mon_flying_polyp", 50, 0, 1, 1)
    :monster("mon_yugg", 50, 0, 1, 1)
    :monster("mon_nether_huntsman", 40, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_NETHER_CORPSE_PORTAL",
    load_mode = "append",
    default_monster = "mon_gracke",
}
    :monster("mon_gelatin", 70, 0, 1, 1)
    :monster("mon_kreck", 180, 0, 1, 1)
    :monster("mon_gracke", 50, 0, 1, 1)
    :monster("mon_unseen_hunter", 30, 0, 1, 1, { starts = duration(60, "day") })
    :monster("mon_blank", 50, 0, 1, 1)
    :monster("mon_star_vampire", 10, 0, 1, 1)
    :monster("mon_star_vampire_coiling", 10, 0, 1, 1)
    :monster("mon_shoggoth", 10, 0, 1, 1)
    :monster("mon_yugg", 5, 0, 1, 1)
    :monster("mon_nether_huntsman", 15, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NETHER_CORPSE_TENTACLES", load_mode = "append" }
    :monster("mon_hanging_roper", 200, 0, 1, 1)
    :monster("mon_nether_spearfisher", 150, 0, 1, 1)
    :monster("mon_carrion_grub", 100, 0, 2, 4)
    :monster("mon_nether_leech", 100, 3, 3, 5))

content.add(content.MonsterGroup { id = "GROUP_NETHER_CORPSE_BOWELS", load_mode = "append" }
    :monster("mon_nether_spearfisher", 150, 0, 1, 1)
    :monster("mon_nether_fish", 300, 0, 1, 3)
    :monster("mon_nether_leech", 100, 3, 3, 5))

content.add(content.MonsterGroup { id = "GROUP_PORTAL_REFLECTIONS", load_mode = "append" }
    :monster("mon_pale_reflection", 150, 0, 1, 1)
    :monster("mon_twisted_reflection", 300, 1, 1, 1)
    :monster("mon_dark_reflection", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_RESORT_DANCERS", load_mode = "append" }
    :monster("mon_zombie_resort_dancer", 775, 1, 1, 1)
    :monster("mon_zombie_resort_dancer", 100, 8, 6, 10)
    :monster("mon_zombie_resort_bouncer", 75, 4, 1, 3)
    :monster("mon_zombie", 50, 10, 2, 10))

content.add(content.MonsterGroup { id = "GROUP_RESORT_MIXED", load_mode = "append" }
    :monster("mon_zombie_resort_dancer", 10, 2, 1, 3)
    :monster("mon_zombie_resort_bouncer", 20, 2, 1, 1)
    :monster("mon_zombie_resort_staff", 40, 2, 1, 4)
    :monster("mon_zombie", 796, 1, 1, 1)
    :monster("mon_zombie", 100, 10, 2, 10)
    :monster("mon_zombie_resort_staff", 20, 2, 1, 3)
    :monster("mon_zombie_tough", 10, 2, 1, 3)
    :monster("mon_zombie_brute_shocker", 1, 35, 1, 1)
    :monster("mon_zombie_brute", 3, 20, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_RESORT_MIXED_STAFF", load_mode = "append" }
    :monster("mon_zombie", 890, 1, 1, 1)
    :monster("mon_zombie_resort_dancer", 20, 2, 1, 3)
    :monster("mon_zombie_resort_bouncer", 20, 2, 1, 1)
    :monster("mon_zombie_resort_staff", 70, 3, 1, 4))

content.add(content.MonsterGroup { id = "GROUP_RESORT_STAFF", load_mode = "append" }
    :monster("mon_zombie", 800, 1, 1, 1)
    :monster("mon_zombie_resort_staff", 200, 2, 1, 4))

content.add(content.MonsterGroup { id = "GROUP_RESORT_BOUNCER", load_mode = "append" }
    :monster("mon_zombie", 800, 1, 1, 1)
    :monster("mon_zombie_resort_bouncer", 200, 3, 1, 4))

content.add(content.MonsterGroup { id = "GROUP_ROBOT", load_mode = "append" }
    :monster("mon_tazer_hack", 515, 0, 1, 1)
    :monster("mon_flashbang_hack", 150, 0, 1, 1)
    :monster("mon_skitterbot", 220, 0, 1, 1)
    :monster("mon_secubot", 150, 0, 1, 1)
    :monster("mon_talon_m202a1", 75, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TURRET", load_mode = "append" }
    :monster("mon_turret_rifle", 950, 1, 1, 1, { ammo = { { id = "556", minimum = 100, maximum = 1600 } } })
    :monster("mon_turret_bmg", 50, 2, 1, 1, { ammo = { { id = "50bmg", minimum = 50, maximum = 400 } } }))

content.add(content.MonsterGroup { id = "GROUP_ROBOT_SECUBOT", load_mode = "append" }
    :monster("mon_secubot", 1, 0, 1, 1, { ammo = { { id = "556", minimum = 30 } } }))

content.add(content.MonsterGroup { id = "GROUP_TRIFFID", load_mode = "append", default_monster = "mon_triffid" }
    :monster("mon_triffid_sprig", 200, 0, 1, 3)
    :monster("mon_triffid_young", 300, 0, 2, 4)
    :monster("mon_fungal_fighter", 100, 1, 1, 1)
    :monster("mon_triffid", 80, 1, 1, 1)
    :monster("mon_triffid", 100, 2, 2, 3)
    :monster("mon_vinebeast", 160, 10, 1, 1)
    :monster("mon_triffid_queen", 60, 20, 1, 1)
    :monster("mon_biollante_sprig", 100, 0, 1, 2)
    :monster("mon_biollante_sprout", 200, 0, 1, 2)
    :monster("mon_biollante", 100, 2, 1, 3)
    :monster("mon_triffid_flower", 100, 4, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_OUTER",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :monster("mon_triffid_sprig", 80, 0, 1, 3)
    :monster("mon_triffid_young", 100, 0, 2, 4)
    :monster("mon_triffid", 205, 1, 1, 1)
    :monster("mon_triffid", 300, 2, 2, 3)
    :monster("mon_fungal_fighter", 160, 0, 1, 1)
    :monster("mon_vinebeast", 160, 10, 1, 1)
    :monster("mon_biollante_sprig", 50, 0, 3, 5)
    :monster("mon_biollante_sprout", 50, 0, 1, 3)
    :monster("mon_biollante", 50, 2, 1, 1)
    :monster("mon_triffid_flower", 25, 4, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_HEARTGUARDS",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :monster("mon_triffid", 280, 0, 1, 1)
    :monster("mon_triffid", 300, 0, 4, 6)
    :monster("mon_vinebeast", 260, 2, 1, 1)
    :monster("mon_triffid_queen", 160, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TRIFFID_HEART", load_mode = "append" }
    :monster("mon_triffid_heart", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CAVE", load_mode = "append", is_animal = true }
    :monster("mon_bat", 600, 1, 2, 5)
    :group("GROUP_BEARS", 100, 1, 1, 1)
    :group("GROUP_COUGARS", 100, 1, 1, 1)
    :group("GROUP_BUGS_SUBTERRANEAN", 175, 1, 1, 1)
    :monster("mon_mutant_experimental", 25, 1, 1, 1)
    :monster("mon_mole_cricket", 60, 1, 1, 1)
    :monster("mon_mole", 60, 1, 1, 1)
    :monster("mon_woodlouse", 60, 1, 1, 4)
    :monster("mon_stag_beetle_larva", 40, 1, 1, 1)
    :monster("mon_pickerel_frog", 200, 1, 2, 4))

content.add(content.MonsterGroup {
    id = "GROUP_FOREST",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :group("GROUP_WILDERNESS_FOREST_MAMMAL", 75, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL", 75, 1, 1, 1, {
        ends = duration(12, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL", 75, 1, 1, 1, {
        ends = duration(28, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL", 75, 1, 1, 1, {
        ends = duration(112, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL", 75, 1, 1, 1, {
        ends = duration(360, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", 75, 1, 1, 1, { conditions = { "WINTER" } })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", 75, 1, 1, 1, {
        ends = duration(12, "day"),
        conditions = { "WINTER" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", 75, 1, 1, 1, {
        ends = duration(28, "day"),
        conditions = { "WINTER" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", 75, 1, 1, 1, {
        ends = duration(112, "day"),
        conditions = { "WINTER" },
    })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", 75, 1, 1, 1, {
        ends = duration(360, "day"),
        conditions = { "WINTER" },
    })
    :group("GROUP_WILDERNESS_FOREST_BIRD", 300, 1, 1, 1)
    :group("GROUP_WILDERNESS_FOREST_INSECT_HARMLESS", 75, 1, 1, 1, {
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_INSECT", 75, 1, 1, 1, {
        starts = duration(12, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_INSECT", 75, 1, 1, 1, {
        starts = duration(28, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_INSECT", 75, 1, 1, 1, {
        starts = duration(112, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_INSECT", 75, 1, 1, 1, {
        starts = duration(360, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_ZOMBIE", 50, 1, 1, 1, {
        starts = duration(12, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_ZOMBIE", 50, 1, 1, 1, {
        starts = duration(28, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_ZOMBIE", 50, 1, 1, 1, {
        starts = duration(112, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_ZOMBIE", 50, 1, 1, 1, {
        starts = duration(360, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_FOREST_REPTILE", 10, 5, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_FROGS_FOREST", 10, 1, 1, 1)
    :group("GROUP_MUTAFROGS_FOREST", 8, 1, 1, 1, { starts = duration(28, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_FOREST_MAMMAL",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_bat", 10, 2, 3, 12)
    :group("GROUP_BEARS", 1, 10, 1, 3)
    :group("GROUP_PIGS", 1, 2, 1, 6)
    :group("GROUP_SHEEPS", 1, 2, 1, 4)
    :group("GROUP_STRAY_CATS", 10, 1, 1, 1)
    :group("GROUP_STRAY_CATS", 1, 1, 2, 8)
    :monster("mon_ferret", 1, 5, 1, 1)
    :monster("mon_shrew", 1, 5, 1, 1)
    :monster("mon_mole", 1, 5, 1, 1)
    :monster("mon_porcupine", 1, 5, 1, 1)
    :monster("mon_chipmunk", 30, 0, 1, 2)
    :group("GROUP_STRAY_DOGS", 6, 25, 1, 6)
    :group("GROUP_HORSES", 1, 15, 1, 4)
    :monster("mon_groundhog", 30, 5, 1, 6)
    :group("GROUP_RABBIT_WILD", 20, 1, 1, 5)
    :monster("mon_squirrel", 50, 0, 1, 2)
    :monster("mon_squirrel_red", 50, 0, 1, 2)
    :monster("mon_weasel", 5, 5, 1, 1)
    :monster("mon_raccoon", 8, 0, 1, 3)
    :monster("mon_opossum", 8, 0, 1, 3)
    :monster("mon_skunk", 6, 0, 1, 2)
    :monster("mon_black_rat", 10, 0, 1, 5)
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", 22, 1, 1, 1)
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_MUTANT", 1, 1, 1, 1, { starts = duration(56, "day") })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_MUTANT", 2, 1, 1, 1, { starts = duration(112, "day") })
    :group("GROUP_WILDERNESS_FOREST_MAMMAL_MUTANT", 4, 1, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_FOREST_MAMMAL_WINTER",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_bobcat", 7, 2, 1, 1)
    :group("GROUP_BOARS", 2, 2, 1, 4)
    :group("GROUP_COUGARS", 1, 3, 1, 1)
    :group("GROUP_DEERS", 4, 2, 1, 5)
    :group("GROUP_REINDEERS", 3, 3, 2, 6, { event = "christmas" })
    :monster("mon_fox_gray", 1, 0, 1, 1)
    :monster("mon_fox_red", 1, 0, 1, 1)
    :group("GROUP_COYOTE", 1, 2, 1, 6)
    :group("GROUP_MOOSE", 1, 3, 1, 3))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_FOREST_MAMMAL_MUTANT",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :group("GROUP_DEER_MUT_SPIDERS", 4, 2, 1, 3)
    :monster("mon_bear_mutant_3headed", 1, 10, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_FOREST_BIRD",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_bluejay", 2, 0, 1, 10)
    :monster("mon_crow", 5, 0, 1, 14)
    :monster("mon_crow_mutant_small", 2, 2, 1, 1, { starts = duration(56, "day") })
    :monster("mon_raven", 5, 0, 1, 14)
    :monster("mon_robin", 4, 0, 1, 14)
    :monster("mon_sparrow", 5, 0, 1, 15)
    :monster("mon_pigeon", 1, 0, 1, 3)
    :monster("mon_turkey", 6, 2, 1, 18)
    :monster("mon_duck", 4, 5, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_goose_canadian", 4, 5, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_hummingbird", 5, 0, 1, 3)
    :monster("mon_woodpecker", 5, 0, 1, 3)
    :monster("mon_guinea_fowl", 1, 1, 1, 3))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_FOREST_REPTILE",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :group("GROUP_RATTLESNAKE", 3, 1, 1, 1)
    :monster("mon_gartersnake", 10, 1, 1, 1)
    :monster("mon_wormsnake", 5, 1, 1, 1)
    :monster("mon_skink_fivelined", 2, 1, 1, 2))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_FOREST_INSECT_HARMLESS",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :group("GROUP_FLY", 2, 0, 1, 1)
    :group("GROUP_APHID", 3, 0, 1, 5)
    :group("GROUP_MOTH_FLY", 1, 0, 1, 4))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_FOREST_INSECT",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :group("GROUP_FLY", 2, 0, 1, 1)
    :group("GROUP_MOTH_FLY", 1, 0, 1, 4)
    :group("GROUP_SPIDER_JUMPING", 1, 0, 1, 1)
    :group("GROUP_SPIDER_WOLF", 1, 0, 1, 1)
    :group("GROUP_PRAYING_MANTIS", 2, 10, 1, 1)
    :group("GROUP_LADY_BUG", 5, 10, 1, 1)
    :group("GROUP_APHID", 3, 0, 1, 5)
    :group("GROUP_LOCUST", 3, 0, 3, 9)
    :group("GROUP_GRASSHOPPER", 3, 0, 1, 3)
    :monster("mon_antlion_giant", 1, 10, 1, 1)
    :group("GROUP_STAG_BEETLE", 2, 10, 1, 1)
    :monster("mon_woodlouse", 3, 3, 1, 1)
    :group("GROUP_BUTTERFLY", 2, 3, 1, 1)
    :group("GROUP_MOTH", 2, 3, 1, 1)
    :monster("mon_cicada", 1, 3, 1, 1)
    :group("GROUP_WORM", 1, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_FOREST_ZOMBIE",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_zeer", 4, 10, 1, 5)
    :monster("mon_zougar", 2, 10, 1, 1)
    :monster("mon_zombear", 1, 10, 1, 1)
    :monster("mon_zeindeer", 1, 15, 2, 5, { event = "christmas" })
    :monster("mon_zombie_dog", 1, 2, 1, 1)
    :monster("mon_zombie_horse", 1, 15, 1, 4)
    :monster("mon_zoose", 1, 10, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_RIVER",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :group("GROUP_BEAVER", 8, 10, 1, 3)
    :monster("mon_mink", 3, 20, 1, 2, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_muskrat", 8, 5, 1, 5, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_otter", 5, 5, 1, 8, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_duck", 20, 5, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_goose_canadian", 20, 5, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_zhark", 1, 25, 1, 3, { starts = duration(12, "day") })
    :monster("mon_zhark", 2, 25, 1, 3, { starts = duration(112, "day") })
    :monster("mon_fish_eel", 6, 3, 1, 3)
    :monster("mon_fish_bowfin", 6, 3, 1, 3)
    :monster("mon_fish_bullhead", 6, 3, 1, 3)
    :monster("mon_fish_goldfish", 6, 8, 1, 3)
    :monster("mon_fish_gar_longnose", 6, 8, 1, 3)
    :monster("mon_fish_burbot", 6, 8, 1, 3)
    :monster("mon_fish_sturgeon_lake", 6, 8, 1, 3)
    :monster("mon_fish_sturgeon_shortnose", 6, 8, 1, 3)
    :monster("mon_fish_pickerel_american", 6, 8, 1, 3)
    :monster("mon_fish_bullhead_yellow", 6, 8, 1, 3)
    :monster("mon_fish_whitefish_round", 6, 8, 1, 3)
    :monster("mon_fish_brown_trout", 6, 8, 1, 3)
    :monster("mon_fish_brook_trout", 6, 8, 1, 3)
    :monster("mon_fish_lake_trout", 6, 8, 1, 3)
    :monster("mon_fish_rainbow_trout", 6, 8, 1, 3)
    :monster("mon_fish_kokanee_salmon", 6, 8, 1, 3)
    :monster("mon_fish_walleye", 6, 8, 1, 3)
    :monster("mon_fish_pumpkinseed", 6, 8, 1, 3)
    :monster("mon_fish_redbreast", 6, 8, 1, 3)
    :monster("mon_fish_green_sunfish", 6, 8, 1, 3)
    :monster("mon_fish_rock_bass", 6, 8, 1, 3)
    :monster("mon_fish_calico_bass", 6, 8, 1, 3)
    :monster("mon_fish_warmouth", 6, 8, 1, 3)
    :monster("mon_fish_channel_catfish", 6, 8, 1, 3)
    :monster("mon_fish_white_catfish", 6, 8, 1, 3)
    :monster("mon_fish_muskellunge", 6, 8, 1, 3)
    :monster("mon_fish_white_sucker", 6, 8, 1, 3)
    :monster("mon_fish_grass_carp", 6, 8, 1, 3)
    :monster("mon_fish_fallfish", 6, 8, 1, 3)
    :monster("mon_fish_carp", 4, 10, 1, 3)
    :monster("mon_fish_pike", 6, 8, 1, 3)
    :monster("mon_fish_sbass", 10, 3, 1, 3)
    :monster("mon_fish_perch", 10, 3, 1, 3)
    :monster("mon_fish_salmon", 6, 8, 4, 6)
    :monster("mon_fish_lbass", 6, 3, 1, 3)
    :monster("mon_fish_pbass", 10, 3, 1, 3)
    :monster("mon_fish_bluegill", 10, 3, 1, 3)
    :monster("mon_fish_whitefish", 10, 2, 4, 6)
    :monster("mon_fish_pickerel", 6, 10, 1, 3)
    :monster("mon_dragonfly_naiad", 10, 2, 1, 1, { ends = duration(28, "day") })
    :monster("mon_dragonfly_naiad", 30, 3, 1, 3, { starts = duration(28, "day") })
    :group("GROUP_WATER_STRIDER", 15, 3, 2, 4)
    :group("GROUP_BIRD_DOMESTIC_WATERFOWL", 15, 5, 1, 1)
    :monster("mon_coot", 15, 5, 1, 6)
    :monster("mon_moorhen", 15, 5, 1, 6)
    :monster("mon_cormorant", 15, 5, 1, 4)
    :monster("mon_grebe", 15, 5, 1, 4)
    :monster("mon_diving_larva", 10, 2, 1, 1, { starts = duration(12, "day") })
    :monster("mon_diving_larva", 20, 3, 1, 3, { starts = duration(28, "day") })
    :monster("mon_water_scorpion_larva", 10, 2, 1, 1, { ends = duration(28, "day") })
    :monster("mon_water_scorpion_larva", 30, 3, 1, 3, { starts = duration(28, "day") })
    :monster("mon_diving_beetle_small", 4, 10, 1, 1)
    :monster("mon_water_scorpion", 4, 10, 1, 1)
    :group("GROUP_TADPOLES_RIVER", 25, 1, 1, 1, { conditions = { "SUMMER", "AUTUMN" } })
    :group("GROUP_FROGS_RIVER", 15, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_MUTAFROGS_RIVER", 8, 1, 1, 1, { starts = duration(28, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_OCEAN_SHORE",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_ocean_zhark", 2, 25, 1, 3)
    :monster("mon_fish_eel", 6, 3, 1, 3)
    :monster("mon_fish_pbass", 10, 3, 1, 3)
    :monster("mon_fish_bluefish", 6, 8, 1, 3)
    :monster("mon_fish_blackfish", 6, 8, 1, 3)
    :monster("mon_fish_porgy", 6, 8, 1, 3)
    :monster("mon_fish_flounder", 6, 8, 1, 3)
    :monster("mon_fish_mackerel", 6, 8, 1, 3)
    :monster("mon_fish_lobster", 6, 8, 1, 1)
    :monster("mon_fish_salmon", 6, 8, 4, 6))

content.add(content.MonsterGroup {
    id = "GROUP_OCEAN_DEEP",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_ocean_zhark", 4, 25, 1, 3)
    :monster("mon_fish_cod", 6, 8, 1, 3)
    :monster("mon_fish_haddock", 6, 8, 1, 3)
    :monster("mon_fish_bluefin_tuna", 6, 8, 1, 3)
    :monster("mon_fish_halibut", 6, 8, 1, 3)
    :monster("mon_fish_pollock", 6, 8, 1, 3)
    :monster("mon_fish_flounder", 6, 8, 1, 3)
    :monster("mon_fish_mackerel", 6, 8, 1, 3)
    :monster("mon_fish_salmon", 6, 8, 4, 6)
    :monster("mon_fish_pbass", 5, 3, 1, 3)
    :monster("mon_fish_bluefish", 3, 8, 1, 3)
    :monster("mon_fish_blackfish", 3, 8, 1, 3)
    :monster("mon_fish_lobster", 6, 8, 1, 1)
    :monster("mon_fish_porgy", 3, 8, 1, 3))

content.add(content.MonsterGroup {
    id = "GROUP_SWAMP",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :group("GROUP_WILDERNESS_SWAMP_INSECT", 100, 1, 1, 1, {
        starts = duration(12, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_SWAMP_INSECT", 100, 1, 1, 1, {
        starts = duration(28, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_SWAMP_INSECT", 100, 1, 1, 1, {
        starts = duration(112, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_WILDERNESS_SWAMP_INSECT", 100, 1, 1, 1, {
        starts = duration(360, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_lemming", 50, 1, 2, 7, {
        ends = duration(360, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :group("GROUP_SLUG", 15, 2, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_SNAIL", 15, 2, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_TADPOLES_SWAMP", 100, 1, 3, 6)
    :group("GROUP_FROGS_SWAMP", 100, 1, 1, 3)
    :group("GROUP_WILDERNESS_FRESHWATER_REPTILE", 85, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_MUTAFROGS_SWAMP", 75, 1, 1, 1, { starts = duration(28, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_FRESHWATER_REPTILE",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_turtle_painted", 15, 1, 1, 5)
    :monster("mon_turtle_snapping_common", 5, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_SWAMP_INSECT",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_firefly", 30, 1, 1, 4)
    :group("GROUP_MOTH_FLY", 1, 1, 1, 4)
    :group("GROUP_MOSQUITO", 50, 1, 1, 6)
    :monster("mon_dragonfly_giant", 35, 2, 1, 3)
    :group("GROUP_CENTIPEDE", 40, 2, 1, 1)
    :monster("mon_dermatik", 40, 2, 1, 1)
    :group("GROUP_CRAYFISH", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PARK_ANIMAL", load_mode = "append", is_animal = true }
    :monster("mon_crow", 50, 0, 1, 1)
    :monster("mon_crow_mutant_small", 20, 2, 1, 1, { starts = duration(56, "day") })
    :monster("mon_raven", 45, 0, 1, 1)
    :monster("mon_pigeon", 50, 0, 1, 3)
    :monster("mon_bluejay", 25, 0, 1, 1)
    :monster("mon_cardinal", 25, 0, 1, 1)
    :monster("mon_chickadee", 15, 0, 1, 1)
    :monster("mon_waxwing", 15, 0, 1, 1)
    :monster("mon_robin", 35, 0, 1, 1)
    :monster("mon_sparrow", 25, 0, 1, 1)
    :group("GROUP_STRAY_CATS", 50, 0, 1, 1)
    :monster("mon_chipmunk", 50, 0, 1, 1)
    :monster("mon_fox_red", 50, 0, 1, 1)
    :group("GROUP_RABBIT_WILD", 50, 0, 1, 1)
    :monster("mon_squirrel", 50, 0, 1, 1)
    :monster("mon_squirrel_red", 50, 0, 1, 1)
    :monster("mon_skunk", 2, 0, 1, 1)
    :group("GROUP_PRAYING_MANTIS", 5, 10, 1, 1)
    :group("GROUP_LADY_BUG", 8, 10, 1, 1)
    :group("GROUP_APHID", 20, 0, 1, 1)
    :group("GROUP_LOCUST", 15, 0, 3, 9)
    :group("GROUP_GRASSHOPPER", 30, 0, 1, 1)
    :monster("mon_antlion_giant", 5, 10, 1, 1)
    :monster("mon_hummingbird", 25, 0, 1, 1)
    :monster("mon_woodpecker", 25, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ROOF_ANIMAL", load_mode = "append", is_animal = true }
    :monster("mon_crow", 45, 0, 1, 1)
    :monster("mon_crow_mutant_small", 20, 2, 1, 1, { starts = duration(56, "day") })
    :monster("mon_raven", 45, 0, 1, 1)
    :monster("mon_robin", 25, 0, 1, 1)
    :monster("mon_sparrow", 25, 0, 1, 1)
    :monster("mon_pigeon", 40, 0, 1, 7)
    :group("GROUP_STRAY_CATS", 50, 0, 1, 1)
    :monster("mon_chipmunk", 50, 0, 1, 1)
    :monster("mon_squirrel", 50, 0, 1, 1)
    :monster("mon_squirrel_red", 50, 0, 1, 1)
    :monster("mon_turkey", 10, 1, 1, 1)
    :monster("mon_raccoon", 25, 0, 1, 3, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_opossum", 25, 0, 1, 3, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_bat", 20, 0, 6, 12, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_woodpecker", 25, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_POND_ANIMAL", load_mode = "append", is_animal = true }
    :group("GROUP_RABBIT_WILD", 50, 0, 1, 1)
    :monster("mon_squirrel_red", 50, 0, 1, 1)
    :monster("mon_squirrel", 50, 0, 1, 1)
    :group("GROUP_FROGS_ALL", 100, 0, 1, 1)
    :group("GROUP_WILDERNESS_FRESHWATER_REPTILE", 10, 0, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } }))

content.add(content.MonsterGroup { id = "GROUP_POND_BIRD", load_mode = "append", is_animal = true }
    :monster("mon_duck", 50, 0, 1, 1)
    :monster("mon_goose_canadian", 50, 0, 1, 1)
    :group("GROUP_BIRD_DOMESTIC_WATERFOWL", 50, 0, 1, 1)
    :monster("mon_coot", 50, 0, 1, 1)
    :monster("mon_moorhen", 50, 0, 1, 1)
    :monster("mon_cormorant", 50, 0, 1, 1)
    :monster("mon_grebe", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_POND_FISH", load_mode = "append", is_animal = true }
    :group("GROUP_POND_FISH_2", 200, 0, 1, 1)
    :group("GROUP_WATER_STRIDER", 30, 0, 3, 6)
    :monster("mon_water_scorpion_larva", 30, 0, 1, 1)
    :group("GROUP_TADPOLES_ALL", 75, 0, 3, 6))

content.add(content.MonsterGroup { id = "GROUP_POND_FISH_2", load_mode = "append", is_animal = true }
    :monster("mon_fish_bluegill", 50, 0, 1, 1)
    :monster("mon_fish_carp", 50, 0, 1, 1)
    :monster("mon_fish_goldfish", 50, 0, 1, 1)
    :monster("mon_fish_sbass", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BIRDFEEDER", load_mode = "append", is_animal = true }
    :monster("mon_bluejay", 50, 0, 1, 1)
    :monster("mon_cardinal", 50, 0, 1, 1)
    :monster("mon_robin", 50, 0, 1, 1)
    :monster("mon_sparrow", 50, 0, 1, 1)
    :monster("mon_chickadee", 50, 0, 1, 1)
    :monster("mon_waxwing", 50, 0, 1, 1)
    :monster("mon_squirrel", 25, 0, 1, 1)
    :monster("mon_hummingbird", 50, 0, 1, 1)
    :monster("mon_woodpecker", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_STREAM", load_mode = "append", is_animal = true }
    :group("GROUP_STREAM_SMALL", 30, 1, 1, 1)
    :group("GROUP_STREAM_BIRDS", 30, 1, 1, 1)
    :group("GROUP_STREAM_DOMESTIC", 2, 1, 1, 1)
    :group("GROUP_FROGS_ALL", 20, 1, 1, 1)
    :group("GROUP_WILDERNESS_FRESHWATER_REPTILE", 10, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } }))

content.add(content.MonsterGroup { id = "GROUP_STREAM_DOMESTIC", load_mode = "append", is_animal = true }
    :monster("mon_goat", 1, 1, 1, 4)
    :group("GROUP_BIRD_DOMESTIC", 10, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_STREAM_BIRDS", load_mode = "append", is_animal = true }
    :monster("mon_duck", 20, 1, 1, 4, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_coot", 15, 1, 2, 4)
    :monster("mon_moorhen", 15, 1, 2, 4)
    :monster("mon_cormorant", 15, 1, 2, 4)
    :monster("mon_grebe", 15, 1, 2, 4))

content.add(content.MonsterGroup { id = "GROUP_STREAM_SMALL", load_mode = "append", is_animal = true }
    :monster("mon_otter", 5, 5, 1, 8, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_mink", 3, 1, 1, 2, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_BEAVER", 8, 1, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_YRAX_SCIENCE_DRONES", load_mode = "append" }
    :monster("mon_yrax_sphenocorona", 100, 0, 1, 1)
    :monster("mon_yrax_trifacet", 100, 0, 1, 1))

-- No bionics or fungal
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_DOG_UPGRADE", load_mode = "append" }
    :monster("mon_dog_skeleton", 340, 5, 1, 1)
    :monster("mon_dog_zombie_brute", 330, 2, 1, 1)
    :monster("mon_zombie_dog_acidic", 330, 2, 1, 1)
    :monster("mon_dog_cuspated", 330, 2, 1, 1)
    :monster("mon_dog_howling", 330, 2, 1, 1))

-- No bionics or fungal
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_PIG_UPGRADE", load_mode = "append" }
    :monster("mon_zpig_brute", 45, 2, 1, 1)
    :monster("mon_zombie_pig_gas", 45, 2, 1, 1))

-- No bionics or fungal
content.add(content.MonsterGroup {
    id = "GROUP_ZOLF_UPGRADE",
    load_mode = "append",
    default_monster = "mon_wolf_skeleton",
}
    :monster("mon_wolf_skeleton", 500, 5, 1, 1)
    :monster("mon_dog_zombie_brute", 500, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_HORSE_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_horse_white", 250, 2, 1, 1)
    :monster("mon_zombie_horse_red", 250, 2, 1, 1)
    :monster("mon_zombie_horse_black", 250, 2, 1, 1)
    :monster("mon_zombie_horse_pale", 250, 2, 1, 1))

-- No bionics or fungal
content.add(content.MonsterGroup {
    id = "GROUP_ZOMBEAR_UPGRADE",
    load_mode = "append",
    default_monster = "mon_zombear_skeleton",
}
    :monster("mon_zombear_skeleton", 500, 5, 1, 1)
    :monster("mon_zombear_acidic", 500, 2, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_ZOOSE_UPGRADE",
    load_mode = "append",
    default_monster = "mon_zoose_brute",
}
    :monster("mon_zoose_brute", 500, 15, 1, 1)
    :monster("mon_zoose_thorny", 500, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOUGAR_UPGRADE", load_mode = "append" }
    :monster("mon_zougar_hunter", 600, 4, 1, 1)
    :monster("mon_zougar_shady", 400, 6, 1, 1))

-- All cocoon groups have a token mon_null spawn, increase its weight if they turn out to be too common
content.add(content.MonsterGroup { id = "GROUP_COCOON_TINY", load_mode = "append" }
    :monster("mon_null", 1, 1, 1, 1)
    :monster("mon_amalgamation_swarmer", 1, 1, 1, 1, { starts = duration(8, "day") }))

content.add(content.MonsterGroup { id = "GROUP_COCOON_SMALL", load_mode = "append" }
    :monster("mon_null", 1, 1, 1, 1)
    :group("GROUP_AMALGAMATION_SMALL", 1, 1, 1, 1, { starts = duration(8, "day") })
    :group("GROUP_AMALGAMATION_SMALL", 2, 1, 2, 2, { starts = duration(28, "day") })
    :group("GROUP_AMALGAMATION_SMALL", 2, 1, 3, 3, { starts = duration(112, "day") }))

content.add(content.MonsterGroup { id = "GROUP_COCOON_MED_1", load_mode = "append" }
    :monster("mon_null", 1, 1, 1, 1)
    :group("GROUP_COCOON_MED_2", 1, 1, 1, 1, { starts = duration(8, "day") })
    :group("GROUP_COCOON_MED_2", 1, 1, 2, 2, { starts = duration(56, "day") }))

content.add(content.MonsterGroup { id = "GROUP_COCOON_MED_2", load_mode = "append" }
    :monster("mon_null", 1, 1, 1, 1)
    :group("GROUP_AMALGAMATION_SMALL", 2, 1, 2, 2, { starts = duration(8, "day") })
    :group("GROUP_AMALGAMATION_MED", 2, 1, 3, 3, { starts = duration(56, "day") }))

-- TODO: big amalgamation line for this (and larger) groups
content.add(content.MonsterGroup { id = "GROUP_COCOON_LARGE", load_mode = "append" }
    :monster("mon_null", 1, 1, 1, 1)
    :group("GROUP_COCOON_MED_1", 1, 1, 1, 1, { starts = duration(8, "day") })
    :group("GROUP_COCOON_MED_1", 1, 1, 2, 2, { starts = duration(28, "day") })
    :group("GROUP_COCOON_MED_1", 1, 1, 3, 3, { starts = duration(112, "day") }))

content.add(content.MonsterGroup { id = "GROUP_AMALGAMATION_BREATHER_HUB_SPARSE", load_mode = "append" }
    :monster("mon_null", 9, 1, 1, 1)
    :monster("mon_amalgamation_breather_hub", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_AMALGAMATION_SMALL", load_mode = "append" }
    :monster("mon_amalgamation_swarmer", 120, 1, 1, 2)
    :monster("mon_amalgamation_spotter", 40, 1, 1, 1, { starts = duration(28, "day") })
    :monster("mon_amalgamation_corroder", 80, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_corroder", 120, 1, 1, 1, { starts = duration(224, "day") }))

content.add(content.MonsterGroup { id = "GROUP_AMALGAMATION_MED", load_mode = "append" }
    :monster("mon_amalgamation_jumper", 160, 1, 1, 2)
    :monster("mon_amalgamation_soldier", 40, 1, 1, 1, { starts = duration(28, "day") })
    :monster("mon_amalgamation_soldier", 80, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_zapper", 40, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_zapper", 40, 1, 1, 1, { starts = duration(224, "day") }))

-- Masters pick from here when upgrading; no dogs, bionics, or profession-types.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_tough", 110, 1, 1, 1)
    :monster("mon_zombie_grabber", 60, 1, 1, 1)
    :monster("mon_zombie_hunter", 60, 1, 1, 1)
    :monster("mon_skeleton", 80, 1, 1, 1)
    :monster("mon_zombie_smoker", 30, 1, 1, 1)
    :monster("mon_zombie_shady", 30, 1, 1, 1)
    :monster("mon_zombie_biter", 30, 1, 1, 1)
    :monster("mon_zombie_shrieker", 90, 1, 1, 1)
    :monster("mon_zombie_acidic", 80, 1, 1, 1)
    :monster("mon_zombie_necro", 8, 1, 1, 1)
    :monster("mon_boomer", 90, 1, 1, 1)
    :monster("mon_zombie_bruiser", 30, 1, 1, 1)
    :monster("mon_zombie_master", 3, 1, 1, 1)
    :monster("mon_zombie_summoner", 3, 1, 1, 1)
    :monster("mon_zombie_lashing", 60, 1, 1, 1)
    :monster("mon_zombie_ocular", 8, 1, 1, 1)
    :monster("mon_zombie_hollow", 5, 1, 1, 1)
    :monster("mon_zombie_thorny", 30, 1, 1, 1)
    :monster("mon_zombie_static", 50, 1, 1, 1)
    :monster("mon_zombie_winged", 60, 1, 1, 1)
    :monster("mon_zombie_regenerating", 10, 1, 1, 1)
    :monster("mon_zombie_pupa", 10, 1, 1, 1)
    :monster("mon_zombie_pupa_decoy", 10, 1, 1, 1))

-- decayed zombie upgrades
content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_DECAYED_UPGRADE",
    load_mode = "append",
    default_monster = "mon_zombie_rot",
}
    :monster("mon_zombie_rot", 250, 1, 1, 1)
    :monster("mon_zombie_rot_grabber", 350, 1, 1, 1)
    :monster("mon_zombie_rot_diseased", 200, 1, 1, 1)
    :monster("mon_devourer", 150, 1, 1, 1))

-- devourer zombie upgrades
content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_DEVOURER_UPGRADE",
    load_mode = "append",
    default_monster = "mon_devourer",
}
    :monster("mon_devourer", 500, 1, 1, 1)
    :monster("mon_devourer_hekatonkheire", 5, 1, 1, 1)
    :monster("mon_devourer_daitya", 5, 1, 1, 1))

-- crawling zombie upgrades
content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_CRAWLER_UPGRADE",
    load_mode = "append",
    default_monster = "mon_zombie_crawler",
}
    :monster("mon_zombie_crawler_pupa", 500, 1, 1, 1)
    :monster("mon_zombie_crawler_pupa_decoy", 500, 1, 1, 1))

-- No bionics or fungal
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_BRAINLESS_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_ears", 245, 1, 1, 1)
    :monster("mon_afs_headless_horror", 40, 1, 1, 1))

-- fat zombie upgrades
content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_FAT",
    load_mode = "append",
    default_monster = "mon_zombie_gasbag",
}
    :monster("mon_zombie_gasbag", 20, 1, 1, 1)
    :monster("mon_boomer", 480, 1, 1, 1)
    :monster("mon_zombie_pupa", 150, 1, 1, 1)
    :monster("mon_zombie_pupa_decoy", 150, 1, 1, 1)
    :monster("mon_zombie_necro_boomer", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_GRAB", load_mode = "append" }
    :monster("mon_zombie_grappler", 960, 0, 1, 1)
    :monster("mon_zombie_biter", 40, 2, 1, 1))

-- Masters pick from here when upgrading.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup {
    id = "GROUP_SOLDIER_UPGRADE",
    load_mode = "append",
    default_monster = "mon_zombie_kevlar_0",
}
    :monster("mon_zombie_soldier_blackops_1", 250, 1, 1, 1)
    :monster("mon_zombie_soldier_acid_1", 200, 1, 1, 1)
    :monster("mon_zombie_soldier_acid_2", 250, 1, 1, 1)
    :monster("mon_bestial_stalker", 250, 1, 1, 1)
    :monster("mon_zombie_kevlar_0", 200, 1, 1, 1)
    :monster("mon_boomer", 25, 1, 1, 1)
    :monster("mon_zombie_hollow", 25, 1, 1, 1)
    :monster("mon_skeleton", 50, 1, 1, 1))

-- Masters pick from here when upgrading.
content.add(content.MonsterGroup { id = "GROUP_FIREMAN_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_fireproof", 250, 1, 1, 1)
    :monster("mon_zombie_fireproof_brute", 250, 1, 1, 1)
    :monster("mon_zombie_fireproof_grappler", 250, 1, 1, 1))

-- Masters pick from here when upgrading.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup { id = "GROUP_MEDICAL_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_medical_brute", 200, 1, 1, 1)
    :monster("mon_zombie_medical_regenerating", 300, 1, 1, 1)
    :monster("mon_boomer", 50, 1, 1, 1)
    :monster("mon_zombie_hollow", 50, 1, 1, 1)
    :monster("mon_skeleton_medical", 200, 1, 1, 1)
    :monster("mon_zombie_medical_acidic", 100, 1, 1, 1)
    :monster("mon_zombie_medical_pupa", 50, 1, 1, 1)
    :monster("mon_zombie_pupa_medical_decoy", 50, 1, 1, 1))

-- crawling medical zombie upgrades
content.add(content.MonsterGroup {
    id = "GROUP_MEDICAL_CRAWLER_UPGRADE",
    load_mode = "append",
    default_monster = "mon_zombie_medical_pupa",
}
    :monster("mon_zombie_medical_pupa", 500, 1, 1, 1)
    :monster("mon_zombie_pupa_medical_decoy", 500, 1, 1, 1))

-- Brute upgrades.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_BRUTE",
    load_mode = "append",
    default_monster = "mon_zombie_brute",
}
    :monster("mon_zombie_brute_grappler", 240, 1, 1, 1)
    :monster("mon_zombie_brute_ninja", 175, 1, 1, 1)
    :monster("mon_brute_pupa", 100, 1, 1, 1)
    :monster("mon_brute_pupa_decoy", 100, 1, 1, 1)
    :monster("mon_zombie_hulk", 245, 1, 1, 1))

-- this is a sub-group of mutated zombie types that can only evolve from zombified human children.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup {
    id = "GROUP_CHILD_ZOMBIE_UPGRADE",
    load_mode = "append",
    default_monster = "mon_zombie_shriekling",
}
    :monster("mon_zombie_anklebiter", 50, 1, 1, 1)
    :monster("mon_zombie_sproglodyte", 100, 1, 1, 1)
    :monster("mon_zombie_shriekling", 300, 1, 1, 1)
    :monster("mon_zombie_creepy", 50, 1, 1, 1)
    :monster("mon_zombie_snotgobbler", 300, 1, 1, 1)
    :monster("mon_zombie_wretch", 100, 1, 1, 1)
    :monster("mon_zombie_waif", 200, 1, 1, 1))

-- this is a sub-group of pupating zombies that can only evolve from pupating zombie brutes.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup { id = "GROUP_BRUTE_PUPA", load_mode = "append" }
    :monster("mon_hulk_pupa", 500, 1, 1, 1)
    :monster("mon_hulk_pupa_decoy", 500, 1, 1, 1))

-- Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_ELECTRIC_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_nullfield", 400, 1, 1, 1)
    :monster("mon_zombie_brute_shocker", 300, 1, 1, 1)
    :monster("mon_skeleton_electric", 300, 1, 1, 1))

-- Raptor upgrades.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_RAPTOR_UPGRADES",
    load_mode = "append",
    default_monster = "mon_spawn_raptor",
}
    :monster("mon_spawn_raptor_shady", 333, 1, 1, 1)
    :monster("mon_spawn_raptor_electric", 333, 1, 1, 1)
    :monster("mon_spawn_raptor_unstable", 333, 1, 1, 1))

-- Shady upgrades.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_SHADY_UPGRADES",
    load_mode = "append",
    default_monster = "mon_zombie_shady",
}
    :monster("mon_zombie_brute_ninja", 500, 1, 1, 1)
    :monster("mon_zombie_pupa_decoy_shady", 250, 1, 1, 1)
    :monster("mon_zombie_pupa_shady", 250, 1, 1, 1)
    :monster("mon_zombie_grue", 250, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERROUS_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_shell", 250, 1, 1, 1)
    :monster("mon_zombie_urchin", 75, 2, 1, 1)
    :monster("mon_zombie_hammer_hands", 75, 2, 1, 1))

-- Boomer upgrades.  Note that 'freq' units are tenth of a percent, with default filling in the gap.
content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_BOOMER_UPGRADE",
    load_mode = "append",
    default_monster = "mon_boomer",
}
    :monster("mon_boomer_glutton", 245, 1, 1, 1)
    :monster("mon_boomer_huge", 310, 1, 1, 1)
    :monster("mon_zombie_necro_boomer", 25, 1, 1, 1)
    :monster("mon_zombie_gasbag", 310, 1, 1, 1)
    :monster("mon_boomer_claymore", 50, 1, 1, 1)
    :monster("mon_zombie_tear_gasbag", 50, 1, 1, 1)
    :monster("mon_zombie_relax_gasbag", 50, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SKELETON_UPGRADE", load_mode = "append" }
    :monster("mon_skeleton_slasher", 120, 2, 1, 1)
    :monster("mon_skeleton_brute", 160, 2, 1, 1)
    :monster("mon_skeleton_master", 60, 2, 1, 1)
    :monster("mon_skeleton_necro", 60, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_MINER_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_shady", 150, 1, 1, 1)
    :monster("mon_zombie_rust", 110, 1, 1, 1)
    :monster("mon_zombie_tough", 60, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PARK_SCENIC", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_zombie", 100, 1, 1, 1)
    :monster("mon_zombie_child", 100, 1, 1, 1)
    :monster("mon_zombie_tough", 75, 2, 1, 1)
    :monster("mon_zombie_fat", 50, 1, 1, 1)
    :monster("mon_zombie_rot", 50, 1, 1, 1)
    :monster("mon_zombie_runner", 20, 2, 1, 1)
    :group("GROUP_FERAL", 115, 1, 1, 1)
    :monster("mon_zombie_crawler", 25, 1, 1, 1)
    :monster("mon_zombie_brainless", 25, 1, 1, 1)
    :monster("mon_zombie_dog", 25, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_SURVIVOR_FOREST", load_mode = "append" }
    :monster("mon_zombie_survivor", 50, 1, 1, 1)
    :monster("mon_feral_sapien_spear", 50, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ROOF_ZOMBIE", load_mode = "append" }
    :monster("mon_null", 540, 1, 1, 1)
    :monster("mon_civilian_stationary", 20, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_zombiefighter", 5, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_panic", 30, 0, 1, 1, { ends = duration(20, "day") })
    :monster("mon_zombie", 50, 1, 2, 3)
    :monster("mon_zombie_tough", 75, 2, 1, 2)
    :monster("mon_zombie_fat", 50, 1, 2, 3)
    :monster("mon_zombie_rot", 100, 1, 2, 3)
    :monster("mon_zombie_crawler", 50, 1, 1, 1)
    :monster("mon_zombie_winged", 50, 5, 1, 1, { starts = duration(4, "day") })
    :monster("mon_zombie_brainless", 25, 1, 1, 1)
    :monster("mon_zombie_technician", 50, 5, 2, 4)
    :monster("mon_feral_human_tool", 25, 3, 1, 1)
    :monster("mon_beekeeper", 10, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PARK_PLAYGROUND", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_zombie_child", 295, 1, 1, 2)
    :monster("mon_zombie", 100, 2, 1, 1)
    :monster("mon_zombie_tough", 75, 3, 1, 1)
    :monster("mon_zombie_fat", 50, 2, 1, 1)
    :monster("mon_zombie_rot", 50, 2, 1, 1)
    :monster("mon_zombie_runner", 20, 3, 1, 1)
    :monster("mon_zombie_crawler", 25, 2, 1, 1)
    :monster("mon_zombie_brainless", 25, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PARK_DOG", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_zombie", 125, 1, 1, 1)
    :monster("mon_zombie_dog", 125, 1, 1, 2)
    :monster("mon_dog_zombie_cop", 25, 1, 1, 1)
    :monster("mon_dog_zombie_rot", 125, 1, 1, 2)
    :monster("mon_zombie_tough", 75, 2, 1, 1)
    :monster("mon_zombie_fat", 50, 1, 1, 1)
    :monster("mon_zombie_rot", 50, 1, 1, 2)
    :monster("mon_zombie_runner", 20, 2, 1, 1)
    :group("GROUP_FERAL", 55, 1, 1, 1)
    :monster("mon_zombie_crawler", 25, 1, 1, 1)
    :monster("mon_zombie_brainless", 25, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DOGS", load_mode = "append" }
    :monster("mon_zombie_dog", 135, 0, 5, 8)
    :monster("mon_dog_zombie_rot", 135, 1, 1, 4))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_SCORCHED", load_mode = "append" }
    :monster("mon_zombie_scorched", 985, 1, 1, 1)
    :monster("mon_zombie_child_scorched", 10, 1, 1, 1)
    :monster("mon_zombie_scorched_brute", 5, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_HORDE", load_mode = "append" }
    :group("GROUP_VANILLA_DORMANT", 250, 0, 1, 1)
    :monster("mon_zombie", 10, 7, 5, 20)
    :monster("mon_zombie", 10, 13, 15, 40)
    :monster("mon_zombie", 10, 20, 25, 60)
    :monster("mon_zombie", 4720, 0, 1, 1)
    :monster("mon_zombie_fat", 750, 2, 1, 1)
    :monster("mon_zombie_fat", 30, 7, 3, 5)
    :monster("mon_zombie_tough", 750, 3, 1, 1)
    :monster("mon_zombie_child", 750, 1, 1, 1)
    :monster("mon_zombie_rot", 500, 3, 1, 1)
    :monster("mon_zombie_crawler", 250, 3, 1, 1)
    :monster("mon_zombie_dog", 200, 2, 1, 1)
    :monster("mon_zombie_dog", 10, 4, 3, 5)
    :monster("mon_zombie_dog", 10, 16, 5, 8)
    :monster("mon_zombie_dog", 10, 24, 8, 12)
    :monster("mon_dog_zombie_cop", 50, 4, 1, 1)
    :monster("mon_dog_zombie_rot", 50, 5, 1, 1)
    :monster("mon_zombie_soldier", 100, 2, 1, 1)
    :monster("mon_zombie_cop", 200, 3, 1, 1)
    :monster("mon_zombie_fursuit", 1, 3, 1, 1)
    :monster("mon_zombie_swat", 100, 3, 1, 1)
    :monster("mon_zombie_medical", 100, 2, 1, 1)
    :monster("mon_zombie_hazmat", 100, 3, 1, 1)
    :monster("mon_zombie_fireman", 100, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 100, 5, 1, 1)
    :monster("mon_zombie_static", 100, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 10, 25, 1, 1)
    :monster("mon_zombie_survivor", 10, 25, 1, 1, { starts = duration(120, "day") })
    :monster("mon_zombie_survivor_elite", 10, 25, 1, 1, { starts = duration(240, "day") })
    :monster("mon_beekeeper", 10, 5, 1, 1)
    :monster("mon_zombie_technician", 10, 12, 1, 1)
    :monster("mon_zombie_runner", 200, 5, 1, 4)
    :group("GROUP_FERAL", 121, 1, 1, 1)
    :monster("mon_feral_soldier", 10, 5, 1, 1)
    :monster("mon_zombie_brainless", 650, 1, 1, 1)
    :group("GROUP_COCOON_TINY", 70, 2, 1, 1, { starts = duration(8, "day") })
    :group("GROUP_COCOON_TINY", 3, 4, 2, 3, { starts = duration(12, "day") })
    :group("GROUP_COCOON_TINY", 3, 16, 4, 6, { starts = duration(16, "day") })
    :group("GROUP_COCOON_TINY", 3, 24, 7, 9, { starts = duration(20, "day") })
    :group("GROUP_COCOON_SMALL", 40, 2, 1, 1, { starts = duration(28, "day") })
    :group("GROUP_COCOON_SMALL", 2, 4, 2, 3, { starts = duration(40, "day") })
    :group("GROUP_COCOON_MED_1", 30, 2, 1, 1, { starts = duration(52, "day") })
    :group("GROUP_COCOON_MED_1", 1, 4, 2, 3, { starts = duration(64, "day") })
    :group("GROUP_COCOON_MED_2", 30, 2, 1, 1, { starts = duration(80, "day") })
    :group("GROUP_COCOON_MED_2", 1, 4, 2, 3, { starts = duration(88, "day") })
    :group("GROUP_COCOON_LARGE", 2, 2, 1, 1, { starts = duration(96, "day") }))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 500, 0, 1, 1)
    :group("GROUP_VANILLA_DORMANT", 250, 0, 1, 1)
    :monster("mon_zombie", 10, 7, 5, 20)
    :monster("mon_zombie", 10, 13, 15, 40)
    :monster("mon_zombie", 10, 20, 25, 60)
    :monster("mon_zombie", 4720, 0, 1, 1)
    :monster("mon_zombie_fat", 750, 2, 1, 1)
    :monster("mon_zombie_fat", 30, 7, 3, 5)
    :monster("mon_zombie_tough", 750, 3, 1, 1)
    :monster("mon_zombie_child", 750, 1, 1, 1)
    :monster("mon_zombie_rot", 500, 3, 1, 1)
    :monster("mon_zombie_crawler", 250, 3, 1, 1)
    :monster("mon_zombie_dog", 200, 2, 1, 1)
    :monster("mon_zombie_dog", 10, 4, 3, 5)
    :monster("mon_zombie_dog", 10, 16, 5, 8)
    :monster("mon_zombie_dog", 10, 24, 8, 12)
    :monster("mon_dog_zombie_cop", 50, 4, 1, 1)
    :monster("mon_dog_zombie_rot", 50, 5, 1, 1)
    :monster("mon_zombie_soldier", 100, 2, 1, 1)
    :monster("mon_zombie_cop", 200, 3, 1, 1)
    :monster("mon_zombie_fursuit", 1, 3, 1, 1)
    :monster("mon_zombie_swat", 100, 3, 1, 1)
    :monster("mon_zombie_medical", 100, 2, 1, 1)
    :monster("mon_zombie_hazmat", 100, 3, 1, 1)
    :monster("mon_zombie_fireman", 100, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 100, 5, 1, 1)
    :monster("mon_zombie_static", 100, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 10, 25, 1, 1)
    :monster("mon_zombie_survivor", 10, 25, 1, 1, { starts = duration(120, "day") })
    :monster("mon_zombie_survivor_elite", 10, 25, 1, 1, { starts = duration(240, "day") })
    :monster("mon_beekeeper", 10, 5, 1, 1)
    :monster("mon_zombie_technician", 10, 12, 1, 1)
    :monster("mon_zombie_runner", 200, 5, 1, 4)
    :group("GROUP_FERAL", 121, 1, 1, 1)
    :monster("mon_feral_soldier", 10, 5, 1, 1)
    :monster("mon_zombie_brainless", 650, 1, 1, 1)
    :group("GROUP_COCOON_TINY", 70, 2, 1, 1, { starts = duration(8, "day") })
    :group("GROUP_COCOON_TINY", 3, 4, 2, 3, { starts = duration(12, "day") })
    :group("GROUP_COCOON_TINY", 3, 16, 4, 6, { starts = duration(16, "day") })
    :group("GROUP_COCOON_TINY", 3, 24, 7, 9, { starts = duration(20, "day") })
    :group("GROUP_COCOON_SMALL", 40, 2, 1, 1, { starts = duration(28, "day") })
    :group("GROUP_COCOON_SMALL", 2, 4, 2, 3, { starts = duration(40, "day") })
    :group("GROUP_COCOON_MED_1", 30, 2, 1, 1, { starts = duration(52, "day") })
    :group("GROUP_COCOON_MED_1", 1, 4, 2, 3, { starts = duration(64, "day") })
    :group("GROUP_COCOON_MED_2", 30, 2, 1, 1, { starts = duration(80, "day") })
    :group("GROUP_COCOON_MED_2", 1, 4, 2, 3, { starts = duration(88, "day") })
    :group("GROUP_COCOON_LARGE", 2, 2, 1, 1, { starts = duration(96, "day") }))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_GASSTATION", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_zombie", 1, 7, 5, 20)
    :monster("mon_zombie", 1, 13, 15, 40)
    :monster("mon_zombie", 1, 20, 25, 60)
    :monster("mon_zombie", 472, 0, 1, 1)
    :monster("mon_zombie_fat", 75, 2, 1, 1)
    :monster("mon_zombie_fat", 3, 7, 3, 5)
    :monster("mon_zombie_tough", 75, 3, 1, 1)
    :monster("mon_zombie_child", 75, 1, 1, 1)
    :monster("mon_zombie_rot", 50, 3, 1, 1)
    :monster("mon_zombie_crawler", 25, 3, 1, 1)
    :monster("mon_zombie_dog", 20, 2, 1, 1)
    :monster("mon_zombie_dog", 1, 4, 3, 5)
    :monster("mon_zombie_dog", 1, 16, 5, 8)
    :monster("mon_zombie_dog", 1, 24, 8, 12)
    :monster("mon_dog_zombie_cop", 5, 4, 1, 1)
    :monster("mon_dog_zombie_rot", 5, 5, 1, 1)
    :monster("mon_zombie_soldier", 10, 2, 1, 1)
    :monster("mon_zombie_cop", 20, 3, 1, 1)
    :monster("mon_zombie_swat", 10, 3, 1, 1)
    :monster("mon_zombie_medical", 10, 2, 1, 1)
    :monster("mon_zombie_hazmat", 10, 3, 1, 1)
    :monster("mon_zombie_fireman", 10, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 10, 5, 1, 1)
    :monster("mon_zombie_static", 10, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 1, 25, 1, 1)
    :monster("mon_zombie_survivor", 1, 25, 1, 1, { starts = duration(120, "day") })
    :monster("mon_zombie_survivor_elite", 1, 25, 1, 1, { starts = duration(240, "day") })
    :monster("mon_beekeeper", 1, 5, 1, 1)
    :monster("mon_zombie_technician", 1, 12, 1, 1)
    :group("GROUP_FERAL", 13, 1, 1, 1)
    :monster("mon_feral_soldier", 1, 5, 1, 1)
    :monster("mon_zombie_runner", 20, 5, 1, 4)
    :monster("mon_zombie_brainless", 65, 1, 1, 1))

-- nemesis squad
content.add(content.MonsterGroup { id = "GROUP_NEMESIS", load_mode = "append" }
    :monster("mon_zombie_nemesis", 1000, 0, 1, 1))

-- default ferals
content.add(content.MonsterGroup {
    id = "GROUP_FERAL",
    load_mode = "append",
    default_monster = "mon_feral_human_crowbar",
}
    :monster("mon_feral_cop", 10, 3, 1, 1)
    :monster("mon_feral_human_pipe", 40, 1, 2, 3)
    :monster("mon_feral_human_crowbar", 30, 1, 2, 3)
    :monster("mon_feral_human_axe", 10, 2, 1, 2)
    :monster("mon_feral_human_tool", 5, 5, 1, 1)
    :monster("mon_feral_sapien_spear", 5, 2, 1, 1))

-- only human zombies, used in the refugee center
content.add(content.MonsterGroup {
    id = "GROUP_VANILLA_ONLY_HUMANS",
    load_mode = "append",
    default_monster = "mon_zombie",
}
    :monster("mon_zombie", 264, 0, 1, 1)
    :monster("mon_zombie_fat", 266, 0, 1, 1)
    :monster("mon_zombie_child", 100, 0, 1, 1)
    :monster("mon_zombie_tough", 100, 0, 1, 1)
    :monster("mon_zombie_rot", 60, 0, 1, 1)
    :monster("mon_zombie_crawler", 30, 0, 1, 1)
    :monster("mon_zombie_brainless", 30, 0, 1, 1))

-- also no civilians, currently used in the sealed hazardous waste sarcophagus chamber
content.add(content.MonsterGroup {
    id = "GROUP_VANILLA_NO_FERAL",
    load_mode = "append",
    default_monster = "mon_zombie",
}
    :group("GROUP_VANILLA_ONLY_HUMANS", 850, 0, 1, 1)
    :monster("mon_zombie_dog", 50, 0, 1, 1))

-- only dormant zombies
-- These are generated in MonsterGenerator::generate_fake_pseudo_dormant_monster
content.add(content.MonsterGroup {
    id = "GROUP_VANILLA_DORMANT",
    load_mode = "append",
    default_monster = "mon_pseudo_dormant_zombie",
}
    :monster("mon_pseudo_dormant_zombie", 264, 0, 1, 1)
    :monster("pseudo_dormant_mon_zombie_fat", 266, 0, 1, 1, { resolve_after_finalization = true })
    :monster("pseudo_dormant_mon_zombie_child", 100, 0, 1, 1, { resolve_after_finalization = true })
    :monster("pseudo_dormant_mon_zombie_tough", 50, 0, 1, 1, { resolve_after_finalization = true })
    :monster("pseudo_dormant_mon_zombie_rot", 60, 0, 1, 1, { resolve_after_finalization = true })
    :monster("pseudo_dormant_mon_zombie_crawler", 30, 0, 1, 1, { resolve_after_finalization = true })
    :monster("pseudo_dormant_mon_zombie_brainless", 30, 0, 1, 1, { resolve_after_finalization = true }))

-- Normalized to 1300
content.add(content.MonsterGroup { id = "GROUP_VANILLA", load_mode = "append", default_monster = "mon_zombie" }
    :group("GROUP_VANILLA_NO_FERAL", 701, 0, 1, 1)
    :group("GROUP_CIVILIANS_STANDARD", 500, 0, 1, 1)
    :group("GROUP_FERAL", 99, 0, 1, 1)
    :group("GROUP_VANILLA_DORMANT", 100, 0, 1, 1))

-- +30% cops, much higher chance of paramilitary people
content.add(content.MonsterGroup { id = "GROUP_POLICE", load_mode = "append", default_monster = "mon_zombie" }
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_civilian_police", 20, 3, 1, 1, { ends = duration(20, "day") })
    :monster("mon_zombie", 223, 1, 1, 1)
    :monster("mon_zombie_fat", 100, 2, 1, 1)
    :monster("mon_zombie_child", 40, 1, 1, 1)
    :monster("mon_zombie_tough", 40, 3, 1, 1)
    :monster("mon_zombie_rot", 20, 2, 1, 1)
    :monster("mon_zombie_crawler", 10, 2, 1, 1)
    :monster("mon_zombie_cop", 280, 3, 1, 1)
    :monster("mon_feral_cop", 1, 4, 1, 1)
    :monster("mon_zombie_swat", 140, 3, 1, 1)
    :monster("mon_zombie_medical", 10, 2, 1, 1)
    :monster("mon_zombie_hazmat", 10, 2, 1, 1)
    :monster("mon_zombie_fireman", 20, 2, 1, 1)
    :monster("mon_dog_zombie_cop", 40, 2, 1, 1)
    :monster("mon_zombie_dog", 10, 2, 1, 1)
    :monster("mon_dog_zombie_rot", 5, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 20, 2, 1, 1)
    :monster("mon_zombie_static", 30, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 10, 25, 1, 1)
    :monster("mon_zombie_survivor", 1, 25, 1, 1, { starts = duration(120, "day") })
    :monster("mon_zombie_survivor_elite", 1, 25, 1, 1, { starts = duration(240, "day") }))

-- 100% cops, 0% civilians
content.add(content.MonsterGroup { id = "GROUP_POLICE_EXTRA", load_mode = "append", default_monster = "mon_zombie" }
    :monster("mon_zombie_cop", 280, 3, 1, 1)
    :monster("mon_zombie_swat", 140, 3, 1, 1)
    :monster("mon_dog_zombie_cop", 40, 2, 1, 1))

-- +15% child
content.add(content.MonsterGroup { id = "GROUP_HOUSE", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 200, 0, 1, 1)
    :group("GROUP_VANILLA_DORMANT", 130, 0, 1, 1)
    :monster("mon_zombie", 483, 1, 1, 1)
    :monster("mon_zombie_fat", 130, 2, 1, 1)
    :monster("mon_zombie_tough", 50, 3, 1, 1)
    :monster("mon_zombie_rot", 10, 2, 1, 1)
    :monster("mon_zombie_crawler", 5, 2, 1, 1)
    :monster("mon_zombie_child", 150, 2, 1, 1)
    :monster("mon_zombie_cop", 20, 2, 1, 1)
    :monster("mon_feral_cop", 1, 3, 1, 1)
    :monster("mon_zombie_swat", 10, 2, 1, 1)
    :monster("mon_zombie_medical", 10, 2, 1, 1)
    :monster("mon_zombie_hazmat", 10, 2, 1, 1)
    :monster("mon_zombie_fireman", 10, 2, 1, 1)
    :monster("mon_zombie_dog", 40, 2, 1, 1)
    :monster("mon_dog_zombie_cop", 10, 2, 1, 1)
    :monster("mon_dog_zombie_rot", 10, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 20, 2, 1, 1)
    :monster("mon_zombie_static", 30, 5, 1, 1)
    :monster("mon_feral_prepper_knife", 1, 2, 1, 1, { starts = duration(40, "day") })
    :monster("mon_feral_prepper_mace", 1, 2, 1, 1, { starts = duration(40, "day") })
    :monster("mon_feral_survivalist", 1, 2, 1, 1, { starts = duration(116, "day") })
    :monster("mon_zombie_paramilitary", 1, 25, 1, 1)
    :monster("mon_zombie_survivor", 1, 25, 1, 1, { starts = duration(120, "day") })
    :monster("mon_zombie_survivor_elite", 1, 25, 1, 1, { starts = duration(240, "day") })
    :group("GROUP_COCOON_TINY", 30, 2, 1, 1, { starts = duration(8, "day") })
    :group("GROUP_COCOON_TINY", 2, 4, 2, 3, { starts = duration(12, "day") })
    :group("GROUP_COCOON_TINY", 2, 16, 4, 6, { starts = duration(16, "day") })
    :group("GROUP_COCOON_TINY", 2, 24, 7, 9, { starts = duration(20, "day") })
    :group("GROUP_COCOON_SMALL", 20, 2, 1, 1, { starts = duration(28, "day") })
    :group("GROUP_COCOON_SMALL", 1, 4, 2, 3, { starts = duration(40, "day") })
    :group("GROUP_COCOON_MED_1", 10, 2, 1, 1, { starts = duration(52, "day") })
    :group("GROUP_COCOON_MED_1", 1, 4, 2, 3, { starts = duration(64, "day") })
    :group("GROUP_COCOON_MED_2", 5, 2, 1, 1, { starts = duration(80, "day") })
    :group("GROUP_COCOON_MED_2", 1, 4, 2, 3, { starts = duration(88, "day") })
    :group("GROUP_COCOON_LARGE", 1, 2, 1, 1, { starts = duration(96, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_PREPPER_HOUSE",
    load_mode = "append",
    default_monster = "mon_zombie",
}
    :monster("mon_zombie_milbase_personnel", 400, 0, 1, 1, { starts = duration(90, "day") })
    :monster("mon_zombie_tough", 180, 0, 1, 1)
    :monster("mon_civilian_stationary", 5, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_zombiefighter", 40, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_panic", 20, 0, 1, 1, { ends = duration(20, "day") })
    :monster("mon_feral_prepper_knife", 180, 5, 1, 1)
    :monster("mon_feral_prepper_mace", 180, 5, 1, 1)
    :monster("mon_feral_survivalist", 180, 10, 1, 1)
    :monster("mon_feral_militia", 150, 10, 1, 1, { starts = duration(90, "day") })
    :monster("mon_feral_jackboot", 110, 10, 1, 2, { starts = duration(90, "day") })
    :monster("mon_zombie_paramilitary", 400, 0, 1, 1)
    :monster("mon_zombie_survivor", 400, 0, 1, 1)
    :monster("mon_zombie_survivor_elite", 150, 10, 1, 1, { starts = duration(90, "day") }))

-- +13% fast
content.add(content.MonsterGroup { id = "GROUP_PHARM", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_zombie", 328, 1, 1, 1)
    :monster("mon_zombie_fat", 130, 2, 1, 1)
    :monster("mon_zombie_tough", 50, 3, 1, 1)
    :monster("mon_zombie_child", 50, 1, 1, 1)
    :monster("mon_zombie_rot", 10, 2, 1, 1)
    :monster("mon_zombie_crawler", 5, 2, 1, 1)
    :monster("mon_zombie_cop", 20, 2, 1, 1)
    :monster("mon_feral_cop", 1, 3, 1, 1)
    :monster("mon_zombie_swat", 10, 2, 1, 1)
    :monster("mon_zombie_medical", 10, 2, 1, 1)
    :monster("mon_zombie_hazmat", 10, 2, 1, 1)
    :monster("mon_zombie_fireman", 10, 2, 1, 1)
    :monster("mon_zombie_dog", 130, 2, 1, 1)
    :monster("mon_dog_zombie_cop", 15, 2, 1, 1)
    :monster("mon_dog_zombie_rot", 40, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 20, 2, 1, 1)
    :monster("mon_zombie_static", 30, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 1, 25, 1, 1)
    :monster("mon_zombie_survivor", 1, 25, 1, 1, { starts = duration(45, "day") })
    :monster("mon_zombie_survivor_elite", 1, 25, 1, 1, { starts = duration(90, "day") })
    :monster("mon_zombie_runner", 130, 3, 1, 1))

-- +15% electric
content.add(content.MonsterGroup { id = "GROUP_ELECTRO", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 50, 0, 1, 1)
    :monster("mon_zombie", 433, 1, 1, 1)
    :monster("mon_zombie_fat", 130, 2, 1, 1)
    :monster("mon_zombie_tough", 50, 3, 1, 1)
    :monster("mon_zombie_child", 50, 1, 1, 1)
    :monster("mon_zombie_rot", 10, 2, 1, 1)
    :monster("mon_zombie_crawler", 5, 2, 1, 1)
    :monster("mon_zombie_cop", 20, 2, 1, 1)
    :monster("mon_zombie_swat", 10, 2, 1, 1)
    :monster("mon_zombie_medical", 10, 2, 1, 1)
    :monster("mon_zombie_hazmat", 10, 2, 1, 1)
    :monster("mon_zombie_fireman", 10, 2, 1, 1)
    :monster("mon_zombie_dog", 40, 2, 1, 1)
    :monster("mon_dog_zombie_cop", 10, 2, 1, 1)
    :monster("mon_dog_zombie_rot", 10, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 20, 2, 1, 1)
    :monster("mon_zombie_static", 180, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 1, 25, 1, 1)
    :monster("mon_zombie_survivor", 1, 25, 1, 1, { starts = duration(45, "day") })
    :monster("mon_zombie_survivor_elite", 1, 25, 1, 1, { starts = duration(90, "day") }))

-- +15% fat
content.add(content.MonsterGroup { id = "GROUP_GROCERY", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 200, 0, 1, 1)
    :monster("mon_zombie", 433, 1, 1, 1)
    :monster("mon_zombie_fat", 280, 2, 1, 1)
    :monster("mon_zombie_tough", 50, 3, 1, 1)
    :monster("mon_zombie_child", 50, 1, 1, 1)
    :monster("mon_zombie_rot", 10, 2, 1, 1)
    :monster("mon_zombie_crawler", 5, 2, 1, 1)
    :monster("mon_zombie_cop", 20, 2, 1, 1)
    :monster("mon_feral_cop", 1, 3, 1, 1)
    :monster("mon_zombie_swat", 2, 2, 1, 1)
    :monster("mon_zombie_medical", 10, 2, 1, 1)
    :monster("mon_zombie_hazmat", 10, 2, 1, 1)
    :monster("mon_zombie_fireman", 10, 2, 1, 1)
    :monster("mon_zombie_dog", 40, 2, 1, 1)
    :monster("mon_dog_zombie_cop", 10, 2, 1, 1)
    :monster("mon_dog_zombie_rot", 10, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 20, 2, 1, 1)
    :monster("mon_zombie_static", 30, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 1, 25, 1, 1)
    :monster("mon_zombie_survivor", 1, 25, 1, 1, { starts = duration(45, "day") })
    :monster("mon_zombie_survivor_elite", 1, 25, 1, 1, { starts = duration(90, "day") }))

content.add(content.MonsterGroup { id = "GROUP_PUBLICWORKERS", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_zombie", 100, 5, 1, 1)
    :monster("mon_zombie_fat", 26, 5, 1, 1)
    :monster("mon_zombie_child", 10, 1, 1, 1)
    :monster("mon_zombie_tough", 654, 5, 1, 1)
    :monster("mon_zombie_rot", 6, 5, 1, 1)
    :monster("mon_zombie_crawler", 4, 5, 1, 1)
    :monster("mon_zombie_static", 200, 5, 1, 1))

-- 10% chance of a zombie
content.add(content.MonsterGroup { id = "GROUP_MAYBE_ZOMBIE", load_mode = "append" }
    :monster("mon_null", 700, 1, 1, 1)
    :group("GROUP_CIVILIANS_STANDARD", 200, 0, 1, 1)
    :monster("mon_zombie", 40, 0, 1, 5)
    :monster("mon_zombie_fat", 18, 2, 1, 5)
    :monster("mon_zombie_tough", 10, 3, 1, 5)
    :monster("mon_zombie_rot", 6, 2, 1, 5)
    :monster("mon_zombie_crawler", 5, 2, 1, 5)
    :monster("mon_zombie_dog", 10, 0, 1, 1)
    :monster("mon_zombie_child", 11, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_FAT_BASE", load_mode = "append" }
    :monster("mon_zombie_fat", 1, 2, 1, 1))

-- School monster spawns.
content.add(content.MonsterGroup { id = "GROUP_SCHOOL", load_mode = "append" }
    :monster("mon_null", 10, 1, 1, 1)
    :monster("mon_civilian_stationary", 20, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_zombiefighter", 10, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_panic", 50, 0, 1, 1, { ends = duration(20, "day") })
    :monster("mon_zombie_child", 50, 1, 1, 1)
    :monster("mon_zombie_fat", 10, 1, 1, 1)
    :monster("mon_zombie_tough", 10, 1, 1, 1)
    :monster("mon_zombie", 30, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SMALL_STATION", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 20, 0, 1, 1)
    :monster("mon_zombie_static", 55, 4, 1, 2)
    :monster("mon_zombie_technician", 870, 1, 1, 1)
    :monster("mon_feral_human_tool", 150, 1, 1, 1)
    :monster("mon_zombie_technician", 50, 5, 2, 4)
    :monster("mon_feral_human_tool", 25, 5, 1, 1)
    :monster("mon_zombie_tough", 25, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LARGE_STATION", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_zombie_static", 55, 4, 1, 2)
    :monster("mon_zombie_technician", 870, 1, 1, 1)
    :monster("mon_zombie_technician", 50, 5, 2, 4)
    :monster("mon_zombie_tough", 25, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_OIL_PLATFORM", load_mode = "append" }
    :monster("mon_zombie_technician", 60, 1, 1, 1)
    :monster("mon_zombie", 90, 1, 1, 1)
    :monster("mon_zombie_fireman", 10, 1, 1, 1)
    :monster("mon_zombie_medical", 10, 1, 1, 1)
    :monster("mon_zombie_fat", 20, 1, 1, 1)
    :monster("mon_zombie_crawler", 12, 1, 1, 1)
    :monster("mon_feral_human_pipe", 6, 2, 1, 1)
    :monster("mon_feral_human_crowbar", 6, 2, 1, 1)
    :monster("mon_feral_human_axe", 4, 4, 1, 1, { starts = duration(14, "day") })
    :monster("mon_zombie_brainless", 12, 1, 1, 1)
    :monster("mon_feral_human_tool", 6, 3, 1, 1)
    :monster("mon_feral_sailor_wrench", 6, 3, 1, 1, { starts = duration(14, "day") })
    :monster("mon_feral_sailor_mop", 6, 3, 1, 1)
    :monster("mon_feral_sailor_axe", 4, 4, 1, 1, { starts = duration(90, "day") })
    :monster("mon_feral_sailor_lug_wrench", 6, 3, 1, 1, { starts = duration(14, "day") })
    :monster("mon_zombie_static", 4, 2, 1, 1, { starts = duration(14, "day") })
    :monster("mon_zombie_swimmer_base", 40, 1, 1, 1)
    :monster("mon_zombie_survivor", 4, 5, 1, 1, { starts = duration(45, "day") })
    :monster("mon_zombie_survivor_elite", 2, 5, 1, 1, { starts = duration(90, "day") })
    :monster("mon_zombie_runner", 20, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CHURCH_ZOMBIE", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 200, 0, 1, 1)
    :monster("mon_zombie", 694, 1, 1, 1)
    :monster("mon_zombie", 1, 7, 5, 10)
    :monster("mon_zombie", 1, 13, 15, 20)
    :monster("mon_zombie", 1, 20, 25, 30)
    :monster("mon_zombie_fat", 75, 2, 1, 1)
    :monster("mon_zombie_fat", 3, 7, 3, 5)
    :monster("mon_zombie_tough", 75, 3, 1, 1)
    :monster("mon_zombie_child", 75, 1, 1, 1)
    :monster("mon_zombie_rot", 50, 3, 1, 1)
    :monster("mon_zombie_crawler", 25, 3, 1, 1)
    :monster("mon_feral_jackboot", 2, 7, 1, 3, { starts = duration(240, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_PRISON",
    load_mode = "append",
    default_monster = "mon_zombie_prisoner",
}
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_zombie_prisoner", 290, 1, 1, 1)
    :monster("mon_zombie_prisoner_fat", 350, 2, 1, 1)
    :monster("mon_zombie_prisoner_tough", 350, 2, 1, 1)
    :monster("mon_zombie_static", 10, 3, 1, 1)
    :monster("mon_feral_prisoner", 50, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_COP", load_mode = "append" }
    :monster("mon_zombie_cop", 900, 0, 1, 1)
    :monster("mon_feral_cop", 1, 1, 1, 1)
    :monster("mon_civilian_police", 20, 2, 1, 1)
    :monster("mon_zombie_swat", 20, 0, 1, 1)
    :monster("mon_dog_zombie_cop", 50, 2, 1, 2))

-- Flavor spawn group for scenario panic rooms for better story-telling.  Improved chance of dogs, fancy dogs, and (still) breathing people and children.
content.add(content.MonsterGroup { id = "GROUP_SCENARIO_PANICROOM", load_mode = "append" }
    :monster("mon_zombie_child", 180, 1, 1, 1)
    :group("GROUP_CIVILIANS_STANDARD", 200, 1, 1, 1)
    :group("GROUP_PET_DOGS", 100, 2, 1, 1)
    :monster("mon_dog_rottweiler", 100, 2, 1, 1)
    :monster("mon_dog_gpyrenees", 100, 2, 1, 1))

-- Same as above, but more lethal.
content.add(content.MonsterGroup { id = "GROUP_PANICROOM", load_mode = "append" }
    :monster("mon_zombie", 120, 2, 1, 1)
    :group("GROUP_SCENARIO_PANICROOM", 680, 1, 1, 1)
    :group("GROUP_FERAL", 150, 2, 1, 1)
    :monster("mon_zombie_dog", 20, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBULL_FROG_UPGRADE", load_mode = "append" }
    :monster("mon_zombullfrog", 100, 3, 1, 1)
    :monster("mon_frog_mummy", 25, 3, 1, 1)
    :monster("mon_frog_dad", 75, 3, 1, 1)
    :monster("mon_frog_mother", 25, 1, 1, 1)
    :monster("mon_frog_smoker_hulk", 15, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DEADTOAD_UPGRADE", load_mode = "append" }
    :monster("mon_toad_zombie", 25, 1, 1, 1)
    :monster("mon_toad_bloat", 50, 1, 1, 1)
    :monster("mon_frog_mummy", 25, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BLOAT_TOAD_UPGRADE", load_mode = "append" }
    :monster("mon_toad_bloat", 25, 1, 1, 1)
    :monster("mon_toad_wart", 25, 1, 1, 1)
    :monster("mon_toad_bone", 25, 1, 1, 1)
    :monster("mon_gastro_bufo", 25, 1, 1, 1)
    :monster("mon_frog_smoker_hulk", 15, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBTREEFROG_UPGRADE", load_mode = "append" }
    :monster("mon_zombtreefrog", 75, 3, 1, 1)
    :monster("mon_frog_shadow", 25, 3, 1, 1)
    :monster("mon_frog_husk", 25, 3, 1, 1))

-- Hospital monster spawns. Same as GROUP_ZOMBIE, but without Z-dogs + 20% medical
content.add(content.MonsterGroup { id = "GROUP_HOSPITAL", load_mode = "append" }
    :group("GROUP_VANILLA_DORMANT", 100, 3, 1, 1)
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_zombie", 1, 7, 5, 10)
    :monster("mon_zombie", 1, 13, 15, 20)
    :monster("mon_zombie", 1, 20, 25, 30)
    :group("GROUP_FERAL", 13, 1, 1, 1)
    :monster("mon_zombie", 75, 2, 1, 1)
    :monster("mon_zombie_medical", 200, 2, 1, 1)
    :monster("mon_zombie_fat", 75, 2, 1, 1)
    :monster("mon_zombie_fat", 3, 7, 3, 5)
    :monster("mon_zombie_tough", 75, 3, 1, 1)
    :monster("mon_zombie_child", 75, 1, 1, 1)
    :monster("mon_zombie_rot", 50, 3, 1, 1)
    :monster("mon_zombie_crawler", 25, 3, 1, 1)
    :monster("mon_zombie_soldier", 10, 2, 1, 1)
    :monster("mon_zombie_cop", 30, 3, 1, 1)
    :monster("mon_zombie_hazmat", 10, 3, 1, 1)
    :monster("mon_zombie_fireman", 10, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 10, 5, 1, 1)
    :monster("mon_zombie_static", 10, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 1, 25, 1, 1)
    :monster("mon_zombie_survivor", 1, 25, 1, 1, { starts = duration(120, "day") })
    :monster("mon_zombie_survivor_elite", 1, 25, 1, 1, { starts = duration(240, "day") })
    :monster("mon_beekeeper", 1, 5, 1, 1)
    :monster("mon_zombie_technician", 1, 12, 1, 1)
    :monster("mon_zombie_runner", 20, 5, 1, 4)
    :monster("mon_zombie_brainless", 55, 1, 1, 1))

-- Steel mill monster spawns.
content.add(content.MonsterGroup { id = "GROUP_STEEL_MILL", load_mode = "append" }
    :monster("mon_null", 486, 1, 1, 1)
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_zombie", 1, 7, 5, 10)
    :monster("mon_zombie", 1, 13, 15, 20)
    :monster("mon_zombie", 1, 20, 25, 30)
    :monster("mon_zombie", 50, 2, 1, 1)
    :group("GROUP_FERROUS", 170, 2, 1, 1)
    :monster("mon_zombie_fat", 45, 2, 1, 1)
    :monster("mon_zombie_fat", 3, 7, 3, 5)
    :monster("mon_zombie_tough", 50, 3, 1, 1)
    :monster("mon_zombie_rot", 25, 3, 1, 1)
    :monster("mon_zombie_crawler", 15, 3, 1, 1)
    :monster("mon_zombie_soldier", 5, 2, 1, 1)
    :monster("mon_zombie_hazmat", 5, 3, 1, 1)
    :monster("mon_zombie_static", 5, 5, 1, 1)
    :monster("mon_zombie_paramilitary", 1, 25, 1, 1)
    :monster("mon_zombie_survivor", 1, 25, 1, 1)
    :monster("mon_zombie_survivor_elite", 1, 25, 1, 1, { starts = duration(240, "day") })
    :monster("mon_zombie_technician", 1, 12, 1, 1)
    :monster("mon_feral_human_tool", 1, 5, 1, 1)
    :monster("mon_zombie_runner", 10, 5, 1, 4)
    :monster("mon_zombie_brainless", 25, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MALL", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :group("GROUP_FERAL", 150, 0, 1, 1)
    :monster("mon_zombie", 920, 1, 1, 1)
    :monster("mon_zombie_fat", 30, 1, 1, 1)
    :monster("mon_zombie_cop", 10, 2, 1, 1)
    :monster("mon_zombie_swat", 2, 2, 1, 1)
    :monster("mon_zombie_medical", 5, 2, 1, 1)
    :monster("mon_zombie_child", 20, 1, 1, 1)
    :monster("mon_zombie_crawler", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FIRE", load_mode = "append" }
    :monster("mon_zombie_fireman", 860, 1, 1, 1)
    :monster("mon_zombie_fireman", 100, 2, 3, 5)
    :monster("mon_zombie", 40, 1, 1, 1))

content.add(content.MonsterGroup { id = "FERAL_HUMANS", load_mode = "append" }
    :monster("mon_feral_prepper_knife", 14, 2, 1, 1, { starts = duration(116, "day") })
    :monster("mon_feral_prepper_mace", 14, 2, 1, 1, { starts = duration(116, "day") })
    :monster("mon_feral_survivalist", 14, 2, 1, 1, { starts = duration(116, "day") })
    :monster("mon_feral_militia", 14, 2, 1, 1, { starts = duration(240, "day") })
    :monster("mon_feral_human_pipe", 840, 1, 1, 1)
    :monster("mon_feral_human_pipe", 100, 1, 3, 8)
    :monster("mon_feral_human_crowbar", 40, 1, 2, 6)
    :monster("mon_feral_human_axe", 20, 2, 1, 4)
    :monster("mon_feral_sapien_spear", 14, 2, 1, 1)
    :monster("mon_feral_human_axe", 20, 2, 1, 4)
    :monster("mon_feral_jackboot", 10, 2, 1, 3, { starts = duration(240, "day") })
    :monster("mon_feral_jackboot", 14, 2, 1, 1, { starts = duration(116, "day") })
    :monster("mon_feral_human_tool", 10, 1, 1, 1)
    :monster("mon_feral_soldier", 5, 2, 1, 1))

content.add(content.MonsterGroup { id = "DUMP_ZOMBIES", load_mode = "append" }
    :monster("mon_zombie_technician", 150, 1, 1, 1)
    :monster("mon_zombie_fat", 150, 1, 1, 1)
    :monster("mon_zombie_wretched", 120, 1, 1, 1, { starts = duration(20, "day") })
    :monster("mon_zombie_crawler", 505, 1, 1, 1)
    :group("GROUP_FERROUS", 350, 2, 1, 1)
    :monster("mon_zombie_regenerating", 5, 1, 1, 1, { starts = duration(20, "day") })
    :monster("mon_zombie_survivor", 70, 1, 1, 1, { starts = duration(45, "day") })
    :monster("mon_zombie_survivor_elite", 10, 1, 1, 1, { starts = duration(90, "day") })
    :monster("mon_feral_jackboot", 5, 1, 1, 3, { starts = duration(40, "day") }))

content.add(content.MonsterGroup { id = "GROUP_PLAIN", load_mode = "append" }
    :monster("mon_zombie", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_HOTEL_POOL", load_mode = "append" }
    :monster("mon_zombie_swimmer", 100, 2, 1, 1, { starts = duration(20, "day") })
    :monster("mon_zombie_swimmer_base", 815, 1, 1, 1)
    :monster("mon_zombie_swimmer_base", 50, 10, 3, 8)
    :monster("mon_feral_swimmer_kickboard", 10, 1, 1, 1, {
        ends = duration(660, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_zombie_child", 35, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_HOTEL_GYM", load_mode = "append" }
    :monster("mon_zombie_fat", 977, 2, 1, 1)
    :monster("mon_zombie_fat", 15, 8, 2, 6)
    :monster("mon_zombie_tough", 8, 3, 1, 1))

-- Civilians that died/went crazy while trying to improve their bodies doing exercise. Lesser improved chance of brute/hulk.
content.add(content.MonsterGroup { id = "GROUP_SEARCH_FITNESS", load_mode = "append" }
    :monster("mon_zombie", 250, 1, 1, 1)
    :monster("mon_zombie_fat", 250, 1, 1, 1)
    :monster("mon_zombie_tough", 400, 1, 1, 1)
    :monster("mon_zombie_brute", 25, 2, 1, 1, { starts = duration(112, "day") })
    :monster("mon_zombie_hulk", 10, 3, 1, 1, { starts = duration(196, "day") })
    :monster("mon_zombie_runner", 350, 1, 1, 1)
    :monster("mon_feral_human_pipe", 60, 1, 1, 1)
    :monster("mon_feral_human_crowbar", 30, 1, 1, 1)
    :monster("mon_feral_human_axe", 5, 2, 1, 1))

-- Civilians that died/went crazy while in a dojo, no runner and less fat zombies. Improved chance of brute/wrestler/hulk.
content.add(content.MonsterGroup { id = "GROUP_DOJO", load_mode = "append" }
    :monster("mon_zombie", 350, 1, 1, 1)
    :monster("mon_zombie_tough", 450, 1, 1, 1)
    :monster("mon_civilian_zombiefighter", 50, 1, 1, 1)
    :monster("mon_zombie_brute", 50, 2, 1, 1, { starts = duration(84, "day") })
    :monster("mon_zombie_brute_grappler", 20, 3, 1, 1, { starts = duration(168, "day") })
    :monster("mon_zombie_brute_ninja", 5, 3, 1, 1, { starts = duration(168, "day") })
    :monster("mon_zombie_hulk", 20, 3, 1, 1, { starts = duration(168, "day") })
    :monster("mon_zombie_fat", 100, 1, 1, 1)
    :monster("mon_feral_human_pipe", 40, 1, 1, 1)
    :monster("mon_feral_human_crowbar", 20, 1, 1, 1)
    :monster("mon_feral_human_axe", 2, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_POOL", load_mode = "append", default_monster = "mon_zombie" }
    :monster("mon_zombie", 350, 1, 1, 1)
    :monster("mon_zombie_swimmer_base", 500, 2, 1, 1)
    :monster("mon_zombie_child", 150, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_POOL_NOKIDS", load_mode = "append" }
    :monster("mon_zombie_swimmer_base", 950, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 50, 10, 3, 8)
    :monster("mon_feral_swimmer_kickboard", 5, 2, 1, 1, {
        ends = duration(660, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

-- Zombies/ferals that could be found on a diving related place.
content.add(content.MonsterGroup { id = "GROUP_DIVING", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 20, 0, 1, 1)
    :monster("mon_zombie_swimmer_base", 100, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 50, 10, 3, 8)
    :monster("mon_zombie", 50, 3, 1, 1)
    :monster("mon_feral_swimmer_kickboard", 10, 2, 1, 1, {
        ends = duration(660, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    }))

-- Zombies/ferals that could be found on the beach/riverside.
content.add(content.MonsterGroup { id = "GROUP_BEACH", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 100, 0, 1, 1)
    :monster("mon_zombie_swimmer_base", 500, 2, 1, 1)
    :monster("mon_zombie_swimmer_base", 50, 10, 3, 8)
    :monster("mon_feral_swimmer_kickboard", 15, 2, 1, 1, {
        ends = duration(660, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_feral_swimmer_kickboard", 10, 4, 3, 5, {
        ends = duration(660, "day"),
        conditions = { "SPRING", "SUMMER", "AUTUMN" },
    })
    :monster("mon_zombie", 5, 3, 1, 1)
    :monster("mon_zombie", 1, 10, 2, 5)
    :monster("mon_zombie_child", 15, 1, 1, 1)
    :monster("mon_zombie_tough", 5, 5, 1, 1)
    :monster("mon_zombie_runner", 15, 5, 1, 1)
    :monster("mon_zombie_dog", 2, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_BOVINE", load_mode = "append" }
    :monster("mon_zow", 825, 1, 1, 1)
    :monster("mon_zow", 100, 1, 1, 3)
    :monster("mon_zombull", 75, 1, 1, 2, { starts = duration(30, "day") }))

content.add(content.MonsterGroup { id = "GROUP_HOSPITAL_INCUBATOR", load_mode = "append" }
    :monster("mon_zombie_anklebiter", 995, 10, 1, 1)
    :monster("mon_zombie_waif", 5, 7, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FORT", load_mode = "append" }
    :monster("mon_zombie_reenactor", 1, 1, 1, 1))

-- Civilians/Normal people that died, represents a lot of different common professions.  No children or dogs.
content.add(content.MonsterGroup { id = "GROUP_CIVILIAN", load_mode = "append" }
    :monster("mon_zombie", 500, 1, 1, 1)
    :monster("mon_zombie_fat", 250, 1, 1, 1)
    :monster("mon_zombie_tough", 100, 1, 1, 1)
    :monster("mon_zombie_runner", 50, 1, 1, 1)
    :monster("mon_zombie_brainless", 40, 1, 1, 1)
    :monster("mon_zombie_crawler", 40, 1, 1, 1)
    :monster("mon_zombie_rot", 20, 1, 1, 1)
    :monster("mon_feral_human_pipe", 60, 1, 1, 1)
    :monster("mon_feral_human_crowbar", 30, 1, 1, 1)
    :monster("mon_feral_human_axe", 5, 2, 1, 1))

-- Civilians/Normal people that died, represents a lot of different common professions.  No children, dogs or ferals.
content.add(content.MonsterGroup { id = "GROUP_CIVILIAN_NO_FERAL", load_mode = "append" }
    :monster("mon_zombie", 500, 1, 1, 1)
    :monster("mon_zombie_fat", 250, 1, 1, 1)
    :monster("mon_zombie_tough", 100, 1, 1, 1)
    :monster("mon_zombie_runner", 50, 1, 1, 1)
    :monster("mon_zombie_brainless", 40, 1, 1, 1)
    :monster("mon_zombie_crawler", 40, 1, 1, 1)
    :monster("mon_zombie_rot", 20, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERROUS", load_mode = "append" }
    :group("GROUP_CIVILIAN_NO_FERAL", 100, 1, 1, 1)
    :group("GROUP_CIVILIAN_NO_FERAL", 100, 1, 1, 1, { ends = duration(56, "day") })
    :group("GROUP_CIVILIAN_NO_FERAL", 200, 1, 1, 1, { ends = duration(112, "day") })
    :group("GROUP_CIVILIAN_NO_FERAL", 150, 1, 1, 1, { ends = duration(168, "day") })
    :group("GROUP_CIVILIAN_NO_FERAL", 150, 1, 1, 1, { ends = duration(224, "day") })
    :monster("mon_zombie_rust", 250, 1, 1, 1, { starts = duration(28, "day") })
    :monster("mon_zombie_rust", 250, 1, 1, 1, { starts = duration(84, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MINERS", load_mode = "append" }
    :monster("mon_zombie_miner", 1, 1, 1, 1))

-- Corpses buried at a mass grave. No ferals, and few animals.
content.add(content.MonsterGroup { id = "GROUP_MASS_GRAVE", load_mode = "append", default_monster = "mon_zombie" }
    :monster("mon_zombie", 132, 0, 1, 1)
    :monster("mon_pseudo_dormant_zombie", 132, 0, 1, 1)
    :monster("mon_zombie_fat", 266, 0, 1, 1)
    :monster("mon_zombie_child", 100, 0, 1, 1)
    :monster("mon_zombie_tough", 100, 0, 1, 1)
    :monster("mon_zombie_brainless", 30, 0, 1, 1)
    :monster("mon_zombie_swimmer_base", 10, 0, 1, 1)
    :monster("mon_zombie_dog", 10, 0, 1, 1)
    :monster("mon_dog_zombie_rot", 5, 0, 1, 1))

-- The things that appeared at a jabberwock mass grave.
content.add(content.MonsterGroup { id = "GROUP_MASS_GRAVE_JABBERWOCK", load_mode = "append" }
    :monster("mon_fleshy_shambler", 250, 0, 1, 1)
    :monster("mon_fleshy_shambler", 25, 1, 2, 4)
    :monster("mon_flesh_golem", 35, 2, 1, 1, { starts = duration(17, "day") })
    :monster("mon_jabberwock", 4, 3, 1, 1, { starts = duration(90, "day") }))

content.add(content.MonsterGroup { id = "GROUP_FOOTBALL", load_mode = "append" }
    :monster("mon_null", 300, 1, 1, 1)
    :monster("mon_zombie_tough", 150, 1, 1, 2)
    :monster("mon_zombie_runner", 150, 1, 1, 1)
    :monster("mon_zombie_fat", 100, 1, 4, 6))

content.add(content.MonsterGroup { id = "GROUP_NURSING_HOME", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 10, 0, 1, 1)
    :monster("mon_zombie", 12, 1, 1, 1)
    :monster("mon_zombie_fat", 5, 1, 1, 1)
    :monster("mon_zombie_rot", 40, 1, 3, 4)
    :monster("mon_zombie_crawler", 5, 1, 1, 1)
    :monster("mon_zombie_brainless", 5, 1, 1, 1)
    :monster("mon_zombie_medical", 20, 1, 1, 1)
    :monster("mon_boomer", 3, 1, 1, 1)
    :monster("mon_feral_human_pipe", 3, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NURSING_HOME_LAB", load_mode = "append" }
    :monster("mon_zombie_labsecurity", 15, 1, 1, 1)
    :monster("mon_zombie_technician", 10, 1, 1, 1)
    :monster("mon_zombie_scientist", 40, 1, 1, 1)
    :monster("mon_zombie_medical", 35, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_RETIREMENT_COMMUNITY", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 10, 0, 1, 1)
    :monster("mon_zombie", 34, 1, 1, 1)
    :monster("mon_zombie_fat", 14, 1, 1, 1)
    :monster("mon_zombie_runner", 6, 1, 1, 1)
    :monster("mon_zombie_rot", 10, 1, 2, 2)
    :monster("mon_zombie_crawler", 5, 1, 1, 1)
    :monster("mon_zombie_brainless", 5, 1, 1, 1)
    :monster("mon_zombie_child", 3, 1, 1, 1)
    :monster("mon_boomer", 5, 1, 1, 1)
    :monster("mon_zombie_dog", 5, 1, 1, 1)
    :monster("mon_feral_human_pipe", 5, 1, 1, 1)
    :monster("mon_feral_human_crowbar", 3, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NUCLEAR_PLANT_WORK_ZOMBIES", load_mode = "append" }
    :group("GROUP_CIVILIANS_STANDARD", 10, 0, 1, 1)
    :monster("mon_zombie_static", 5, 4, 1, 2)
    :monster("mon_zombie_technician", 100, 1, 1, 1)
    :monster("mon_feral_human_tool", 5, 1, 1, 1)
    :monster("mon_zombie_crawler", 15, 1, 1, 1)
    :monster("mon_zombie_technician", 50, 5, 2, 4)
    :monster("mon_feral_human_tool", 25, 5, 1, 1)
    :monster("mon_zombie_survivor", 30, 1, 1, 1, { starts = duration(45, "day") })
    :monster("mon_zombie_survivor_elite", 10, 1, 1, 1, { starts = duration(90, "day") })
    :monster("mon_zombie_hazmat", 75, 2, 1, 1)
    :monster("mon_zombie_fireman", 25, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CIVILIANS_UPGRADE", load_mode = "append" }
    :monster("mon_zombie", 264, 0, 1, 1)
    :monster("mon_zombie_fat", 266, 0, 1, 1)
    :monster("mon_zombie_tough", 100, 0, 1, 1)
    :monster("mon_zombie_crawler", 66, 0, 1, 1)
    :monster("mon_zombie_brainless", 30, 0, 1, 1)
    :group("GROUP_FERAL", 180, 0, 1, 1))

-- Used for deduplication only, so one does not have to repeat the same standard ratio over and over again
content.add(content.MonsterGroup { id = "GROUP_CIVILIANS_STANDARD", load_mode = "append" }
    :monster("mon_civilian_stationary", 30, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_zombiefighter", 16, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_zombiegunner", 12, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_police_rifle", 4, 3, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_police", 4, 3, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_parent", 20, 0, 1, 2, { ends = duration(8, "day") })
    :monster("mon_civilian_parent", 20, 0, 1, 1, { starts = duration(8, "day"), ends = duration(16, "day") })
    :monster("mon_civilian_panic", 40, 0, 1, 5, { ends = duration(8, "day") })
    :monster("mon_civilian_panic", 60, 0, 1, 2, { starts = duration(8, "day"), ends = duration(16, "day") })
    :monster("mon_civilian_panic", 60, 0, 1, 1, { starts = duration(16, "day"), ends = duration(24, "day") }))

content.add(content.MonsterGroup { id = "GROUP_AMALGAMATIONS_SPAWNED", load_mode = "append" }
    :monster("mon_amalgamation_swarmer", 20, 1, 1, 1)
    :monster("mon_amalgamation_corroder", 4, 1, 1, 1)
    :monster("mon_amalgamation_soldier", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_QUIVERFULL", load_mode = "append" }
    :monster("mon_null", 900, 1, 1, 1)
    :monster("mon_zombie_child", 100, 0, 6, 10))

content.add(content.MonsterGroup { id = "GROUP_LAST_STAND", load_mode = "append", default_monster = "mon_null" }
    :monster("mon_civilian_police", 1, 1, 1, 1, { ends = duration(20, "day") })
    :monster("mon_civilian_police_rifle", 1, 1, 1, 1, { ends = duration(20, "day") })
    :monster("mon_civilian_zombiefighter", 4, 1, 1, 1, { ends = duration(20, "day") })
    :monster("mon_civilian_zombiegunner", 4, 1, 1, 1, { ends = duration(20, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MIL_EXTRA", load_mode = "append" }
    :monster("mon_zombie_soldier", 76, 1, 1, 1)
    :monster("mon_feral_soldier", 20, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TOXIC_WASTE", load_mode = "append" }
    :monster("mon_sewer_rat", 60, 1, 1, 1)
    :monster("mon_blob", 30, 1, 1, 1)
    :monster("mon_zombie_hazmat", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TOXIC_WASTE_CORPSES", load_mode = "append" }
    :monster("mon_mutant_experimental", 60, 1, 1, 1)
    :monster("mon_mutant_antler", 30, 1, 1, 1)
    :monster("mon_mutant_arthropod", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MLAB_RUST_ZOMBIE", load_mode = "append" }
    :monster("mon_zombie_rust", 250, 1, 1, 1)
    :monster("mon_zombie_urchin", 20, 1, 1, 1, { starts = duration(28, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MLAB_ACID_ZOMBIE", load_mode = "append" }
    :monster("mon_zombie_acidic", 250, 1, 1, 1)
    :monster("mon_zombie_spitter", 20, 1, 1, 1, { starts = duration(28, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MLAB_PHASE_ZOMBIE", load_mode = "append" }
    :monster("mon_zombie_phase_skulker", 250, 1, 1, 1)
    :monster("mon_zombie_phase_shrike", 20, 1, 1, 1, { starts = duration(28, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MLAB_HUNTER_ZOMBIE", load_mode = "append" }
    :monster("mon_zombie_hunter", 250, 1, 1, 1)
    :monster("mon_zombie_predator", 20, 1, 1, 1, { starts = duration(28, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MLAB_RAPTOR_ZOMBIE", load_mode = "append" }
    :monster("mon_zombie_pupa", 50, 1, 1, 1)
    :monster("mon_zombie_pupa_decoy", 50, 1, 1, 1)
    :monster("mon_spawn_raptor", 50, 1, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_MLAB_MEDICAL_ZOMBIE", load_mode = "append" }
    :monster("mon_zombie_medical", 200, 1, 1, 1)
    :monster("mon_zombie_medical", 25, 1, 1, 3)
    :monster("mon_zombie_medical_brute", 30, 1, 1, 1, { starts = duration(56, "day") })
    :monster("mon_zombie_medical_regenerating", 50, 1, 1, 1)
    :monster("mon_skeleton_medical", 75, 1, 1, 1)
    :monster("mon_zombie_medical_acidic", 50, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MLAB_MUTANTS", load_mode = "append" }
    :monster("mon_mutant_experimental", 150, 1, 1, 1)
    :monster("mon_mutant_evolved", 150, 1, 1, 1)
    :monster("mon_mutant_camouflaged", 150, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MLAB_ROBOT", load_mode = "append" }
    :monster("mon_science_bot", 200, 1, 1, 1)
    :monster("mon_tazer_hack", 200, 1, 1, 1)
    :monster("mon_skitterbot", 150, 1, 1, 1)
    :monster("mon_skitterbot", 150, 1, 2, 3)
    :monster("mon_secubot", 50, 1, 1, 1)
    :monster("mon_talon_m202a1", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MLAB_LEECH_PLANT", load_mode = "append" }
    :monster("mon_leech_root_drone", 200, 1, 1, 1)
    :monster("mon_leech_root_runner", 200, 1, 1, 1)
    :monster("mon_leech_root_drone", 200, 1, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_MLAB_YRAX", load_mode = "append" }
    :monster("mon_yrax_trifacet", 200, 1, 1, 1)
    :monster("mon_yrax_triakis", 200, 1, 1, 1)
    :monster("mon_yrax_delta", 200, 1, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_MINER", load_mode = "append" }
    :monster("mon_zombie_miner", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_cellar_depths", load_mode = "append" }
    :monster("mon_inner_cabins_interstice_mutant_harmless", 12, 1, 1, 4)
    :monster("mon_inner_cabins_interstice_mutant_ignoring", 3, 1, 1, 4)
    :monster("mon_inner_cabins_interstice_mutant", 3, 1, 1, 1)
    :monster("mon_zombie_inner_cabins_revenant", 2, 1, 1, 1)
    :monster("mon_zombie_inner_cabins_grue", 1, 1, 1, 1))

-- Monsters in rooms in a Labyrinth.  Filler.
content.add(content.MonsterGroup { id = "GROUP_Labyrinth_Room", load_mode = "append" }
    :monster("mon_fleshborg_1_1", 600, 1, 1, 1)
    :monster("mon_fleshborg_launcher_1_1", 300, 1, 1, 1)
    :monster("mon_fleshborg_1_1", 100, 10, 1, 2)
    :monster("mon_fleshborg_1_1", 50, 20, 4, 6)
    :monster("mon_fleshborg_1_2", 50, 20, 1, 1)
    :monster("mon_nl_surgicalbot_1_1", 10, 0, 1, 1)
    :monster("mon_star_vampire", 1, 0, 1, 1))

-- Monsters walking the catwalks in a Labyrinth.  Filler.
content.add(content.MonsterGroup { id = "GROUP_Labyrinth_Hallmonitors", load_mode = "append" }
    :monster("mon_fleshborg_1_1", 600, 1, 1, 1)
    :monster("mon_fleshborg_launcher_1_1", 300, 1, 1, 1)
    :monster("mon_stiltwalker_1_1", 100, 1, 1, 1)
    :monster("mon_fleshborg_1_1", 100, 10, 1, 2)
    :monster("mon_flying_polyp", 2, 0, 1, 1)
    :monster("mon_hunting_horror", 2, 0, 1, 1)
    :monster("mon_unseen_hunter", 2, 0, 1, 1))

-- Monsters walking the catwalks in a Labyrinth.  Filler.
content.add(content.MonsterGroup { id = "GROUP_Labyrinth_Turret", load_mode = "append" }
    :monster("mon_labyrinth_turret_1_1", 1000, 1, 1, 1))

-- Monsters in the flooded labyrinth.
content.add(content.MonsterGroup { id = "GROUP_Labyrinth_Flooded", load_mode = "append" }
    :monster("mon_labyrinth_buoy_turret_1_1", 850, 1, 1, 1)
    :monster("mon_nl_turret_searchlight_1_1", 215, 1, 1, 1)
    :monster("mon_labyrinth_buoy_turret_1_2", 85, 1, 1, 1))

-- Monsters in rooms in a Labyrinth.  Filler.
content.add(content.MonsterGroup { id = "GROUP_Overgrown_Labyrinth_Room", load_mode = "append" }
    :monster("mon_plantborg_2_1", 500, 1, 1, 1)
    :monster("mon_plantborg_2_1", 100, 10, 2, 4)
    :monster("mon_plantborg_2_1", 50, 20, 6, 8)
    :monster("mon_plantborg_2_2", 50, 20, 1, 1)
    :monster("mon_star_vampire", 1, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_Overgrown_Labyrinth_Hallmonitors", load_mode = "append" }
    :monster("mon_plantborg_2_1", 850, 1, 1, 1)
    :monster("mon_plantborg_2_1", 200, 10, 2, 4)
    :monster("mon_plantborg_2_1", 50, 20, 6, 8)
    :monster("mon_vinewalker_2_1", 50, 1, 1, 1)
    :monster("mon_flying_polyp", 2, 0, 1, 1)
    :monster("mon_hunting_horror", 2, 0, 1, 1)
    :monster("mon_unseen_hunter", 2, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_Overgrown_Labyrinth_Turret", load_mode = "append" }
    :monster("mon_overgrown_labyrinth_turret_2_1", 1000, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_radiosphere_solar_beetle", load_mode = "append" }
    :monster("mon_beetle_solar_starving_reverberation", 300, 1, 1, 1)
    :monster("mon_beetle_solar_starving_reverberation", 200, 1, 1, 3)
    :monster("mon_beetle_solar_reverberation", 20, 1, 1, 1))
