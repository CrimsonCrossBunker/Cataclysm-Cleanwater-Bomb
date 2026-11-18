local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "rehydrated_fruit",
    result = "rehydrated_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("dry_fruit", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 1)
)

-- flour=1u, fruit=1u, hardtack = 3 each (would be 6-7 by weight but it is already cooked)
content.add(content.Recipe {
    id = "hardtack_pudding",
    result = "hardtack_pudding",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 8, true)
    :component("hardtack", 2)
    :component("flour_any", 1, true)
    :component("sugar_standard_half", 1, true)
    :component("sweet_fruit_like", 1, true)
    :component("water_clean", 1)
    :quality("COOK", 3, 1)
    :batch_discount(80, 4)
    :result_charges(8)
)

-- cooking it longer than is typical for fruit.
content.add(content.Recipe {
    id = "fruit_leather",
    result = "fruit_leather",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 108000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 8, true)
    :component("sweet_fruit", 1, true)
    :component("sugar_standard_half", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :batch_discount(83, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "apple_sugar_vacuum_packed",
    result = "apple_sugar",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
    container = "plastic_bag_vac",
}
    :component("water_clean", 1)
    :component("sweet_fruit", 4, true)
    :component("sugar_standard", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requirement("vacuum_sealing_standard", 1)
    :book("vacuum_sealing", 1)
    :proficiency("prof_preservation")
    :batch_discount(10, 3)
    :result_charges(8)
)

content.add(content.Recipe {
    id = "brandied_fruit",
    result = "brandied_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("sweet_fruit", 1, true)
    :component("hard_liquor", 1, true)
    :quality("CONTAIN", 1, 1)
    :proficiency("prof_preservation")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "brandied_fruit_jarred",
    result = "brandied_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    container = "jar_glass_sealed",
}
    :component("sweet_fruit", 1, true)
    :component("jar_glass_sealed", 1)
    :component("hard_liquor", 1, true)
    :quality("CONTAIN", 1, 1)
    :proficiency("prof_preservation")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "brandied_fruit_jarred_3l",
    result = "brandied_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    container = "jar_3l_glass_sealed",
}
    :component("sweet_fruit", 8, true)
    :component("jar_3l_glass_sealed", 1)
    :component("hard_liquor", 5, true)
    :quality("CONTAIN", 1, 1)
    :proficiency("prof_preservation")
    :result_charges(12)
)

-- 1u for fruit and 1u for sugar, you're basically just turning it into goop and not really cooking it
content.add(content.Recipe {
    id = "jam_fruit",
    result = "jam_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 2, true)
    :component("sweet_fruit", 1, true)
    :component("sugar_powdered", 10, true)
    :quality("COOK", 2, 1)
    :book("sweets_book", 1)
    :book("cookbook", 1)
    :batch_discount(80, 4)
    :result_charges(8)
)

content.add(content.Recipe {
    id = "cooked_elderberries",
    result = "cooked_elderberries",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("elderberries", 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 3)
)
