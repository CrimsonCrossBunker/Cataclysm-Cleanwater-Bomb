local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

-- 300g of onions for 6u heat and 4u for the batter.
content.add(content.Recipe {
    id = "onion_rings",
    result = "onion_rings",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 96000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component("onion", 2)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 2, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :result_charges(1)
)

-- 800g Hungry Man dinner cooks in 2 minutes in the microwave
content.add(content.Recipe {
    id = "cooked_dinner",
    result = "cooked_dinner",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 5, true)
    :component("frozen_dinner", 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "chips_plain",
    result = "chips",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 96000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    variant = "plain",
}
    :tool_charges("surface_heat", 8, true)
    :tool_charges("cooking_oil", 19)
    :component("veggy_potatolike", 1, true)
    :component_any({
            { id = "salt", count = 2 },
            { id = "seasoning_salt", count = 2 }
        })
    :component("cooking_oil", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep", { time_multiplier = 1 })
    :proficiency("prof_knife_skills", { time_multiplier = 1 })
    :proficiency("prof_frying", { time_multiplier = 1.2 })
    :batch_discount(70, 1)
    :result_charges(2)
    :byproduct("cooking_oil", 19)
)

-- these are actually tortilla chips.  about 120g of tortilla, plus oil, so about 11u
content.add(content.Recipe {
    id = "nachos",
    result = "nachos",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 96000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 11, true)
    :tool_charges("frying_oil", 1, true)
    :component_any({
            { id = "tortilla_corn", count = 5 },
            { id = "tortilla_flour", count = 5 }
        })
    :component("fry_oil", 2, true)
    :component_any({
            { id = "salt", count = 2 },
            { id = "seasoning_salt", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_mexican", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :result_charges(1)
)

-- doesn't take very much to melt cheese in a microwave
content.add(content.Recipe {
    id = "nachosc",
    result = "nachosc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("cheese_standard", 1, true)
    :component("nachos", 3)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(3)
)

-- you're just heating it up, energy needed is not much
content.add(content.Recipe {
    id = "nachosm",
    result = "nachosm",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "meat_cooked", count = 1, requirement = true },
            { id = "dry_meat", count = 1 },
            { id = "can_chicken", count = 1 }
        })
    :component("nachos", 3)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(5)
)

-- you're just heating it up, energy needed is not much
content.add(content.Recipe {
    id = "nachosmc",
    result = "nachosmc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 3, true)
    :component_any({
            { id = "meat_cooked", count = 1, requirement = true },
            { id = "dry_meat", count = 1 },
            { id = "can_chicken", count = 1 }
        })
    :component("cheese_standard", 1, true)
    :component("nachos", 3)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(3)
)

-- you're just heating it up, energy needed is not much
content.add(content.Recipe {
    id = "nachosv",
    result = "nachosv",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 1, true)
    :component_any({
            { id = "can_beans", count = 2 },
            { id = "beans_cooked", count = 2 }
        })
    :component("nachos", 3)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(5)
)

-- you're just heating it up, energy needed is not much
content.add(content.Recipe {
    id = "nachosvc",
    result = "nachosvc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "can_beans", count = 2 },
            { id = "beans_cooked", count = 2 }
        })
    :component("cheese_standard", 1, true)
    :component("nachos", 3)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(3)
)

content.add(content.Recipe {
    id = "fries",
    result = "fries",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 96000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 8, true)
    :tool_charges("cooking_oil", 47)
    :component_any({
            { id = "veggy_potatolike", count = 1, requirement = true },
            { id = "carrot", count = 3 },
            { id = "carrot_wild", count = 3 }
        })
    :component_any({
            { id = "salt", count = 2 },
            { id = "seasoning_salt", count = 2 }
        })
    :component("cooking_oil", 3)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep", { time_multiplier = 1 })
    :proficiency("prof_knife_skills", { time_multiplier = 1 })
    :proficiency("prof_frying", { time_multiplier = 1.2 })
    :batch_discount(70, 1)
    :result_charges(3)
    :byproduct("cooking_oil", 47)
)

-- you're just melting the cheese, not much energy needed
content.add(content.Recipe {
    id = "cheese_fries",
    result = "cheese_fries",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("cheese_standard", 1, true)
    :component("fries", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
)

content.add(content.Recipe {
    id = "syrup",
    result = "syrup",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("water_boiling_heat", 60, true)
    :component("maple_sap", 10)
    :quality("BOIL", 2, 1)
    :quality("STRAIN", 2, 1)
    :batch_discount(80, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "syrup_simple",
    result = "syrup_simple",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("water_boiling_heat", 5, true)
    :component("water", 1)
    :component("sugar", 42)
    :quality("BOIL", 2, 1)
    :batch_discount(80, 1)
    :result_charges(24)
)

-- https://www.thespruceeats.com/maple-leaves-521376 : 10u for a recipe that calls for 2 cups of maple syrup,
-- this recipe is 1/8 of that
content.add(content.Recipe {
    id = "maple_candy",
    result = "maple_candy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 1, true)
    :tool("thermometer", 1)
    :component("syrup", 4)
    :component("any_butter", 1, true)
    :quality("BOIL", 2, 1)
    :book("family_cookbook", 5)
    :book("sweets_book", 4)
    :proficiency("prof_food_prep")
    :batch_discount(80, 1)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "beet_syrup",
    result = "beet_syrup",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 60, true)
    :component("sugar_beet", 1)
    :component("water_clean", 4)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :quality("STRAIN", 2, 1)
    :batch_discount(80, 4)
    :result_charges(16)
)

-- 11u for flour, 1u for milk, 3u for egg, 1u for choc, presuming butter/syrup added after it's done.
content.add(content.Recipe {
    id = "choc_pancakes",
    result = "choc_pancakes",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 16, true)
    :component("flour_any", 10, true)
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :component("eggs_any_shape", 1, true)
    :component_any({
            { id = "syrup", count = 2 },
            { id = "syrup_corn", count = 2 }
        })
    :component("any_butter_or_oil", 1, true)
    :component("water_clean", 1)
    :component_any({
            { id = "candy2", count = 2 },
            { id = "chocolate", count = 3 },
            { id = "choc_drink", count = 4 }
        })
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(50, 4)
    :result_charges(8)
)

-- 1u for milk, 10u for flour, 3u for egg, 1u for choc.
content.add(content.Recipe {
    id = "choc_waffles",
    result = "choc_waffles",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 15, true)
    :tool("waffleiron", 1)
    :component("flour_any", 10, true)
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :component("eggs_any_shape", 1, true)
    :component_any({
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 2 },
            { id = "artificial_sweetener", count = 2 }
        })
    :component("any_butter_or_oil", 1, true)
    :component("water_clean", 1)
    :component_any({
            { id = "chocolate", count = 1 },
            { id = "choc_drink", count = 2 }
        })
    :proficiency("prof_food_prep")
    :batch_discount(20, 2)
    :result_charges(2)
)

-- just 1u for melting the chocolate onto the beans.
content.add(content.Recipe {
    id = "choco_coffee_beans",
    result = "choco_coffee_beans",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 1, true)
    :component("roasted_coffee_bean", 1)
    :component("chocolate", 1)
    :quality("COOK", 2, 1)
    :result_charges(5)
)

-- just 1u for melting the chocolate onto the pretzels.
content.add(content.Recipe {
    id = "chocpretzels",
    result = "chocpretzels",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 1, true)
    :component("pretzels", 2)
    :component("chocolate", 1)
    :quality("COOK", 2, 1)
    :batch_discount(80, 4)
    :result_charges(2)
)

-- just 1u for melting the caramel onto the apple.
content.add(content.Recipe {
    id = "caramel_apple",
    result = "caramel_apple",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 1, true)
    :component("sugar_fried", 2)
    :component("apple", 1)
    :quality("COOK", 2, 1)
    :result_charges(1)
)

-- 30 seconds in the microwave may actually be too much for the poor marshmallow
content.add(content.Recipe {
    id = "smores",
    result = "smores",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 1, true)
    :component("grahmcrackers", 1)
    :component("marshmallow", 1)
    :component("chocolate", 1)
    :quality("COOK", 1, 1)
    :book("sweets_book", 3)
)

-- about 90g meat total, which means 6u charge.
content.add(content.Recipe {
    id = "hotdogs_campfire",
    result = "hotdogs_campfire",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "hotdogs_frozen", count = 2 },
            { id = "homemade_hotdogs", count = 2 },
            { id = "bratwurst_sausage", count = 1 }
        })
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(2)
)

-- about 90g meat total, which means 6u charge.  the bread doesn't need heat.
content.add(content.Recipe {
    id = "hotdogs_cooked",
    result = "hotdogs_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "hotdogs_frozen", count = 2 },
            { id = "homemade_hotdogs", count = 2 },
            { id = "bratwurst_sausage", count = 1 }
        })
    :component("bread_sandwich", 2, true)
    :component_any({
            { id = "ketchup", count = 2 },
            { id = "barbecue_sauce", count = 2 },
            { id = "honey_mustard", count = 2 },
            { id = "mustard", count = 2 },
            { id = "horseradish", count = 2 },
            { id = "sauerkraut", count = 2 }
        })
    :component("water_clean", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "hotdogs_newyork",
    result = "hotdogs_newyork",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 5, true)
    :component("hotdogs_cooked", 1)
    :component_any({
            { id = "meat_fatty_cooked", count = 1 },
            { id = "meat_cooked", count = 1 },
            { id = "onion", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :book("cookbook", 1)
)

content.add(content.Recipe {
    id = "chilidogs",
    result = "chilidogs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "hotdogs_frozen", count = 2 },
            { id = "homemade_hotdogs", count = 2 },
            { id = "bratwurst_sausage", count = 2 }
        })
    :component("chili", 1)
    :component("bread_sandwich", 2, true)
    :component_any({
            { id = "mustard", count = 2 },
            { id = "horseradish", count = 1 },
            { id = "sauerkraut", count = 1 },
            { id = "onion", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "corndogs_cooked",
    result = "corndogs_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 10500,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 10, true)
    :component("corndogs_frozen", 1)
    :quality("COOK", 1, 1)
    :result_charges(1)
)

-- 80-100g of meat: 7u, 5u for the cornmeal and oil
content.add(content.Recipe {
    id = "corndogs_homemade",
    result = "corndogs_homemade",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 12, true)
    :component_any({
            { id = "hotdogs_frozen", count = 1 },
            { id = "homemade_hotdogs", count = 1 },
            { id = "hotdogs_cooked", count = 1 },
            { id = "bratwurst_sausage", count = 1 },
            { id = "sausage_wasteland", count = 1 }
        })
    :component("splinter", 1)
    :component("cornmeal", 1)
    :component_any({
            { id = "cooking_oil", count = 1 },
            { id = "edible_tallow", count = 2, requirement = true }
        })
    :quality("COOK", 1, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_frying")
    :batch_discount(80, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "toastem",
    result = "toastem",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("flour_any", 12, true)
    :component("eggs_bird", 1, true)
    :component("jam_fruit", 9)
    :component("cornmeal", 1)
    :component("any_frosting", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("baking_book", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_baking")
    :result_charges(6)
)

content.add(content.Recipe {
    id = "toasterpastry_without_toaster",
    result = "toasterpastry",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 15000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "toasterpastryfrozen", count = 1 },
            { id = "toastem", count = 1 },
            { id = "mre_chocolate_cake", count = 1 }
        })
    :result_charges(1)
)

content.add(content.Recipe {
    id = "toasterpastry_with_toaster",
    result = "toasterpastry",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("toaster", 5)
    :component_any({
            { id = "toasterpastryfrozen", count = 1 },
            { id = "toastem", count = 1 },
            { id = "mre_chocolate_cake", count = 1 }
        })
    :result_charges(1)
)

content.add(content.Recipe {
    id = "buttercream",
    result = "buttercream",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 39000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("milk_cream", 1)
    :component("any_butter", 16, true)
    :component("sugar_standard", 1, true)
    :quality("COOK", 1, 1)
    :result_charges(8)
)

-- https://www.simplyrecipes.com/recipes/caramel_sauce/ minimum heavy cream is 250ml so double recipe.
-- Minimum 28u to caramelize the sugar, plus 14 for the milkfat
content.add(content.Recipe {
    id = "sugar_fried",
    result = "sugar_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 21000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 42, true)
    :component("sugar", 84)
    :component("any_butter", 12, true)
    :component("milk_cream", 1)
    :component("salt", 1)
    :quality("COOK", 2, 1)
    :result_charges(13)
)

-- 25u for flour, 6u for eggs, 4u for milk
content.add(content.Recipe {
    id = "crepe",
    result = "crepe",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 35, true)
    :component("flour", 25)
    :component("eggs_any_shape", 2, true)
    :component("sugar_standard", 1, true)
    :component_any({
            { id = "milk_standard_raw", count = 2, requirement = true },
            { id = "lf_milk_standard", count = 2, requirement = true }
        })
    :quality("COOK", 2, 1)
    :batch_discount(25, 2)
    :result_charges(12)
)

-- 25u for flour, 6u for eggs, 4u for milk + water
content.add(content.Recipe {
    id = "crepe_plain",
    result = "crepe_plain",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 35, true)
    :component("flour_any", 25, true)
    :component("eggs_any_shape", 2, true)
    :component("water_clean", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
    :quality("COOK", 2, 1)
    :batch_discount(25, 2)
    :result_charges(12)
)
