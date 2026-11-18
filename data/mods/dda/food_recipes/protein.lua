local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "protein_drink",
    result = "protein_drink",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 24000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("protein_powder", 1)
    :component("water_clean", 1)
)

content.add(content.Recipe {
    id = "protein_shake",
    result = "protein_shake",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("protein_powder", 1)
    :component("water_clean", 1)
    :component_any({
            { id = "lemonade_powder", count = 1 },
            { id = "sweet_fruit_like", count = 1, requirement = true },
            { id = "coconut_flesh", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "milk_fortified",
    result = "milk_fortified",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("protein_powder", 1)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
)

content.add(content.Recipe {
    id = "protein_smoothie_milk",
    result = "protein_smoothie",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("protein_powder", 1)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
    :component_any({
            { id = "lemonade_powder", count = 1 },
            { id = "sweet_fruit_like", count = 1, requirement = true },
            { id = "coconut_flesh", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "protein_smoothie_water",
    result = "protein_smoothie",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("protein_powder", 1)
    :component("milk_powder", 1)
    :component_any({
            { id = "lemonade_powder", count = 1 },
            { id = "sweet_fruit_like", count = 1, requirement = true },
            { id = "coconut_flesh", count = 1 }
        })
    :component("water_clean", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(2)
)
