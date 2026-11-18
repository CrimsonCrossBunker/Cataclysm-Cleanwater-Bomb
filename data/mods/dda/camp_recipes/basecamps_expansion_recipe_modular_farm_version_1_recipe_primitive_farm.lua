local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_farm_0",
    result = "faction_base_farm_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey land for a farming area."),
}
    :camp_blueprint {
        update = "faction_base_farm_0",
        name = content.text("farm area survey"),
        provides = {
            { id = "fbmf_0" },
            { id = "farming" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_farm_1",
    result = "faction_base_farm_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 3240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Plowing a few plots should get us started."),
}
    :quality("DIG", 1, 1)
    :camp_blueprint {
        update = "faction_base_field_camp_farm_1",
        name = content.text("Farm basic plots"),
        requires = {
            { id = "fbmf_0" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_farm_2",
    result = "faction_base_farm_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 21600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    never_learn = true,
    description = content.text("We could use a farming shed to store resources where we'll be working."),
}
    :component("log", 54)
    :component("stick", 90)
    :quality("DIG", 2, 1)
    :quality("HAMMER", 2, 1)
    :camp_blueprint {
        update = "faction_base_field_camp_farm_2",
        name = content.text("Farm basic shed"),
        requires = {
            { id = "fbmf_0" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_farm_3",
    result = "faction_base_farm_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 12960000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    never_learn = true,
    description = content.text("Our farm could be expanded by finishing the shed and adding additional plots."),
}
    :component("log", 24)
    :component("stick", 36)
    :component("2x4", 16)
    :component("nails", 36, true)
    :quality("DIG", 2, 1)
    :quality("HAMMER", 2, 1)
    :camp_blueprint {
        update = "faction_base_field_camp_farm_3",
        name = content.text("Farm upgraded shed"),
        requires = {
            { id = "fbmf_0" },
            { id = "faction_base_farm_1" },
        },
        check_needs = false,
    }
)

-- 1hrs*26wall + 1.5 hr*1door + 0.5hrs*14pits + 2hrs*2window + 2hrs*20log roof + 0.5hrs*9counter +
-- 0.5hrs*1table = 83.5 hrs (12hrs on/off) 7 days total; requires 26wall*(2log+3stick+6 2x4 ) + 1door*(16
-- 2x4+36nail) + 2windows*(15 2x4+30nail+2log+glass) + 20roof*(2log+4stick+8 2x4) + 1table*(8nail+6 2x4) +
-- 9counter*(8nail+6 2x4)
content.add(content.Recipe {
    id = "faction_base_farm_4",
    result = "faction_base_farm_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 30240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    never_learn = true,
    description = content.text("Building a processing shack should allow us to reclaim additional seeds from our byproducts."),
}
    :component("log", 96)
    :component("stick", 158)
    :component("2x4", 336)
    :component("nails", 176, true)
    :component("glass_sheet", 2)
    :quality("DIG", 2, 1)
    :quality("HAMMER", 2, 1)
    :camp_blueprint {
        update = "faction_base_field_camp_farm_4",
        name = content.text("Farm processing shack"),
        provides = {
            { id = "reseeding" },
            { id = "farm_recipes_1" },
        },
        requires = {
            { id = "faction_base_farm_3" },
        },
        check_needs = false,
    }
)
