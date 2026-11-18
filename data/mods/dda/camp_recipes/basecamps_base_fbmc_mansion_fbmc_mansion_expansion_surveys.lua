local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_mansion_e1",
    result = "faction_base_mansion_e1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's entrance."),
}
    :camp_blueprint {
        update = "faction_base_mansion_e1",
        name = content.text("entrance survey"),
        provides = {
            { id = "faction_base_mansion_e1" },
            { id = "farming" },
            { id = "reseeding" },
            { id = "farm_recipes_1" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_e2",
    result = "faction_base_mansion_e2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's entrance."),
}
    :camp_blueprint {
        update = "faction_base_mansion_e2",
        name = content.text("entrance survey"),
        provides = {
            { id = "faction_base_mansion_e2" },
            { id = "farming" },
            { id = "reseeding" },
            { id = "farm_recipes_1" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_t1",
    result = "faction_base_mansion_t1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's swimming pool."),
}
    :camp_blueprint {
        update = "faction_base_mansion_t1",
        name = content.text("swimming pool survey"),
        provides = {
            { id = "faction_base_mansion_t1" },
            { id = "farming" },
            { id = "reseeding" },
            { id = "farm_recipes_1" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_t2",
    result = "faction_base_mansion_t2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's bedrooms."),
}
    :camp_blueprint {
        update = "faction_base_mansion_t2",
        name = content.text("bedrooms survey"),
        provides = {
            { id = "faction_base_mansion_t2" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_t3",
    result = "faction_base_mansion_t3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's '???'."),
}
    :camp_blueprint {
        update = "faction_base_mansion_t3",
        name = content.text("??? survey"),
        provides = {
            { id = "faction_base_mansion_t3" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_t4",
    result = "faction_base_mansion_t4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's kitchen."),
}
    :camp_blueprint {
        update = "faction_base_mansion_t4",
        name = content.text("kitchen survey"),
        provides = {
            { id = "faction_base_mansion_t4" },
            { id = "kitchen" },
            { id = "kitchen_recipes_1" },
            { id = "kitchen_recipes_2" },
            { id = "kitchen_recipes_3" },
            { id = "saltworks_recipes_1" },
            { id = "saltworks_recipes_2" },
            { id = "saltworks_recipes_3" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        resources = { "oven" },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_t5",
    result = "faction_base_mansion_t5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's library."),
}
    :camp_blueprint {
        update = "faction_base_mansion_t5",
        name = content.text("library survey"),
        provides = {
            { id = "faction_base_mansion_t5" },
            { id = "kitchen" },
            { id = "library_recipes_1" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_t6",
    result = "faction_base_mansion_t6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's bedroom."),
}
    :camp_blueprint {
        update = "faction_base_mansion_t6",
        name = content.text("bedroom survey"),
        provides = {
            { id = "faction_base_mansion_t6" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_t7",
    result = "faction_base_mansion_t7",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's living rooms."),
}
    :camp_blueprint {
        update = "faction_base_mansion_t7",
        name = content.text("living rooms survey"),
        provides = {
            { id = "faction_base_mansion_t7" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_c1",
    result = "faction_base_mansion_c1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's swimming pool."),
}
    :camp_blueprint {
        update = "faction_base_mansion_c1",
        name = content.text("swimming survey"),
        provides = {
            { id = "faction_base_mansion_c1" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_c2",
    result = "faction_base_mansion_c2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's bar."),
}
    :camp_blueprint {
        update = "faction_base_mansion_c2",
        name = content.text("bar survey"),
        provides = {
            { id = "faction_base_mansion_c2" },
            { id = "kitchen" },
            { id = "kitchen_recipes_1" },
            { id = "kitchen_recipes_2" },
            { id = "kitchen_recipes_3" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_c3",
    result = "faction_base_mansion_c3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's living rooms."),
}
    :camp_blueprint {
        update = "faction_base_mansion_c3",
        name = content.text("living rooms survey"),
        provides = {
            { id = "faction_base_mansion_c3" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_c4",
    result = "faction_base_mansion_c4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's bedroom."),
}
    :camp_blueprint {
        update = "faction_base_mansion_c4",
        name = content.text("bedroom survey"),
        provides = {
            { id = "faction_base_mansion_c4" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_mansion_c5",
    result = "faction_base_mansion_c5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey mansion's kitchen."),
}
    :camp_blueprint {
        update = "faction_base_mansion_c5",
        name = content.text("kitchen survey"),
        provides = {
            { id = "faction_base_mansion_c5" },
            { id = "kitchen" },
            { id = "kitchen_recipes_1" },
            { id = "kitchen_recipes_2" },
            { id = "kitchen_recipes_3" },
            { id = "saltworks_recipes_1" },
            { id = "saltworks_recipes_2" },
            { id = "saltworks_recipes_3" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        resources = { "oven" },
    }
)
