local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_radio_tower_0",
    result = "faction_base_radio_tower_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should survey the base site and set up a bulletin board."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_0",
        name = content.text("basic survey"),
        provides = {
            { id = "fbmc_radio_tower_0" },
            { id = "fbmc_radio_tower" },
            { id = "primitive_camp_recipes_1" },
            { id = "gathering" },
            { id = "firewood" },
            { id = "foraging" },
            { id = "sorting" },
            { id = "logging" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_1_0",
    result = "faction_base_radio_tower_1_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should survey the base site and set up a bulletin board."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_1",
        name = content.text("basic survey"),
        provides = {
            { id = "fbmc_radio_tower_1" },
            { id = "fbmc_radio_tower" },
            { id = "primitive_camp_recipes_1" },
            { id = "gathering" },
            { id = "firewood" },
            { id = "foraging" },
            { id = "sorting" },
            { id = "logging" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_root_cellar",
    result = "faction_base_radio_tower_root_cellar",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a root cellar will give us a way to preserve food."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_root_cellar",
        name = content.text("root cellar"),
        provides = {
            { id = "pantry" },
            { id = "trapping" },
            { id = "fbmc_radio_tower_root_cellar" },
        },
        requires = {
            { id = "fbmc_radio_tower" },
        },
        excludes = {
            { id = "fbmc_radio_tower_root_cellar" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_water_well",
    result = "faction_base_radio_tower_water_well",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a well will give us easy access to water."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_water_well",
        name = content.text("water well"),
        provides = {
            { id = "relaying" },
            { id = "fbmc_radio_tower_water_well" },
        },
        requires = {
            { id = "fbmc_radio_tower" },
        },
        excludes = {
            { id = "fbmc_radio_tower_water_well" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_fix_controls",
    result = "faction_base_radio_tower_fix_controls",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's fix up radio tower and controls to improve our recruitment efforts."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_fix_controls",
        name = content.text("fix radio tower and controls"),
        provides = {
            { id = "fbmc_radio_tower_fix_controls" },
            { id = "recruiting" },
            { id = "scouting" },
            { id = "patrolling" },
            { id = "radio" },
        },
        requires = {
            { id = "fbmc_radio_tower_water_well" },
            { id = "fbmc_radio_tower_root_cellar" },
        },
        excludes = {
            { id = "fbmc_radio_tower_fix_controls" },
        },
        check_needs = false,
        needs = {
            duration_moves = 3600000,
            skills = { ["fabrication"] = 3 },
            tools = {
            },
            qualities = {
                { { id = "HAMMER", level = 2, count = 1 } },
                { { id = "SAW_M", level = 1, count = 1 } },
                { { id = "SCREW", level = 1, count = 1 } },
                { { id = "WRENCH", level = 1, count = 1 } },
            },
            components = {
                { { id = "wind_turbine", count = 4 }, { id = "xl_wind_turbine", count = 1 }, { id = "solar_panel", count = 4 }, { id = "reinforced_solar_panel", count = 4 }, { id = "solar_panel_v2", count = 2 }, { id = "reinforced_solar_panel_v2", count = 2 } },
                { { id = "storage_battery", count = 1 }, { id = "medium_storage_battery", count = 4 }, { id = "small_storage_battery", count = 32 } },
                { { id = "processor", count = 1 } },
                { { id = "RAM", count = 1 } },
                { { id = "large_lcd_screen", count = 1 } },
                { { id = "e_scrap", count = 2 } },
                { { id = "circuit", count = 2 } },
                { { id = "power_supply", count = 1 } },
                { { id = "amplifier", count = 1 } },
                { { id = "cable", count = 54 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_0_prepalisade",
    result = "faction_base_radio_tower_0_prepalisade",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should dig pits for palisade around camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_0_prepalisade",
        name = content.text("dig pits"),
        provides = {
            { id = "fbmc_radio_tower_0_prepalisade" },
        },
        requires = {
            { id = "fbmc_radio_tower_0" },
            { id = "fbmc_radio_tower_shack_5" },
        },
        excludes = {
            { id = "fbmc_radio_tower_prepalisade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_1_prepalisade",
    result = "faction_base_radio_tower_1_prepalisade",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should dig pits for palisade around camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_1_prepalisade",
        name = content.text("dig pits"),
        provides = {
            { id = "fbmc_radio_tower_1_prepalisade" },
        },
        requires = {
            { id = "fbmc_radio_tower_1" },
            { id = "fbmc_radio_tower_shack_8" },
        },
        excludes = {
            { id = "fbmc_radio_tower_prepalisade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_0_palisade",
    result = "faction_base_radio_tower_0_palisade",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build palisade around camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_0_palisade",
        name = content.text("build palisade"),
        provides = {
            { id = "fbmc_radio_tower_0_palisade" },
            { id = "fbmc_radio_tower_palisade" },
            { id = "walls" },
        },
        requires = {
            { id = "fbmc_radio_tower_0_prepalisade" },
        },
        excludes = {
            { id = "fbmc_radio_tower_palisade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_1_palisade",
    result = "faction_base_radio_tower_1_palisade",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build palisade around camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_1_palisade",
        name = content.text("build palisade"),
        provides = {
            { id = "fbmc_radio_tower_1_palisade" },
            { id = "fbmc_radio_tower_palisade" },
            { id = "walls" },
        },
        requires = {
            { id = "fbmc_radio_tower_1_prepalisade" },
        },
        excludes = {
            { id = "fbmc_radio_tower_palisade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_fix_tower",
    result = "faction_base_radio_tower_fix_tower",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could try to fix whole tower and supply it with enough power, which could give us remote access to computer systems connected to backbone network or communication satellites."),
}
    :requirement("soldering_standard", 200)
    :requirement("welding_standard", 80)
    :camp_blueprint {
        update = "faction_base_radio_tower_fix_tower",
        name = content.text("fix whole radio tower"),
        provides = {
            { id = "faction_base_radio_tower_fix_tower" },
            { id = "hack_recipes_general" },
            { id = "hack_recipes_science" },
            { id = "hack_recipes_satellite" },
        },
        requires = {
            { id = "fbmc_radio_tower_palisade" },
            { id = "fbmc_radio_tower_fix_controls" },
        },
        excludes = {
            { id = "faction_base_radio_tower_fix_tower" },
        },
        check_needs = false,
        needs = {
            duration_moves = 25920000,
            skills = { ["fabrication"] = 3, ["computer"] = 4, ["electronics"] = 8 },
            tools = {
                { { id = "laptop", charges = 600 } },
                { { id = "radio_book", count = 1 } },
            },
            qualities = {
                { { id = "HAMMER", level = 2, count = 1 } },
                { { id = "SAW_M", level = 1, count = 1 } },
                { { id = "SCREW", level = 1, count = 1 } },
                { { id = "SCREW_FINE", level = 1, count = 1 } },
                { { id = "WRENCH", level = 2, count = 1 } },
                { { id = "WRENCH_FINE", level = 1, count = 1 } },
                { { id = "GLARE", level = 1, count = 1 } },
            },
            components = {
                { { id = "wind_turbine", count = 16 }, { id = "xl_wind_turbine", count = 4 }, { id = "solar_panel", count = 16 }, { id = "reinforced_solar_panel", count = 16 }, { id = "solar_panel_v2", count = 8 }, { id = "reinforced_solar_panel_v2", count = 8 } },
                { { id = "storage_battery", count = 4 }, { id = "medium_storage_battery", count = 16 } },
                { { id = "sheet_metal", count = 8 }, { id = "lc_wire", count = 32 } },
                { { id = "pipe", count = 24 } },
                { { id = "processor", count = 16 } },
                { { id = "RAM", count = 16 } },
                { { id = "e_scrap", count = 40 } },
                { { id = "frame", count = 1 } },
                { { id = "circuit", count = 32 } },
                { { id = "power_supply", count = 16 } },
                { { id = "amplifier", count = 16 } },
                { { id = "cable", count = 134 } },
                { { id = "software_electronics_reference", count = 1 } },
            },
        },
    }
)
