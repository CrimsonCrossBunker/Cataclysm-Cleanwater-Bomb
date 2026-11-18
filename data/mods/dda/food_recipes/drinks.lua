local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

-- https://www.netsolwater.com/how-much-energy-does-an-ro-system-use.php?blog=484
-- Unclear if this is a RO filter but basing it off that.  0.03 KwH per 2 liters in a RO filter = 14kJ for 1u
-- of water
-- https://blackblum.com/pages/charcoal-water-filter
-- 50g of charcoal for 1 liter of water = 12.5g of charcoal per u of water.  1u charcoal weighs 1.04g, so
-- making it 12:1
content.add(content.Recipe {
    id = "water_clean_using_water_purifier",
    result = "water_clean",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 900,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :tool_any({
            { id = "water_purifier", charges = 14 },
            { id = "char_purifier", charges = 12 },
            { id = "char_purifier_clay", charges = 12 }
        })
    :component("water", 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "water_using_water_filter_sand",
    result = "water",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :tool("water_filter_sand", 1)
    :component("water_murky", 10)
    :result_charges(10)
)

-- 2 minutes to boil per 250ml, then simultaneous steeping time of 4 minutes.
content.add(content.Recipe {
    id = "tea",
    result = "tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component_any({
            { id = "tea_raw", count = 1 },
            { id = "tea_bag", count = 1 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(65, 1)
)

-- 2 minutes to (near-)boil per 250ml, then simultaneous steeping time of 2 minutes.
content.add(content.Recipe {
    id = "tea_green",
    result = "tea_green",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 24000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component_any({
            { id = "tea_green_raw", count = 1 },
            { id = "tea_green_bag", count = 1 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(50, 1)
)

content.add(content.Recipe {
    id = "chicory_coffee",
    result = "chicory_coffee",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("chicory_raw", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :quality("CUT", 2, 1)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :book("mag_survival", 1)
    :book("family_cookbook", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "kompot",
    result = "kompot",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component("sweet_fruit_like", 1, true)
    :component("sugar_powdered", 5, true)
    :component("water_clean", 2)
    :quality("COOK", 3, 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "coffee",
    result = "coffee",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component_any({
            { id = "coffee_raw", count = 1 },
            { id = "coffee_syrup", count = 1 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "coffee_using_instant_coffee",
    result = "coffee",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("instant_coffee", 1)
    :component("water_clean", 1)
    :batch_discount(80, 2)
)

-- now that it's just very strong coffee it doesn't need to be atomic-exclusive anymore
content.add(content.Recipe {
    id = "atomic_coffee",
    result = "atomic_coffee",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 4, true)
    :component_any({
            { id = "coffee_raw", count = 2 },
            { id = "coffee_syrup", count = 2 }
        })
    :component("caffeine", 2)
    :component("sugar_standard", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "coffee_substitute",
    result = "coffee_substitute",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("coffee_raw_kentucky", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "almond_milk_mortar",
    result = "almond_milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("almond_shelled", 2)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :quality("STRAIN", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(30, 1)
    :result_charges(1)
    :byproduct("almond_pulp", 1)
)

content.add(content.Recipe {
    id = "almond_milk",
    result = "almond_milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("food_processor", 20)
    :component("almond_shelled", 2)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 1)
    :result_charges(1)
    :byproduct("almond_pulp", 1)
)

content.add(content.Recipe {
    id = "hazelnut_milk_mortar",
    result = "hazelnut_milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("hazelnut_shelled", 2)
    :component("water_clean", 3)
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :quality("STRAIN", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(30, 1)
    :result_charges(3)
    :byproduct("hazelnut_pulp", 1)
)

content.add(content.Recipe {
    id = "hazelnut_milk",
    result = "hazelnut_milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("food_processor", 20)
    :component("hazelnut_shelled", 2)
    :component("water_clean", 3)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 1)
    :result_charges(3)
    :byproduct("hazelnut_pulp", 1)
)

content.add(content.Recipe {
    id = "walnut_milk_mortar",
    result = "walnut_milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("walnut_shelled", 2)
    :component("water_clean", 3)
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :quality("STRAIN", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(30, 1)
    :result_charges(3)
    :byproduct("walnut_pulp", 1)
)

content.add(content.Recipe {
    id = "walnut_milk",
    result = "walnut_milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("food_processor", 20)
    :component("walnut_shelled", 2)
    :component("water_clean", 3)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 1)
    :result_charges(3)
    :byproduct("walnut_pulp", 1)
)

content.add(content.Recipe {
    id = "soy_milk_mortar",
    result = "soy_milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 168000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :component("soybean", 2)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :quality("STRAIN", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(25, 2)
)

content.add(content.Recipe {
    id = "soy_milk",
    result = "soy_milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 78000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("food_processor", 20)
    :tool_charges("surface_heat", 10, true)
    :component("soybean", 2)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(25, 2)
)

content.add(content.Recipe {
    id = "oat_milk",
    result = "oat_milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 42000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("food_processor", 20)
    :component("oats", 1)
    :component("water_clean", 3)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(25, 2)
    :result_charges(3)
    :byproduct("oat_pulp", 1)
)

content.add(content.Recipe {
    id = "hot_chocolate_from_cocoa_powder",
    result = "hot_chocolate",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :tool_charges("water_boiling_heat", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("cocoa_powder", 2)
    :quality("BOIL", 1, 1)
)

content.add(content.Recipe {
    id = "can_coconut",
    result = "can_coconut",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :component("coconut_flesh", 2)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :quality("CUT", 2, 1)
    :quality("STRAIN", 2, 1)
    :book("manual_sealing", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(75, 2)
    :result_charges(2)
    :byproduct("juice_pulp", 2)
)

content.add(content.Recipe {
    id = "oj_fresh",
    result = "oj_fresh",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("orange", 4)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :byproduct("juice_pulp", 16)
)

content.add(content.Recipe {
    id = "cranberry_juice",
    result = "cranberry_juice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("cranberries", 3)
    :component("water_clean", 1)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :result_charges(1)
    :byproduct("juice_pulp", 2)
)

content.add(content.Recipe {
    id = "apple_cider",
    result = "apple_cider",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 42000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component_any({
            { id = "apple", count = 2 },
            { id = "crabapple", count = 10 }
        })
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :result_charges(1)
    :byproduct("juice_pulp", 2)
)

content.add(content.Recipe {
    id = "lemonade",
    result = "lemonade",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("lemon", 1)
    :component("sugar_powdered", 10, true)
    :component("water_clean", 1)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "lemonade_from_mix",
    result = "lemonade",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("lemonade_powder", 1)
    :component("water_clean", 1)
)

content.add(content.Recipe {
    id = "orangeade_from_mix",
    result = "orangeade",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("orangeade_powder", 1)
    :component("water_clean", 1)
)

content.add(content.Recipe {
    id = "grapeade_from_mix",
    result = "grapeade",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("grapeade_powder", 1)
    :component("water_clean", 1)
)

content.add(content.Recipe {
    id = "spezi",
    result = "spezi",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component("orangesoda", 1)
    :component("cola", 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "crispycran",
    result = "crispycran",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component("lemonlime", 1)
    :component("cranberry_juice", 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "V8",
    result = "V8",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component("water_clean", 2)
    :component("any_tomato", 1, true)
    :component("broccoli", 1)
    :component("any_zucchini", 1, true)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "juice",
    result = "juice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("sweet_fruit", 1, true)
    :component("water_clean", 1)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :result_charges(1)
    :byproduct("juice_pulp", 1)
)

content.add(content.Recipe {
    id = "juice_fresh",
    result = "juice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("sweet_fruit", 2, true)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :result_charges(1)
    :byproduct("juice_pulp", 2)
)

content.add(content.Recipe {
    id = "sweet_water",
    result = "sweet_water",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("water_clean", 1)
    :component_any({
            { id = "sugar", count = 10 },
            { id = "syrup", count = 4 },
            { id = "syrup_corn", count = 3 },
            { id = "syrup_simple", count = 5 },
            { id = "beet_syrup", count = 5 },
            { id = "molasses", count = 1 },
            { id = "honey_bottled", count = 3 },
            { id = "honey_glassed", count = 1 },
            { id = "honeydew", count = 3 },
            { id = "artificial_sweetener", count = 10 }
        })
    :result_charges(1)
)

content.add(content.Recipe {
    id = "milk_tea",
    result = "milk_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("tea", 1)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :batch_discount(80, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "milk_coffee",
    result = "milk_coffee",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "coffee_syrup", count = 1 },
            { id = "coffee", count = 1 }
        })
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :result_charges(2)
)

content.add(content.Recipe {
    id = "chai_tea",
    result = "chai_tea",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("tea_raw", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :component("sugar_standard", 2, true)
    :component("pepper", 10)
    :component("cinnamon", 10)
    :quality("BOIL", 1, 1)
    :batch_discount(65, 1)
    :result_charges(2)
)

-- 3u for egg, 2u for milk
content.add(content.Recipe {
    id = "eggnog",
    result = "eggnog",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "eggs_bird", count = 1, requirement = true },
            { id = "eggs_reptile", count = 1, requirement = true },
            { id = "powder_eggs", count = 1 }
        })
    :component_any({
            { id = "milk_standard_raw", count = 2, requirement = true },
            { id = "lf_milk_standard", count = 2, requirement = true },
            { id = "con_milk", count = 2 }
        })
    :component_any({
            { id = "sugar", count = 4 },
            { id = "artificial_sweetener", count = 4 }
        })
    :component("cinnamon", 2)
    :quality("COOK", 3, 1)
    :quality("BOIL", 2, 1)
    :book("family_cookbook", 2)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "hot_chocolate",
    result = "hot_chocolate",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "chocolate", count = 1 },
            { id = "cocoa_powder", count = 2 }
        })
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "con_milk", count = 1 },
            { id = "milk_powder", count = 1 }
        })
    :component("water_clean", 1)
    :component_any({
            { id = "sugar", count = 5 },
            { id = "artificial_sweetener", count = 5 }
        })
    :quality("COOK", 3, 1)
    :batch_discount(20, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "mex_chocolate",
    result = "mex_chocolate",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 8, true)
    :component_any({
            { id = "chocolate", count = 2 },
            { id = "cocoa_powder", count = 3 }
        })
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "con_milk", count = 1 },
            { id = "milk_powder", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 5 },
            { id = "artificial_sweetener", count = 5 }
        })
    :component("chilly-p", 1)
    :component("cinnamon", 1)
    :component_any({
            { id = "water", count = 7 },
            { id = "water_clean", count = 7 }
        })
    :quality("COOK", 3, 1)
    :book("family_cookbook", 2)
    :book("cookbook_mexican", 1)
    :batch_discount(20, 1)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "rehydration_drink",
    result = "rehydration_drink",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
}
    :component("sugar", 10)
    :component("salt", 1)
    :component("water_clean", 8)
    :component("chem_baking_soda", 2)
    :quality("CONTAIN", 1, 1)
    :book("textbook_firstaid", 1)
    :book("manual_survival", 1)
    :book("manual_first_aid", 1)
    :result_charges(8)
)

content.add(content.Recipe {
    id = "coffee_sweetened",
    result = "coffee_sweetened",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component_any({
            { id = "coffee_raw", count = 1 },
            { id = "coffee_syrup", count = 1 },
            { id = "instant_coffee", count = 1 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("sugar_standard_half", 1, true)
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "coffee_substitute_sweetened",
    result = "coffee_substitute_sweetened",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("coffee_raw_kentucky", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("sugar_standard_half", 1, true)
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "milk_coffee_sweetened",
    result = "milk_coffee_sweetened",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "coffee_syrup", count = 1 },
            { id = "coffee", count = 1 }
        })
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :component("sugar_standard_half", 1, true)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "tea_sweetened",
    result = "tea_sweetened",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("tea_raw", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("sugar_standard_half", 1, true)
    :quality("BOIL", 1, 1)
    :batch_discount(65, 1)
)

content.add(content.Recipe {
    id = "mycus_juice",
    result = "mycus_juice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("mycus_fruit", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
)

content.add(content.Recipe {
    id = "milk_tea_sweetened",
    result = "milk_tea_sweetened",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("tea", 1)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :component("sugar_standard_half", 1, true)
    :batch_discount(80, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "tomato_juice",
    result = "tomato_juice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_any({
            { id = "water_boiling_heat", charges = 2, requirement = true },
            { id = "food_processor", charges = 20 }
        })
    :component_any({
            { id = "tomato", count = 10 },
            { id = "tomato_cut", count = 10 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 1 },
            { id = "artificial_sweetener", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "tea_willowbark",
    result = "tea_willowbark",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 72000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 8, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("willowbark", 1)
    :quality("BOIL", 1, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 4)
    :book("atomic_survival", 4)
    :book("survival_book", 3)
    :book("textbook_botany", 4)
    :book("textbook_chemistry", 4)
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "pineapple_juice",
    result = "pineapple_juice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("pineapple_chunks", 1)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :result_charges(1)
    :byproduct("juice_pulp", 1)
)

content.add(content.Recipe {
    id = "grenadine_syrup",
    result = "grenadine_syrup",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 3, true)
    :component("pomegranate", 1)
    :component("sugar", 10)
    :quality("HAMMER", 1, 1)
    :quality("BOIL", 2, 1)
    :quality("STRAIN", 2, 1)
    :batch_discount(50, 4)
    :result_charges(5)
    :byproduct("juice_pulp", 1)
)

content.add(content.Recipe {
    id = "drink_pinitacolada",
    result = "drink_pinitacolada",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
    flags = { "BLIND_HARD" },
}
    :component("pineapple_juice", 4)
    :component("can_coconut", 1)
    :batch_discount(50, 4)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "drink_shirleytemple",
    result = "drink_shirleytemple",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "lemonlime", count = 1 },
            { id = "lemonade", count = 1 },
            { id = "oj", count = 1 },
            { id = "oj_fresh", count = 1 }
        })
    :component("grenadine_syrup", 1)
    :batch_discount(50, 4)
)

content.add(content.Recipe {
    id = "drink_royrogers",
    result = "drink_royrogers",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("cola", 1)
    :component("grenadine_syrup", 1)
    :batch_discount(50, 4)
)

content.add(content.Recipe {
    id = "drink_virgin_mary",
    result = "drink_virgin_mary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "tomato_juice", count = 1 },
            { id = "V8", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :component_any({
            { id = "pepper", count = 1 },
            { id = "curry_powder", count = 1 },
            { id = "chilly-p", count = 1 },
            { id = "hot_sauce", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "lemon", count = 1 }
        })
)

content.add(content.Recipe {
    id = "milk_coffee_substitute",
    result = "milk_coffee_substitute",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("coffee_substitute", 1)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :result_charges(2)
)

content.add(content.Recipe {
    id = "milk_coffee_substitute_sweetened",
    result = "milk_coffee_substitute_sweetened",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("coffee_substitute", 1)
    :component("sugar_standard_half", 1, true)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :result_charges(2)
)

content.add(content.Recipe {
    id = "sweet_milk",
    result = "sweet_milk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("sugar_standard_half", 1, true)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
)

content.add(content.Recipe {
    id = "sweet_milk_fortified",
    result = "sweet_milk_fortified",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("protein_powder", 1)
    :component("sugar_standard_half", 1, true)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
)

content.add(content.Recipe {
    id = "milk_choc_using_cocoa_powder",
    result = "milk_choc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
    :component("cocoa_powder", 1)
)

-- You're just dissolving the milk cocoa powder into the water. That takes some time because cocoa powder has
-- some fat. Therefore, you need to mix well
content.add(content.Recipe {
    id = "milk_choc_from_milk_cococa_powder",
    result = "milk_choc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("cocoa_powder_milk", 1)
    :component("water_clean", 1)
)

content.add(content.Recipe {
    id = "drink_queenmary",
    result = "drink_queenmary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "beer", count = 1 },
            { id = "hb_beer", count = 1 }
        })
    :component("grenadine_syrup", 1)
    :batch_discount(50, 4)
)

content.add(content.Recipe {
    id = "drink_karsk",
    result = "drink_karsk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "coffee", count = 1 },
            { id = "coffee_sweetened", count = 1 }
        })
    :component_any({
            { id = "moonshine", count = 1 },
            { id = "vodka", count = 1 }
        })
    :batch_discount(50, 4)
)

content.add(content.Recipe {
    id = "drink_gunfire",
    result = "drink_gunfire",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("tea", 1)
    :component("rum", 1)
    :batch_discount(50, 4)
)

content.add(content.Recipe {
    id = "drink_gintonic",
    result = "drink_gintonic",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "gin", count = 1 },
            { id = "vodka", count = 1 }
        })
    :component("tonic_water", 1)
    :batch_discount(50, 4)
)

content.add(content.Recipe {
    id = "drink_pinacolada",
    result = "drink_pinacolada",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
    flags = { "BLIND_HARD" },
}
    :component("pineapple_juice", 4)
    :component("can_coconut", 1)
    :component_any({
            { id = "rum", count = 3 },
            { id = "vodka", count = 3 },
            { id = "tequila", count = 3 },
            { id = "whiskey_any", count = 3, requirement = true }
        })
    :batch_discount(50, 4)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "drink_tequilasunrise",
    result = "drink_tequilasunrise",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "tequila", count = 1 },
            { id = "rum", count = 1 },
            { id = "vodka", count = 1 }
        })
    :component_any({
            { id = "oj", count = 1 },
            { id = "oj_fresh", count = 1 },
            { id = "pineapple_juice", count = 2 }
        })
    :component("grenadine_syrup", 1)
    :batch_discount(50, 4)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "tea_wild_sarsaparilla",
    result = "tea_wild_sarsaparilla",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 72000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("water_boiling_heat", 8, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("wild_sarsaparilla_root", 1)
    :quality("BOIL", 1, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 3)
    :batch_discount(80, 4)
)

-- Compressed the timescale for flavor infusion to keep things easy and avoid intermediate crafting items.
content.add(content.Recipe {
    id = "horchata",
    result = "horchata",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("food_processor", 20)
    :component("rice_cooked", 1)
    :component("sugar_standard", 1, true)
    :component("cinnamon", 1)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 1, 1)
    :requires_skill("cooking", 2)
    :book("cookbook_mexican", 3)
    :batch_discount(75, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "brew_kvass",
    result = "brew_kvass",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component_any({
            { id = "bread", count = 8 },
            { id = "toast", count = 8 }
        })
    :component("water", 8)
    :component("sugar_standard", 1, true)
    :component("sweet_fruit_like", 1, true)
    :component("yeast", 1)
    :quality("CUT", 1, 1)
    :quality("CONTAIN", 1, 1)
    :learn_automatically("survival", 2)
    :learn_automatically("fabrication", 3)
    :batch_discount(75, 2)
    :result_charges(16)
)
