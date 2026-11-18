local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "milk",
    result = "milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("milk_raw", 1)
    :quality("BOIL", 1, 1)
    :proficiency("prof_preservation")
    :batch_discount(80, 4)
    :result_charges(1)
)

-- you're just melting the chocolate with the heat of the boiled milk, insignificant additional energy needed
content.add(content.Recipe {
    id = "milk_choc",
    result = "milk_choc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
    :component("chocolate", 1)
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "milk_reconstituted_from_powder",
    result = "milk_reconstituted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("milk_powder", 1)
    :component("water_clean", 1)
)

content.add(content.Recipe {
    id = "milk_reconstituted_from_condensed",
    result = "milk_reconstituted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("con_milk", 5)
    :component("water_clean", 3)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "cheese_rehydrated_from_powder",
    result = "cheese_rehydrated",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("cheese_powder", 4)
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "milk_standard", count = 1, requirement = true }
        })
    :result_charges(4)
)

-- most of the work here is the straining, not the cooking. basing on
-- https://www.liveeatlearn.com/5-minute-microwave-ricotta/ to get 300kJ in a microwave
content.add(content.Recipe {
    id = "cheese_hard",
    result = "cheese_hard",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 72, true)
    :component("milk_curdled", 12)
    :component_any({
            { id = "salt_water", count = 12 },
            { id = "saline", count = 12 },
            { id = "salt", count = 12 },
            { id = "seasoning_salt", count = 12 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :quality("BOIL", 2, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :book("survival_book", 7)
    :book("dairy_book", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_cheesemaking_1")
    :proficiency("prof_cheesemaking_2")
    :batch_discount(90, 2)
    :result_charges(12)
)

-- this is a very small quesadilla.  1u for tortilla and 1u for cheese.
content.add(content.Recipe {
    id = "quesadilla_cheese",
    result = "quesadilla_cheese",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("cheese_standard", 1, true)
    :component("tortilla_any", 1, true)
    :quality("COOK", 1, 1)
    :result_charges(1)
)

-- 520g of milk is halfway dehydrated, so 26u of dehydrating.
content.add(content.Recipe {
    id = "con_milk",
    result = "con_milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("dehydrating_heat", 26, true)
    :component("milk_standard_raw_fresh", 2, true)
    :component("sugar_standard", 3, true)
    :quality("COOK", 3, 1)
    :book("cookbook_italian", 2)
    :book("family_cookbook", 2)
    :book("mag_cooking", 2)
    :batch_discount(80, 4)
    :result_charges(10)
)

-- Book Things to do with milk.  Add curdled milk and cheese recipes to the book.  Also consider adding to
-- brewing json Airag from this book.
content.add(content.Recipe {
    id = "raw_butter",
    result = "raw_butter",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :component("milk_cream", 5)
    :component("salt", 1)
    :quality("CHURN", 1, 1)
    :book("dairy_book", 3)
    :batch_discount(95, 2)
    :result_charges(22)
)

-- Book Things to do with milk.  Add curdled milk and cheese recipes to the book.  Also consider adding to
-- brewing json Airag from this book.
content.add(content.Recipe {
    id = "raw_butter_shake",
    result = "raw_butter",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool("jar_glass_sealed", 1)
    :component("water_clean", 1)
    :component("milk_cream", 3)
    :component("salt", 1)
    :book("dairy_book", 3)
    :result_charges(13)
    :byproduct("buttermilk", 3)
)

content.add(content.Recipe {
    id = "milk_cream_rising_active",
    result = "milk_cream_rising_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component("jar_3l_glass_sealed", 1)
    :component("milk_raw", 12)
    :quality("COOK", 3, 1)
)

content.add(content.Recipe {
    id = "milk_cream_whipped",
    result = "milk_cream_whipped",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("milk_cream", 1)
    :component("sugar", 2)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "milk_cream",
    result = "milk_cream",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component("milk_cream_jar", 1)
    :quality("COOK", 1, 1)
    :result_charges(5)
    :byproduct("jar_3l_glass_sealed", 1)
    :byproduct("buttermilk", 7)
)

content.add(content.Recipe {
    id = "cottage_cheese",
    result = "cottage_cheese",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component_any({
            { id = "milk", count = 16 },
            { id = "milk_raw", count = 16 }
        })
    :component("vinegar", 1)
    :component("salt", 1)
    :quality("COOK", 1, 1)
    :quality("STRAIN", 1, 1)
    :book("dairy_book", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_cheesemaking_1")
    :proficiency("prof_cheesemaking_2")
    :result_charges(8)
)

content.add(content.Recipe {
    id = "cottage_cheese_with_fruit",
    result = "cottage_cheese_with_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :component("cottage_cheese", 1)
    :component("sweet_fruit", 1, true)
    :quality("CUT", 1, 1)
    :book("dairy_book", 1)
)

content.add(content.Recipe {
    id = "cottage_cheese_with_savory_veg",
    result = "cottage_cheese_with_savory_veg",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :component("cottage_cheese", 1)
    :component("onion", 1)
    :component_any({
            { id = "any_bell_pepper", count = 1, requirement = true },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "any_salad_cucumber", count = 1, requirement = true }
        })
    :quality("CUT", 1, 1)
    :book("dairy_book", 1)
)

content.add(content.Recipe {
    id = "mozzarella_cheese",
    result = "mozzarella_cheese",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 210000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component_any({
            { id = "milk", count = 5 },
            { id = "milk_raw", count = 5 }
        })
    :component_any({
            { id = "vinegar", count = 1 },
            { id = "chem_citric_acid", count = 1 }
        })
    :component("salt", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 1, 1)
    :quality("STRAIN", 1, 1)
    :book("dairy_book", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_cheesemaking_1")
    :proficiency("prof_cheesemaking_2")
    :result_charges(8)
)

content.add(content.Recipe {
    id = "fried_mozzarella_sticks",
    result = "fried_mozzarella_sticks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 150000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :tool_charges("frying_oil", 1, true)
    :component("mozzarella_cheese", 8)
    :component_any({
            { id = "flour", count = 4 },
            { id = "flour_wheat_free", count = 4 }
        })
    :component("milk", 1)
    :component("garlic_powder", 1)
    :component("eggs_any_shape", 1, true)
    :quality("COOK", 1, 1)
    :book("dairy_book", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :result_charges(10)
)

-- Increased recipe size, due to such minuscule amounts would have excessive loss in the straining step
-- otherwise. Made it X8
content.add(content.Recipe {
    id = "ghee",
    result = "ghee",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component_any({
            { id = "raw_butter", count = 8 },
            { id = "butter", count = 8 }
        })
    :quality("BOIL", 1, 1)
    :quality("COOK", 2, 1)
    :quality("STRAIN", 1, 1)
    :book("cookbook_indian", 1)
    :batch_discount(70, 1)
    :result_charges(8)
)

-- biscuits: 4u, eggs: 2u, mascarpone: 2u, other: 1u.
content.add(content.Recipe {
    id = "tiramisu",
    result = "tiramisu",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool("casserole", 1)
    :component("biscuit", 6)
    :component("mascarpone", 3)
    :component("eggs_any_shape", 3, true)
    :component_any({
            { id = "sugar", count = 4 },
            { id = "artificial_sweetener", count = 4 }
        })
    :component("coffee", 3)
    :quality("COOK", 3, 1)
    :book("cookbook_italian", 2)
    :batch_discount(50, 2)
    :result_charges(4)
)

-- 8 lemons make 18 citric acid, so 2 lemons ~ 4.5 => 5 citric acid
content.add(content.Recipe {
    id = "mascarpone",
    result = "mascarpone",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :component("milk_cream", 8)
    :component_any({
            { id = "lemon", count = 2 },
            { id = "chem_citric_acid", count = 5 }
        })
    :quality("CHURN", 1, 1)
    :book("cookbook_italian", 3)
    :batch_discount(70, 2)
    :result_charges(6)
)
