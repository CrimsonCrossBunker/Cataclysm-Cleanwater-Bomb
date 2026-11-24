local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_tindalos",
    copy_from = "mon_tindalos",
    inheritance = { add = { flags = { "STABILIZED_TIMELINE", "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_hound_tindalos",
    copy_from = "mon_hound_tindalos",
    inheritance = { add = { flags = { "STABILIZED_TIMELINE", "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_lieutenant_shadow",
    copy_from = "mon_lieutenant_shadow",
    inheritance = { add = { flags = { "STABILIZED_TIMELINE", "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_bear_cub",
    copy_from = "mon_bear_cub",
    species = { "MAMMAL", "NIGHT_CREATURE" },
    harvest = "bear_with_skull",
}

ccb.content.define_monster { id = "mon_bear", copy_from = "mon_bear", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster {
    id = "mon_bear_mutant_3headed",
    copy_from = "mon_bear_mutant_3headed",
    species = { "MAMMAL", "NIGHT_CREATURE" },
}

ccb.content.define_monster { id = "mon_wolf", copy_from = "mon_wolf", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_wolf_pup", copy_from = "mon_wolf_pup", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_coyote", copy_from = "mon_coyote", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster {
    id = "mon_coyote_mutant_shark",
    copy_from = "mon_coyote_mutant_shark",
    species = { "MAMMAL", "NIGHT_CREATURE" },
}

ccb.content.define_monster {
    id = "mon_coyote_mutant_venom",
    copy_from = "mon_coyote_mutant_venom",
    species = { "MAMMAL", "NIGHT_CREATURE" },
}

ccb.content.define_monster { id = "mon_big_rat", copy_from = "mon_big_rat", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_pack_rat", copy_from = "mon_pack_rat", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_sewer_rat", copy_from = "mon_sewer_rat", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster {
    id = "mon_black_ratkin",
    copy_from = "mon_black_ratkin",
    species = { "MAMMAL", "NIGHT_CREATURE" },
}

ccb.content.define_monster { id = "mon_black_rat", copy_from = "mon_black_rat", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_bat", copy_from = "mon_bat", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_crow", copy_from = "mon_crow", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster {
    id = "mon_crow_mutant_small",
    copy_from = "mon_crow_mutant_small",
    species = { "MAMMAL", "NIGHT_CREATURE" },
}

ccb.content.define_monster { id = "mon_crow_mutant", copy_from = "mon_crow_mutant", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_fox_red", copy_from = "mon_fox_red", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_fox_gray", copy_from = "mon_fox_gray", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_boar_wild_piglet", copy_from = "mon_boar_wild_piglet", harvest = "pig_with_skull" }

ccb.content.define_monster {
    id = "mon_ant",
    name = ccb.content.plural_text("giant ant", "giant ants"),
    description = ccb.content.text("An enormous red ant covered in chitinous plates.  She possesses a pair of wriggling antennae and vicious-looking mandibles."),
    copy_from = "mon_ant",
    harvest = "giant_ant",
}

ccb.content.define_monster {
    id = "mon_ant_acid",
    name = ccb.content.plural_text("giant acidic ant", "giant acidic ants"),
    description = ccb.content.text("A monstrous brown ant with a swollen abdomen that ends with a small orifice at the tip.  Glistening liquid seems to drip out periodically."),
    copy_from = "mon_ant_acid",
    harvest = "giant_acid_ant",
}

ccb.content.define_monster { id = "mon_zombie_child_base", copy_from = "mon_zombie_child_base", harvest = "zombie_child" }

ccb.content.define_monster { id = "mon_zombie_runner", copy_from = "mon_zombie_runner", harvest = "zombie_runner" }

ccb.content.define_monster {
    id = "mon_broken_cyborg",
    copy_from = "mon_broken_cyborg",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_prototype_cyborg",
    copy_from = "mon_prototype_cyborg",
    inheritance = { add = { armor = { withering_damage = 6 } } },
}

ccb.content.define_monster {
    id = "mon_exodii_worker",
    copy_from = "mon_exodii_worker",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_exodii_quad",
    copy_from = "mon_exodii_quad",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_zomborg_devourer",
    copy_from = "mon_zomborg_devourer",
    inheritance = { add = { armor = { withering_damage = 30 } } },
}

ccb.content.define_monster {
    id = "mon_secubot",
    copy_from = "mon_secubot",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_talon_m202a1",
    copy_from = "mon_talon_m202a1",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_secubot_america",
    copy_from = "mon_secubot_america",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_skitterbot",
    copy_from = "mon_skitterbot",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_science_bot",
    copy_from = "mon_science_bot",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_robofac_prototype",
    copy_from = "mon_robofac_prototype",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_dispatch",
    copy_from = "mon_dispatch",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_dispatch_military",
    copy_from = "mon_dispatch_military",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "base_drone",
    abstract = true,
    copy_from = "base_drone",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "exodii_sniper_drone",
    copy_from = "exodii_sniper_drone",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_fungus",
    copy_from = "mon_zombie_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag_fungus",
    copy_from = "mon_zombie_gasbag_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_smoker_fungus",
    copy_from = "mon_zombie_smoker_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_fungus",
    copy_from = "mon_skeleton_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_brute_fungus",
    copy_from = "mon_skeleton_brute_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_hulk_fungus",
    copy_from = "mon_skeleton_hulk_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_child_fungus",
    copy_from = "mon_zombie_child_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_boomer_fungus",
    copy_from = "mon_boomer_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_wretch",
    copy_from = "mon_fungal_wretch",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_raptor",
    copy_from = "mon_fungal_raptor",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_runner_fungal",
    copy_from = "mon_zombie_runner_fungal",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_rot_fungal",
    copy_from = "mon_zombie_rot_fungal",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_tough_fungal",
    copy_from = "mon_zombie_tough_fungal",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_crawler_fungal",
    copy_from = "mon_zombie_crawler_fungal",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_fat_fungus",
    copy_from = "mon_zombie_fat_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_beekeeper_fungal",
    copy_from = "mon_beekeeper_fungal",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_fungus_acidic",
    copy_from = "mon_zombie_fungus_acidic",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_dog_fungus",
    copy_from = "mon_zombie_dog_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zoose_fungus",
    copy_from = "mon_zoose_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zougar_fungus",
    copy_from = "mon_zougar_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_horse_fungus",
    copy_from = "mon_zombie_horse_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_ziger_fungus",
    copy_from = "mon_ziger_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zeer_fungus",
    copy_from = "mon_zeer_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zeindeer_fungus",
    copy_from = "mon_zeindeer_fungus",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_fleshy_shambler",
    copy_from = "mon_fleshy_shambler",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_flesh_golem",
    copy_from = "mon_flesh_golem",
    inheritance = { add = { armor = { withering_damage = 12 } } },
}

ccb.content.define_monster {
    id = "mon_jabberwock",
    copy_from = "mon_jabberwock",
    inheritance = { add = { armor = { withering_damage = 20 } } },
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_GM",
    copy_from = "mon_lab_security_drone_GM",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_YM",
    copy_from = "mon_lab_security_drone_YM",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_BM",
    copy_from = "mon_lab_security_drone_BM",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_BM2",
    copy_from = "mon_lab_security_drone_BM2",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_GR",
    copy_from = "mon_lab_security_drone_GR",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_mech_recon",
    copy_from = "mon_mech_recon",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_mech_combat",
    copy_from = "mon_mech_combat",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_mech_lifter",
    copy_from = "mon_mech_lifter",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_slaver",
    copy_from = "mon_mi_go_slaver",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_surgeon",
    copy_from = "mon_mi_go_surgeon",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_guard",
    copy_from = "mon_mi_go_guard",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_myrmidon",
    copy_from = "mon_mi_go_myrmidon",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_captured",
    copy_from = "mon_mi_go_captured",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_scout",
    copy_from = "mon_mi_go_scout",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_amigara_horror",
    copy_from = "mon_amigara_horror",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_shrapnel_swarm",
    copy_from = "mon_shrapnel_swarm",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_structural_spur",
    copy_from = "mon_structural_spur",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_void_spider",
    copy_from = "mon_void_spider",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_void_spider_maw",
    copy_from = "mon_void_spider_maw",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_void_spider_limb",
    copy_from = "mon_void_spider_limb",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_void_spider_spiderling",
    copy_from = "mon_void_spider_spiderling",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_darkman",
    copy_from = "mon_darkman",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_flying_polyp",
    copy_from = "mon_flying_polyp",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_star_vampire",
    copy_from = "mon_star_vampire",
    inheritance = { add = { armor = { withering_damage = 18 } } },
}

ccb.content.define_monster {
    id = "mon_star_vampire_coiling",
    copy_from = "mon_star_vampire_coiling",
    inheritance = { add = { armor = { withering_damage = 18 } } },
}

ccb.content.define_monster {
    id = "mon_hunting_horror",
    copy_from = "mon_hunting_horror",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_shadow",
    copy_from = "mon_shadow",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_shadow_snake",
    copy_from = "mon_shadow_snake",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_thing",
    copy_from = "mon_thing",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_vortex",
    copy_from = "mon_vortex",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_shifting_mass",
    copy_from = "mon_shifting_mass",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_impossible_shape",
    copy_from = "mon_impossible_shape",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_absence",
    copy_from = "mon_absence",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_flatlander",
    copy_from = "mon_flatlander",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_memory",
    copy_from = "mon_memory",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_swarm_structure",
    copy_from = "mon_swarm_structure",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_twisting_blade",
    copy_from = "mon_twisting_blade",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_archunk_weak",
    copy_from = "mon_archunk_weak",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_archunk_medium",
    copy_from = "mon_archunk_weak",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_archunk_strong",
    copy_from = "mon_archunk_weak",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_pale_reflection",
    copy_from = "mon_twisting_blade",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_tainted_shadow",
    copy_from = "mon_tainted_shadow",
    inheritance = { add = { flags = { "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_robofac_laserturret_mk1",
    copy_from = "mon_robofac_laserturret_mk1",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_robofac_camspy",
    copy_from = "mon_robofac_camspy",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_robofac_skittergun",
    copy_from = "mon_robofac_skittergun",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_blob",
    copy_from = "mon_blob",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_blob_brain",
    copy_from = "mon_blob_brain",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_blob_large",
    copy_from = "mon_blob_large",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_blob_small",
    copy_from = "mon_blob_small",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_gelatin",
    copy_from = "mon_gelatin",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_player_blob",
    copy_from = "mon_player_blob",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_slime_ocularium",
    copy_from = "mon_slime_ocularium",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_turret",
    copy_from = "mon_turret",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_turret_searchlight",
    copy_from = "mon_turret_searchlight",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_turret_bmg",
    copy_from = "mon_turret_bmg",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_turret_rifle",
    copy_from = "mon_turret_rifle",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_crows_m240",
    copy_from = "mon_crows_m240",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_turret_riot",
    copy_from = "mon_turret_riot",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_turret_speaker",
    copy_from = "mon_turret_speaker",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_exodii_turret",
    copy_from = "mon_exodii_turret",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_turret_artisans",
    copy_from = "mon_turret_artisans",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_grocerybot",
    copy_from = "mon_grocerybot",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_grocerybot_busted",
    copy_from = "mon_grocerybot_busted",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_hazmatbot",
    copy_from = "mon_hazmatbot",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_nursebot",
    copy_from = "mon_nursebot",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_nursebot_defective",
    copy_from = "mon_nursebot_defective",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_yrax_trifacet",
    copy_from = "mon_yrax_trifacet",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_yrax_sphenocorona",
    copy_from = "mon_yrax_sphenocorona",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_golden_monolith",
    copy_from = "mon_golden_monolith",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_yrax_apeirogon",
    copy_from = "mon_yrax_apeirogon",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_yrax_delta",
    copy_from = "mon_yrax_delta",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_dog_skeleton",
    copy_from = "mon_dog_skeleton",
    inheritance = { add = { armor = { withering_damage = 16 } } },
}

ccb.content.define_monster {
    id = "mon_dog_skeleton_brute",
    copy_from = "mon_dog_skeleton_brute",
    inheritance = { add = { armor = { withering_damage = 22 } } },
}

ccb.content.define_monster {
    id = "mon_wolf_skeleton",
    copy_from = "mon_wolf_skeleton",
    inheritance = { add = { armor = { withering_damage = 16 } } },
}

ccb.content.define_monster {
    id = "mon_zombear_skeleton",
    copy_from = "mon_zombear_skeleton",
    inheritance = { add = { armor = { withering_damage = 16 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_horse_white",
    copy_from = "mon_zombie_horse_white",
    inheritance = { add = { armor = { withering_damage = 16 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_horse_pale",
    copy_from = "mon_zombie_horse_pale",
    inheritance = { add = { armor = { withering_damage = 16 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_snotgobbler",
    copy_from = "mon_zombie_snotgobbler",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_sproglodyte",
    copy_from = "mon_zombie_sproglodyte",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_wretch",
    copy_from = "mon_zombie_wretch",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_master",
    copy_from = "mon_skeleton_master",
    inheritance = { add = { armor = { withering_damage = 16 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_necro",
    copy_from = "mon_skeleton_necro",
    inheritance = { add = { armor = { withering_damage = 16 } } },
}

ccb.content.define_monster {
    id = "mon_boomer",
    copy_from = "mon_boomer",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_boomer_huge",
    copy_from = "mon_boomer_huge",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag",
    copy_from = "mon_zombie_gasbag",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_relax_gasbag",
    copy_from = "mon_zombie_relax_gasbag",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_tear_gasbag",
    copy_from = "mon_zombie_tear_gasbag",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_boomer_glutton",
    copy_from = "mon_boomer_glutton",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_boomer_claymore",
    copy_from = "mon_boomer_claymore",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_rust",
    copy_from = "mon_zombie_rust",
    inheritance = { add = { armor = { withering_damage = 12 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_shell",
    copy_from = "mon_zombie_shell",
    inheritance = { add = { armor = { withering_damage = 12 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_plated",
    copy_from = "mon_zombie_plated",
    inheritance = { add = { armor = { withering_damage = 12 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_urchin",
    copy_from = "mon_zombie_urchin",
    inheritance = { add = { armor = { withering_damage = 12 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_hammer_hands",
    copy_from = "mon_zombie_hammer_hands",
    inheritance = { add = { armor = { withering_damage = 12 } } },
}

ccb.content.define_monster {
    id = "mon_devourer",
    copy_from = "mon_devourer",
    inheritance = { add = { armor = { withering_damage = 22 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag_immobile",
    copy_from = "mon_zombie_gasbag_immobile",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag_crawler",
    copy_from = "mon_zombie_gasbag_crawler",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag_impaler",
    copy_from = "mon_zombie_gasbag_impaler",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_phase_skulker",
    copy_from = "mon_zombie_phase_skulker",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_phase_shrike",
    copy_from = "mon_zombie_phase_shrike",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_frog_mother",
    copy_from = "mon_frog_mother",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_brainless",
    copy_from = "mon_zombie_brainless",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_afs_headless_horror",
    copy_from = "mon_afs_headless_horror",
    inheritance = { add = { armor = { withering_damage = 22 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_grue",
    copy_from = "mon_zombie_grue",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_ears",
    copy_from = "mon_zombie_ears",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_nemesis",
    copy_from = "mon_zombie_nemesis",
    inheritance = { add = { armor = { withering_damage = 22 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_master",
    copy_from = "mon_zombie_master",
    inheritance = { add = { armor = { withering_damage = 22 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_necro",
    copy_from = "mon_zombie_necro",
    inheritance = { add = { armor = { withering_damage = 22 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_necro_boomer",
    copy_from = "mon_zombie_necro_boomer",
    inheritance = { add = { armor = { withering_damage = 16 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_shady",
    copy_from = "mon_zombie_shady",
    inheritance = { add = { armor = { withering_damage = 8, xe_shadow_damage = 12 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_skull",
    copy_from = "mon_zombie_skull",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton",
    copy_from = "mon_skeleton",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_brute",
    copy_from = "mon_skeleton_brute",
    inheritance = { add = { armor = { withering_damage = 22 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_electric",
    copy_from = "mon_skeleton_electric",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_hulk",
    copy_from = "mon_skeleton_hulk",
    inheritance = { add = { armor = { withering_damage = 30 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_kevlar_2",
    copy_from = "mon_zombie_kevlar_2",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_medical",
    copy_from = "mon_skeleton_medical",
    inheritance = { add = { armor = { withering_damage = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zomborg",
    copy_from = "mon_zomborg",
    inheritance = {
        add = {
            armor = { withering_damage = 15 },
        },
    },
}
