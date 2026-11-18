local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_shelter_0",
    result = "faction_base_shelter_0",
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
        update = "fbmc_shelter_0",
        name = content.text("basic survey"),
        provides = {
            { id = "gathering" },
            { id = "fbmc_shelter_recipes_1" },
            { id = "fbmc_shelter_0" },
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
    id = "faction_base_modular_shelter_fireplace",
    result = "faction_base_modular_shelter_fireplace",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a fireplace for cooking and grab a pot.  Let's set up near the working terminal."),
}
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "clay_pot", count = 1 }
        })
    :camp_blueprint {
        update = "fbmc_shelter_fireplace",
        name = content.text("build a fireplace"),
        provides = {
            { id = "fbmc_shelter_fire" },
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "fbmc_shelter_cooking_recipes_1" },
        },
        requires = {
            { id = "fbmc_shelter_0" },
        },
        excludes = {
            { id = "fbmc_shelter_fire" },
        },
        resources = { "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_brazier",
    result = "faction_base_modular_shelter_brazier",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should build a brazier for cooking and grab a pot.  Let's set up near the working terminal."),
}
    :component("brazier", 1)
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "clay_pot", count = 1 }
        })
    :camp_blueprint {
        update = "fbmc_shelter_brazier",
        name = content.text("build a brazier"),
        provides = {
            { id = "fbmc_shelter_fire" },
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "fbmc_shelter_cooking_recipes_1" },
        },
        requires = {
            { id = "fbmc_shelter_0" },
        },
        excludes = {
            { id = "fbmc_shelter_fire" },
        },
        resources = { "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_stove",
    result = "faction_base_modular_shelter_stove",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should build a wood stove for cooking and grab a pot.  Let's set up near the working terminal."),
}
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "clay_pot", count = 1 }
        })
    :camp_blueprint {
        update = "fbmc_shelter_stove",
        name = content.text("build a wood stove"),
        provides = {
            { id = "fbmc_shelter_fire" },
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "fbmc_shelter_cooking_recipes_1" },
        },
        requires = {
            { id = "fbmc_shelter_0" },
        },
        excludes = {
            { id = "fbmc_shelter_fire" },
        },
        resources = { "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_well",
    result = "faction_base_modular_shelter_well",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a well, put it near the terminal.  This will make our future here more secure."),
}
    :camp_blueprint {
        update = "fbmc_shelter_well",
        name = content.text("build a well"),
        provides = {
            { id = "fbmc_shelter_well" },
            { id = "relaying" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "fbmc_shelter_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_well" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_beds_SE",
    result = "faction_base_modular_shelter_beds_SE",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the southeast bedroom with beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_beds_SE",
        name = content.text("furnish the SE bedroom"),
        provides = {
            { id = "fbmc_shelter_beds_se" },
        },
        requires = {
            { id = "fbmc_shelter_bedroom1" },
        },
        excludes = {
            { id = "fbmc_shelter_beds_se" },
        },
        parameter_labels = {
            ["fbmc_bed_palette"] = {
                ["fbmc_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmc_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmc_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_beds_E",
    result = "faction_base_modular_shelter_beds_E",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the east bedroom with beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_beds_E",
        name = content.text("furnish the E bedroom"),
        provides = {
            { id = "fbmc_shelter_beds_e" },
        },
        requires = {
            { id = "fbmc_shelter_bedroom2" },
            { id = "fbmc_shelter_beds_se" },
        },
        excludes = {
            { id = "fbmc_shelter_beds_e" },
        },
        parameter_labels = {
            ["fbmc_bed_palette"] = {
                ["fbmc_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmc_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmc_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_beds_SW",
    result = "faction_base_modular_shelter_beds_SW",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the southwest bedroom with beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_beds_SW",
        name = content.text("furnish the SW bedroom"),
        provides = {
            { id = "fbmc_shelter_beds_sw" },
        },
        requires = {
            { id = "fbmc_shelter_bedroom3" },
            { id = "fbmc_shelter_beds_e" },
        },
        excludes = {
            { id = "fbmc_shelter_beds_sw" },
        },
        parameter_labels = {
            ["fbmc_bed_palette"] = {
                ["fbmc_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmc_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmc_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_beds_W",
    result = "faction_base_modular_shelter_beds_W",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the west bedroom with beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_beds_W",
        name = content.text("furnish the W bedroom"),
        provides = {
            { id = "fbmc_shelter_beds_w" },
        },
        requires = {
            { id = "fbmc_shelter_bedroom4" },
            { id = "fbmc_shelter_beds_sw" },
        },
        excludes = {
            { id = "fbmc_shelter_beds_w" },
        },
        parameter_labels = {
            ["fbmc_bed_palette"] = {
                ["fbmc_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmc_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmc_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_beds_NW",
    result = "faction_base_modular_shelter_beds_NW",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the northwest bedroom with beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_beds_NW",
        name = content.text("furnish the NW bedroom"),
        provides = {
            { id = "fbmc_shelter_beds_nw" },
        },
        requires = {
            { id = "fbmc_shelter_bedroom5" },
            { id = "fbmc_shelter_beds_w" },
        },
        excludes = {
            { id = "fbmc_shelter_beds_nw" },
        },
        parameter_labels = {
            ["fbmc_bed_palette"] = {
                ["fbmc_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmc_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmc_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_diningroom",
    result = "faction_base_modular_shelter_diningroom",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's make a dining area."),
}
    :camp_blueprint {
        update = "fbmc_shelter_dining",
        name = content.text("furnish the dining room"),
        provides = {
            { id = "fbmc_shelter_dining" },
        },
        requires = {
            { id = "fbmc_shelter_beds_se" },
        },
        excludes = {
            { id = "fbmc_shelter_dining" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_livingroom",
    result = "faction_base_modular_shelter_livingroom",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's make a living room area."),
}
    :camp_blueprint {
        update = "fbmc_shelter_livingroom",
        name = content.text("furnish the living room"),
        provides = {
            { id = "fbmc_shelter_livingroom" },
        },
        requires = {
            { id = "fbmc_shelter_beds_se" },
        },
        excludes = {
            { id = "fbmc_shelter_livingroom" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_pantry",
    result = "faction_base_modular_shelter_pantry",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some pantry storage."),
}
    :camp_blueprint {
        update = "fbmc_shelter_pantry",
        name = content.text("build some wooden racks"),
        provides = {
            { id = "fbmc_shelter_pantry" },
            { id = "pantry" },
            { id = "sorting" },
            { id = "tool_storage" },
        },
        requires = {
            { id = "fbmc_shelter_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_pantry" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_craftspot",
    result = "faction_base_modular_shelter_craftspot",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a work bench."),
}
    :camp_blueprint {
        update = "fbmc_shelter_craftspot",
        name = content.text("build a work bench"),
        provides = {
            { id = "fbmc_shelter_craftspot" },
            { id = "tool_storage" },
        },
        requires = {
            { id = "fbmc_shelter_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_craftspot" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_radio",
    result = "faction_base_modular_shelter_radio",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's set up a radio tower to improve our recruitment efforts."),
}
    :camp_blueprint {
        update = "fbmc_shelter_radio_console",
        name = content.text("build a radio tower and console"),
        provides = {
            { id = "fbmc_shelter_radio" },
            { id = "recruiting" },
            { id = "radio" },
        },
        requires = {
            { id = "fbmc_shelter_well" },
        },
        excludes = {
            { id = "fbmc_shelter_radio" },
        },
    }
)
