local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_outpost_normal_0",
    result = "faction_base_outpost_normal_0",
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
        update = "fbmc_outpost_normal_0",
        name = content.text("basic survey"),
        provides = {
            { id = "tool_storage" },
            { id = "gathering" },
            { id = "firewood" },
            { id = "foraging" },
            { id = "sorting" },
            { id = "logging" },
            { id = "kitchen" },
            { id = "kitchen_recipes_1" },
            { id = "primitive_camp_recipes_1" },
            { id = "fbmc_outpost_normal_0" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_outpost_normal_bed_0",
    result = "faction_base_outpost_normal_bed_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a bunk bed."),
}
    :camp_blueprint {
        update = "fbmc_outpost_normal_bed_0",
        name = content.text("bunk bed"),
        provides = {
            { id = "fbmc_outpost_normal_bed_0" },
        },
        requires = {
            { id = "fbmc_outpost_normal_0" },
        },
        excludes = {
            { id = "fbmc_outpost_normal_bed_0" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_outpost_normal_root_cellar",
    result = "faction_base_outpost_normal_root_cellar",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a root cellar will allow us to preserve any small game that we trap."),
}
    :camp_blueprint {
        update = "fbmc_outpost_normal_root_cellar",
        name = content.text("root cellar"),
        provides = {
            { id = "fbmc_outpost_normal_root_cellar" },
            { id = "pantry" },
            { id = "trapping" },
        },
        requires = {
            { id = "fbmc_outpost_normal_0" },
        },
        excludes = {
            { id = "fbmc_outpost_normal_root_cellar" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_outpost_normal_butchery_rack",
    result = "faction_base_outpost_normal_butchery_rack",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Building a butchery rack will allow us to hunt bigger animals."),
}
    :camp_blueprint {
        update = "fbmc_outpost_normal_butchery_rack",
        name = content.text("butchery rack"),
        provides = {
            { id = "fbmc_outpost_normal_butchery_rack" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmc_outpost_normal_root_cellar" },
        },
        excludes = {
            { id = "fbmc_outpost_normal_butchery_rack" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_outpost_normal_water_well",
    result = "faction_base_outpost_normal_water_well",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a well will give us easy access to water and allow us to start small farm."),
}
    :camp_blueprint {
        update = "fbmc_outpost_normal_water_well",
        name = content.text("water well"),
        provides = {
            { id = "fbmc_outpost_normal_water_well" },
        },
        requires = {
            { id = "fbmc_outpost_normal_0" },
        },
        excludes = {
            { id = "fbmc_outpost_normal_water_well" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_outpost_normal_farm",
    result = "faction_base_outpost_normal_farm",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's plow some plots."),
}
    :quality("DIG", 1, 1)
    :camp_blueprint {
        update = "fbmc_outpost_normal_farm",
        name = content.text("small farm"),
        provides = {
            { id = "fbmc_outpost_normal_farm" },
            { id = "farming" },
        },
        requires = {
            { id = "fbmc_outpost_normal_water_well" },
        },
        excludes = {
            { id = "fbmc_outpost_normal_farm" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_outpost_normal_generator",
    result = "faction_base_outpost_normal_generator",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could try to fix the reactor's controller to power lights, it would really help us in planning missions."),
}
    :camp_blueprint {
        update = "fbmc_outpost_normal_generator",
        name = content.text("fix reactor's controller"),
        provides = {
            { id = "fbmc_outpost_normal_generator" },
            { id = "walls" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "fbmc_outpost_normal_0" },
        },
        excludes = {
            { id = "fbmc_outpost_normal_generator" },
        },
        check_needs = false,
        needs = {
            duration_moves = 8640000,
            skills = { ["electronics"] = 8 },
            tools = {
                { { id = "hazmat_suit", count = 1 } },
                { { id = "mask_gas", charges = 50 } },
                { { id = "soldering_iron", charges = 50 }, { id = "soldering_iron_portable", charges = 50 }, { id = "integrated_electrokit", charges = 50 } },
            },
            qualities = {
                { { id = "SCREW", level = 1, count = 1 } },
                { { id = "SCREW_FINE", level = 1, count = 1 } },
                { { id = "WRENCH", level = 1, count = 1 } },
                { { id = "WRENCH_FINE", level = 1, count = 1 } },
            },
            components = {
                { { id = "solder_wire", count = 50 } },
                { { id = "processor", count = 2 } },
                { { id = "RAM", count = 8 } },
                { { id = "cable", count = 4 } },
                { { id = "e_scrap", count = 20 } },
                { { id = "circuit", count = 10 } },
                { { id = "ai_module_basic", count = 1 }, { id = "ai_module", count = 1 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_outpost_normal_radio",
    result = "faction_base_outpost_normal_radio",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's set up a radio tower to improve our recruitment efforts, we will redirect some power into it from nuclear reactor."),
}
    :camp_blueprint {
        update = "fbmc_outpost_normal_radio",
        name = content.text("radio tower"),
        provides = {
            { id = "fbmc_outpost_normal_radio" },
            { id = "recruiting" },
            { id = "radio" },
        },
        requires = {
            { id = "fbmc_outpost_normal_generator" },
        },
        excludes = {
            { id = "fbmc_outpost_normal_radio" },
        },
        check_needs = false,
        needs = {
            duration_moves = 8640000,
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
                { { id = "sheet_metal", count = 2 }, { id = "lc_wire", count = 8 } },
                { { id = "pipe", count = 24 } },
                { { id = "processor", count = 2 } },
                { { id = "RAM", count = 2 } },
                { { id = "large_lcd_screen", count = 1 } },
                { { id = "e_scrap", count = 8 } },
                { { id = "frame", count = 1 } },
                { { id = "circuit", count = 4 } },
                { { id = "power_supply", count = 2 } },
                { { id = "amplifier", count = 2 } },
                { { id = "cable", count = 27 } },
                { { id = "motor_small", count = 1 }, { id = "motor_tiny", count = 2 } },
            },
        },
    }
)
