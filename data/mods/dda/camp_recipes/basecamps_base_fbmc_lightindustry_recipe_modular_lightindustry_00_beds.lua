local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_lightindustry_00_bed_1",
    result = "faction_base_lightindustry_00_bed_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a first set of beds in place of some existing desks."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_bed_1",
        name = content.text("build a first set of beds"),
        provides = {
            { id = "fbmc_lightindustry_00_bed_1" },
        },
        requires = {
            { id = "fbmc_lightindustry_00_barricades" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_bed_1" },
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
    id = "faction_base_lightindustry_00_bed_2",
    result = "faction_base_lightindustry_00_bed_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a second set of beds in place of some existing desks."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_bed_2",
        name = content.text("build a second set of beds"),
        provides = {
            { id = "fbmc_lightindustry_00_bed_2" },
        },
        requires = {
            { id = "fbmc_lightindustry_00_bed_1" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_bed_2" },
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
    id = "faction_base_lightindustry_00_bed_3",
    result = "faction_base_lightindustry_00_bed_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a third set of beds in place of some existing desks."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_bed_3",
        name = content.text("build a third set of beds"),
        provides = {
            { id = "fbmc_lightindustry_00_bed_3" },
        },
        requires = {
            { id = "fbmc_lightindustry_00_bed_2" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_bed_3" },
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
    id = "faction_base_lightindustry_00_bed_4",
    result = "faction_base_lightindustry_00_bed_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a fourth set of beds in place of some existing desks."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_bed_4",
        name = content.text("build a fourth set of beds"),
        provides = {
            { id = "fbmc_lightindustry_00_bed_4" },
        },
        requires = {
            { id = "fbmc_lightindustry_00_bed_3" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_bed_4" },
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
    id = "faction_base_lightindustry_00_bed_5",
    result = "faction_base_lightindustry_00_bed_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a fifth set of beds in place of some existing desks."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_bed_5",
        name = content.text("build a fifth set of beds"),
        provides = {
            { id = "fbmc_lightindustry_00_bed_5" },
        },
        requires = {
            { id = "fbmc_lightindustry_00_bed_4" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_bed_5" },
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
