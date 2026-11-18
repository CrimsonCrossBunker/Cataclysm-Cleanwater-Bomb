local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_radio_tower_beds_controls_room",
    result = "faction_base_radio_tower_beds_controls_room",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should remove some of display racks and counters, then build a set of beds inside the radio control room for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_beds_controls_room",
        name = content.text("set of beds in the radio control room"),
        provides = {
            { id = "fbmc_radio_tower_beds_controls_room" },
        },
        requires = {
            { id = "fbmc_radio_tower_controls_room" },
        },
        excludes = {
            { id = "fbmc_radio_tower_beds_controls_room" },
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
    id = "faction_base_radio_tower_beds_0",
    result = "faction_base_radio_tower_beds_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a set of beds inside the radio tower shack for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_beds_0",
        name = content.text("set of beds in the radio tower"),
        provides = {
            { id = "fbmc_radio_tower_beds_0" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_0" },
        },
        excludes = {
            { id = "fbmc_radio_tower_beds_0" },
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
    id = "faction_base_radio_tower_beds_1",
    result = "faction_base_radio_tower_beds_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a set of beds in the northeast side shack for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_beds_1",
        name = content.text("set of beds in NE side shack"),
        provides = {
            { id = "fbmc_radio_tower_beds_1" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_1" },
        },
        excludes = {
            { id = "fbmc_radio_tower_beds_1" },
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
    id = "faction_base_radio_tower_beds_2",
    result = "faction_base_radio_tower_beds_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a set of beds in the southwest corner shack for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_beds_2",
        name = content.text("set of beds in SW corner shack"),
        provides = {
            { id = "fbmc_radio_tower_beds_2" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_2" },
        },
        excludes = {
            { id = "fbmc_radio_tower_beds_2" },
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
    id = "faction_base_radio_tower_beds_3",
    result = "faction_base_radio_tower_beds_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a set of beds in the southwest side shack for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_beds_3",
        name = content.text("set of beds in SW side shack"),
        provides = {
            { id = "fbmc_radio_tower_beds_3" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_3" },
        },
        excludes = {
            { id = "fbmc_radio_tower_beds_3" },
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
    id = "faction_base_radio_tower_beds_4",
    result = "faction_base_radio_tower_beds_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a set of beds in the southeast side shack for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_beds_4",
        name = content.text("set of beds in SE side shack"),
        provides = {
            { id = "fbmc_radio_tower_beds_4" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_4" },
        },
        excludes = {
            { id = "fbmc_radio_tower_beds_4" },
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
    id = "faction_base_radio_tower_beds_5",
    result = "faction_base_radio_tower_beds_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a set of beds in the southeast corner shack for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_beds_5",
        name = content.text("set of beds in SE corner shack"),
        provides = {
            { id = "fbmc_radio_tower_beds_5" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_5" },
        },
        excludes = {
            { id = "fbmc_radio_tower_beds_5" },
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
    id = "faction_base_radio_tower_beds_6",
    result = "faction_base_radio_tower_beds_6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a set of beds in the southeast corner shack for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_beds_6",
        name = content.text("set of beds in SE corner shack"),
        provides = {
            { id = "fbmc_radio_tower_beds_6" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_6" },
        },
        excludes = {
            { id = "fbmc_radio_tower_beds_6" },
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
    id = "faction_base_radio_tower_beds_7",
    result = "faction_base_radio_tower_beds_7",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a set of beds in the southwest corner shack for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_beds_7",
        name = content.text("set of beds in SW corner shack"),
        provides = {
            { id = "fbmc_radio_tower_beds_7" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_7" },
        },
        excludes = {
            { id = "fbmc_radio_tower_beds_7" },
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
    id = "faction_base_radio_tower_beds_8",
    result = "faction_base_radio_tower_beds_8",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a set of beds in the south side shack for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_beds_8",
        name = content.text("set of beds in S side shack"),
        provides = {
            { id = "fbmc_radio_tower_beds_8" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_8" },
        },
        excludes = {
            { id = "fbmc_radio_tower_beds_8" },
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
