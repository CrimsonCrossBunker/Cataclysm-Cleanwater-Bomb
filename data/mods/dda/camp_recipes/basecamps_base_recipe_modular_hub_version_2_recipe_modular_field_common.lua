local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_modular_hub_field_version_2_0",
    result = "faction_base_modular_hub_field_version_2_0",
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
        update = "fbmh_2",
        name = content.text("basic hub version 1 survey"),
        provides = {
            { id = "gathering" },
            { id = "fbmh_2_crafting_recipes_1" },
            { id = "fbmh_2" },
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
    id = "fbmh_2_brazier_NE",
    result = "fbmh_2_brazier_NE",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Now that we have some cover, we should build basic cooking facilities in the northeast shack."),
}
    :component("brazier", 1)
    :camp_blueprint {
        update = "fbmh_2_brazier_NE",
        name = content.text("northeast cooking (Brazier)"),
        provides = {
            { id = "fbmh_2_cooking_NE" },
        },
        requires = {
            { id = "fbmh_2_room_NE" },
        },
        excludes = {
            { id = "fbmh_2_cooking_NE" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_cooking_NE",
    result = "fbmh_2_cooking_NE",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Now that we have some cover, we should build basic cooking facilities in the northeast shack."),
}
    :camp_blueprint {
        update = "fbmh_2_cooking_NE",
        name = content.text("northeast cooking"),
        provides = {
            { id = "fbmh_2_cooking_NE" },
        },
        requires = {
            { id = "fbmh_2_shack_NE" },
        },
        excludes = {
            { id = "fbmh_2_cooking_NE" },
        },
        parameter_labels = {
            ["fbmh_2_cooking_palette"] = {
                ["fbmh_2_fireplace_palette"] = content.text("Fireplace"),
                ["fbmh_2_stove_palette"] = content.text("Woodstove"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_tent_cooking_NE",
    result = "fbmh_2_tent_cooking_NE",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Now that we have some cover, we should build basic cooking facilities in the northeast tent."),
}
    :camp_blueprint {
        update = "fbmh_2_tent_cooking_NE",
        name = content.text("northeast cooking"),
        provides = {
            { id = "fbmh_2_tent_cooking_NE" },
        },
        requires = {
            { id = "fbmh_2_tent_NE" },
        },
        excludes = {
            { id = "fbmh_2_tent_cooking_NE" },
        },
        parameter_labels = {
            ["fbmh_2_tent_cooking_palette"] = {
                ["fbmh_2_tent_fireplace_palette"] = content.text("Fireplace"),
                ["fbmh_2_tent_stove_palette"] = content.text("Woodstove"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_bed_NE_1",
    result = "fbmh_2_bed_NE_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A bed in the northeast shack will make sleeping much easier."),
}
    :camp_blueprint {
        update = "fbmh_2_bed_NE_1",
        name = content.text("northeast bed"),
        provides = {
            { id = "fbmh_2_bed_NE_1" },
        },
        requires = {
            { id = "fbmh_2_room_NE" },
        },
        excludes = {
            { id = "fbmh_2_bed_NE_1" },
        },
        parameter_labels = {
            ["fbmh_2_bed_palette"] = {
                ["fbmh_2_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_2_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_2_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_bed_NE_2",
    result = "fbmh_2_bed_NE_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Another bed in the northeast shack will make sleeping much easier."),
}
    :camp_blueprint {
        update = "fbmh_2_bed_NE_2",
        name = content.text("northeast bed"),
        provides = {
            { id = "fbmh_2_bed_NE_2" },
        },
        requires = {
            { id = "fbmh_2_room_NE", amount = 2 },
        },
        excludes = {
            { id = "fbmh_2_bed_NE_2" },
        },
        parameter_labels = {
            ["fbmh_2_bed_palette"] = {
                ["fbmh_2_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_2_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_2_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_bed_ENE",
    result = "fbmh_2_bed_ENE",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the southern room to the northeast will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_2_bed_ENE",
        name = content.text("east north east beds"),
        provides = {
            { id = "fbmh_2_bed_ENE" },
        },
        requires = {
            { id = "fbmh_2_room_ENE" },
        },
        excludes = {
            { id = "fbmh_2_bed_ENE" },
        },
        parameter_labels = {
            ["fbmh_2_bed_palette"] = {
                ["fbmh_2_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_2_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_2_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_bed_ESE",
    result = "fbmh_2_bed_ESE",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the east northern room to the southeast will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_2_bed_ESE",
        name = content.text("east south east beds"),
        provides = {
            { id = "fbmh_2_bed_ESE" },
        },
        requires = {
            { id = "fbmh_2_room_ESE" },
        },
        excludes = {
            { id = "fbmh_2_bed_ESE" },
        },
        parameter_labels = {
            ["fbmh_2_bed_palette"] = {
                ["fbmh_2_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_2_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_2_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_bed_SE",
    result = "fbmh_2_bed_SE",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the south eastern room will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_2_bed_SE",
        name = content.text("southeast beds"),
        provides = {
            { id = "fbmh_2_bed_SE" },
        },
        requires = {
            { id = "fbmh_2_room_SE" },
        },
        excludes = {
            { id = "fbmh_2_bed_SE" },
        },
        parameter_labels = {
            ["fbmh_2_bed_palette"] = {
                ["fbmh_2_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_2_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_2_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_bed_SW",
    result = "fbmh_2_bed_SW",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the south western room will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_2_bed_SW",
        name = content.text("southwest beds"),
        provides = {
            { id = "fbmh_2_bed_SW" },
        },
        requires = {
            { id = "fbmh_2_room_SW" },
        },
        excludes = {
            { id = "fbmh_2_bed_SW" },
        },
        parameter_labels = {
            ["fbmh_2_bed_palette"] = {
                ["fbmh_2_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_2_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_2_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_bed_WSW",
    result = "fbmh_2_bed_WSW",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the northern room to the southwest will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_2_bed_WSW",
        name = content.text("west south west beds"),
        provides = {
            { id = "fbmh_2_bed_WSW" },
        },
        requires = {
            { id = "fbmh_2_room_WSW" },
        },
        excludes = {
            { id = "fbmh_2_bed_WSW" },
        },
        parameter_labels = {
            ["fbmh_2_bed_palette"] = {
                ["fbmh_2_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_2_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_2_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_bed_WNW",
    result = "fbmh_2_bed_WNW",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the southern room to the northwest will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_2_bed_WNW",
        name = content.text("west north west beds"),
        provides = {
            { id = "fbmh_2_bed_WNW" },
        },
        requires = {
            { id = "fbmh_2_room_WNW" },
        },
        excludes = {
            { id = "fbmh_2_bed_WNW" },
        },
        parameter_labels = {
            ["fbmh_2_bed_palette"] = {
                ["fbmh_2_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_2_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_2_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_bed_NW",
    result = "fbmh_2_bed_NW",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the north western room will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_2_bed_NW",
        name = content.text("northwest beds"),
        provides = {
            { id = "fbmh_2_bed_NW" },
        },
        requires = {
            { id = "fbmh_2_room_NW" },
        },
        excludes = {
            { id = "fbmh_2_bed_NW" },
        },
        parameter_labels = {
            ["fbmh_2_bed_palette"] = {
                ["fbmh_2_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_2_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_2_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_center_fireplace",
    result = "fbmh_2_center_fireplace",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A fireplace, counter, and some pots and pans in the central building will allow us to cook simple recipes and organize hunting expeditions."),
}
    :camp_blueprint {
        update = "fbmh_2_center_fireplace",
        name = content.text("central fireplace"),
        provides = {
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "fbmh_2_cooking_recipes_1" },
        },
        requires = {
            { id = "fbmh_2_center_west" },
        },
        resources = { "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_center_butchery",
    result = "fbmh_2_center_butchery",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need a butchery rack to maximize the harvest from our hunting and trapping efforts."),
}
    :camp_blueprint {
        update = "fbmh_2_center_butchery",
        name = content.text("central butchery rack"),
        provides = {
            { id = "trapping" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmh_2_center_east" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_center_toolrack",
    result = "fbmh_2_center_toolrack",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A tool rack in the central building will give us a place to store tools."),
}
    :camp_blueprint {
        update = "fbmh_2_center_toolrack",
        name = content.text("central tool rack"),
        provides = {
            { id = "tool_storage" },
        },
        requires = {
            { id = "fbmh_2_center_west" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_center_table_east",
    result = "fbmh_2_center_table_east",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Setting up some tables and chairs will make the central building into a dining area, and we can also use them as a workspace to organize the camp."),
}
    :camp_blueprint {
        update = "fbmh_2_center_table_east",
        name = content.text("central dining hall east"),
        provides = {
            { id = "relaying" },
            { id = "walls" },
            { id = "recruiting" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "fbmh_2_center_east" },
            { id = "fbmh_2_center_mideast" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_center_table_west",
    result = "fbmh_2_center_table_west",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Setting up some tables and chairs will make the central building into a dining area, and we can also use them as a workspace to organize the camp."),
}
    :camp_blueprint {
        update = "fbmh_2_center_table_west",
        name = content.text("central dining hall west"),
        provides = {
            { id = "relaying" },
            { id = "walls" },
            { id = "recruiting" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "fbmh_2_center_west" },
            { id = "fbmh_2_center_midwest" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_center_table",
    result = "fbmh_2_center_table",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Setting up some tables and chairs will make the central building into a dining area, and we can also use them as a workspace to organize the camp."),
}
    :camp_blueprint {
        update = "fbmh_2_center_table",
        name = content.text("central dining hall"),
        provides = {
            { id = "relaying" },
            { id = "walls" },
            { id = "recruiting" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "fbmh_2_center_mideast" },
            { id = "fbmh_2_center_midwest" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_center_stove",
    result = "fbmh_2_center_stove",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A wood stove, counter, and some pots and pans in the central building will allow us to cook simple recipes and organize hunting expeditions.  The stove will be more efficient than a fireplace."),
}
    :camp_blueprint {
        update = "fbmh_2_center_stove",
        name = content.text("central wood stove"),
        provides = {
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "fbmh_2_cooking_recipes_1" },
        },
        requires = {
            { id = "fbmh_2_center_east" },
        },
        resources = { "fake_woodstove" },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_well",
    result = "fbmh_2_well",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a well will give us easy access to water."),
}
    :camp_blueprint {
        update = "fbmh_2_well",
        name = content.text("water well"),
        provides = {
            { id = "water_well" },
        },
        requires = {
            { id = "fbmh_2" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_root_cellar",
    result = "fbmh_2_root_cellar",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a root cellar will give us a way to extend the shelf life of perishable food."),
}
    :camp_blueprint {
        update = "fbmh_2_root_cellar",
        name = content.text("root cellar"),
        provides = {
            { id = "pantry" },
        },
        requires = {
            { id = "fbmh_2" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_radio_tower",
    result = "fbmh_2_radio_tower",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 8640000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    never_learn = true,
    description = content.text("We could build a radio tower to improve the range of our radios."),
}
    :component_any({
            { id = "wind_turbine", count = 4 },
            { id = "xl_wind_turbine", count = 1 },
            { id = "solar_panel", count = 4 },
            { id = "reinforced_solar_panel", count = 4 },
            { id = "solar_panel_v2", count = 2 },
            { id = "reinforced_solar_panel_v2", count = 2 }
        })
    :component_any({
            { id = "storage_battery", count = 1 },
            { id = "medium_storage_battery", count = 4 },
            { id = "small_storage_battery", count = 32 }
        })
    :component_any({
            { id = "sheet_metal", count = 2 },
            { id = "lc_wire", count = 8 }
        })
    :component("pipe", 24)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("SCREW", 1, 1)
    :camp_blueprint {
        update = "fbmh_2_radio_tower",
        name = content.text("radio tower"),
        provides = {
            { id = "fbmh_2_radio_tower" },
        },
        requires = {
            { id = "fbmh_2" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "fbmh_2_radio_console",
    result = "fbmh_2_radio_console",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 8640000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 6,
    never_learn = true,
    description = content.text("Adding a console to control the radio tower will help with recruiting more survivors."),
}
    :component("processor", 2)
    :component("RAM", 2)
    :component("large_lcd_screen", 1)
    :component("e_scrap", 8)
    :component("frame", 1)
    :component("circuit", 4)
    :component("power_supply", 2)
    :component("amplifier", 2)
    :component("cable", 27)
    :component_any({
            { id = "motor_small", count = 1 },
            { id = "motor_tiny", count = 2 }
        })
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("SCREW", 1, 1)
    :camp_blueprint {
        update = "fbmh_2_radio_console",
        name = content.text("radio console"),
        provides = {
            { id = "fbmh_2_radio_console" },
            { id = "recruiting" },
            { id = "radio" },
        },
        requires = {
            { id = "fbmh_2_radio_tower" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "fbmh_2_parkour",
    result = "fbmh_2_parkour",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a parkour obstacle training course in the northern courtyard."),
}
    :camp_blueprint {
        update = "fbmh_2_parkour",
        name = content.text("build an obstacle course"),
        provides = {
            { id = "fbmh_2_parkour" },
        },
        requires = {
            { id = "fbmh_2" },
        },
        excludes = {
            { id = "fbmh_2_parkour" },
        },
    }
)
