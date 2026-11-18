local content = require("ccb").content

-- A simple mix of common low level zombies.  Threat level keeps below around 7.
content.add(content.MonsterGroup { id = "GROUP_SI_ZOMEASY" }
    :monster("mon_zombie", 2000, 1, 1, 1)
    :monster("mon_zombie_fat", 200, 1, 1, 1)
    :monster("mon_zombie_tough", 100, 1, 1, 1)
    :monster("mon_zombie_child", 25, 1, 1, 1)
    :monster("mon_zombie_rot", 25, 1, 1, 1)
    :monster("mon_zombie_crawler", 25, 1, 1, 1)
    :monster("mon_zombie_dog", 25, 1, 1, 1)
    :monster("mon_dog_zombie_cop", 10, 1, 1, 1)
    :monster("mon_dog_zombie_rot", 10, 1, 1, 1)
    :monster("mon_zombie_cop", 10, 1, 1, 1)
    :monster("mon_boomer", 10, 1, 1, 1)
    :monster("mon_zombie_shady", 5, 1, 1, 1)
    :monster("mon_zombie_medical", 5, 1, 1, 1)
    :monster("mon_zombie_hazmat", 5, 1, 1, 1)
    :monster("mon_zombie_fireman", 5, 1, 1, 1)
    :monster("mon_zombie_swimmer_base", 5, 1, 1, 1)
    :monster("mon_zombie_static", 15, 1, 1, 1)
    :monster("mon_beekeeper", 5, 1, 1, 1)
    :monster("mon_feral_human_tool", 25, 1, 1, 1)
    :monster("mon_dog_skeleton", 5, 1, 1, 1)
    :monster("mon_zombie_runner", 100, 1, 1, 1)
    :monster("mon_zombie_medical_regenerating", 5, 1, 1, 1)
    :monster("mon_zombie_rust", 5, 1, 1, 1)
    :monster("mon_zombie_brainless", 5, 1, 1, 1)
    :monster("mon_skeleton", 35, 1, 1, 1)
    :monster("mon_zombie_winged", 25, 1, 1, 1)
    :monster("mon_zombie_pig", 10, 1, 1, 1)
    :monster("mon_zombie_thorny", 10, 1, 1, 1)
    :monster("mon_zombie_regenerating", 5, 1, 1, 1)
    :monster("mon_zombie_scientist", 10, 1, 1, 1))

-- A simple mix of evolved zombies.  Threat level to mid/low teens.  A few exceptions made for special effects like acid or speed, like dogs.
content.add(content.MonsterGroup { id = "GROUP_SI_ZOMMID" }
    :monster("mon_zombie_tough", 1000, 1, 1, 1)
    :monster("mon_zombie_horse_white", 5, 1, 1, 1)
    :monster("mon_zombie_grabber", 100, 1, 1, 1)
    :monster("mon_zombie_grappler", 50, 1, 1, 1)
    :monster("mon_zougar_shady", 5, 1, 1, 1)
    :monster("mon_zombie_hunter", 100, 1, 1, 1)
    :monster("mon_feral_sapien_spear", 25, 1, 1, 1)
    :monster("mon_feral_soldier", 20, 1, 1, 1)
    :monster("mon_zombie_gasbag", 25, 1, 1, 1)
    :monster("mon_zeindeer", 5, 1, 1, 1)
    :monster("mon_zombie_shrieker", 25, 1, 1, 1)
    :monster("mon_zombie_acidic", 25, 1, 1, 1)
    :monster("mon_zombie_brute", 25, 1, 1, 1)
    :monster("mon_zombie_medical_acidic", 10, 1, 1, 1)
    :monster("mon_zombie_technician", 20, 1, 1, 1)
    :monster("mon_zombie_hollow", 20, 1, 1, 1)
    :monster("mon_zombie_pupa", 10, 1, 1, 1)
    :monster("mon_zombie_pupa_decoy", 10, 1, 1, 1)
    :monster("mon_zombie_survivor", 10, 1, 1, 1)
    :monster("mon_zombie_plated", 5, 1, 1, 1)
    :monster("mon_zombie_urchin", 5, 1, 1, 1)
    :monster("mon_zombie_hammer_hands", 5, 1, 1, 1)
    :monster("mon_boomer_huge", 10, 1, 1, 1)
    :monster("mon_zombie_tear_gasbag", 5, 1, 1, 1)
    :monster("mon_zombie_relax_gasbag", 5, 1, 1, 1)
    :monster("mon_dog_zombie_brute", 25, 1, 1, 1)
    :monster("mon_zombie_dog_acidic", 15, 1, 1, 1)
    :monster("mon_zombie_swat", 20, 1, 1, 1)
    :monster("mon_zombie_skull", 10, 1, 1, 1)
    :monster("mon_zpig_brute", 5, 1, 1, 1)
    :monster("mon_zombie_biter", 15, 1, 1, 1)
    :monster("mon_zombie_soldier", 50, 1, 1, 1)
    :monster("mon_zombie_scorched_brute", 20, 1, 1, 1)
    :monster("mon_zombie_marine", 10, 1, 1, 1)
    :monster("mon_zoose", 5, 1, 1, 1)
    :monster("mon_zombie_shell", 5, 1, 1, 1)
    :monster("mon_zombie_scientist", 10, 1, 1, 1))

