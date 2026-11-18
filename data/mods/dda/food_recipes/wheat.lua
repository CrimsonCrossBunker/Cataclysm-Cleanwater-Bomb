local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "oatmeal",
    result = "oatmeal",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 3, true)
    :tool("rock_quern", 1)
    :component("oats", 1)
    :batch_discount(83, 3)
    :result_charges(4)
)

-- about 1-2 min in the microwave feels right
content.add(content.Recipe {
    id = "oatmeal_cooked",
    result = "oatmeal_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 3, true)
    :component("oatmeal", 1)
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
)

-- little bit more energy due to the extra stuff
content.add(content.Recipe {
    id = "oatmeal_deluxe",
    result = "oatmeal_deluxe",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 4, true)
    :component("oatmeal", 1)
    :component_any({
            { id = "sugar_standard_half", count = 1, requirement = true },
            { id = "cinnamon", count = 6 },
            { id = "coffee_syrup", count = 1 },
            { id = "con_milk", count = 1 },
            { id = "jam_fruit", count = 1 },
            { id = "strawberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "cherries", count = 1 },
            { id = "plums", count = 1 },
            { id = "grapes", count = 1 },
            { id = "cranberries", count = 1 },
            { id = "wintergreen_berry", count = 4 },
            { id = "m_stellatum_berries", count = 4 },
            { id = "raspberries", count = 1 },
            { id = "blackberries", count = 1 },
            { id = "pomegranate", count = 1 },
            { id = "dry_fruit", count = 1 },
            { id = "juice_pulp", count = 2 }
        })
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "grits",
    result = "grits",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 8, true)
    :component("cornmeal", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 3, 1)
)

content.add(content.Recipe {
    id = "cheese_grits",
    result = "cheese_grits",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 8, true)
    :component("cornmeal", 1)
    :component("cheese_standard", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 3, 1)
)

-- oatmeal: 18, rice: 16, so take avg = 17u, sugar = 2u, fruit/candy = 1u
content.add(content.Recipe {
    id = "granola",
    result = "granola",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "oatmeal", count = 6 },
            { id = "dry_rice", count = 4 },
            { id = "dry_wild_rice", count = 4 }
        })
    :component_any({
            { id = "honeycomb", count = 1 },
            { id = "con_milk", count = 1 },
            { id = "honey_bottled", count = 1 },
            { id = "honey_glassed", count = 1 },
            { id = "sugar", count = 10 },
            { id = "artificial_sweetener", count = 10 },
            { id = "syrup", count = 3 },
            { id = "syrup_corn", count = 3 },
            { id = "beet_syrup", count = 3 }
        })
    :component_any({
            { id = "sweet_fruit_like", count = 1, requirement = true },
            { id = "jam_fruit", count = 1 },
            { id = "chocolate", count = 1 },
            { id = "candy", count = 1 },
            { id = "candy2", count = 1 },
            { id = "choco_coffee_beans", count = 2 }
        })
    :proficiency("prof_food_prep")
    :batch_discount(75, 2)
    :result_charges(6)
)

-- 11u for flour, 1u for milk, 3u for egg, presuming butter/syrup added after it's done.
content.add(content.Recipe {
    id = "pancakes",
    result = "pancakes",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 15, true)
    :component("flour_any", 10, true)
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 },
            { id = "cottage_cheese", count = 1 }
        })
    :component("eggs_any_shape", 1, true)
    :component_any({
            { id = "syrup", count = 2 },
            { id = "syrup_corn", count = 2 }
        })
    :component("any_butter_or_oil", 1, true)
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(50, 4)
    :result_charges(8)
)

-- 11u for flour, 1u for milk, 3u for egg, 2u for fruit, presuming butter/syrup added after it's done.
content.add(content.Recipe {
    id = "fruit_pancakes",
    result = "fruit_pancakes",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 17, true)
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
    :component("any_butter_or_oil", 1, true)
    :component("water_clean", 1)
    :component_any({
            { id = "sweet_fruit_like", count = 2, requirement = true },
            { id = "jam_fruit", count = 2 }
        })
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(50, 4)
    :result_charges(8)
)

-- 11u for flour, 1u for milk, 3u for egg, 30u for blood.
content.add(content.Recipe {
    id = "blood_pancakes",
    result = "blood_pancakes",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 42, true)
    :component("flour", 10)
    :component("edible_blood", 2, true)
    :component_any({
            { id = "sugar", count = 1 },
            { id = "artificial_sweetener", count = 1 }
        })
    :component("any_butter_or_oil", 1, true)
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :book("cookbook_bloodforgood", 2)
    :proficiency("prof_food_prep")
    :batch_discount(50, 4)
    :result_charges(6)
)

-- 1u for milk, 3u for egg, 2u for the bread (already cooked).
content.add(content.Recipe {
    id = "frenchtoast",
    result = "frenchtoast",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
    :component("eggs_any_shape", 1, true)
    :component("cinnamon", 2)
    :component("bread_sandwich", 2, true)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(50, 2)
    :result_charges(3)
)

-- 1u for milk, 10u for flour, 3u for egg.
content.add(content.Recipe {
    id = "waffles",
    result = "waffles",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 14, true)
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
    :proficiency("prof_food_prep")
    :batch_discount(20, 2)
    :result_charges(2)
)

-- 1u for milk, 10u for flour, 3u for egg, 2u for fruit.
content.add(content.Recipe {
    id = "fruit_waffles",
    result = "fruit_waffles",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 16, true)
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
            { id = "sweet_fruit_like", count = 2, requirement = true },
            { id = "jam_fruit", count = 2 }
        })
    :proficiency("prof_food_prep")
    :batch_discount(20, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "cloutie_dumpling",
    result = "cloutie_dumpling",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "oatmeal", count = 1 },
            { id = "flour_any", count = 5, requirement = true },
            { id = "buckwheat", count = 1 }
        })
    :component("dry_fruit", 1)
    :component("edible_tallow", 5, true)
    :component("sugar_standard", 1, true)
    :quality("BOIL", 1, 1)
    :quality("COOK", 3, 1)
    :book("family_cookbook", 6)
    :book("scots_cookbook", 2)
    :batch_discount(50, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "oatmeal_with_food_processor",
    result = "oatmeal",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 67500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("food_processor", 10)
    :component("oats", 1)
    :batch_discount(83, 3)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "oatmeal_mortar",
    result = "oatmeal",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 405000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 3, true)
    :component("oats", 1)
    :quality("FINE_GRIND", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(83, 3)
    :result_charges(1)
)
