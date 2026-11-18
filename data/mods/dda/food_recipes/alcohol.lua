local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "irish_coffee",
    result = "irish_coffee",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 42000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "sugar", count = 6 },
            { id = "artificial_sweetener", count = 6 }
        })
    :component("whiskey_any", 1, true)
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
    :result_charges(1)
)

content.add(content.Recipe {
    id = "long_island",
    result = "long_island",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 42000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component("cola", 1)
    :component("vodka", 1)
    :component("gin", 1)
    :component("rum", 1)
    :component("tequila", 1)
    :component("triple_sec", 1)
)

content.add(content.Recipe {
    id = "drink_screwdriver",
    result = "drink_screwdriver",
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
            { id = "oj", count = 1 },
            { id = "oj_fresh", count = 1 },
            { id = "cranberry_juice", count = 1 }
        })
    :component("vodka", 1)
)

content.add(content.Recipe {
    id = "drink_wild_apple",
    result = "drink_wild_apple",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component("apple_cider", 1)
    :component("vodka", 1)
)

content.add(content.Recipe {
    id = "drink_rumcola",
    result = "drink_rumcola",
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
            { id = "rum", count = 1 },
            { id = "sake_filtered", count = 1 },
            { id = "whiskey_any", count = 1, requirement = true }
        })
    :component("cola", 1)
)

content.add(content.Recipe {
    id = "drink_grog",
    result = "drink_grog",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "rum", count = 1 },
            { id = "whiskey", count = 1 },
            { id = "brandy", count = 1 }
        })
    :component("water_clean", 1)
    :component("sugar", 3)
    :book("distilling_cookbook", 4)
    :result_charges(3)
)

-- alcohol is generally sterilizing but I removed the ability to make vodka with pond water
content.add(content.Recipe {
    id = "vodka_from_ethanol",
    result = "vodka",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("chem_ethanol", 125)
    :component("water_clean", 1)
    :result_charges(7)
)

content.add(content.Recipe {
    id = "mixed_alcohol_strong",
    result = "mixed_alcohol_strong",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_EASY" },
}
    :component("hard_liquor_unmixed", 1, true)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "mixed_alcohol_weak",
    result = "mixed_alcohol_weak",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_EASY" },
}
    :component("weak_liquor_unmixed", 1, true)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "drink_strawberry_surprise",
    result = "drink_strawberry_surprise",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 42000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("strawberries", 2)
    :component("vodka", 4)
    :quality("COOK", 2, 1)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "drink_boozeberry",
    result = "drink_boozeberry",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 42000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("blueberries", 2)
    :component("vodka", 4)
    :quality("COOK", 2, 1)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "drink_beeknees",
    result = "drink_beeknees",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 21000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component("gin", 1)
    :component("honey_bottled", 1)
    :component("lemonade", 1)
)

content.add(content.Recipe {
    id = "drink_wsour",
    result = "drink_wsour",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component("lemon", 1)
    :component_any({
            { id = "whiskey_any", count = 3, requirement = true },
            { id = "gin", count = 3 }
        })
    :component("sugar_standard_half", 1, true)
)

content.add(content.Recipe {
    id = "drink_martini",
    result = "drink_martini",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component_any({
            { id = "gin", count = 6 },
            { id = "tequila", count = 6 },
            { id = "vodka", count = 6 }
        })
    :component("wine_vermouth", 1)
    :batch_discount(50, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "drink_kalimotxo",
    result = "drink_kalimotxo",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "bum_wine", count = 2 },
            { id = "wine_cabernet", count = 2 },
            { id = "wine_chardonnay", count = 2 },
            { id = "wine_noir", count = 2 },
            { id = "wine_vermouth", count = 2 }
        })
    :component("cola", 1)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "drink_hobo",
    result = "drink_hobo",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 24000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component("sweet_juice", 1, true)
    :component("weak_liquor", 1, true)
    :component("hard_liquor_chem", 1, true)
    :result_charges(15)
)

content.add(content.Recipe {
    id = "honey_gold",
    result = "honey_gold",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("honey_ant", 1)
    :component_any({
            { id = "honeycomb", count = 1 },
            { id = "honey_glassed", count = 2 },
            { id = "honey_bottled", count = 6 }
        })
    :quality("BOIL", 1, 1)
    :requires_skill("survival", 4)
    :batch_discount(80, 4)
    :result_charges(2)
)

-- 3u for egg, 2u for milk, 1u for alcohol/sugar
content.add(content.Recipe {
    id = "eggnog_spiked",
    result = "eggnog_spiked",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
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
    :component("hard_liquor_chem", 1, true)
    :component("cinnamon", 2)
    :quality("COOK", 3, 1)
    :quality("BOIL", 2, 1)
    :book("family_cookbook", 2)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "drink_bloody_mary",
    result = "drink_bloody_mary",
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
    :component("vodka", 1)
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
    :result_charges(2)
)

content.add(content.Recipe {
    id = "drink_bloody_mary_blood",
    result = "drink_bloody_mary_blood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD" },
}
    :component("edible_blood", 1, true)
    :component("vodka", 1)
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
    :book("cookbook_bloodforgood", 2)
    :result_charges(2)
)
