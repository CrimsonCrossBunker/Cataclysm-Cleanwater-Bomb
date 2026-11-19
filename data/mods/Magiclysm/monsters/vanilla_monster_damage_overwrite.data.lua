local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zomborg_devourer",
    copy_from = "mon_zomborg_devourer",
    inheritance = { add = { flags = { "PSIONICPROOF" }, armor = { nether = 20, necrotic = 20, poison = 20 } } },
}

ccb.content.define_monster {
    id = "mon_secubot",
    copy_from = "mon_secubot",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_talon_m202a1",
    copy_from = "mon_talon_m202a1",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_secubot_america",
    copy_from = "mon_secubot_america",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_skitterbot",
    copy_from = "mon_skitterbot",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_science_bot",
    copy_from = "mon_science_bot",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_robofac_prototype",
    copy_from = "mon_robofac_prototype",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_dispatch",
    copy_from = "mon_dispatch",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_dispatch_military",
    copy_from = "mon_dispatch_military",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "base_drone",
    abstract = true,
    copy_from = "base_drone",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "exodii_sniper_drone",
    copy_from = "exodii_sniper_drone",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20, nether = 4 } } },
}

ccb.content.define_monster { id = "mon_chud", copy_from = "mon_chud", inheritance = { add = { armor = { poison = 4 } } } }

