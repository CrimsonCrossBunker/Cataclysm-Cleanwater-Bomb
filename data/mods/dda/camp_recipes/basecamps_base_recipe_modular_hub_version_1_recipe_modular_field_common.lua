local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_modular_hub_field_0",
    result = "faction_base_modular_hub_field_0",
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
        update = "fbmh_0",
        name = content.text("basic survey"),
        provides = {
            { id = "gathering" },
            { id = "primitive_camp_recipes_1" },
            { id = "fbmh_0" },
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
    id = "faction_base_modular_hub_mallroof_0",
    result = "faction_base_modular_hub_mallroof_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should survey the roof top and set up a bulletin board."),
}
    :camp_blueprint {
        update = "fbmh_0",
        name = content.text("basic survey"),
        provides = {
            { id = "gathering" },
            { id = "primitive_camp_recipes_1" },
            { id = "fbmh_0" },
            { id = "firewood" },
            { id = "foraging" },
            { id = "sorting" },
            { id = "logging" },
            { id = "fbm_no_dig" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "fbmh_0_brazier_northeast",
    result = "fbmh_0_brazier_northeast",
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
        update = "fbmh_0_brazier_northeast",
        name = content.text("northeast cooking (Brazier)"),
        provides = {
            { id = "fbmh_fire_northeast" },
        },
        requires = {
            { id = "fbmh_northeast" },
        },
        excludes = {
            { id = "fbmh_fire_northeast" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_cooking_shack_northeast",
    result = "fbmh_0_cooking_shack_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Now that we have some cover, we should build basic cooking facilities in the northeast shack."),
}
    :camp_blueprint {
        update = "fbmh_0_cooking_shack_northeast",
        name = content.text("northeast cooking"),
        provides = {
            { id = "fbmh_fire_northeast" },
        },
        requires = {
            { id = "fbmh_shack_northeast" },
        },
        excludes = {
            { id = "fbmh_fire_northeast" },
        },
        parameter_labels = {
            ["fbmh_0_cooking_shack_palette"] = {
                ["fbmh_0_fireplace_shack_palette"] = content.text("Fireplace"),
                ["fbmh_0_stove_shack_palette"] = content.text("Woodstove"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_cooking_tent_northeast",
    result = "fbmh_0_cooking_tent_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Now that we have some cover, we should build basic cooking facilities in the northeast tent."),
}
    :camp_blueprint {
        update = "fbmh_0_cooking_tent_northeast",
        name = content.text("northeast cooking"),
        provides = {
            { id = "fbmh_fire_northeast" },
        },
        requires = {
            { id = "fbmh_tent_northeast" },
        },
        excludes = {
            { id = "fbmh_fire_northeast" },
        },
        parameter_labels = {
            ["fbmh_0_cooking_tent_palette"] = {
                ["fbmh_0_fireplace_tent_palette"] = content.text("Fireplace"),
                ["fbmh_0_stove_tent_palette"] = content.text("Woodstove"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_bed_northeast_1",
    result = "fbmh_0_bed_northeast_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A bed in the northeast shack will make sleeping much easier."),
}
    :camp_blueprint {
        update = "fbmh_0_bed1_northeast",
        name = content.text("northeast bed"),
        provides = {
            { id = "fbmh_bed1_northeast" },
        },
        requires = {
            { id = "fbmh_northeast" },
        },
        excludes = {
            { id = "fbmh_bed1_northeast" },
        },
        parameter_labels = {
            ["fbmh_0_bed_palette"] = {
                ["fbmh_0_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_0_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_0_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_bed_northeast_2",
    result = "fbmh_0_bed_northeast_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Another bed in the northeast shack will make sleeping much easier."),
}
    :camp_blueprint {
        update = "fbmh_0_bed2_northeast",
        name = content.text("northeast bed"),
        provides = {
            { id = "fbmh_bed2_northeast" },
        },
        requires = {
            { id = "fbmh_bed1_northeast" },
            { id = "fbmh_northeast", amount = 2 },
        },
        excludes = {
            { id = "fbmh_bed2_northeast" },
        },
        parameter_labels = {
            ["fbmh_0_bed_palette"] = {
                ["fbmh_0_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_0_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_0_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_tent_bed3_east",
    result = "fbmh_0_tent_bed3_east",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the east tent will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_0_tent_bed3_east",
        name = content.text("east beds"),
        provides = {
            { id = "fbmh_bed1_east" },
            { id = "fbmh_bed2_east" },
        },
        requires = {
            { id = "fbmh_tent_east" },
        },
        excludes = {
            { id = "fbmh_bed1_east" },
            { id = "fbmh_bed2_east" },
        },
        parameter_labels = {
            ["fbmh_0_bed_palette"] = {
                ["fbmh_0_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_0_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_0_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_room_bed3_east",
    result = "fbmh_0_room_bed3_east",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the east room will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_0_room_bed3_east",
        name = content.text("east beds"),
        provides = {
            { id = "fbmh_bed1_east" },
            { id = "fbmh_bed2_east" },
        },
        requires = {
            { id = "fbmh_east", amount = 4 },
        },
        excludes = {
            { id = "fbmh_bed1_east" },
            { id = "fbmh_bed2_east" },
            { id = "fbmh_tent_east" },
        },
        parameter_labels = {
            ["fbmh_0_bed_palette"] = {
                ["fbmh_0_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_0_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_0_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_tent_bed3_southeast",
    result = "fbmh_0_tent_bed3_southeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the southeast tent will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_0_tent_bed3_southeast",
        name = content.text("southeast beds"),
        provides = {
            { id = "fbmh_bed1_southeast" },
            { id = "fbmh_bed2_southeast" },
        },
        requires = {
            { id = "fbmh_tent_southeast" },
        },
        excludes = {
            { id = "fbmh_bed1_southeast" },
            { id = "fbmh_bed2_southeast" },
        },
        parameter_labels = {
            ["fbmh_0_bed_palette"] = {
                ["fbmh_0_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_0_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_0_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_room_bed3_southeast",
    result = "fbmh_0_room_bed3_southeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the southeast room will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_0_room_bed3_southeast",
        name = content.text("southeast beds"),
        provides = {
            { id = "fbmh_bed1_southeast" },
            { id = "fbmh_bed2_southeast" },
        },
        requires = {
            { id = "fbmh_southeast", amount = 4 },
        },
        excludes = {
            { id = "fbmh_bed1_southeast" },
            { id = "fbmh_bed2_southeast" },
            { id = "fbmh_tent_southeast" },
        },
        parameter_labels = {
            ["fbmh_0_bed_palette"] = {
                ["fbmh_0_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_0_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_0_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_bed3_northwest",
    result = "fbmh_0_bed3_northwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the northwest building will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_0_bed3_northwest",
        name = content.text("northwest beds"),
        provides = {
            { id = "fbmh_bed1_northwest" },
            { id = "fbmh_bed2_northwest" },
        },
        requires = {
            { id = "fbmh_northwest", amount = 4 },
        },
        excludes = {
            { id = "fbmh_bed1_northwest" },
            { id = "fbmh_bed2_northwest" },
        },
        parameter_labels = {
            ["fbmh_0_bed_palette"] = {
                ["fbmh_0_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_0_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_0_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_tent_bed3_west",
    result = "fbmh_0_tent_bed3_west",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the west tent will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_0_tent_bed3_west",
        name = content.text("west beds"),
        provides = {
            { id = "fbmh_bed1_west" },
            { id = "fbmh_bed2_west" },
        },
        requires = {
            { id = "fbmh_tent_west" },
        },
        excludes = {
            { id = "fbmh_bed1_west" },
            { id = "fbmh_bed2_west" },
        },
        parameter_labels = {
            ["fbmh_0_bed_palette"] = {
                ["fbmh_0_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_0_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_0_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_room_bed3_west",
    result = "fbmh_0_room_bed3_west",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the west room will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_0_room_bed3_west",
        name = content.text("west beds"),
        provides = {
            { id = "fbmh_bed1_west" },
            { id = "fbmh_bed2_west" },
        },
        requires = {
            { id = "fbmh_west", amount = 4 },
        },
        excludes = {
            { id = "fbmh_bed1_west" },
            { id = "fbmh_bed2_west" },
            { id = "fbmh_tent_west" },
        },
        parameter_labels = {
            ["fbmh_0_bed_palette"] = {
                ["fbmh_0_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_0_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_0_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_tent_bed3_southwest",
    result = "fbmh_0_tent_bed3_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the southwest tent will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_0_tent_bed3_southwest",
        name = content.text("southwest beds"),
        provides = {
            { id = "fbmh_bed1_southwest" },
            { id = "fbmh_bed2_southwest" },
        },
        requires = {
            { id = "fbmh_tent_southwest" },
        },
        excludes = {
            { id = "fbmh_bed1_southwest" },
            { id = "fbmh_bed2_southwest" },
        },
        parameter_labels = {
            ["fbmh_0_bed_palette"] = {
                ["fbmh_0_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_0_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_0_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_room_bed3_southwest",
    result = "fbmh_0_room_bed3_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A pair of beds in the southwest room will allow us to house two more people."),
}
    :camp_blueprint {
        update = "fbmh_0_room_bed3_southwest",
        name = content.text("southwest beds"),
        provides = {
            { id = "fbmh_bed1_southwest" },
            { id = "fbmh_bed2_southwest" },
        },
        requires = {
            { id = "fbmh_southwest", amount = 4 },
        },
        excludes = {
            { id = "fbmh_bed1_southwest" },
            { id = "fbmh_bed2_southwest" },
            { id = "fbmh_tent_southwest" },
        },
        parameter_labels = {
            ["fbmh_0_bed_palette"] = {
                ["fbmh_0_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmh_0_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmh_0_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_core_kitchen_fireplace_center",
    result = "faction_base_modular_hub_core_kitchen_fireplace_center",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A fireplace, counter, and some pots and pans in the central building will allow us to cook simple recipes and organize hunting expeditions."),
}
    :camp_blueprint {
        update = "fbmh_core_kitchen_fireplace_center",
        name = content.text("central fireplace"),
        provides = {
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "kitchen_recipes_1" },
        },
        requires = {
            { id = "fbmh_center", amount = 2 },
            { id = "fbmh_ne_center" },
        },
        resources = { "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_core_kitchen_butchery_center",
    result = "faction_base_modular_hub_core_kitchen_butchery_center",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need a butchery rack to maximize the harvest from our hunting and trapping efforts."),
}
    :camp_blueprint {
        update = "fbmh_core_kitchen_butchery_center",
        name = content.text("central butchery rack"),
        provides = {
            { id = "trapping" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmh_center", amount = 2 },
            { id = "fbmh_ne_center" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_core_kitchen_toolrack_center",
    result = "faction_base_modular_hub_core_kitchen_toolrack_center",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A tool rack in the central building will give us a place to store tools."),
}
    :camp_blueprint {
        update = "fbmh_core_kitchen_toolrack_center",
        name = content.text("central tool rack"),
        provides = {
            { id = "tool_storage" },
        },
        requires = {
            { id = "fbmh_center", amount = 2 },
            { id = "fbmh_nw_center" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_core_kitchen_table_center",
    result = "faction_base_modular_hub_core_kitchen_table_center",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Setting up some tables and chairs will make the central building into a dining area, and we can also use them as a workspace to organize the camp."),
}
    :camp_blueprint {
        update = "fbmh_core_kitchen_table_center",
        name = content.text("central dining hall"),
        provides = {
            { id = "relaying" },
            { id = "walls" },
            { id = "recruiting" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "fbmh_center", amount = 4 },
            { id = "fbmh_ne_center" },
            { id = "fbmh_nw_center" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_core_kitchen_table_south",
    result = "faction_base_modular_hub_core_kitchen_table_south",
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
        update = "fbmh_core_kitchen_table_south",
        name = content.text("south dining hall"),
        provides = {
            { id = "relaying" },
            { id = "walls" },
            { id = "recruiting" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "fbmh_south", amount = 4 },
            { id = "fbmh_se_south" },
            { id = "fbmh_sw_south" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_core_kitchen_stove_south",
    result = "faction_base_modular_hub_core_kitchen_stove_south",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A wood stove, counter, and some pots and pans in the south half of the central building will allow us to cook simple recipes and organize hunting expeditions.  The stove will be more efficient than a fireplace."),
}
    :camp_blueprint {
        update = "fbmh_core_kitchen_stove_south",
        name = content.text("south wood stove"),
        provides = {
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "kitchen_recipes_1" },
        },
        requires = {
            { id = "fbmh_south", amount = 2 },
            { id = "fbmh_sw_south" },
        },
        resources = { "fake_woodstove" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_well_north",
    result = "faction_base_modular_hub_well_north",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a well will give us easy access to water."),
}
    :camp_blueprint {
        update = "fbmh_well_north",
        name = content.text("north water well"),
        provides = {
            { id = "water_well" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_root_cellar_north",
    result = "faction_base_modular_hub_root_cellar_north",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a root cellar will give us a way to preserve food."),
}
    :camp_blueprint {
        update = "fbmh_root_cellar_north",
        name = content.text("north root cellar"),
        provides = {
            { id = "pantry" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_radio_tower_north",
    result = "faction_base_modular_hub_radio_tower_north",
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
        update = "fbmh_radio_tower_north",
        name = content.text("north radio tower"),
        provides = {
            { id = "fbmh_radio_tower_north" },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_hub_radio_console_north",
    result = "faction_base_modular_hub_radio_console_north",
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
        update = "fbmh_radio_console_north",
        name = content.text("north radio console"),
        provides = {
            { id = "fbmh_radio_console_north" },
            { id = "recruiting" },
            { id = "radio" },
        },
        requires = {
            { id = "fbmh_radio_tower_north" },
        },
        check_needs = false,
    }
)
