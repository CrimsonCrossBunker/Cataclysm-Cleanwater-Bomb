local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "rehydrated_eggs",
    result = "rehydrated_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("powder_eggs", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
)

-- 3u is the default to cook an egg
content.add(content.Recipe {
    id = "scrambled_eggs",
    result = "scrambled_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 3, true)
    :component("eggs_any_shape", 1, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(1)
)

-- 3u is the default to cook an egg
content.add(content.Recipe {
    id = "seasoned_scrambled_eggs",
    result = "seasoned_scrambled_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 3, true)
    :component("eggs_any_shape", 1, true)
    :component_any({
            { id = "salt", count = 2 },
            { id = "seasoning_salt", count = 2 },
            { id = "pepper", count = 4 }
        })
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(1)
)

-- 6u for the egg, 1u for the oil
content.add(content.Recipe {
    id = "fried_eggs",
    result = "fried_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 7, true)
    :component_any({
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true }
        })
    :component("any_butter_or_oil", 2, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(2)
)

-- 6u for the egg, 1u for the oil
content.add(content.Recipe {
    id = "seasoned_fried_eggs",
    result = "seasoned_fried_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 7, true)
    :component_any({
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true }
        })
    :component("any_butter_or_oil", 2, true)
    :component_any({
            { id = "salt", count = 2 },
            { id = "seasoning_salt", count = 2 },
            { id = "pepper", count = 4 }
        })
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(2)
)

-- 6u for the eggs, 1u for the oil, 2u for the veggy, 1u for the cheese
content.add(content.Recipe {
    id = "deluxe_fried_eggs",
    result = "deluxe_fried_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true }
        })
    :component("any_butter_or_oil", 2, true)
    :component_any({
            { id = "mushroom", count = 1 },
            { id = "mushroom_morel", count = 1 },
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "wild_garlic", count = 1 },
            { id = "onion", count = 1 },
            { id = "veggy_potatolike", count = 1, requirement = true }
        })
    :component_any({
            { id = "cheese_standard", count = 1, requirement = true },
            { id = "veggy_green", count = 1, requirement = true }
        })
    :component_any({
            { id = "salt", count = 2 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_salt", count = 2 },
            { id = "pepper", count = 4 }
        })
    :component("condiment", 2, true)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 2)
    :result_charges(2)
)

-- 6u for the egg, 1u for the oil.  no energy is spent cooking the bread, that's already done.
content.add(content.Recipe {
    id = "fried_egg_sandwich",
    result = "fried_egg_sandwich",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 7, true)
    :component_any({
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true }
        })
    :component("any_butter_or_oil", 2, true)
    :component("bread_sandwich", 2, true)
    :component("condiment", 2, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "caviar_egg_sandwich",
    result = "caviar_egg_sandwich",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component("boiled_egg", 1)
    :component("mayonnaise", 1)
    :component("cured_roe", 1)
    :component("bread_sandwich", 2, true)
    :quality("CUT", 1, 1)
    :batch_discount(80, 2)
)

-- 6u for the egg, 1u for the oil, 3u for the cheese and veggy.  no energy is spent cooking the bread, that's
-- already done.
content.add(content.Recipe {
    id = "deluxe_fried_egg_sandwich",
    result = "deluxe_fried_egg_sandwich",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true }
        })
    :component("any_butter_or_oil", 2, true)
    :component_any({
            { id = "mushroom", count = 1 },
            { id = "mushroom_morel", count = 1 },
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "wild_garlic", count = 1 },
            { id = "young_leaves", count = 2 },
            { id = "chicory_leaves", count = 2 },
            { id = "onion", count = 1 }
        })
    :component_any({
            { id = "cheese_standard", count = 1, requirement = true },
            { id = "veggy_green", count = 1, requirement = true }
        })
    :component_any({
            { id = "salt", count = 2 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_salt", count = 2 },
            { id = "pepper", count = 4 }
        })
    :component("condiment", 2, true)
    :component("bread_sandwich", 2, true)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "omelet",
    result = "omelet",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 42000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 7, true)
    :component_any({
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true }
        })
    :component("cheese_standard", 1, true)
    :component("any_butter_or_oil", 1, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "vegetable_omelet",
    result = "vegetable_omelet",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 7, true)
    :component_any({
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true }
        })
    :component("cheese_standard", 1, true)
    :component("veggy_any", 2, true)
    :component("any_butter_or_oil", 1, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "supreme_omelet",
    result = "supreme_omelet",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 7, true)
    :component_any({
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true }
        })
    :component("cheese_standard", 1, true)
    :component("veggy_any", 2, true)
    :component("meat_cooked", 1, true)
    :component("any_butter_or_oil", 1, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "cured_roe_vacuum_packed",
    result = "cured_roe",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
    container = "plastic_bag_vac",
    name = content.text("vacuum packed %s"),
}
    :component("curing_roe_active", 2)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requirement("vacuum_sealing_standard", 1)
    :book("vacuum_sealing", 1)
    :proficiency("prof_preservation")
    :batch_discount(10, 3)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "egg_salad",
    result = "egg_salad",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("boiled_egg", 6)
    :component_any({
            { id = "mustard", count = 1 },
            { id = "mustard_powder", count = 1 }
        })
    :component_any({
            { id = "sauce_pesto", count = 2 },
            { id = "mayonnaise", count = 2 }
        })
    :component_any({
            { id = "pickle", count = 1 },
            { id = "veggy_pickled", count = 1 },
            { id = "bacon", count = 1 }
        })
    :component_any({
            { id = "seasoning_salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "pepper", count = 1 },
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "garlic_powder", count = 1 },
            { id = "vinegar", count = 1 },
            { id = "seasoning_italian", count = 1 }
        })
    :component_any({
            { id = "seasoning_salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "pepper", count = 1 },
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "garlic_powder", count = 1 },
            { id = "vinegar", count = 1 },
            { id = "seasoning_italian", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("CONTAIN", 1, 1)
    :result_charges(10)
)