ccb.content.define_monster {
    id = "mon_feral_human_crowbar_fungal_infected",
    copy_from = "mon_feral_human_crowbar_fungal_infected",
    inheritance = { add = { armor = { poison = 8, nether = 4 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_axe_fungal_infected",
    copy_from = "mon_feral_human_axe_fungal_infected",
    inheritance = { add = { armor = { poison = 8, nether = 4 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_pipe_fungal_corpse",
    copy_from = "mon_feral_human_pipe_fungal_corpse",
    inheritance = { add = { armor = { poison = 8, nether = 4, psionic = 4 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar_fungal_corpse",
    copy_from = "mon_feral_human_crowbar_fungal_corpse",
    inheritance = { add = { armor = { poison = 8, nether = 4, psionic = 4 } } },
}

ccb.content.define_monster {
    id = "mon_feral_human_axe_fungal_corpse",
    copy_from = "mon_feral_human_axe_fungal_corpse",
    inheritance = { add = { armor = { poison = 8, nether = 4, psionic = 4 } } },
}

ccb.content.define_monster {
    id = "mon_feral_cop_fungal_infected",
    copy_from = "mon_feral_cop_fungal_infected",
    inheritance = { add = { armor = { poison = 8, nether = 4 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_blossom",
    copy_from = "mon_fungal_blossom",
    inheritance = { add = { armor = { poison = 20, nether = 10, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_hedgerow",
    copy_from = "mon_fungal_hedgerow",
    inheritance = { add = { armor = { poison = 20, nether = 10, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_tendril",
    copy_from = "mon_fungal_tendril",
    inheritance = { add = { armor = { poison = 20, nether = 10, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_wall",
    copy_from = "mon_fungal_wall",
    inheritance = { add = { armor = { poison = 20, nether = 10, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid",
    copy_from = "mon_fungaloid",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_shambler",
    copy_from = "mon_fungaloid_shambler",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_queen",
    copy_from = "mon_fungaloid_queen",
    inheritance = { add = { armor = { poison = 20, nether = 14, psionic = 8 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_seeder",
    copy_from = "mon_fungaloid_seeder",
    inheritance = { add = { armor = { poison = 20, nether = 14, psionic = 8 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_tower",
    copy_from = "mon_fungaloid_tower",
    inheritance = { add = { armor = { poison = 20, nether = 14, psionic = 8 } } },
}

ccb.content.define_monster {
    id = "mon_fungaloid_young",
    copy_from = "mon_fungaloid_young",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_spore",
    copy_from = "mon_spore",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_ant_fungus",
    copy_from = "mon_ant_fungus",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_spider_fungus",
    copy_from = "mon_spider_fungus",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_wasp_small_fungus",
    copy_from = "mon_wasp_small_fungus",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_wasp_small_guard_fungus",
    copy_from = "mon_wasp_small_guard_fungus",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_wasp_queen_fungus",
    copy_from = "mon_wasp_queen_fungus",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_wasp_fungus",
    copy_from = "mon_wasp_fungus",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_wasp_guard_fungus",
    copy_from = "mon_wasp_guard_fungus",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_wasp_mega_fungus",
    copy_from = "mon_wasp_mega_fungus",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_bee_fungus",
    copy_from = "mon_bee_fungus",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_bee_mega_fungus",
    copy_from = "mon_bee_mega_fungus",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_fungus",
    copy_from = "mon_zombie_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag_fungus",
    copy_from = "mon_zombie_gasbag_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_smoker_fungus",
    copy_from = "mon_zombie_smoker_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_fungus",
    copy_from = "mon_skeleton_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_brute_fungus",
    copy_from = "mon_skeleton_brute_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_hulk_fungus",
    copy_from = "mon_skeleton_hulk_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_child_fungus",
    copy_from = "mon_zombie_child_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_boomer_fungus",
    copy_from = "mon_boomer_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_wretch",
    copy_from = "mon_fungal_wretch",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_raptor",
    copy_from = "mon_fungal_raptor",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_runner_fungal",
    copy_from = "mon_zombie_runner_fungal",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_rot_fungal",
    copy_from = "mon_zombie_rot_fungal",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_tough_fungal",
    copy_from = "mon_zombie_tough_fungal",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_crawler_fungal",
    copy_from = "mon_zombie_crawler_fungal",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_fat_fungus",
    copy_from = "mon_zombie_fat_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_beekeeper_fungal",
    copy_from = "mon_beekeeper_fungal",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_fungus_acidic",
    copy_from = "mon_zombie_fungus_acidic",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_dog_fungus",
    copy_from = "mon_zombie_dog_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zoose_fungus",
    copy_from = "mon_zoose_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zougar_fungus",
    copy_from = "mon_zougar_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_horse_fungus",
    copy_from = "mon_zombie_horse_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_ziger_fungus",
    copy_from = "mon_ziger_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zeer_fungus",
    copy_from = "mon_zeer_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zeindeer_fungus",
    copy_from = "mon_zeindeer_fungus",
    inheritance = { add = { armor = { poison = 14, nether = 6, psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_larva_abstract",
    copy_from = "mon_larva_abstract",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_dark_wyrm",
    copy_from = "mon_dark_wyrm",
    inheritance = { add = { armor = { psionic = 6 } } },
}

ccb.content.define_monster {
    id = "mon_graboid",
    copy_from = "mon_graboid",
    inheritance = { add = { armor = { psionic = 8, poison = 6 } } },
}

ccb.content.define_monster {
    id = "mon_halfworm",
    copy_from = "mon_halfworm",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster { id = "mon_worm", copy_from = "mon_worm", inheritance = { add = { armor = { psionic = 14 } } } }

ccb.content.define_monster {
    id = "mon_worm_small",
    copy_from = "mon_worm_small",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_worm_larva",
    copy_from = "mon_worm_larva",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_large_cockroach",
    copy_from = "mon_large_cockroach",
    inheritance = { add = { armor = { psionic = 14, poison = 8, necrotic = 4 } } },
}

ccb.content.define_monster {
    id = "mon_skittering_plague",
    copy_from = "mon_skittering_plague",
    inheritance = { add = { armor = { psionic = 14, poison = 12, necrotic = 4 } } },
}

ccb.content.define_monster {
    id = "mon_plague_nymph",
    copy_from = "mon_plague_nymph",
    inheritance = { add = { armor = { psionic = 14, poison = 12, necrotic = 4 } } },
}

ccb.content.define_monster {
    id = "mon_plague_vector",
    copy_from = "mon_plague_vector",
    inheritance = { add = { armor = { psionic = 14, poison = 12, necrotic = 4 } } },
}

ccb.content.define_monster {
    id = "mon_giant_cockroach",
    copy_from = "mon_giant_cockroach",
    inheritance = { add = { armor = { psionic = 14, poison = 8, necrotic = 4 } } },
}

ccb.content.define_monster {
    id = "mon_giant_cockroach_nymph",
    copy_from = "mon_giant_cockroach_nymph",
    inheritance = { add = { armor = { psionic = 14, poison = 8, necrotic = 4 } } },
}

ccb.content.define_monster {
    id = "mon_pregnant_giant_cockroach",
    copy_from = "mon_pregnant_giant_cockroach",
    inheritance = { add = { armor = { psionic = 14, poison = 8, necrotic = 4 } } },
}

ccb.content.define_monster {
    id = "mon_bee_small",
    copy_from = "mon_bee_small",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster { id = "mon_bee", copy_from = "mon_bee", inheritance = { add = { armor = { psionic = 14 } } } }

ccb.content.define_monster {
    id = "mon_bee_mega",
    copy_from = "mon_bee_mega",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_centipede_small",
    copy_from = "mon_centipede_small",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_centipede_giant",
    copy_from = "mon_centipede_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_centipede_larva",
    copy_from = "mon_centipede_larva",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_centipede_mom",
    copy_from = "mon_centipede_mom",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_centipede_mega",
    copy_from = "mon_centipede_mega",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_dragonfly_naiad",
    copy_from = "mon_dragonfly_naiad",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_dragonfly_giant",
    copy_from = "mon_dragonfly_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_dragonfly_mega",
    copy_from = "mon_dragonfly_mega",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_firefly",
    copy_from = "mon_firefly",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_fly_small",
    copy_from = "mon_fly_small",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster { id = "mon_fly", copy_from = "mon_fly", inheritance = { add = { armor = { psionic = 14 } } } }

ccb.content.define_monster {
    id = "mon_mosquito_giant",
    copy_from = "mon_mosquito_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_spider_cellar_giant",
    copy_from = "mon_spider_cellar_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_spider_cellar_leg",
    copy_from = "mon_spider_cellar_leg",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_spider_jumping_giant",
    copy_from = "mon_spider_jumping_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_spider_trapdoor_giant",
    copy_from = "mon_spider_trapdoor_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_spider_web",
    copy_from = "mon_spider_web",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_spider_widow_giant",
    copy_from = "mon_spider_widow_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_spider_wolf_giant",
    copy_from = "mon_spider_wolf_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_wasp_pupa",
    copy_from = "mon_wasp_pupa",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_wasp_small",
    copy_from = "mon_wasp_small",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_wasp_queen",
    copy_from = "mon_wasp_queen",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster { id = "mon_wasp", copy_from = "mon_wasp", inheritance = { add = { armor = { psionic = 14 } } } }

ccb.content.define_monster {
    id = "mon_wasp_guard",
    copy_from = "mon_wasp_guard",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_wasp_mega",
    copy_from = "mon_wasp_mega",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_dermatik",
    copy_from = "mon_dermatik",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster { id = "mon_ant", copy_from = "mon_ant", inheritance = { add = { armor = { psionic = 14 } } } }

ccb.content.define_monster {
    id = "mon_ant_acid",
    copy_from = "mon_ant_acid",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_ant_acid_queen",
    copy_from = "mon_ant_acid_queen",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_ant_acid_soldier",
    copy_from = "mon_ant_acid_soldier",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_ant_acid_soldier_mega",
    copy_from = "mon_ant_acid_soldier_mega",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_ant_queen",
    copy_from = "mon_ant_queen",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_ant_soldier",
    copy_from = "mon_ant_soldier",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_ant_soldier_mega",
    copy_from = "mon_ant_soldier_mega",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_locust",
    copy_from = "mon_locust",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster { id = "mon_aphid", copy_from = "mon_aphid", inheritance = { add = { armor = { psionic = 14 } } } }

ccb.content.define_monster {
    id = "mon_mantis_small",
    copy_from = "mon_mantis_small",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mantis_giant",
    copy_from = "mon_mantis_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mantis_mega",
    copy_from = "mon_mantis_mega",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mole_cricket",
    copy_from = "mon_mole_cricket",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_lady_bug",
    copy_from = "mon_lady_bug",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_lady_bug_giant",
    copy_from = "mon_lady_bug_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_grasshopper_giant",
    copy_from = "mon_grasshopper_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_stag_beetle_larva",
    copy_from = "mon_stag_beetle_larva",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_stag_beetle_small",
    copy_from = "mon_stag_beetle_small",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_stag_beetle_giant",
    copy_from = "mon_stag_beetle_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_stag_beetle_mega",
    copy_from = "mon_stag_beetle_mega",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_antlion_larva",
    copy_from = "mon_antlion_larva",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_antlion_giant",
    copy_from = "mon_antlion_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_strider_giant",
    copy_from = "mon_strider_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_butterfly",
    copy_from = "mon_butterfly",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_butterfly_giant",
    copy_from = "mon_butterfly_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster { id = "mon_moth", copy_from = "mon_moth", inheritance = { add = { armor = { psionic = 14 } } } }

ccb.content.define_monster {
    id = "mon_moth_giant",
    copy_from = "mon_moth_giant",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_butterfly_cocoon",
    copy_from = "mon_butterfly_cocoon",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_moth_cocoon",
    copy_from = "mon_moth_cocoon",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_cicada",
    copy_from = "mon_cicada",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_woodlouse",
    copy_from = "mon_woodlouse",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_diving_larva",
    copy_from = "mon_diving_larva",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_diving_beetle_small",
    copy_from = "mon_diving_beetle_small",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_water_scorpion",
    copy_from = "mon_water_scorpion",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_fleshy_shambler",
    copy_from = "mon_fleshy_shambler",
    inheritance = { add = { armor = { nether = 8 } } },
}

ccb.content.define_monster {
    id = "mon_flesh_golem",
    copy_from = "mon_flesh_golem",
    inheritance = { add = { armor = { nether = 8 } } },
}

ccb.content.define_monster {
    id = "mon_jabberwock",
    copy_from = "mon_jabberwock",
    inheritance = { add = { armor = { nether = 14, psionic = 8, necrotic = 4, sonic = -10 } } },
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_GM",
    copy_from = "mon_lab_security_drone_GM",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_YM",
    copy_from = "mon_lab_security_drone_YM",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_BM",
    copy_from = "mon_lab_security_drone_BM",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_BM2",
    copy_from = "mon_lab_security_drone_BM2",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_GR",
    copy_from = "mon_lab_security_drone_GR",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_marloss_zealot_f",
    copy_from = "mon_marloss_zealot_f",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_marloss_zealot_m",
    copy_from = "mon_marloss_zealot_m",
    inheritance = { add = { armor = { poison = 20, nether = 4, psionic = 9 } } },
}

ccb.content.define_monster {
    id = "mon_mech_recon",
    copy_from = "mon_mech_recon",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mech_combat",
    copy_from = "mon_mech_combat",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mech_lifter",
    copy_from = "mon_mech_lifter",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { necrotic = 14 } } },
}

ccb.content.define_monster { id = "mon_mi_go", copy_from = "mon_mi_go", inheritance = { add = { armor = { nether = 14 } } } }

ccb.content.define_monster {
    id = "mon_mi_go_slaver",
    copy_from = "mon_mi_go_slaver",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_surgeon",
    copy_from = "mon_mi_go_surgeon",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_guard",
    copy_from = "mon_mi_go_guard",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_myrmidon",
    copy_from = "mon_mi_go_myrmidon",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_captured",
    copy_from = "mon_mi_go_captured",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_mi_go_scout",
    copy_from = "mon_mi_go_scout",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_amigara_horror",
    copy_from = "mon_amigara_horror",
    inheritance = { add = { flags = { "TIMELESS" }, armor = { nether = 30 } } },
}

ccb.content.define_monster { id = "mon_blank", copy_from = "mon_blank", inheritance = { add = { armor = { nether = 14 } } } }

ccb.content.define_monster {
    id = "mon_breather",
    copy_from = "mon_breather",
    inheritance = { add = { flags = { "PSIONICPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_breather_hub",
    copy_from = "mon_breather_hub",
    inheritance = { add = { flags = { "PSIONICPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_shrapnel_swarm",
    copy_from = "mon_shrapnel_swarm",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { nether = 8 } } },
}

ccb.content.define_monster {
    id = "mon_structural_spur",
    copy_from = "mon_structural_spur",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { nether = 8, sonic = 80 } } },
}

ccb.content.define_monster {
    id = "mon_void_spider",
    copy_from = "mon_void_spider",
    inheritance = { add = { armor = { light = -100, nether = 10 } } },
}

ccb.content.define_monster {
    id = "mon_void_spider_maw",
    copy_from = "mon_void_spider_maw",
    inheritance = { add = { armor = { light = -100, nether = 10 } } },
}

ccb.content.define_monster {
    id = "mon_void_spider_limb",
    copy_from = "mon_void_spider_limb",
    inheritance = { add = { armor = { light = -100, nether = 10 } } },
}

ccb.content.define_monster {
    id = "mon_void_spider_spiderling",
    copy_from = "mon_void_spider_spiderling",
    inheritance = { add = { armor = { light = -100, nether = 10 } } },
}

ccb.content.define_monster {
    id = "mon_darkman",
    copy_from = "mon_darkman",
    inheritance = { add = { armor = { light = -100, nether = 10 } } },
}

ccb.content.define_monster {
    id = "mon_flaming_eye",
    copy_from = "mon_flaming_eye",
    inheritance = { add = { armor = { light = -50, nether = 20 } } },
}

ccb.content.define_monster {
    id = "mon_flying_polyp",
    copy_from = "mon_flying_polyp",
    inheritance = { add = { armor = { nether = 20, necrotic = 10 } } },
}

ccb.content.define_monster {
    id = "mon_star_vampire",
    copy_from = "mon_star_vampire",
    inheritance = { add = { flags = { "TIMELESS" }, armor = { nether = 20 } } },
}

ccb.content.define_monster {
    id = "mon_star_vampire_coiling",
    copy_from = "mon_star_vampire_coiling",
    inheritance = { add = { flags = { "TIMELESS" }, armor = { nether = 20 } } },
}

ccb.content.define_monster {
    id = "mon_unseen_hunter",
    copy_from = "mon_unseen_hunter",
    inheritance = { add = { armor = { nether = 10 } } },
}

ccb.content.define_monster {
    id = "mon_gracke",
    copy_from = "mon_gracke",
    inheritance = { add = { flags = { "TIMELESS" }, armor = { nether = 40 } } },
}

ccb.content.define_monster {
    id = "mon_hound_tindalos",
    copy_from = "mon_hound_tindalos",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_hunting_horror",
    copy_from = "mon_hunting_horror",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster { id = "mon_kreck", copy_from = "mon_kreck", inheritance = { add = { armor = { nether = 14 } } } }

ccb.content.define_monster {
    id = "mon_shadow",
    copy_from = "mon_shadow",
    inheritance = { add = { armor = { light = -60, nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_shadow_snake",
    copy_from = "mon_shadow_snake",
    inheritance = { add = { armor = { light = -60, nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_shoggoth",
    copy_from = "mon_shoggoth",
    inheritance = { add = { armor = { nether = 40, necrotic = -20 } } },
}

ccb.content.define_monster { id = "mon_thing", copy_from = "mon_thing", inheritance = { add = { armor = { nether = 14 } } } }

ccb.content.define_monster {
    id = "mon_vortex",
    copy_from = "mon_vortex",
    inheritance = { add = { flags = { "TIMELESS", "PSIONICPROOF" }, armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_shifting_mass",
    copy_from = "mon_shifting_mass",
    inheritance = { add = { armor = { nether = 40, necrotic = -20 } } },
}

ccb.content.define_monster {
    id = "mon_impossible_shape",
    copy_from = "mon_impossible_shape",
    inheritance = { add = { armor = { nether = 40, necrotic = -20 } } },
}

ccb.content.define_monster {
    id = "mon_absence",
    copy_from = "mon_absence",
    inheritance = { add = { flags = { "TIMELESS", "PSIONICPROOF" }, armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_flatlander",
    copy_from = "mon_flatlander",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_memory",
    copy_from = "mon_memory",
    inheritance = { add = { armor = { nether = 40, necrotic = -20 } } },
}

ccb.content.define_monster {
    id = "mon_swarm_structure",
    copy_from = "mon_swarm_structure",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_twisting_blade",
    copy_from = "mon_twisting_blade",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_archunk_weak",
    copy_from = "mon_archunk_weak",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_archunk_medium",
    copy_from = "mon_archunk_weak",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_archunk_strong",
    copy_from = "mon_archunk_weak",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_pale_reflection",
    copy_from = "mon_twisting_blade",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_tainted_shadow",
    copy_from = "mon_tainted_shadow",
    inheritance = { add = { flags = { "PSIONICPROOF", "POISONPROOF" }, armor = { light = -100, nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_nether_spearfisher",
    copy_from = "mon_nether_spearfisher",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_nether_leech",
    copy_from = "mon_nether_leech",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_nether_fish",
    copy_from = "mon_nether_fish",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_cat_mutant_prism",
    copy_from = "mon_cat_mutant_prism",
    inheritance = { add = { armor = { light = 20 } } },
}

ccb.content.define_monster {
    id = "mon_cat_void",
    copy_from = "mon_cat_void",
    inheritance = { add = { armor = { light = -20 } } },
}

ccb.content.define_monster {
    id = "mon_dog_antimemetic",
    copy_from = "mon_dog_antimemetic",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_leech_blossom",
    copy_from = "mon_leech_blossom",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_leech_stalk",
    copy_from = "mon_leech_stalk",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_leech_pod_cluster",
    copy_from = "mon_leech_pod_cluster",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_leech_root_runner",
    copy_from = "mon_leech_root_runner",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_leech_root_drone",
    copy_from = "mon_leech_root_drone",
    inheritance = { add = { armor = { psionic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_robofac_laserturret_mk1",
    copy_from = "mon_robofac_laserturret_mk1",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_robofac_camspy",
    copy_from = "mon_robofac_camspy",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_robofac_skittergun",
    copy_from = "mon_robofac_skittergun",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_blob",
    copy_from = "mon_blob",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_blob_brain",
    copy_from = "mon_blob_brain",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_blob_large",
    copy_from = "mon_blob_large",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_blob_small",
    copy_from = "mon_blob_small",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_gelatin",
    copy_from = "mon_gelatin",
    inheritance = { add = { flags = { "PSIONICPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_player_blob",
    copy_from = "mon_player_blob",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_slime_ocularium",
    copy_from = "mon_slime_ocularium",
    inheritance = { add = { flags = { "PSIONICPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_biollante_sprig",
    copy_from = "mon_biollante_sprig",
    inheritance = { add = { armor = { poison = 4 } } },
}

ccb.content.define_monster {
    id = "mon_biollante",
    copy_from = "mon_biollante",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_creeper_hub",
    copy_from = "mon_creeper_hub",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_creeper_vine",
    copy_from = "mon_creeper_vine",
    inheritance = { add = { armor = { poison = 4 } } },
}

ccb.content.define_monster {
    id = "mon_triffid_sprig",
    copy_from = "mon_triffid_sprig",
    inheritance = { add = { armor = { poison = 4 } } },
}

ccb.content.define_monster {
    id = "mon_triffid_young",
    copy_from = "mon_triffid_young",
    inheritance = { add = { armor = { poison = 4 } } },
}

ccb.content.define_monster {
    id = "mon_triffid",
    copy_from = "mon_triffid",
    inheritance = { add = { armor = { poison = 10 } } },
}

ccb.content.define_monster {
    id = "mon_triffid_queen",
    copy_from = "mon_triffid_queen",
    inheritance = { add = { armor = { poison = 30 } } },
}

ccb.content.define_monster {
    id = "mon_vinebeast",
    copy_from = "mon_vinebeast",
    inheritance = { add = { armor = { poison = 10 } } },
}

ccb.content.define_monster {
    id = "mon_fungal_fighter",
    copy_from = "mon_fungal_fighter",
    inheritance = { add = { armor = { poison = 40 } } },
}

ccb.content.define_monster {
    id = "mon_triffid_flower",
    copy_from = "mon_triffid_flower",
    inheritance = { add = { armor = { poison = 10 } } },
}

ccb.content.define_monster {
    id = "mon_triffid_heart",
    copy_from = "mon_triffid_heart",
    inheritance = { add = { armor = { poison = 10 } } },
}

ccb.content.define_monster {
    id = "mon_turret",
    copy_from = "mon_turret",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_turret_searchlight",
    copy_from = "mon_turret_searchlight",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_turret_bmg",
    copy_from = "mon_turret_bmg",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_turret_rifle",
    copy_from = "mon_turret_rifle",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_crows_m240",
    copy_from = "mon_crows_m240",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_turret_riot",
    copy_from = "mon_turret_riot",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_turret_speaker",
    copy_from = "mon_turret_speaker",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_exodii_turret",
    copy_from = "mon_exodii_turret",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_turret_artisans",
    copy_from = "mon_turret_artisans",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_grocerybot",
    copy_from = "mon_grocerybot",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_grocerybot_busted",
    copy_from = "mon_grocerybot_busted",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_hazmatbot",
    copy_from = "mon_hazmatbot",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_nursebot",
    copy_from = "mon_nursebot",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_nursebot_defective",
    copy_from = "mon_nursebot_defective",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_yrax_trifacet",
    copy_from = "mon_yrax_trifacet",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_yrax_sphenocorona",
    copy_from = "mon_yrax_sphenocorona",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_golden_monolith",
    copy_from = "mon_golden_monolith",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_yrax_apeirogon",
    copy_from = "mon_yrax_apeirogon",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_yrax_delta",
    copy_from = "mon_yrax_delta",
    inheritance = { add = { flags = { "POISONPROOF", "PSIONICPROOF" }, armor = { necrotic = 20 } } },
}

ccb.content.define_monster {
    id = "mon_dog_skeleton",
    copy_from = "mon_dog_skeleton",
    inheritance = { add = { armor = { necrotic = 8 } } },
}

ccb.content.define_monster {
    id = "mon_dog_skeleton_brute",
    copy_from = "mon_dog_skeleton_brute",
    inheritance = { add = { armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_wolf_skeleton",
    copy_from = "mon_wolf_skeleton",
    inheritance = { add = { armor = { necrotic = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombear_skeleton",
    copy_from = "mon_zombear_skeleton",
    inheritance = { add = { armor = { necrotic = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_horse_white",
    copy_from = "mon_zombie_horse_white",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_horse_pale",
    copy_from = "mon_zombie_horse_pale",
    inheritance = { add = { armor = { necrotic = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_snotgobbler",
    copy_from = "mon_zombie_snotgobbler",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_sproglodyte",
    copy_from = "mon_zombie_sproglodyte",
    inheritance = { add = { armor = { light = -5 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_wretch",
    copy_from = "mon_zombie_wretch",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_master",
    copy_from = "mon_skeleton_master",
    inheritance = { add = { armor = { nether = 14, necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_necro",
    copy_from = "mon_skeleton_necro",
    inheritance = { add = { armor = { nether = 30, necrotic = 14 } } },
}

ccb.content.define_monster { id = "mon_boomer", copy_from = "mon_boomer", inheritance = { add = { armor = { poison = 14 } } } }

ccb.content.define_monster {
    id = "mon_boomer_huge",
    copy_from = "mon_boomer_huge",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag",
    copy_from = "mon_zombie_gasbag",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_relax_gasbag",
    copy_from = "mon_zombie_relax_gasbag",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_tear_gasbag",
    copy_from = "mon_zombie_tear_gasbag",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_boomer_glutton",
    copy_from = "mon_boomer_glutton",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_boomer_claymore",
    copy_from = "mon_boomer_claymore",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_rust",
    copy_from = "mon_zombie_rust",
    inheritance = { add = { armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_shell",
    copy_from = "mon_zombie_shell",
    inheritance = { add = { armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_plated",
    copy_from = "mon_zombie_plated",
    inheritance = { add = { armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_urchin",
    copy_from = "mon_zombie_urchin",
    inheritance = { add = { armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_hammer_hands",
    copy_from = "mon_zombie_hammer_hands",
    inheritance = { add = { armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_devourer",
    copy_from = "mon_devourer",
    inheritance = { add = { armor = { necrotic = 14, poison = 10, psionic = 10, nether = 8 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag_immobile",
    copy_from = "mon_zombie_gasbag_immobile",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag_crawler",
    copy_from = "mon_zombie_gasbag_crawler",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_gasbag_impaler",
    copy_from = "mon_zombie_gasbag_impaler",
    inheritance = { add = { armor = { poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_phase_skulker",
    copy_from = "mon_zombie_phase_skulker",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_phase_shrike",
    copy_from = "mon_zombie_phase_shrike",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_lieutenant_shadow",
    copy_from = "mon_lieutenant_shadow",
    inheritance = { add = { armor = { light = -40, nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_frog_mother",
    copy_from = "mon_frog_mother",
    inheritance = { add = { armor = { nether = 14, necrotic = -20, poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_brainless",
    copy_from = "mon_zombie_brainless",
    inheritance = { add = { flags = { "PSIONICPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_afs_headless_horror",
    copy_from = "mon_afs_headless_horror",
    inheritance = { add = { flags = { "PSIONICPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_grue",
    copy_from = "mon_zombie_grue",
    inheritance = { add = { armor = { light = -10, nether = 20 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_ears",
    copy_from = "mon_zombie_ears",
    inheritance = { add = { flags = { "PSIONICPROOF" }, armor = { sonic = -20 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_nemesis",
    copy_from = "mon_zombie_nemesis",
    inheritance = { add = { armor = { nether = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_master",
    copy_from = "mon_zombie_master",
    inheritance = { add = { armor = { nether = 20 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_necro",
    copy_from = "mon_zombie_necro",
    inheritance = { add = { armor = { nether = 30 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_necro_boomer",
    copy_from = "mon_zombie_necro_boomer",
    inheritance = { add = { armor = { nether = 30, poison = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_regenerating",
    copy_from = "mon_zombie_regenerating",
    inheritance = { add = { armor = { necrotic = -14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_shady",
    copy_from = "mon_zombie_shady",
    inheritance = { add = { armor = { light = -14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_skull",
    copy_from = "mon_zombie_skull",
    inheritance = { add = { flags = { "PSIONICPROOF" }, armor = { sonic = -10 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton",
    copy_from = "mon_skeleton",
    inheritance = { add = { armor = { necrotic = 8 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_brute",
    copy_from = "mon_skeleton_brute",
    inheritance = { add = { armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_electric",
    copy_from = "mon_skeleton_electric",
    inheritance = { add = { armor = { necrotic = 8 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_hulk",
    copy_from = "mon_skeleton_hulk",
    inheritance = { add = { armor = { necrotic = 30 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_kevlar_2",
    copy_from = "mon_zombie_kevlar_2",
    inheritance = { add = { armor = { necrotic = 14 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_medical_regenerating",
    copy_from = "mon_zombie_medical_regenerating",
    inheritance = { add = { armor = { necrotic = -10 } } },
}

ccb.content.define_monster {
    id = "mon_skeleton_medical",
    copy_from = "mon_skeleton_medical",
    inheritance = { add = { armor = { necrotic = 14 } } },
}
