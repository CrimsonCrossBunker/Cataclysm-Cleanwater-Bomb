local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_DWARF_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_tough", 110, 1, 1, 1)
    :monster("mon_zombie_grabber", 30, 1, 1, 1)
    :monster("mon_zombie_grappler", 120, 1, 1, 1)
    :monster("mon_zombie_hunter", 100, 1, 1, 1)
    :monster("mon_skeleton", 150, 1, 1, 1)
    :monster("mon_zombie_smoker", 50, 1, 1, 1)
    :monster("mon_zombie_gasbag", 30, 1, 1, 1)
    :monster("mon_zombie_acidic", 110, 1, 1, 1)
    :monster("mon_zombie_necro", 15, 1, 1, 1)
    :monster("mon_zombie_necro_boomer", 12, 1, 1, 1)
    :monster("mon_boomer", 90, 1, 1, 1)
    :monster("mon_zombie_brute", 25, 1, 1, 1)
    :monster("mon_zombie_bruiser", 35, 1, 1, 1)
    :monster("mon_zombie_master", 3, 1, 1, 1)
    :monster("mon_zombie_lashing", 40, 1, 1, 1)
    :monster("mon_zombie_ocular", 5, 1, 1, 1)
    :monster("mon_zombie_hollow", 3, 1, 1, 1)
    :monster("mon_zombie_thorny", 25, 1, 1, 1)
    :monster("mon_zombie_static", 50, 1, 1, 1)
    :monster("mon_zombie_regenerating", 15, 1, 1, 1)
    :monster("mon_zombie_pupa", 10, 1, 1, 1)
    :monster("mon_zombie_pupa_decoy", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_ELF_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_tough", 25, 1, 1, 1)
    :monster("mon_zombie_grabber", 25, 1, 1, 1)
    :monster("mon_zombie_grappler", 50, 1, 1, 1)
    :monster("mon_zombie_hunter", 60, 1, 1, 1)
    :monster("mon_zombie_runner", 165, 1, 1, 1)
    :monster("mon_zombie_smoker", 30, 1, 1, 1)
    :monster("mon_zombie_shady", 30, 1, 1, 1)
    :monster("mon_zombie_shrieker", 90, 1, 1, 1)
    :monster("mon_zombie_acidic", 80, 1, 1, 1)
    :monster("mon_zombie_necro", 25, 1, 1, 1)
    :monster("mon_zombie_brute", 15, 1, 1, 1)
    :monster("mon_zombie_bruiser", 15, 1, 1, 1)
    :monster("mon_zombie_master", 8, 1, 1, 1)
    :monster("mon_zombie_lashing", 75, 1, 1, 1)
    :monster("mon_zombie_ocular", 12, 1, 1, 1)
    :monster("mon_zombie_hollow", 10, 1, 1, 1)
    :monster("mon_zombie_thorny", 80, 1, 1, 1)
    :monster("mon_zombie_static", 40, 1, 1, 1)
    :monster("mon_zombie_winged", 50, 1, 1, 1)
    :monster("mon_zombie_regenerating", 10, 1, 1, 1)
    :monster("mon_zombie_pupa", 10, 1, 1, 1)
    :monster("mon_zombie_pupa_decoy", 10, 1, 1, 1))

-- Child-type zombies that evoke no guilt.
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_GOBLIN_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_anklebiter", 300, 1, 1, 1)
    :monster("mon_zombie_sproglodyte", 100, 1, 1, 1)
    :monster("mon_zombie_creepy", 300, 1, 1, 1)
    :monster("mon_zombie_snotgobbler", 300, 1, 1, 1)
    :monster("mon_zombie_wretch", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_RAVENFOLK_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_necro", 30, 1, 1, 1)
    :monster("mon_zombie_necro_boomer", 20, 1, 1, 1)
    :monster("mon_boomer", 200, 1, 1, 1)
    :monster("mon_zombie_master", 10, 1, 1, 1)
    :monster("mon_zombie_winged", 750, 1, 1, 1)
    :monster("mon_zombie_pupa", 200, 1, 1, 1)
    :monster("mon_zombie_pupa_decoy", 100, 1, 1, 1))