-- A mix of powerful zombies.  Threat level high teens up to mid 20s.  Exceptions made for especially tough monsters.
content.add(content.MonsterGroup { id = "GROUP_SI_ZOMHARD" }
    :monster("mon_zombie_brute", 1000, 1, 1, 1)
    :monster("mon_zombie_kevlar_1", 100, 1, 1, 1)
    :monster("mon_zombie_mancroc", 25, 1, 1, 1)
    :monster("mon_zombie_smoker", 10, 1, 1, 1)
    :monster("mon_brute_pupa", 15, 1, 1, 1)
    :monster("mon_brute_pupa_decoy", 10, 1, 1, 1)
    :monster("mon_zombie_nullfield", 25, 1, 1, 1)
    :monster("mon_zombie_electric", 50, 1, 1, 1)
    :monster("mon_boomer_claymore", 10, 1, 1, 1)
    :monster("mon_zombie_tear_gasbag", 5, 1, 1, 1)
    :monster("mon_zombie_relax_gasbag", 5, 1, 1, 1)
    :monster("mon_skeleton_brute", 200, 1, 1, 1)
    :monster("mon_skeleton_master", 50, 1, 1, 1)
    :monster("mon_zombie_horse_pale", 5, 1, 1, 1)
    :monster("mon_zombie_horse_red", 5, 1, 1, 1)
    :monster("mon_zombie_horse_black", 5, 1, 1, 1)
    :monster("mon_zombear", 10, 1, 1, 1)
    :monster("mon_zombear_skeleton", 10, 1, 1, 1)
    :monster("mon_zoose_thorny", 5, 1, 1, 1)
    :monster("mon_dog_skeleton_brute", 50, 1, 1, 1)
    :monster("mon_devourer", 25, 1, 1, 1)
    :monster("mon_zombullfrog", 10, 1, 1, 1)
    :monster("mon_zombie_survivor_elite", 15, 1, 1, 1)
    :monster("mon_zombie_spitter", 75, 1, 1, 1)
    :monster("mon_zombie_armored", 10, 1, 1, 1)
    :monster("mon_zombie_predator", 10, 1, 1, 1)
    :monster("mon_zombie_pig_gas", 5, 1, 1, 1))

-- A blend of truly elite zombies.  Threat level up to the ceiling.
content.add(content.MonsterGroup { id = "GROUP_SI_ZOMELITE" }
    :monster("mon_zombie_soldier_blackops_1", 100, 1, 1, 1)
    :monster("mon_zombie_soldier_acid_1", 100, 1, 1, 1)
    :monster("mon_zombie_soldier_acid_2", 25, 1, 1, 1)
    :monster("mon_zombie_kevlar_1", 50, 1, 1, 1)
    :monster("mon_zombie_necro", 20, 1, 1, 1)
    :monster("mon_zombie_hulk", 5, 1, 1, 1)
    :monster("mon_boomer_glutton", 5, 1, 1, 1)
    :monster("mon_skeleton_necro", 25, 1, 1, 1)
    :monster("mon_zombear_acidic", 20, 1, 1, 1)
    :monster("mon_zoose_brute", 5, 1, 1, 1)
    :monster("mon_zougar_hunter", 10, 1, 1, 1)
    :monster("mon_dog_zombie_hulk", 100, 1, 1, 1)
    :monster("mon_zombie_nullfield", 100, 1, 1, 1)
    :monster("mon_zombie_brute_shocker", 5, 1, 1, 1)
    :monster("mon_zombie_necro_boomer", 5, 1, 1, 1)
    :monster("mon_skeleton_electric", 50, 1, 1, 1)
    :monster("mon_zombie_bio_op", 50, 1, 1, 1)
    :monster("mon_zombie_survivor_elite", 50, 1, 1, 1)
    :monster("mon_zombie_brute_ninja", 20, 1, 1, 1)
    :monster("mon_gastro_bufo", 10, 1, 1, 1)
    :monster("mon_zombie_armored", 10, 1, 1, 1)
    :monster("mon_zombull", 50, 1, 1, 1)
    :monster("mon_zombie_predator", 50, 1, 1, 1)
    :monster("mon_zombie_corrosive", 25, 1, 1, 1)
    :monster("mon_hulk_pupa", 10, 1, 1, 1)
    :monster("mon_zombie_relax_gasbag", 20, 1, 1, 1))

