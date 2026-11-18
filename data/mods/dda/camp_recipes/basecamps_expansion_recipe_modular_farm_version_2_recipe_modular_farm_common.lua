local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_farm_2_0",
    result = "faction_base_farm_2_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Survey land for a farming area."),
}
    :camp_blueprint {
        update = "faction_base_farm_2_0",
        name = content.text("farm area survey"),
        provides = {
            { id = "fbmf_2" },
            { id = "farming" },
            { id = "blacksmith" },
            { id = "fbmf_2_fallback_recipe_1" },
            { id = "fbmf_2_recipes_1" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

-- This is a fallback created during 0.G allowing preexisting farm plots to gain recipes that otherwise would
-- be gained on expansion creation.
content.add(content.Recipe {
    id = "fbmf_2_fallback_recipe_1",
    result = "fbmf_2_fallback_recipe_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Add crafting recipes to the farm expansion."),
}
    :camp_blueprint {
        update = "fbmf_2_fallback_recipe_1",
        name = content.text("fallback recipe addition"),
        provides = {
            { id = "fbmf_2_fallback_recipe_1" },
            { id = "blacksmith" },
            { id = "fbmf_2_recipes_1" },
        },
        requires = {
            { id = "fbmf_2" },
        },
        excludes = {
            { id = "fbmf_2_fallback_recipe_1" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_plot_1",
    result = "fbmf_2_plot_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 288000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Prepare a row of farm plots."),
}
    :quality("DIG", 1, 1)
    :camp_blueprint {
        update = "fbmf_2_plot_1",
        name = content.text("prepare farm plots"),
        provides = {
            { id = "fbmf_2_plot_1" },
        },
        requires = {
            { id = "fbmf_2" },
        },
        excludes = {
            { id = "fbmf_2_plot_1" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_plot_2",
    result = "fbmf_2_plot_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 288000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Prepare a second row of farm plots."),
}
    :quality("DIG", 1, 1)
    :camp_blueprint {
        update = "fbmf_2_plot_2",
        name = content.text("prepare farm plots"),
        provides = {
            { id = "fbmf_2_plot_2" },
        },
        requires = {
            { id = "fbmf_2_plot_1" },
        },
        excludes = {
            { id = "fbmf_2_plot_2" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_plot_3",
    result = "fbmf_2_plot_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 576000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Prepare another pair of rows of farm plots."),
}
    :quality("DIG", 1, 1)
    :camp_blueprint {
        update = "fbmf_2_plot_3",
        name = content.text("prepare farm plots"),
        provides = {
            { id = "fbmf_2_plot_3" },
        },
        requires = {
            { id = "fbmf_2_plot_2" },
        },
        excludes = {
            { id = "fbmf_2_plot_3" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_plot_4",
    result = "fbmf_2_plot_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 576000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Prepare another pair of rows of farm plots."),
}
    :quality("DIG", 1, 1)
    :camp_blueprint {
        update = "fbmf_2_plot_4",
        name = content.text("prepare farm plots"),
        provides = {
            { id = "fbmf_2_plot_4" },
        },
        requires = {
            { id = "fbmf_2_plot_3" },
        },
        excludes = {
            { id = "fbmf_2_plot_4" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_plot_5",
    result = "fbmf_2_plot_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 576000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Prepare another pair of rows of farm plots."),
}
    :quality("DIG", 1, 1)
    :camp_blueprint {
        update = "fbmf_2_plot_5",
        name = content.text("prepare farm plots"),
        provides = {
            { id = "fbmf_2_plot_5" },
        },
        requires = {
            { id = "fbmf_2_plot_4" },
        },
        excludes = {
            { id = "fbmf_2_plot_5" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_plot_6",
    result = "fbmf_2_plot_6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 576000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Prepare another pair of rows of farm plots."),
}
    :quality("DIG", 1, 1)
    :camp_blueprint {
        update = "fbmf_2_plot_6",
        name = content.text("prepare farm plots"),
        provides = {
            { id = "fbmf_2_plot_6" },
        },
        requires = {
            { id = "fbmf_2_plot_5" },
        },
        excludes = {
            { id = "fbmf_2_plot_6" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_plot_7",
    result = "fbmf_2_plot_7",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 576000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Prepare another pair of rows of farm plots."),
}
    :quality("DIG", 1, 1)
    :camp_blueprint {
        update = "fbmf_2_plot_7",
        name = content.text("prepare farm plots"),
        provides = {
            { id = "fbmf_2_plot_7" },
        },
        requires = {
            { id = "fbmf_2_plot_6" },
        },
        excludes = {
            { id = "fbmf_2_plot_7" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_plot_8",
    result = "fbmf_2_plot_8",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 576000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Prepare another pair of rows of farm plots."),
}
    :quality("DIG", 1, 1)
    :camp_blueprint {
        update = "fbmf_2_plot_8",
        name = content.text("prepare farm plots"),
        provides = {
            { id = "fbmf_2_plot_8" },
        },
        requires = {
            { id = "fbmf_2_plot_7" },
        },
        excludes = {
            { id = "fbmf_2_plot_8" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_fence_1",
    result = "fbmf_2_fence_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Erect a fence along the longer outer edge to keep deer away from the crops."),
}
    :camp_blueprint {
        update = "fbmf_2_fence_1",
        name = content.text("erect a fence"),
        provides = {
            { id = "fbmf_2_fence_1" },
        },
        requires = {
            { id = "fbmf_2" },
        },
        excludes = {
            { id = "fbmf_2_fence_1" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_fence_2",
    result = "fbmf_2_fence_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Erect a fence along the shorter outer edge to keep deer away from the crops."),
}
    :camp_blueprint {
        update = "fbmf_2_fence_2",
        name = content.text("erect a fence"),
        provides = {
            { id = "fbmf_2_fence_2" },
        },
        requires = {
            { id = "fbmf_2" },
        },
        excludes = {
            { id = "fbmf_2_fence_2" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_fence_3",
    result = "fbmf_2_fence_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Erect a fence along the shorter inner edge to keep deer away from the crops."),
}
    :camp_blueprint {
        update = "fbmf_2_fence_3",
        name = content.text("erect a fence"),
        provides = {
            { id = "fbmf_2_fence_3" },
        },
        requires = {
            { id = "fbmf_2" },
        },
        excludes = {
            { id = "fbmf_2_fence_3" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_fence_4",
    result = "fbmf_2_fence_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Erect a fence along the outer part of the longer inner edge to keep deer away from the crops."),
}
    :camp_blueprint {
        update = "fbmf_2_fence_4",
        name = content.text("erect a fence"),
        provides = {
            { id = "fbmf_2_fence_4" },
        },
        requires = {
            { id = "fbmf_2" },
        },
        excludes = {
            { id = "fbmf_2_fence_4" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_fence_5",
    result = "fbmf_2_fence_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We don't plan to replow the fields with a tractor, so erect a fence along the inner part of the longer inner edge."),
}
    :camp_blueprint {
        update = "fbmf_2_fence_5",
        name = content.text("erect a fence"),
        provides = {
            { id = "fbmf_2_fence_5" },
        },
        requires = {
            { id = "fbmf_2" },
        },
        excludes = {
            { id = "fbmf_2_fence_5" },
            { id = "fbmf_2_gate" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmf_2_gate",
    result = "fbmf_2_gate",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Build a palisade gate to allow us to reach the fields and replow them with a tractor next year."),
}
    :camp_blueprint {
        update = "fbmf_2_gate",
        name = content.text("build a palisade gate"),
        provides = {
            { id = "fbmf_2_gate" },
        },
        requires = {
            { id = "fbmf_2" },
        },
        excludes = {
            { id = "fbmf_2_fence_5" },
            { id = "fbmf_2_gate" },
        },
    }
)
