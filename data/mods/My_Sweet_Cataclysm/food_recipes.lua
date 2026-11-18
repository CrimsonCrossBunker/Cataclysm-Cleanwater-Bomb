local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "milk_choc_from_raw",
    result = "milk_choc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 3, true)
    :component("milk_raw_choc", 1)
    :quality("BOIL", 1, 1)
    :proficiency("prof_preservation")
    :batch_discount(80, 4)
    :result_charges(1)
)

-- Not in base game because people don't seem to do this IRL, with chocolate cows they might.
content.add(content.Recipe {
    id = "milk_reconstituted_choc",
    result = "milk_reconstituted_choc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("milk_powder_choc", 1)
    :component("water_clean", 1)
)

-- Not in base game because people don't seem to do this IRL, with chocolate cows they might.
content.add(content.Recipe {
    id = "milk_powder_choc",
    result = "milk_powder_choc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "dehydrator", charges = 25 },
            { id = "char_smoker", charges = 25 }
        })
    :component("milk_choc", 1)
    :batch_discount(67, 5)
    :result_charges(4)
)
