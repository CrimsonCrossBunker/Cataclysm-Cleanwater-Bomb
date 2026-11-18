local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_shelter_1_0",
    result = "faction_base_shelter_1_0",
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
        update = "fbmc_shelter_1_0",
        name = content.text("basic survey"),
        provides = {
            { id = "gathering" },
            { id = "fbmc_shelter_1_recipes_1" },
            { id = "fbmc_shelter_1_0" },
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
    id = "faction_base_modular_shelter_1_fireplace",
    result = "faction_base_modular_shelter_1_fireplace",
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
        update = "fbmc_shelter_1_fireplace",
        name = content.text("build a fireplace"),
        provides = {
            { id = "fbmc_shelter_1_fire" },
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "fbmc_shelter_1_cooking_recipes_1" },
        },
        requires = {
            { id = "fbmc_shelter_1_0" },
        },
        excludes = {
            { id = "fbmc_shelter_1_fire" },
        },
        resources = { "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_brazier",
    result = "faction_base_modular_shelter_1_brazier",
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
        update = "fbmc_shelter_1_brazier",
        name = content.text("build a brazier"),
        provides = {
            { id = "fbmc_shelter_1_fire" },
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "fbmc_shelter_1_cooking_recipes_1" },
        },
        requires = {
            { id = "fbmc_shelter_1_0" },
        },
        excludes = {
            { id = "fbmc_shelter_1_fire" },
        },
        resources = { "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_stove",
    result = "faction_base_modular_shelter_1_stove",
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
        update = "fbmc_shelter_1_stove",
        name = content.text("build a wood stove"),
        provides = {
            { id = "fbmc_shelter_1_fire" },
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "fbmc_shelter_1_cooking_recipes_1" },
        },
        requires = {
            { id = "fbmc_shelter_1_0" },
        },
        excludes = {
            { id = "fbmc_shelter_1_fire" },
        },
        resources = { "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_well",
    result = "faction_base_modular_shelter_1_well",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a well, put it near the terminal.  This will make our future here more secure."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_well",
        name = content.text("build a well"),
        provides = {
            { id = "fbmc_shelter_1_well" },
            { id = "relaying" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "fbmc_shelter_1_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_1_well" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_bed_NW",
    result = "faction_base_modular_shelter_1_bed_NW",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the southeast bedroom with a set of beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bed_NW",
        name = content.text("furnish the NW bedroom"),
        provides = {
            { id = "fbmc_shelter_1_bed_nw" },
        },
        requires = {
            { id = "fbmc_shelter_1_bedroom1" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bed_nw" },
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
    id = "faction_base_modular_shelter_1_beds_W1",
    result = "faction_base_modular_shelter_1_beds_W1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the west bedroom with beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bed_W1",
        name = content.text("furnish the W bedroom"),
        provides = {
            { id = "fbmc_shelter_1_bed_w1" },
        },
        requires = {
            { id = "fbmc_shelter_1_bedroom2" },
            { id = "fbmc_shelter_1_bed_nw" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bed_w1" },
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
    id = "faction_base_modular_shelter_1_beds_W2",
    result = "faction_base_modular_shelter_1_beds_W2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the west bedroom with beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bed_W2",
        name = content.text("furnish the W bedroom"),
        provides = {
            { id = "fbmc_shelter_1_bed_w2" },
        },
        requires = {
            { id = "fbmc_shelter_1_bedroom3" },
            { id = "fbmc_shelter_1_bed_w1" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bed_w2" },
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
    id = "faction_base_modular_shelter_1_beds_W3",
    result = "faction_base_modular_shelter_1_beds_W3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the west bedroom with beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bed_W3",
        name = content.text("furnish the W bedroom"),
        provides = {
            { id = "fbmc_shelter_1_bed_w3" },
        },
        requires = {
            { id = "fbmc_shelter_1_bedroom5" },
            { id = "fbmc_shelter_1_bed_w2" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bed_w3" },
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
    id = "faction_base_modular_shelter_1_bed_SW",
    result = "faction_base_modular_shelter_1_bed_SW",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the southwest bedroom with a set of beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bed_SW",
        name = content.text("furnish the SW bedroom"),
        provides = {
            { id = "fbmc_shelter_1_bed_sw" },
        },
        requires = {
            { id = "fbmc_shelter_1_bed_w3" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bed_sw" },
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
    id = "faction_base_modular_shelter_1_beds_S1",
    result = "faction_base_modular_shelter_1_beds_S1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the southern bedroom with beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bed_S1",
        name = content.text("furnish the S bedroom"),
        provides = {
            { id = "fbmc_shelter_1_bed_s1" },
        },
        requires = {
            { id = "fbmc_shelter_1_bedroom6" },
            { id = "fbmc_shelter_1_bed_sw" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bed_s1" },
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
    id = "faction_base_modular_shelter_1_beds_S2",
    result = "faction_base_modular_shelter_1_beds_S2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the southwestern bedroom with beds."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bed_S2",
        name = content.text("furnish the SW bedroom"),
        provides = {
            { id = "fbmc_shelter_1_bed_s2" },
        },
        requires = {
            { id = "fbmc_shelter_1_bed_s1" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bed_s2" },
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
    id = "faction_base_modular_shelter_1_diningroom",
    result = "faction_base_modular_shelter_1_diningroom",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's make a dining area."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_dining",
        name = content.text("furnish the dining room"),
        provides = {
            { id = "fbmc_shelter_1_dining" },
        },
        requires = {
            { id = "fbmc_shelter_1_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_1_dining" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_livingroom",
    result = "faction_base_modular_shelter_1_livingroom",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's make a living room area."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_livingroom",
        name = content.text("furnish the living room"),
        provides = {
            { id = "fbmc_shelter_1_livingroom" },
        },
        requires = {
            { id = "fbmc_shelter_1_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_1_livingroom" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_pantry",
    result = "faction_base_modular_shelter_1_pantry",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some pantry storage."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_pantry",
        name = content.text("build some wooden racks"),
        provides = {
            { id = "fbmc_shelter_1_pantry" },
            { id = "pantry" },
            { id = "sorting" },
            { id = "tool_storage" },
        },
        requires = {
            { id = "fbmc_shelter_1_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_1_pantry" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_craftspot",
    result = "faction_base_modular_shelter_1_craftspot",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a work bench."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_craftspot",
        name = content.text("build a work bench"),
        provides = {
            { id = "fbmc_shelter_1_craftspot" },
            { id = "tool_storage" },
        },
        requires = {
            { id = "fbmc_shelter_1_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_1_craftspot" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_radio",
    result = "faction_base_modular_shelter_1_radio",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's set up a radio tower to improve our recruitment efforts."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_radio_console",
        name = content.text("build a radio tower and console"),
        provides = {
            { id = "fbmc_shelter_1_radio" },
            { id = "recruiting" },
            { id = "radio" },
        },
        requires = {
            { id = "fbmc_shelter_1_well" },
        },
        excludes = {
            { id = "fbmc_shelter_1_radio" },
        },
    }
)
