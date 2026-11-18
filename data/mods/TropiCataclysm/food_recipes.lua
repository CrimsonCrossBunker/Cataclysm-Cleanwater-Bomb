local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "cnidarian_cooked",
    result = "cnidarian_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 7, true)
    :component("cnidarian", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "echinoderm_cooked",
    result = "echinoderm_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 7, true)
    :component("echinoderm", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)
