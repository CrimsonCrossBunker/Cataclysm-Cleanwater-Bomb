local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "homemade_ink",
    result = "homemade_ink",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 2, true)
    :component("sweet_fruit", 1, true)
    :component("salt", 2)
    :component("vinegar", 2)
    :quality("COOK", 2, 1)
    :batch_discount(80, 4)
    :result_charges(10)
)

-- 20u energy to cook a meat chunk per standard
content.add(content.Recipe {
    id = "insect_meat_cooked",
    result = "insect_meat_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("insect_meat", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 300g meat = 20u
content.add(content.Recipe {
    id = "insect_meat_fried",
    result = "insect_meat_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 20, true)
    :component("insect_meat", 1)
    :component("fry_oil", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills", { time_multiplier = 1.5 })
    :proficiency("prof_frying")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "amphora_plum_juice",
    result = "amphora_plum_juice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("amphora_plums", 4)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :byproduct("juice_pulp", 16)
)

content.add(content.Recipe {
    id = "oxblood_paste",
    result = "oxblood_paste",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 20, true)
    :component("oxblood_apple", 1)
    :component("water", 2)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :batch_discount(67, 5)
    :result_charges(2)
)