-- Boss tier encounters.  Extreme danger level.
content.add(content.MonsterGroup { id = "GROUP_SI_ZOMBOSS" }
    :monster("mon_zombie_hulk", 100, 1, 1, 1)
    :monster("mon_skeleton_hulk", 75, 1, 1, 1)
    :monster("mon_zombie_kevlar_2", 50, 1, 1, 1)
    :monster("mon_si_jabberwock", 25, 1, 1, 1)
    :monster("mon_zombie_brute_shocker", 10, 1, 1, 1)
    :monster("mon_zoose_brute", 20, 1, 1, 1)
    :monster("mon_zombie_nemesis", 5, 1, 1, 1))

-- Boss tier encounters for enemies that show up in bunches.  Extreme danger level.
content.add(content.MonsterGroup { id = "GROUP_SI_ZOMBOSSMULT" }
    :monster("mon_zombie_hulk", 10, 1, 1, 1)
    :monster("mon_dog_zombie_hulk", 100, 1, 1, 1)
    :monster("mon_feral_militia", 100, 1, 1, 1)
    :monster("mon_skeleton_electric", 100, 1, 1, 1)
    :monster("mon_zombie_brute_grappler", 50, 1, 1, 1)
    :monster("mon_zombie_brute_shocker", 100, 1, 1, 1))

-- Powerful migo.
content.add(content.MonsterGroup { id = "GROUP_SI_MIGO" }
    :monster("mon_mi_go", 200, 1, 1, 1)
    :monster("mon_mi_go_scout", 25, 1, 1, 1)
    :monster("mon_mi_go_slaver", 15, 1, 1, 1)
    :monster("mon_mi_go_surgeon", 10, 1, 1, 1))

-- Evolved migo.
content.add(content.MonsterGroup { id = "GROUP_SI_MIGO_ELITE" }
    :monster("mon_mi_go_myrmidon", 25, 1, 1, 1)
    :monster("mon_mi_go_guard", 75, 1, 1, 1))

content.extend_monster_group(content.MonsterGroup { id = "GROUP_LAB", default_monster = "mon_zombie_scientist" }
    :monster("mon_zombie_bio_op", 50, 5, 1, 1))

content.extend_monster_group(content.MonsterGroup { id = "GROUP_LAB_SURFACE", default_monster = "mon_zombie_scientist" }
    :monster("mon_zombie_bio_op", 50, 5, 1, 1))

content.extend_monster_group(content.MonsterGroup { id = "GROUP_LAB_SECURITY", default_monster = "mon_zombie_labsecurity" }
    :monster("mon_zombie_bio_op", 50, 5, 1, 1))

-- Used in the military bunker
content.extend_monster_group(content.MonsterGroup { id = "GROUP_MIL_BASE" }
    :monster("mon_zombie_bio_op", 20, 50, 1, 1))

content.extend_monster_group(content.MonsterGroup { id = "GROUP_MAYBE_MIL" }
    :monster("mon_zombie_bio_op", 20, 50, 1, 1))

-- Used in the military bunker, LIXA and Hub01 convoy ambush
content.extend_monster_group(content.MonsterGroup { id = "GROUP_MIL_STRONG" }
    :monster("mon_zombie_bio_op", 20, 50, 1, 1))

content.extend_monster_group(content.MonsterGroup { id = "GROUP_MIL_EXTRA" }
    :monster("mon_zombie_bio_op", 4, 1, 1, 1))

content.extend_monster_group(content.MonsterGroup { id = "GROUP_BUNKER" }
    :monster("mon_zombie_bio_op", 150, 10, 1, 1))
