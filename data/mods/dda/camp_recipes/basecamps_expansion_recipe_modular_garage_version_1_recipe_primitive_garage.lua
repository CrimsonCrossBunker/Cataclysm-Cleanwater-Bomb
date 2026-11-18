local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_garage_0",
    result = "faction_base_garage_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey land for a garage."),
}
    :camp_blueprint {
        update = "faction_base_garage_0",
        name = content.text("garage survey"),
        provides = {
            { id = "fbmg_0" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_garage_1",
    result = "faction_base_garage_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 30240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    never_learn = true,
    description = content.text("Building a tool rack should be the first priority."),
}
    :component("log", 72)
    :component("stick", 72)
    :component("2x4", 110)
    :component("nails", 16, true)
    :component("pipe", 24)
    :component("wrench", 1)
    :component("hacksaw", 1)
    :component("sheet_metal", 4)
    :quality("DIG", 2, 1)
    :quality("HAMMER", 2, 1)
    :quality("WRENCH", 1, 1)
    :camp_blueprint {
        update = "faction_base_field_camp_garage_1",
        name = content.text("Garage tool rack"),
        provides = {
            { id = "dismantling" },
        },
        requires = {
            { id = "fbmg_0" },
        },
        resources = { "wrench", "hacksaw" },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_garage_2",
    result = "faction_base_garage_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 25920000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    never_learn = true,
    description = content.text("We should start construction of a roof for the garage."),
}
    :component("log", 68)
    :component("stick", 60)
    :component("2x4", 112)
    :quality("DIG", 2, 1)
    :quality("HAMMER", 2, 1)
    :camp_blueprint {
        update = "faction_base_field_camp_garage_2",
        name = content.text("Garage partial roof"),
        requires = {
            { id = "faction_base_garage_1" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_garage_3",
    result = "faction_base_garage_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 60480000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    never_learn = true,
    description = content.text("Finishing out the roof will let our mechanics work rain or shine."),
}
    :component("log", 112)
    :component("2x4", 448)
    :quality("DIG", 2, 1)
    :quality("HAMMER", 2, 1)
    :camp_blueprint {
        update = "faction_base_field_camp_garage_3",
        name = content.text("Garage completed roof"),
        requires = {
            { id = "faction_base_garage_2" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_garage_4",
    result = "faction_base_garage_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 25920000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    never_learn = true,
    description = content.text("Our garage isn't big enough to work on larger vehicles.  Let's start expanding it."),
}
    :component("log", 65)
    :component("stick", 96)
    :quality("DIG", 2, 1)
    :quality("HAMMER", 2, 1)
    :camp_blueprint {
        update = "faction_base_field_camp_garage_4",
        name = content.text("Garage partial expansion"),
        requires = {
            { id = "faction_base_garage_3" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_garage_5",
    result = "faction_base_garage_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 69120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
    never_learn = true,
    description = content.text("Finishing the roof will let us park RVs and buses in the garage."),
}
    :component("log", 124)
    :component("stick", 96)
    :component("2x4", 752)
    :component("nails", 24, true)
    :component("pipe", 24)
    :component("sheet_metal", 4)
    :quality("DIG", 2, 1)
    :quality("HAMMER", 2, 1)
    :quality("WRENCH", 1, 1)
    :camp_blueprint {
        update = "faction_base_field_camp_garage_5",
        name = content.text("Garage expanded roof"),
        requires = {
            { id = "faction_base_garage_4" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_garage_6",
    result = "faction_base_garage_6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 17280000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    never_learn = true,
    description = content.text("Attaching quarters will let our mechanics work longer hours when needed."),
}
    :component("log", 95)
    :component("stick", 90)
    :component("2x4", 154)
    :component("nails", 72, true)
    :component("pipe", 12)
    :component("sheet_metal", 2)
    :component_any({
            { id = "straw_pile", count = 16 },
            { id = "pine_bough", count = 20 }
        })
    :quality("DIG", 2, 1)
    :quality("HAMMER", 2, 1)
    :quality("WRENCH", 1, 1)
    :camp_blueprint {
        update = "faction_base_field_camp_garage_6",
        name = content.text("Garage mechanics quarters"),
        requires = {
            { id = "faction_base_garage_5" },
        },
        check_needs = false,
    }
)
