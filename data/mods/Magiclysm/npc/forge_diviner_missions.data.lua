local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_ANTS",
    name = ccb.content.text("Visit the anthill"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be giant ants here."),
    destination = "anthill",
    start = { target = { terrain = "anthill", special = "anthill", reveal_radius = 3, cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_ACID_ANTS",
    name = ccb.content.text("Visit the acid anthill"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be giant acid ants here."),
    destination = "acid_anthill",
    start = { target = { terrain = "acid_anthill", reveal_radius = 3, cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_DERMATIK",
    name = ccb.content.text("Visit the dermatiks"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be dermatiks here."),
    destination = "nest_dermatik",
    start = {
        target = {
            terrain = "nest_dermatik",
            special = "Large Dermatik Nest",
            reveal_radius = 3,
            cant_see = true,
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_SPIDER_WEB",
    name = ccb.content.text("Visit the spider web"),
    goal = "MGOAL_GO_TO",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a spider web here."),
    start = { target = { terrain = "forest", reveal_radius = 3, special = "mx_spider", cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_SPIDER_PIT",
    name = ccb.content.text("Visit the spider pit"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a pit full of spiders here."),
    destination = "spider_pit",
    start = { target = { terrain = "spider_pit", special = "Spider Pit", reveal_radius = 3, cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_SPIDER_DEMON",
    name = ccb.content.text("Visit the demon spiders"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be demon spiders here."),
    destination = "demon_spider_lair",
    start = {
        target = {
            terrain = "demon_spider_lair",
            special = "demon_spider_lair",
            reveal_radius = 3,
            cant_see = true,
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_FUNGAL_BLOOM",
    name = ccb.content.text("Visit the fungal bloom"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a fungal bloom here."),
    destination = "fungal_bloom",
    start = {
        target = { terrain = "fungal_bloom", special = "Fungal Bloom", reveal_radius = 3, cant_see = true },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_FUNGAL_TOWER",
    name = ccb.content.text("Visit the fungal tower"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a fungal tower here."),
    destination = "fungal_tower",
    start = {
        target = { terrain = "fungal_tower", special = "Fungal Tower", reveal_radius = 3, cant_see = true },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_FUNGAL_FLOWERS",
    name = ccb.content.text("Visit the fungal flowers"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be fungal flowers here."),
    destination = "fungal_flowers",
    start = {
        target = { terrain = "fungal_flowers", special = "Fungal Flowers", reveal_radius = 3, cant_see = true },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_MI_GO_ENCAMPMENT",
    name = ccb.content.text("Visit the mi-go encampment"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a mi-go encampment here."),
    destination = "mi-go_camp1",
    start = {
        target = { terrain = "mi-go_camp1", special = "Mi-Go Encampment", reveal_radius = 3, cant_see = true },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_MI_GO_TOWER",
    name = ccb.content.text("Visit the mi-go tower"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a mi-go tower here."),
    destination = "mi-go_scout_tower_1",
    start = {
        target = {
            terrain = "mi-go_scout_tower_1",
            special = "Mi-Go Scout Tower",
            reveal_radius = 3,
            cant_see = true,
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_TRIFFID",
    name = ccb.content.text("Visit the triffid grove"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be triffids here."),
    destination = "triffid_grove",
    start = {
        target = { terrain = "triffid_grove", special = "Triffid Grove", reveal_radius = 3, cant_see = true },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_KRAKEN",
    name = ccb.content.text("Visit the kraken cave"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a kraken cave here."),
    destination = "river_cave",
    start = { target = { terrain = "river_cave", reveal_radius = 3, cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_SLIME",
    name = ccb.content.text("Visit the slime pit"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a slime pit here."),
    destination = "slimepit_z0",
    start = { target = { terrain = "slimepit_z0", special = "Slime Pit", reveal_radius = 3, cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_GOBLIN_ENCAMPMENT",
    name = ccb.content.text("Visit the goblin encampment"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a goblin encampment here."),
    destination = "goblin_1A",
    start = {
        target = { terrain = "goblin_1A", special = "goblin_encampment", reveal_radius = 3, cant_see = true },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_GOBLIN_OUTPOST",
    name = ccb.content.text("Visit the goblin outpost"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a goblin outpost here."),
    destination = "orc_village",
    start = {
        target = { terrain = "orc_village", special = "orc_village", reveal_radius = 3, cant_see = true },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_SWAMP_DRAGON",
    name = ccb.content.text("Visit the dragon"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that here be swamp dragons."),
    destination = "black_dragon_lair_z-0_NW",
    start = {
        target = {
            terrain = "black_dragon_lair_z-0_NW",
            special = "black_dragon_lair",
            reveal_radius = 3,
            cant_see = true,
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_BALROG",
    name = ccb.content.text("Visit the balrog"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a balrog here."),
    destination = "mine_balrog_central",
    start = {
        target = {
            terrain = "mine_balrog_central",
            special = "Balrog mine",
            reveal_radius = 3,
            cant_see = true,
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_LAB",
    name = ccb.content.text("Visit the lab"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a lab here."),
    destination = "microlab_generic_surface",
    start = {
        target = {
            terrain = "microlab_generic_surface",
            special = "4x4_microlab_surface",
            reveal_radius = 3,
            cant_see = true,
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_LAB_NETHER",
    name = ccb.content.text("Visit the nether lab"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a nether lab here."),
    destination = "nether_elevator_above",
    start = { target = { terrain = "nether_elevator_above", reveal_radius = 3, cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_EXODII",
    name = ccb.content.text("Visit the Exodii"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be Exodii here."),
    destination = "exodii_base_x0y0z0",
    start = {
        target = {
            terrain = "exodii_base_x0y3z0",
            special = "exodii_base",
            reveal_radius = 3,
            cant_see = true,
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_TEMPLE",
    name = ccb.content.text("Visit the strange temple"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a strange temple."),
    destination = "temple_stairs",
    start = {
        target = { terrain = "temple_stairs", special = "Strangle Temple", reveal_radius = 3, cant_see = true },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_ATTUNEMENT",
    name = ccb.content.text("Visit the attunement altar"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be an attunement altar here."),
    destination = "attunement_altar_NW",
    start = {
        target = {
            terrain = "attunement_altar_NW",
            special = "attunement altar",
            reveal_radius = 3,
            cant_see = true,
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_ACADEMY",
    name = ccb.content.text("Visit the magic academy"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a magic academy here."),
    destination = "magic_academy_ground",
    start = { target = { terrain = "magic_academy_ground", reveal_radius = 3, cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_TOWER1",
    name = ccb.content.text("Visit the wizard tower"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a wizard tower here."),
    destination = "wizardtower1_ground",
    start = { target = { terrain = "wizardtower1_ground", reveal_radius = 3, cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_TOWER2",
    name = ccb.content.text("Visit the wizard tower"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a wizard tower with an altar here."),
    destination = "wizardtower2_ground",
    start = { target = { terrain = "wizardtower2_ground", reveal_radius = 3, cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_DRUID_TOWER",
    name = ccb.content.text("Visit the druid tower"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a druid tower here."),
    destination = "druid_ritual_home_z0",
    start = {
        target = {
            terrain = "druid_ritual_home_z0",
            special = "druid_tower",
            reveal_radius = 3,
            cant_see = true,
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_RIVER",
    name = ccb.content.text("Visit the river"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a river here."),
    destination = "river_center",
    start = { target = { terrain = "river_center", reveal_radius = 3, cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_CLAY",
    name = ccb.content.text("Visit the clay deposit"),
    goal = "MGOAL_GO_TO",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a clay deposit here."),
    start = {
        target = { terrain = "forest", reveal_radius = 3, special = "mx_clay_deposit", cant_see = true },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_SAND",
    name = ccb.content.text("Visit the sand patch"),
    goal = "MGOAL_GO_TO",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you there would be a sand patch here."),
    start = { target = { terrain = "field", reveal_radius = 3, special = "mx_sand_patch", cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_SPRING",
    name = ccb.content.text("Visit the hot spring"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a hot spring here."),
    destination = "hot_springs",
    start = {
        target = { terrain = "hot_springs", special = "Hot Springs", reveal_radius = 3, cant_see = true },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_CAVE",
    name = ccb.content.text("Visit the cave"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a cave here."),
    destination = "cave",
    start = { target = { terrain = "cave", special = "Cave", reveal_radius = 3, cant_see = true } },
}

-- Innawood uses a different terrain ID for caves
ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_CAVE_INNAWOOD",
    name = ccb.content.text("Visit the cave"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a cave here."),
    destination = "cave_innawood",
    start = { target = { terrain = "cave_innawood", special = "Cave", reveal_radius = 3, cant_see = true } },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_MAGIC_PLANT",
    name = ccb.content.text("Visit the magic field"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be a field of magical flowers here."),
    destination = "magic_field_a1",
    start = {
        target = { terrain = "magic_field_a1", special = "magic_field", reveal_radius = 3, cant_see = true },
    },
}

ccb.content.define_mission {
    id = "MISSION_FORGE_DIVINER_LOVECRAFTIAN",
    name = ccb.content.text("Visit the Lovecraftian horror"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 0,
    value = 0,
    description = ccb.content.text("The diviner told you that there would be the corpse of a Lovecraftian horror here."),
    destination = "corpse_tentacle_surface_entry",
    start = {
        target = {
            terrain = "corpse_tentacle_surface_entry",
            special = "nether_monster_corpse",
            reveal_radius = 2,
            cant_see = true,
        },
    },
}