-- Heavily weighted toward the more feral variants but with some other options too.
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_LIZARDFOLK_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_hunter", 200, 1, 1, 1)
    :monster("mon_skeleton", 200, 1, 1, 1)
    :monster("mon_zombie_smoker", 30, 1, 1, 1)
    :monster("mon_zombie_shady", 30, 1, 1, 1)
    :monster("mon_zombie_biter", 500, 1, 1, 1)
    :monster("mon_zombie_shrieker", 90, 1, 1, 1)
    :monster("mon_zombie_necro", 15, 1, 1, 1)
    :monster("mon_zombie_necro_boomer", 12, 1, 1, 1)
    :monster("mon_boomer", 90, 1, 1, 1)
    :monster("mon_zombie_brute", 20, 1, 1, 1)
    :monster("mon_zombie_bruiser", 30, 1, 1, 1)
    :monster("mon_zombie_master", 3, 1, 1, 1)
    :monster("mon_zombie_lashing", 60, 1, 1, 1)
    :monster("mon_zombie_static", 50, 1, 1, 1)
    :monster("mon_zombie_winged", 60, 1, 1, 1)
    :monster("mon_zombie_regenerating", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_THAUMIC", load_mode = "append" }
    :monster("mon_zombie_leyspark", 500, 1, 1, 1)
    :monster("mon_zombie_levinbolt", 90, 1, 1, 1)
    :monster("mon_zombie_manastorm", 4, 1, 1, 1)
    :monster("mon_zombie_queller", 400, 1, 1, 1)
    :monster("mon_zombie_disruptor", 60, 1, 1, 1)
    :monster("mon_zombie_magebreaker", 2, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NULL", load_mode = "append", is_safe = true }
    :monster("mon_null", 920, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FOREST", load_mode = "append", is_animal = true }
    :monster("mon_null", 860, 1, 1, 1)
    :monster("mon_giant_heron_ridable", 15, 2, 2, 3, { starts = duration(7, "day") })
    :monster("mon_owlbear", 10, 10, 1, 1)
    :monster("mon_wisp", 3, 10, 1, 1, { conditions = { "NIGHT" } })
    :monster("mon_troll", 3, 10, 1, 1, { conditions = { "DAY" } })
    :monster("mon_wolf_goblin", 10, 4, 1, 1)
    :monster("mon_claygolem", 8, 3, 1, 1)
    :monster("mon_stonegolem", 4, 5, 1, 1)
    :monster("mon_yulecat", 2, 7, 1, 1, { event = "christmas" })
    :monster("mon_yulecat_cub", 1, 4, 1, 1, { event = "christmas" })
    :monster("mon_leprechaun", 5, 7, 1, 1)
    :monster("mon_loup_garou", 4, 5, 2, 4, { starts = duration(125, "day"), conditions = { "NIGHT" } })
    :monster("mon_were_zolf", 4, 5, 1, 2, { starts = duration(133, "day") })
    :monster("mon_winter_wolf", 4, 5, 1, 3, { starts = duration(125, "day") })
    :monster("mon_goblin_warrior", 10, 5, 2, 6, { conditions = { "NIGHT" } })
    :monster("mon_goblin_bugbear", 5, 5, 2, 4, { starts = duration(60, "day"), conditions = { "NIGHT" } })
    :monster("mon_irongolem", 2, 8, 1, 1)
    :monster("mon_demon_spiderling", 15, 5, 3, 7)
    :monster("mon_giant_heron_ridable_zombie", 7, 10, 1, 1, { starts = duration(21, "day") })
    :monster("mon_owlbear_zombie", 15, 1, 1, 1, { starts = duration(28, "day") })
    :monster("mon_owlbear_zombie_brute", 1, 15, 1, 1, { starts = duration(120, "day") })
    :monster("mon_troll_zombie", 1, 13, 1, 1, { starts = duration(21, "day") })
    :monster("mon_yulecat_zombie", 3, 12, 1, 1, { event = "christmas" })
    :monster("mon_yulecat_zombie_brute", 1, 25, 1, 1, { event = "christmas" })
    :monster("mon_ogre_spider", 5, 12, 1, 1, { starts = duration(240, "day") })
    :group("GROUP_FOREST_SPIRIT", 15, 3, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :group("GROUP_FOREST_SPIRIT", 20, 3, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN", "DAY" } })
    :group("GROUP_EARTH_SPIRIT", 5, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERAL_WIZARDS", load_mode = "append" }
    :monster("mon_feral_human_magician", 50, 2, 1, 1)
    :monster("mon_feral_animist", 50, 2, 1, 1)
    :monster("mon_feral_animist_enhanced", 5, 4, 1, 1)
    :monster("mon_feral_druid", 50, 2, 1, 1)
    :monster("mon_feral_druid_enhanced", 5, 4, 1, 1)
    :monster("mon_feral_earthshaper", 50, 2, 1, 1)
    :monster("mon_feral_earthshaper_enhanced", 5, 4, 1, 1)
    :monster("mon_feral_magus", 50, 2, 1, 1)
    :monster("mon_feral_magus_enhanced", 5, 4, 1, 1)
    :monster("mon_feral_stormshaper", 50, 2, 1, 1)
    :monster("mon_feral_stormshaper_enhanced", 5, 4, 1, 1)
    :monster("mon_feral_technomancer", 50, 2, 1, 1)
    :monster("mon_feral_technomancer_enhanced", 5, 4, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERAL_TECHNOMANCERS", load_mode = "append" }
    :monster("mon_feral_technomancer", 50, 2, 1, 1)
    :monster("mon_feral_technomancer_enhanced", 5, 4, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SWAMP", load_mode = "append", is_animal = true }
    :monster("mon_null", 940, 1, 1, 1)
    :monster("mon_black_pudding", 14, 1, 4, 6)
    :monster("mon_stirge", 7, 1, 2, 8)
    :monster("mon_catoblepas", 3, 10, 1, 1)
    :monster("mon_wisp", 5, 10, 1, 1, { conditions = { "NIGHT" } })
    :monster("mon_wisp", 1, 10, 1, 3, { conditions = { "NIGHT" } })
    :monster("mon_dragon_black_wyrmling", 2, 50, 1, 1)
    :monster("mon_dragon_black_young", 1, 65, 1, 1)
    :group("GROUP_OGRE", 4, 12, 1, 1)
    :monster("mon_troll_water", 3, 10, 1, 1, { conditions = { "DAY" } })
    :group("GROUP_FOREST_SPIRIT_SWAMP", 10, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } }))

content.add(content.MonsterGroup { id = "GROUP_CAVE", load_mode = "append", is_animal = true }
    :monster("mon_null", 782, 1, 1, 1)
    :monster("mon_owlbear", 100, 10, 2, 4)
    :monster("mon_shrieker", 10, 1, 1, 1)
    :monster("mon_lemure", 5, 2, 1, 4)
    :monster("mon_troll_stone", 3, 10, 1, 1, { conditions = { "DAY" } })
    :monster("mon_rust_monster", 5, 1, 1, 1)
    :monster("mon_owlbear_zombie", 40, 10, 2, 4, { starts = duration(60, "day") })
    :monster("mon_owlbear_zombie_brute", 5, 20, 1, 2, { starts = duration(120, "day") })
    :monster("mon_yulecat_zombie_brute", 5, 30, 1, 1, { starts = duration(120, "day"), event = "christmas" })
    :group("GROUP_EARTH_SPIRIT_CAVE", 50, 1, 1, 1))

-- same ratio as ferals
content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_FANTASY_SPECIES", load_mode = "append" }
    :monster("mon_zombie_dwarf", 40, 1, 1, 1)
    :monster("mon_zombie_elf", 40, 1, 1, 1)
    :monster("mon_zombie_goblin", 20, 1, 1, 1)
    :monster("mon_zombie_ravenfolk", 15, 1, 1, 1)
    :monster("mon_zombie_lizardfolk", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE", load_mode = "append" }
    :monster("mon_zombie_thaumic", 240, 1, 1, 1)
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 8000, 1, 1, 1)
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 10, 7, 5, 20)
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 10, 13, 15, 40)
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 10, 20, 25, 60))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_GASSTATION", load_mode = "append" }
    :monster("mon_zombie_thaumic", 15, 1, 1, 1)
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 472, 1, 1, 1)
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 1, 7, 5, 20)
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 1, 13, 15, 40)
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 1, 20, 25, 60))

