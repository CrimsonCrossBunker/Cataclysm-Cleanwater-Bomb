local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

-- power use = 10 for flour, 1 for water, 1 for sugar, 1 for oil
content.add(content.Recipe {
    id = "donut_holes",
    result = "donut_holes",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 13, true)
    :tool_charges("frying_oil", 1, true)
    :component("flour_any", 10, true)
    :component("water_clean", 1)
    :component("salt", 1)
    :component("sugar_standard", 1, true)
    :component("fry_oil", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :book("cookbook_foodfashions", 5)
    :book("baking_book", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :proficiency("prof_baking", { skill_penalty = 0.1 })
    :batch_discount(50, 1)
    :result_charges(12)
)

content.add(content.Recipe {
    id = "soggy_hardtack",
    result = "soggy_hardtack",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("hardtack", 1)
    :component("water_clean", 2)
    :quality("COOK", 1, 1)
    :batch_discount(80, 4)
    :result_charges(2)
)

-- flour = 11u
content.add(content.Recipe {
    id = "flatbread",
    result = "flatbread",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 11, true)
    :component_any({
            { id = "flour", count = 11 },
            { id = "bread_flour", count = 11 }
        })
    :component("water_clean", 2)
    :quality("COOK", 2, 1)
    :book("cookbook_indian", 1)
    :book("cookbook", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_baking")
    :batch_discount(50, 4)
    :result_charges(2)
)

-- 11u for flour and 2u for oil
content.add(content.Recipe {
    id = "frybread",
    result = "frybread",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 13, true)
    :component_any({
            { id = "flour", count = 11 },
            { id = "bread_flour", count = 11 },
            { id = "flour_wheat_free", count = 11 }
        })
    :component("water_clean", 2)
    :component("any_butter_or_oil", 4, true)
    :component("salt", 1)
    :quality("COOK", 2, 1)
    :book("cookbook_native", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_frying")
    :batch_discount(50, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "tortilla_corn",
    result = "tortilla_corn",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 5, true)
    :component("cornmeal", 1)
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :book("cookbook_mexican", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_baking")
    :batch_discount(80, 3)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "tortilla_flour",
    result = "tortilla_flour",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 3, true)
    :component_any({
            { id = "flour", count = 1 },
            { id = "bread_flour", count = 1 }
        })
    :component("any_butter_or_oil", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 2, 1)
    :book("cookbook_mexican", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_baking")
    :batch_discount(80, 3)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "cornbread",
    result = "cornbread",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 108000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 20, true)
    :component("cornmeal", 4)
    :component("water_clean", 2)
    :quality("COOK", 2, 1)
    :quality("OVEN", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_baking")
    :batch_discount(50, 4)
    :result_charges(1)
)

-- Online recipe says prep time 5 min, cook time 1hr. Adjusted batch time to mimic that.
-- double usual price of flour to dehydrate it more than usual.
content.add(content.Recipe {
    id = "hardtack_cracker",
    result = "hardtack_cracker",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 450000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 12, true)
    :component("flour_any", 38, true)
    :component_any({
            { id = "salt", count = 6 },
            { id = "soysauce", count = 6 },
            { id = "seasoning_salt", count = 6 }
        })
    :component("water_clean", 2)
    :quality("COOK", 2, 1)
    :quality("OVEN", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_baking")
    :batch_discount(85, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "hardtack",
    result = "hardtack",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("hardtack_cracker", 1)
    :result_charges(6)
)

-- flour = 20u, milk = 2u, oil = 2u.
content.add(content.Recipe {
    id = "biscuit",
    result = "biscuit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 168000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 24, true)
    :component("flour_any", 20, true)
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "buttermilk", count = 1 }
        })
    :component("any_butter_or_oil", 4, true)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_baking")
    :batch_discount(50, 4)
    :result_charges(10)
)

-- cornmeal = 75u, oil = 1u.
content.add(content.Recipe {
    id = "johnnycake",
    result = "johnnycake",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 84000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 76, true)
    :component("cornmeal", 15)
    :component("water_clean", 1)
    :component("any_butter_or_oil", 1, true)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :batch_discount(50, 4)
    :result_charges(6)
)

-- 3u flour, 1u for milk, 4u for oil, 6u for eggs.  I thought the flour used was low, but I saw a recipe I
-- saw used 100g of flour for 5 eggs so this really is correct.
content.add(content.Recipe {
    id = "brioche",
    result = "brioche",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 14, true)
    :component("flour_any", 3, true)
    :component("yeast", 1)
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :component_any({
            { id = "powder_eggs", count = 2 },
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true }
        })
    :component_any({
            { id = "sugar", count = 2 },
            { id = "artificial_sweetener", count = 2 }
        })
    :component("any_butter_or_oil", 8, true)
    :component("water_clean", 1)
    :quality("COOK", 3, 1)
    :book("baking_book", 3)
    :book("cookbook_daintydishes", 5)
    :proficiency("prof_baking")
    :proficiency("prof_baking_desserts_1")
    :batch_discount(75, 4)
    :result_charges(6)
)

-- Toyed with this recipe because it used entirely too much bone meal per flour (4x more by weight).
-- Splinters represent sawdust.  Total weight is 260g of flour, 500g of water, 165g of inedible filler and up
-- to 100g of additives
-- 20u for the flour, 15u for the additives (sawdust isn't really 'cooked' but it steals some heat so that
-- contributes too)
content.add(content.Recipe {
    id = "wastebread",
    result = "wastebread",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 35, true)
    :component("flour_any", 20, true)
    :component_any({
            { id = "meal_bone", count = 15 },
            { id = "splinter", count = 11 }
        })
    :component_any({
            { id = "meal_chitin_piece", count = 8 },
            { id = "cornmeal", count = 4 },
            { id = "flour_wheat_free", count = 4 },
            { id = "oatmeal", count = 4 },
            { id = "powder_eggs", count = 4 },
            { id = "milk_powder", count = 4 },
            { id = "cheese_powder", count = 4 },
            { id = "protein_powder", count = 4 },
            { id = "dry_fruit", count = 4 },
            { id = "dry_veggy", count = 4 },
            { id = "wild_herbs", count = 20 },
            { id = "sugar", count = 20 },
            { id = "dogfood_dry", count = 1 },
            { id = "catfood_dry", count = 1 }
        })
    :component("water_clean", 2)
    :quality("COOK", 2, 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_baking")
    :proficiency("prof_scav_cooking")
    :batch_discount(50, 4)
    :result_charges(15)
)

-- Making the very first starter is a lot more finnicky than splitting it once it's mature.
content.add(content.Recipe {
    id = "sourdough_young_uncovered_active",
    result = "sourdough_young_uncovered_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component("water_clean", 1)
    :component("flour_any", 4, true)
    :quality("CONTAIN", 1, 1)
    :proficiency("prof_fermenting")
    :proficiency("prof_lactofermenting")
)

content.add(content.Recipe {
    id = "sourdough_split_uncovered_active",
    result = "sourdough_split_uncovered_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("water_clean", 1)
    :component("flour_any", 4, true)
    :component("sourdough_starter_uncovered", 1)
    :quality("CONTAIN", 1, 1)
    :proficiency("prof_fermenting")
    :proficiency("prof_lactofermenting")
    :result_charges(2)
)

-- 2u of water for baking the bread (not allowing dirty water here since it may not fully boil) + 1u for the
-- new starter.
-- This is 14u of flour in total + anything else that may be needed.
content.add(content.Recipe {
    id = "sourdough_bread",
    result = "sourdough_bread",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 15, true)
    :component("flour_any", 10, true)
    :component("sourdough_starter_uncovered", 1)
    :component("water_clean", 3)
    :quality("OVEN", 2, 1)
    :proficiency("prof_baking")
    :proficiency("prof_baking_bread")
    :proficiency("prof_fermenting")
    :proficiency("prof_lactofermenting")
    :batch_discount(50, 4)
    :result_charges(10)
    :byproduct("sourdough_split_uncovered_active", 1)
)

-- Flour: 40u, milk: 2u, pumpkin: 4u, eggs: 6u, oil: 1u, other: 1u.
content.add(content.Recipe {
    id = "pumpkin_yeast_bread",
    result = "pumpkin_yeast_bread",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 54, true)
    :component("flour_any", 40, true)
    :component("yeast", 2)
    :component_any({
            { id = "milk_standard_raw", count = 2, requirement = true },
            { id = "lf_milk_standard", count = 2, requirement = true }
        })
    :component("pumpkin_cut", 2)
    :component_any({
            { id = "sugar", count = 4 },
            { id = "artificial_sweetener", count = 4 }
        })
    :component("eggs_any_shape", 2, true)
    :component("any_butter_or_oil", 2, true)
    :component("salt", 2)
    :quality("OVEN", 1, 1)
    :book("family_cookbook", 1)
    :book("baking_book", 1)
    :book("cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_baking")
    :proficiency("prof_baking_bread")
    :batch_discount(50, 4)
    :result_charges(24)
)

-- bread flour: 5u, flour: 5u, cornmeal: 25u, molasses: 2u
-- Later: this needs baking soda. Also possibility of rewrite to use portions of components' charges.
content.add(content.Recipe {
    id = "brown_bread",
    result = "brown_bread",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 37, true)
    :component("bread_flour", 1)
    :component("flour", 5)
    :component("cornmeal", 5)
    :component("molasses", 2)
    :component("sugar", 1)
    :component_any({
            { id = "molasses", count = 1 },
            { id = "sugar", count = 13 }
        })
    :component("water_clean", 1)
    :component("salt", 1)
    :quality("OVEN", 1, 1)
    :book("family_cookbook", 1)
    :book("baking_book", 2)
    :book("cookbook", 2)
    :book("cookbook_daintydishes", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_baking")
    :proficiency("prof_baking_bread")
    :batch_discount(50, 5)
    :result_charges(10)
)

-- flour: 6u, oil: 2u, sugar: 1u
-- I'm not sure whether this should also be rewritten to use a portion of charges, or scaled up so that the
-- smallest component in the recipe becomes a single charge.
-- Since milk is only used sparingly in the creation of hallula, to give it a glazed appearance, Cataclysm
-- practicality suggests omitting it.
content.add(content.Recipe {
    id = "hallula",
    result = "hallula",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 9, true)
    :component("flour_any", 6, true)
    :component("yeast", 3)
    :component("sugar", 2)
    :component("salt", 2)
    :component("water_clean", 2)
    :component_any({
            { id = "any_butter_or_oil", count = 4, requirement = true },
            { id = "edible_tallow", count = 2, requirement = true }
        })
    :quality("OVEN", 2, 1)
    :book("family_cookbook", 1)
    :book("baking_book", 2)
    :book("cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_baking")
    :proficiency("prof_baking_bread")
    :batch_discount(50, 5)
    :result_charges(16)
)

-- flour: 30u, oil: 4u, sugar: 1u
content.add(content.Recipe {
    id = "crackers",
    result = "crackers",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 35, true)
    :component("flour_any", 30, true)
    :component("sugar", 4)
    :component("salt", 5)
    :component("water_clean", 1)
    :component("any_butter_or_oil", 8, true)
    :quality("OVEN", 2, 1)
    :book("baking_book", 2)
    :book("cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_baking")
    :batch_discount(50, 5)
    :result_charges(8)
)

-- bread already baked, so 1u + 1u for garlic + 1u for oil
content.add(content.Recipe {
    id = "bread_garlic",
    result = "bread_garlic",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 3, true)
    :component_any({
            { id = "flatbread", count = 1 },
            { id = "bread", count = 1 },
            { id = "cornbread", count = 1 },
            { id = "wastebread", count = 1 }
        })
    :component_any({
            { id = "garlic_clove", count = 3 },
            { id = "rehydrated_garlic", count = 3 },
            { id = "garlic_powder", count = 10 }
        })
    :component("any_butter_or_oil", 1, true)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "pepper", count = 1 },
            { id = "chilly-p", count = 1 },
            { id = "curry_powder", count = 1 },
            { id = "seasoning_italian", count = 1 },
            { id = "wild_herbs", count = 1 },
            { id = "hot_sauce", count = 1 },
            { id = "soysauce", count = 1 }
        })
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_italian", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "toast_without_toaster",
    result = "toast",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 1, true)
    :component("bread_toastable", 1, true)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(50, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "toast_with_toaster",
    result = "toast",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("toaster", 5)
    :component("bread_toastable", 1, true)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "buttered_toast",
    result = "buttered_toast",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("toast", 1)
    :component_any({
            { id = "butter", count = 1 },
            { id = "raw_butter", count = 1 }
        })
    :batch_discount(20, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "jam_toast",
    result = "jam_toast",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("toast", 1)
    :component("jam_fruit", 1)
    :batch_discount(20, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "peanut_butter_toast",
    result = "peanut_butter_toast",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("any_peanutbutter", 1, true)
    :component("toast", 1)
    :batch_discount(20, 2)
    :result_charges(1)
)

-- bread: 1u, oil: 1u, egg: 3u
content.add(content.Recipe {
    id = "toad_in_a_hole",
    result = "toad_in_a_hole",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "eggs_bird", count = 1, requirement = true },
            { id = "eggs_reptile", count = 1, requirement = true }
        })
    :component_any({
            { id = "bread_sandwich", count = 1, requirement = true },
            { id = "toast", count = 1 },
            { id = "buttered_toast", count = 1 }
        })
    :component("any_butter_or_oil", 1, true)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_frying")
    :batch_discount(80, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "PBJ_Toast",
    result = "PBJ_Toast",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("jam_fruit", 1)
    :component_any({
            { id = "butter", count = 1 },
            { id = "raw_butter", count = 1 }
        })
    :component("any_peanutbutter", 1, true)
    :component("toast", 1)
    :batch_discount(20, 2)
    :result_charges(1)
)
