local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "curing_roe_active",
    result = "curing_roe_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component_any({
            { id = "salt", count = 2 },
            { id = "soysauce", count = 4 },
            { id = "seasoning_salt", count = 2 }
        })
    :component("eggs_roe", 2, true)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 2)
)