content.add(content.MonsterGroup { id = "GROUP_MINERS", load_mode = "append" }
    :monster("mon_zombie_miner", 100, 1, 1, 1)
    :monster("mon_zombie_dwarf_miner", 40, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PARK_DOG", load_mode = "append" }
    :monster("mon_zombie_thaumic", 5, 1, 1, 1)
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 125, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PARK_PLAYGROUND", load_mode = "append" }
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PARK_SCENIC", load_mode = "append" }
    :monster("mon_zombie_thaumic", 7, 1, 1, 1)
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ROOF_ZOMBIE", load_mode = "append" }
    :monster("mon_zombie_thaumic", 5, 1, 1, 1)
    :group("GROUP_ZOMBIE_FANTASY_SPECIES", 100, 1, 2, 3))

content.add(content.MonsterGroup { id = "DUMP_ANIMALS", load_mode = "append" }
    :monster("mon_otyugh", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SEWER", load_mode = "append" }
    :monster("mon_otyugh", 15, 1, 1, 1)
    :monster("mon_rust_monster", 20, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SUBWAY", load_mode = "append" }
    :monster("mon_rust_monster", 35, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SUBWAY_CITY", load_mode = "append" }
    :monster("mon_rust_monster", 35, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB", load_mode = "append" }
    :monster("mon_zombie_thaumic", 50, 1, 1, 1)
    :monster("mon_feral_lab_magician", 25, 5, 1, 1)
    :monster("mon_feral_technomancer", 8, 5, 1, 1)
    :monster("mon_feral_technomancer_enhanced", 2, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB_SURFACE", load_mode = "append" }
    :monster("mon_zombie_thaumic", 50, 1, 1, 1)
    :monster("mon_feral_lab_magician", 25, 5, 1, 1)
    :monster("mon_feral_technomancer", 8, 5, 1, 1)
    :monster("mon_feral_technomancer_enhanced", 2, 10, 1, 1)
    :monster("mon_feral_radiation_mage", 2, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MICROLAB", load_mode = "append" }
    :monster("mon_zombie_thaumic", 50, 1, 1, 1)
    :monster("mon_feral_lab_magician", 2, 5, 1, 1)
    :monster("mon_feral_technomancer", 2, 5, 1, 1)
    :monster("mon_feral_technomancer_enhanced", 1, 50, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB_RESEARCHERS", load_mode = "append" }
    :monster("mon_feral_lab_magician", 20, 5, 1, 1)
    :monster("mon_feral_technomancer", 10, 5, 1, 1)
    :monster("mon_feral_technomancer_enhanced", 2, 10, 1, 1)
    :monster("mon_feral_radiation_mage", 1, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_POLYMORPH_SHADOW", load_mode = "append", is_animal = true }
    :monster("mon_magi_shadow", 990, 1, 1, 1)
    :monster("mon_shadow_snake", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DOMESTIC", load_mode = "append", is_animal = true }
    :monster("mon_dog", 980, 1, 1, 1)
    :monster("mon_nightmare_sheep", 20, 25, 1, 12))

content.add(content.MonsterGroup { id = "GROUP_WORM", load_mode = "append", is_animal = true }
    :monster("mon_worm_small", 500, 1, 1, 1)
    :monster("mon_worm", 445, 1, 1, 1)
    :monster("mon_ankheg", 50, 6, 1, 1)
    :monster("mon_bulette", 5, 40, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BLACKDRAGON_LAIR_1", load_mode = "append", is_animal = true }
    :monster("mon_null", 880, 1, 1, 1)
    :monster("mon_black_pudding", 14, 1, 4, 6)
    :monster("mon_wisp", 5, 10, 1, 1, { conditions = { "NIGHT" } })
    :monster("mon_wisp", 1, 10, 1, 3, { conditions = { "NIGHT" } })
    :monster("mon_bat", 5, 5, 6, 10)
    :monster("mon_rattlesnake", 5, 1, 1, 1)
    :monster("mon_rattlesnake_giant", 5, 2, 1, 1)
    :monster("mon_black_rat", 10, 1, 1, 1)
    :monster("mon_dragon_black_wyrmling", 2, 50, 1, 1)
    :monster("mon_lizardfolk_warrior", 20, 1, 2, 4)
    :monster("mon_lizardfolk_hunter", 30, 4, 1, 2)
    :monster("mon_crocodile", 20, 10, 1, 4)
    :monster("mon_lizardfolk_shaman", 2, 30, 1, 1)
    :monster("mon_lizardfolk_chieftan", 1, 50, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BLACKDRAGON_LAIR_2", load_mode = "append", is_animal = true }
    :monster("mon_black_pudding", 14, 1, 4, 6)
    :monster("mon_dragon_black_wyrmling", 2, 50, 1, 1)
    :monster("mon_dragon_black_young", 1, 65, 1, 1)
    :monster("mon_lizardfolk_warrior", 883, 1, 1, 1)
    :monster("mon_lizardfolk_warrior", 20, 1, 2, 4)
    :monster("mon_lizardfolk_hunter", 30, 4, 1, 2)
    :monster("mon_crocodile", 30, 30, 1, 4)
    :monster("mon_lizardfolk_shaman", 10, 30, 1, 1)
    :monster("mon_lizardfolk_chieftan", 10, 50, 1, 1))

-- A lizard humanoid race, they are allies and servants of the black dragons.
content.add(content.MonsterGroup { id = "GROUP_LIZARDFOLK", load_mode = "append", is_animal = true }
    :monster("mon_lizardfolk_warrior", 900, 1, 1, 1)
    :monster("mon_lizardfolk_warrior", 20, 1, 2, 4)
    :monster("mon_lizardfolk_hunter", 30, 4, 1, 2)
    :monster("mon_crocodile", 30, 30, 1, 4)
    :monster("mon_lizardfolk_shaman", 10, 30, 1, 1)
    :monster("mon_lizardfolk_chieftan", 10, 50, 1, 1))

-- Contains ogres and their various mutations
content.add(content.MonsterGroup { id = "GROUP_OGRE", load_mode = "append" }
    :monster("mon_ogre", 500, 1, 1, 1)
    :monster("mon_ogre", 100, 1, 1, 1, { ends = duration(28, "day") })
    :monster("mon_ogre", 150, 1, 1, 1, { ends = duration(112, "day") })
    :monster("mon_ogre", 150, 1, 1, 1, { ends = duration(360, "day") })
    :monster("mon_ogre_mage", 100, 1, 1, 1)
    :group("GROUP_OGRE_MUTANTS", 100, 1, 1, 1, { starts = duration(28, "day") })
    :group("GROUP_OGRE_MUTANTS", 150, 1, 1, 1, { starts = duration(112, "day") })
    :group("GROUP_OGRE_MUTANTS", 150, 1, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_OGRE_MUTANTS", load_mode = "append" }
    :monster("mon_ogre_twoheaded", 500, 1, 1, 1)
    :monster("mon_ogre_spider", 400, 1, 1, 1)
    :monster("mon_ogre_giant", 100, 1, 1, 1))

-- Cheap golems used to defend the average wizard's tower.
content.add(content.MonsterGroup { id = "GROUP_TOWER_GOLEM", load_mode = "append" }
    :monster("mon_plasticgolem", 965, 1, 1, 1)
    :monster("mon_claygolem", 20, 1, 1, 1)
    :monster("mon_stonegolem", 10, 1, 1, 1)
    :monster("mon_irongolem", 5, 1, 1, 1))

-- Nature frogs with no seasonal limits
content.add(content.MonsterGroup {
    id = "GROUP_FROGS_CLOAK",
    load_mode = "append",
    default_monster = "mon_peeper_frog",
}
    :monster("mon_leo_frog", 100, 1, 1, 4)
    :monster("mon_bullfrog_frog", 100, 1, 1, 4)
    :monster("mon_fowler_toad", 100, 1, 1, 4)
    :monster("mon_freedom_toad", 100, 1, 1, 4)
    :monster("mon_peeper_frog", 100, 1, 2, 6)
    :monster("mon_gray_frog", 100, 1, 1, 4))

content.add(content.MonsterGroup { id = "GROUP_ALL_GOBLINS", load_mode = "append" }
    :monster("mon_goblin_warrior", 335, 1, 1, 1)
    :monster("mon_feral_goblin", 50, 1, 1, 1)
    :monster("mon_wolf_goblin", 75, 1, 1, 1)
    :monster("mon_wolf_goblin", 15, 1, 2, 4)
    :monster("mon_goblin_warrior", 100, 1, 1, 1, { ends = duration(28, "day") })
    :monster("mon_goblin_warrior", 125, 1, 1, 1, { ends = duration(112, "day") })
    :monster("mon_goblin_warrior", 150, 1, 1, 1, { ends = duration(360, "day") })
    :monster("mon_goblin_mage_poison", 25, 1, 1, 1)
    :monster("mon_goblin_warrior", 35, 1, 2, 4)
    :monster("mon_goblin_slinger", 65, 1, 2, 4)
    :monster("mon_troll_goblin_tamed", 15, 1, 1, 1)
    :group("GROUP_GOBLIN_MUTANTS", 100, 1, 1, 1, { starts = duration(28, "day") })
    :group("GROUP_GOBLIN_MUTANTS", 125, 1, 1, 1, { starts = duration(112, "day") })
    :group("GROUP_GOBLIN_MUTANTS", 150, 1, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_GOBLIN_MUTANTS", load_mode = "append" }
    :monster("mon_orc_warrior", 400, 1, 1, 1)
    :monster("mon_orc_archer", 150, 1, 1, 1)
    :monster("mon_orc_blood_warrior", 100, 1, 1, 1)
    :monster("mon_orc_mage_blood", 25, 1, 1, 1)
    :monster("mon_goblin_bugbear", 250, 1, 1, 1)
    :monster("mon_goblin_bugbear_stalker", 75, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_GOBLIN_STANDARD", load_mode = "append" }
    :monster("mon_goblin_warrior", 900, 1, 1, 1)
    :monster("mon_goblin_warrior", 35, 1, 2, 4)
    :monster("mon_goblin_slinger", 65, 1, 2, 4))

content.add(content.MonsterGroup { id = "GROUP_GOBLIN_ADVANCED", load_mode = "append" }
    :monster("mon_goblin_chieftain", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FORGE_STANDARD", load_mode = "append" }
    :monster("mon_null", 978, 1, 1, 1)
    :monster("mon_forgeborn", 10, 10, 1, 1)
    :monster("mon_forgemaster1", 3, 10, 1, 1)
    :monster("mon_forgemaster2", 3, 10, 1, 1)
    :monster("mon_forgemaster3", 3, 10, 1, 1)
    :monster("mon_forgedwarves", 3, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FORGEDEMONS", load_mode = "append" }
    :monster("mon_forgedemons", 1, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FORGE_DWARVES", load_mode = "append" }
    :monster("mon_forgedwarves", 1, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FORGE_AUTOMATA", load_mode = "append" }
    :monster("mon_forgeborn", 1, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ORC", load_mode = "append" }
    :monster("mon_orc_warrior", 960, 5, 1, 1)
    :monster("mon_orc_archer", 25, 7, 1, 1)
    :monster("mon_orc_blood_warrior", 15, 5, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_WORKSHOP",
    load_mode = "append",
    default_monster = "mon_workshop_elf",
}
    :monster("mon_workshop_elf", 100, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERAL", load_mode = "append" }
    :monster("mon_feral_elf_pipe", 20, 1, 2, 3)
    :monster("mon_feral_dwarf_pipe", 20, 1, 2, 3)
    :monster("mon_feral_elf_crowbar", 15, 1, 2, 3)
    :monster("mon_feral_dwarf_crowbar", 15, 1, 2, 3)
    :monster("mon_feral_elf_axe", 5, 2, 1, 2)
    :monster("mon_feral_dwarf_axe", 5, 2, 1, 2)
    :monster("mon_feral_goblin", 20, 1, 2, 3)
    :monster("mon_feral_ravenfolk", 15, 1, 2, 3)
    :monster("mon_feral_lizardfolk", 10, 1, 2, 3)
    :group("GROUP_FERAL_WIZARDS", 5, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FOREST_SPIRIT", load_mode = "append" }
    :monster("mon_mossling", 48, 1, 1, 1)
    :monster("mon_mossling", 16, 2, 3, 6)
    :monster("mon_dryad", 16, 2, 1, 1)
    :monster("mon_dryad", 6, 2, 2, 4)
    :monster("mon_brackenwight", 10, 5, 1, 1)
    :monster("mon_treant", 4, 10, 1, 1)
    :monster("mon_keeper_of_the_glades", 1, 20, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FOREST_SPIRIT_SWAMP", load_mode = "append" }
    :monster("mon_mossling", 25, 1, 1, 1)
    :monster("mon_mossling", 10, 2, 2, 4)
    :monster("mon_brackenwight", 8, 5, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EARTH_SPIRIT", load_mode = "append" }
    :monster("mon_earth_gnome", 25, 1, 1, 1)
    :monster("mon_earth_gnome", 5, 1, 2, 4))

content.add(content.MonsterGroup { id = "GROUP_EARTH_SPIRIT_CAVE", load_mode = "append" }
    :monster("mon_earth_gnome", 25, 1, 1, 1)
    :monster("mon_earth_gnome", 15, 3, 2, 4))

content.add(content.MonsterGroup { id = "GROUP_MAGIC_FIELD", load_mode = "append" }
    :group("GROUP_FOREST", 2, 1, 1, 1)
    :group("GROUP_FOREST_SPIRIT", 1, 1, 1, 1))

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

-- For placing in magic fields
content.add(content.MonsterGroup { id = "GROUP_TRIFFID_HERBALISM_SEEDSHAPER", load_mode = "append" }
    :monster("mon_triffid_seedshaper", 1, 1, 1, 1)
    :monster("mon_triffid", 1, 1, 4, 8)
    :monster("mon_vinebeast", 1, 1, 2, 3))

-- For placing in magic fields
content.add(content.MonsterGroup { id = "GROUP_TRIFFID_HERBALISM_VINEWEAVER", load_mode = "append" }
    :monster("mon_triffid_vineweaver", 1, 1, 1, 1)
    :monster("mon_triffid", 1, 1, 4, 8)
    :monster("mon_vinebeast", 1, 1, 2, 3))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_CAMP_OM", load_mode = "append" }
    :monster("mon_mi_go_fleshwarper", 50, 20, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_nethermancer", 50, 20, 1, 1, { starts = duration(35, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_COMMON", load_mode = "append" }
    :monster("mon_mi_go_fleshwarper", 50, 2, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_nethermancer", 50, 2, 1, 1, { starts = duration(35, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_CAPTORS", load_mode = "append" }
    :monster("mon_mi_go_fleshwarper", 300, 2, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_nethermancer", 100, 2, 1, 1, { starts = duration(35, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_BOSS", load_mode = "append" }
    :monster("mon_mi_go_fleshwarper", 200, 2, 1, 1)
    :monster("mon_mi_go_fleshwarper", 50, 5, 2, 3)
    :monster("mon_mi_go_nethermancer", 200, 2, 1, 1)
    :monster("mon_mi_go_nethermancer", 50, 5, 2, 3))

content.add(content.MonsterGroup {
    id = "GROUP_NETHERMANCER_SUMMON",
    load_mode = "append",
    default_monster = "mon_blank",
}
    :monster("mon_flying_polyp_migo", 100, 0, 1, 1)
    :monster("mon_hunting_horror_migo", 100, 0, 1, 1)
    :monster("mon_unseen_hunter_migo", 100, 1, 1, 1, { starts = duration(30, "day") })
    :monster("mon_yugg_migo", 100, 0, 1, 1)
    :monster("mon_gelatin_migo", 100, 0, 1, 1)
    :monster("mon_flaming_eye_migo", 100, 0, 1, 1)
    :monster("mon_kreck_migo", 100, 0, 2, 4))

-- For overrun or feral druid spaces
content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIFIED_ANIMALS",
    load_mode = "append",
    default_monster = "mon_zombie_dog",
}
    :monster("mon_zombie_dog", 200, 1, 1, 1)
    :monster("mon_zombie_dog", 25, 1, 2, 5)
    :monster("mon_zolf", 100, 1, 1, 1)
    :monster("mon_zombie_pig", 150, 1, 1, 1)
    :monster("mon_zeer", 150, 1, 1, 1)
    :monster("mon_zeer", 25, 1, 2, 5)
    :monster("mon_zougar", 100, 1, 1, 1)
    :monster("mon_giant_heron_ridable_zombie", 75, 1, 1, 1)
    :monster("mon_zombear", 75, 1, 1, 1)
    :monster("mon_zoose", 50, 1, 1, 1)
    :monster("mon_owlbear_zombie", 25, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_AENOR", load_mode = "append" }
    :monster("mon_giant_heron_ridable", 150, 2, 1, 1)
    :monster("mon_giant_heron_ridable_chick", 50, 1, 1, 1, { ends = duration(124, "day") })
    :monster("mon_giant_heron_ridable_chick", 25, 1, 1, 1, { starts = duration(124, "day") }))

content.add(content.MonsterGroup { id = "GROUP_RANCH_AENOR_STABLES", load_mode = "append" }
    :monster("mon_null", 50, 1, 1, 1)
    :group("GROUP_AENOR", 50, 1, 1, 1, { ends = duration(56, "day") }))

content.add(content.MonsterGroup { id = "GROUP_EGG_OWLBEAR", load_mode = "append" }
    :monster("mon_owlbear_cub", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DRUID_TOWER_DRUID_HEAD", load_mode = "append" }
    :monster("mon_feral_druid", 150, 1, 1, 1)
    :monster("mon_feral_druid_enhanced", 850, 1, 1, 1))
