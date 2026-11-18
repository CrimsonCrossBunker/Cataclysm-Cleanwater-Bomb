local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- standard is 2u energy per 100g veggy ish, 1u mushroom is 70g
content.add(content.Recipe {
    id = "mushroom_cooked",
    result = "mushroom_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 3, true)
    :component("mushroom", 2)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
    :result_charges(2)
)

-- 80g of veggy-adjacent matter for 2u heat
content.add(content.Recipe {
    id = "morel_cooked",
    result = "morel_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 2, true)
    :component("water_clean", 1)
    :component("mushroom_morel", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_food_prep")
)

-- 80g of veggy-adjacent matter for 2u heat plus 2u for batter and oil
content.add(content.Recipe {
    id = "morel_fried",
    result = "morel_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 4, true)
    :component("mushroom_morel", 1)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 1, true)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "mushroom_ketchup",
    result = "mushroom_ketchup",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 6, true)
    :component("mushroom", 15)
    :component("water_clean", 5)
    :component_any({
            { id = "salt", count = 18 },
            { id = "seasoning_salt", count = 18 }
        })
    :quality("COOK", 2, 1)
    :batch_discount(50, 2)
    :result_charges(15)
    :byproduct("mushroom_cooked", 10)
)
