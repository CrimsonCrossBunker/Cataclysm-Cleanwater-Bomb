local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_canteen_2_0",
    result = "faction_base_canteen_2_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Survey land for a canteen."),
}
    :camp_blueprint {
        update = "faction_base_canteen_2_0",
        name = content.text("canteen survey"),
        provides = {
            { id = "fbmk_2" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_fireplace",
    result = "fbmk_2_fireplace",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Now that we have some cover, we should build a fireplace for cooking and grab a pot."),
}
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "clay_pot", count = 1 }
        })
    :component("pan", 1)
    :camp_blueprint {
        update = "fbmk_2_fireplace",
        name = content.text("build a fireplace"),
        provides = {
            { id = "kitchen" },
            { id = "fbmk_2_recipes_1" },
            { id = "fbmk_2_fire" },
            { id = "trapping" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmk_2_center" },
        },
        excludes = {
            { id = "fbmk_2_fire" },
        },
        resources = { "fake_fireplace", "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_stove",
    result = "fbmk_2_stove",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Now that we have some cover, we should build a stove for cooking and grab a pot."),
}
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "clay_pot", count = 1 }
        })
    :component("pan", 1)
    :camp_blueprint {
        update = "fbmk_2_stove",
        name = content.text("build a wood stove"),
        provides = {
            { id = "kitchen" },
            { id = "fbmk_2_recipes_1" },
            { id = "fbmk_2_fire" },
            { id = "trapping" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmk_2_center" },
        },
        excludes = {
            { id = "fbmk_2_fire" },
        },
        resources = { "fake_fireplace", "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_well",
    result = "fbmk_2_well",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We should build a well.  This will make cooking more convenient and provides water to support a chef's garden."),
}
    :camp_blueprint {
        update = "fbmk_2_well",
        name = content.text("build a well"),
        provides = {
            { id = "fbmk_2_well" },
            { id = "water_well" },
        },
        requires = {
            { id = "fbmk_2" },
        },
        excludes = {
            { id = "fbmk_2_well" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_counters",
    result = "fbmk_2_counters",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build some counters and shelves."),
}
    :camp_blueprint {
        update = "fbmk_2_counters",
        name = content.text("build kitchen counters"),
        provides = {
            { id = "fbmk_2_counters" },
        },
        requires = {
            { id = "fbmk_2_center_2" },
        },
        excludes = {
            { id = "fbmk_2_counters" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_smoking",
    result = "fbmk_2_smoking",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build some smokers and a charcoal kiln for food preservation and additional cooking options."),
}
    :camp_blueprint {
        update = "fbmk_2_smoking_kiln",
        name = content.text("build 3 smoking racks and a charcoal kiln"),
        provides = {
            { id = "fbmk_2_smoking" },
            { id = "fbmk_2_recipes_2" },
        },
        requires = {
            { id = "fbmk_2_fire" },
            { id = "fbmk_2_smoking_area" },
        },
        excludes = {
            { id = "fbmk_2_smoking" },
        },
        resources = { "fake_char_smoker", "fake_char_smoker", "fake_char_smoker", "fake_char_kiln" },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_cellar",
    result = "fbmk_2_cellar",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build 2 root cellars in the kitchen."),
}
    :camp_blueprint {
        update = "fbmk_2_root_cellar",
        name = content.text("build root cellars"),
        provides = {
            { id = "fbmk_2_root_cellar" },
        },
        requires = {
            { id = "fbmk_2_center_2" },
        },
        excludes = {
            { id = "fbmk_2_root_cellar" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_pantry_furniture",
    result = "fbmk_2_pantry_furniture",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's furnish the pantry."),
}
    :camp_blueprint {
        update = "fbmk_2_pantry",
        name = content.text("furnish the pantry"),
        provides = {
            { id = "fbmk_2_pantry_furniture" },
            { id = "pantry" },
        },
        requires = {
            { id = "fbmk_2_pantry_room" },
        },
        excludes = {
            { id = "fbmk_2_pantry_furniture" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_butchery",
    result = "fbmk_2_butchery",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's make a butchery area."),
}
    :component_any({
            { id = "knife_huge", count = 1 },
            { id = "knife_small", count = 1 },
            { id = "knife_large", count = 2 }
        })
    :camp_blueprint {
        update = "fbmk_2_butchery",
        name = content.text("build butchery area"),
        provides = {
            { id = "fbmk_2_butchery" },
            { id = "fbmk_2_recipes_3" },
            { id = "trapping" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmk_2_smoking" },
        },
        excludes = {
            { id = "fbmk_2_butchery" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_dining_furniture",
    result = "fbmk_2_dining_furniture",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's make some furniture for the dining hall."),
}
    :camp_blueprint {
        update = "fbmk_2_dining_furniture",
        name = content.text("furnish the dining room"),
        provides = {
            { id = "fbmk_2_dining_furniture" },
        },
        requires = {
            { id = "fbmk_2_dining_2" },
        },
        excludes = {
            { id = "fbmk_2_dining_furniture" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_1",
    result = "fbmk_2_planters_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build some planters for a chef's garden."),
}
    :camp_blueprint {
        update = "fbmk_2_planters_1",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_1" },
        },
        requires = {
            { id = "fbmk_2_well" },
        },
        excludes = {
            { id = "fbmk_2_planters_1" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_2",
    result = "fbmk_2_planters_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_2",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_2" },
        },
        requires = {
            { id = "fbmk_2_planters_1" },
        },
        excludes = {
            { id = "fbmk_2_planters_2" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_3",
    result = "fbmk_2_planters_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_3",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_3" },
        },
        requires = {
            { id = "fbmk_2_planters_2" },
        },
        excludes = {
            { id = "fbmk_2_planters_3" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_4",
    result = "fbmk_2_planters_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_4",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_4" },
        },
        requires = {
            { id = "fbmk_2_planters_3" },
        },
        excludes = {
            { id = "fbmk_2_planters_4" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_5",
    result = "fbmk_2_planters_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_5",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_5" },
        },
        requires = {
            { id = "fbmk_2_planters_4" },
        },
        excludes = {
            { id = "fbmk_2_planters_5" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_6",
    result = "fbmk_2_planters_6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_6",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_6" },
        },
        requires = {
            { id = "fbmk_2_planters_5" },
        },
        excludes = {
            { id = "fbmk_2_planters_6" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_7",
    result = "fbmk_2_planters_7",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_7",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_7" },
        },
        requires = {
            { id = "fbmk_2_planters_6" },
        },
        excludes = {
            { id = "fbmk_2_planters_7" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_8",
    result = "fbmk_2_planters_8",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_8",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_8" },
        },
        requires = {
            { id = "fbmk_2_planters_7" },
        },
        excludes = {
            { id = "fbmk_2_planters_8" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_9",
    result = "fbmk_2_planters_9",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_9",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_9" },
        },
        requires = {
            { id = "fbmk_2_planters_8" },
        },
        excludes = {
            { id = "fbmk_2_planters_9" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_10",
    result = "fbmk_2_planters_10",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_10",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_10" },
        },
        requires = {
            { id = "fbmk_2_planters_9" },
        },
        excludes = {
            { id = "fbmk_2_planters_10" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_11",
    result = "fbmk_2_planters_11",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_11",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_11" },
        },
        requires = {
            { id = "fbmk_2_planters_10" },
        },
        excludes = {
            { id = "fbmk_2_planters_11" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_12",
    result = "fbmk_2_planters_12",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_12",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_12" },
        },
        requires = {
            { id = "fbmk_2_planters_11" },
        },
        excludes = {
            { id = "fbmk_2_planters_12" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_13",
    result = "fbmk_2_planters_13",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_13",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_13" },
        },
        requires = {
            { id = "fbmk_2_planters_12" },
        },
        excludes = {
            { id = "fbmk_2_planters_13" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_14",
    result = "fbmk_2_planters_14",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_14",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_14" },
        },
        requires = {
            { id = "fbmk_2_planters_13" },
        },
        excludes = {
            { id = "fbmk_2_planters_14" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_15",
    result = "fbmk_2_planters_15",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_15",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_15" },
        },
        requires = {
            { id = "fbmk_2_planters_14" },
        },
        excludes = {
            { id = "fbmk_2_planters_15" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_planters_16",
    result = "fbmk_2_planters_16",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's expand the chef's garden in the 'free' area.  (Stop expanding if you want to use the area for something else)"),
}
    :camp_blueprint {
        update = "fbmk_2_planters_16",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_2_planters_16" },
        },
        requires = {
            { id = "fbmk_2_planters_15" },
        },
        excludes = {
            { id = "fbmk_2_planters_16" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_tanks",
    result = "fbmk_2_tanks",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's install a pair of tanks for salt water to allow for salt production and make hide working easier."),
}
    :camp_blueprint {
        update = "fbmk_2_tank",
        name = content.text("build salt water tanks"),
        provides = {
            { id = "fbmk_2_tank" },
            { id = "saltworks_recipes_1" },
        },
        requires = {
            { id = "fbmk_2_pantry_room" },
        },
        excludes = {
            { id = "fbmk_2_tank" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_vat",
    result = "fbmk_2_vat",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's install some vats in the brewery."),
}
    :camp_blueprint {
        update = "fbmk_2_vat",
        name = content.text("install some brewery vats"),
        provides = {
            { id = "fbmk_2_vat" },
            { id = "saltworks_recipes_2" },
        },
        requires = {
            { id = "fbmk_2_brewery" },
        },
        excludes = {
            { id = "fbmk_2_vat" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_display",
    result = "fbmk_2_display",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's install some racks for storage in the brewery."),
}
    :camp_blueprint {
        update = "fbmk_2_display",
        name = content.text("install some brewery racks"),
        provides = {
            { id = "fbmk_2_display" },
        },
        requires = {
            { id = "fbmk_2_brewery" },
        },
        excludes = {
            { id = "fbmk_2_display" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_still",
    result = "fbmk_2_still",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's install a still in the brewery."),
}
    :camp_blueprint {
        update = "fbmk_2_still",
        name = content.text("install a still in the brewery"),
        provides = {
            { id = "fbmk_2_still" },
            { id = "saltworks_recipes_3" },
        },
        requires = {
            { id = "fbmk_2_brewery" },
        },
        excludes = {
            { id = "fbmk_2_still" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_windmill",
    result = "fbmk_2_windmill",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build a windmill to allow us to grind flour efficiently."),
}
    :camp_blueprint {
        update = "fbmk_2_windmill",
        name = content.text("build a windmill"),
        provides = {
            { id = "fbmk_2_windmill" },
        },
        requires = {
            { id = "fbmk_2" },
        },
        excludes = {
            { id = "fbmk_2_windmill" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmk_2_bath",
    result = "fbmk_2_bath",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build a bench and a bird bath outside the kitchen for relaxation."),
}
    :camp_blueprint {
        update = "fbmk_2_bench_bath",
        name = content.text("build a bench and a bird bath"),
        provides = {
            { id = "fbmk_2_bench_bath" },
        },
        requires = {
            { id = "fbmk_2_center_2" },
        },
        excludes = {
            { id = "fbmk_2_bench_bath" },
        },
    }
)
