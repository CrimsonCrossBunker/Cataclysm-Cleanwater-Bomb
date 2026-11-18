local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_canteen_0",
    result = "faction_base_canteen_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey land for a kitchen and dining area."),
}
    :camp_blueprint {
        update = "faction_base_canteen_0",
        name = content.text("kitchen survey"),
        provides = {
            { id = "fbmk_0" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_canteen_fireplace",
    result = "faction_base_modular_canteen_fireplace",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Now that we have some cover, we should build 2 fireplaces for cooking and grab a pot."),
}
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "clay_pot", count = 1 }
        })
    :component("pan", 1)
    :camp_blueprint {
        update = "fbmk_canteen_fireplace",
        name = content.text("build 2 fireplaces"),
        provides = {
            { id = "kitchen" },
            { id = "kitchen_recipes_1" },
            { id = "fbmk_canteen_fire" },
            { id = "trapping" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmk_center" },
        },
        excludes = {
            { id = "fbmk_canteen_fire" },
        },
        resources = { "fake_fireplace", "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_canteen_stove",
    result = "faction_base_modular_canteen_stove",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Now that we have some cover, we should build 2 stoves for cooking and grab a pot."),
}
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "clay_pot", count = 1 }
        })
    :component("pan", 1)
    :camp_blueprint {
        update = "fbmk_canteen_stove",
        name = content.text("build 2 wood stoves"),
        provides = {
            { id = "kitchen" },
            { id = "kitchen_recipes_1" },
            { id = "fbmk_canteen_fire" },
            { id = "trapping" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmk_center" },
        },
        excludes = {
            { id = "fbmk_canteen_fire" },
        },
        resources = { "fake_fireplace", "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_canteen_well",
    result = "faction_base_modular_canteen_well",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a well.  This will make cooking more convenient."),
}
    :camp_blueprint {
        update = "fbmk_canteen_well",
        name = content.text("build a well"),
        provides = {
            { id = "fbmk_canteen_well" },
            { id = "water_well" },
        },
        requires = {
            { id = "fbmk_canteen_fire" },
        },
        excludes = {
            { id = "fbmk_canteen_well" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_canteen_counters",
    result = "faction_base_modular_canteen_counters",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some counters and shelves."),
}
    :camp_blueprint {
        update = "faction_base_canteen_counters",
        name = content.text("build kitchen counters"),
        provides = {
            { id = "fbmk_counters" },
        },
        requires = {
            { id = "fbmk_center2" },
        },
        excludes = {
            { id = "fbmk_counters" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_canteen_smoking",
    result = "faction_base_modular_canteen_smoking",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's build some smokers and a charcoal kiln for food preservation."),
}
    :camp_blueprint {
        update = "fbmk_canteen_smoking_kiln",
        name = content.text("build 3 smoking racks and a charcoal kiln"),
        provides = {
            { id = "fbmk_canteen_smoking" },
            { id = "kitchen_recipes_2" },
        },
        requires = {
            { id = "fbmk_canteen_fire" },
        },
        excludes = {
            { id = "fbmk_canteen_smoking" },
        },
        resources = { "fake_char_smoker", "fake_char_smoker", "fake_char_smoker", "fake_char_kiln" },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_pantry_furniture",
    result = "faction_base_canteen_pantry_furniture",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the pantry and build 2 root cellars."),
}
    :camp_blueprint {
        update = "fbmk_canteen_pantry_furniture",
        name = content.text("furnish the pantry"),
        provides = {
            { id = "fbmk_pantry_furniture" },
            { id = "pantry" },
        },
        requires = {
            { id = "fbmk_pantry_room" },
        },
        excludes = {
            { id = "fbmk_pantry_furniture" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_butchery",
    result = "faction_base_canteen_butchery",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's make a butchery area."),
}
    :component_any({
            { id = "knife_huge", count = 1 },
            { id = "knife_small", count = 1 },
            { id = "knife_large", count = 2 }
        })
    :camp_blueprint {
        update = "fbmk_canteen_butchery_rack",
        name = content.text("build butchery area"),
        provides = {
            { id = "fbmk_canteen_butchery" },
            { id = "kitchen_recipes_3" },
            { id = "trapping" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmk_canteen_smoking" },
        },
        excludes = {
            { id = "fbmk_canteen_butchery" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_dining_furniture",
    result = "faction_base_canteen_dining_furniture",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's make some furniture for the dining hall."),
}
    :camp_blueprint {
        update = "fbmk_canteen_dining_furniture",
        name = content.text("furnish the dining room"),
        provides = {
            { id = "fbmk_canteen_dining_furniture" },
        },
        requires = {
            { id = "fbmk_canteen_dining_center" },
        },
        excludes = {
            { id = "fbmk_canteen_dining_furniture" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_planters_1",
    result = "faction_base_canteen_planters_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's build some planters to the north for a chef's garden."),
}
    :camp_blueprint {
        update = "fbmk_canteen_planters_1",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_canteen_planterA" },
        },
        requires = {
            { id = "fbmk_canteen_well" },
        },
        excludes = {
            { id = "fbmk_canteen_planterA" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_planters_2",
    result = "faction_base_canteen_planters_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's build some planters to the north for a chef's garden."),
}
    :camp_blueprint {
        update = "fbmk_canteen_planters_2",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_canteen_planterB" },
        },
        requires = {
            { id = "fbmk_canteen_planterA" },
        },
        excludes = {
            { id = "fbmk_canteen_planterB" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_planters_3",
    result = "faction_base_canteen_planters_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's build some planters to the north for a chef's garden."),
}
    :camp_blueprint {
        update = "fbmk_canteen_planters_3",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_canteen_planterC" },
        },
        requires = {
            { id = "fbmk_canteen_planterB" },
        },
        excludes = {
            { id = "fbmk_canteen_planterC" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_canteen_planters_4",
    result = "faction_base_canteen_planters_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's build some planters to the north for a chef's garden."),
}
    :camp_blueprint {
        update = "fbmk_canteen_planters_4",
        name = content.text("build some planters"),
        provides = {
            { id = "fbmk_canteen_planterD" },
        },
        requires = {
            { id = "fbmk_canteen_planterC" },
        },
        excludes = {
            { id = "fbmk_canteen_planterD" },
        },
    }
)
