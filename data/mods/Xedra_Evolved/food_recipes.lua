local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "alchemy_recipe_abyssal_coffee",
    result = "alchemy_recipe_abyssal_coffee",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_HARD", "SECRET" },
}
    :tool_charges("water_boiling_heat", 2, true)
    :component_any({
            { id = "coffee_raw", count = 1 },
            { id = "coffee_syrup", count = 1 }
        })
    :component("caffeine", 1)
    :component("lotus_blossom", 1)
    :component("wild_herbs", 3)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :requires_skill("deduction", 3)
    :book("alchemy_recipe_abyssal_coffee", 3)
    :batch_discount(80, 2)
)

content.add(content.Recipe {
    id = "butter_brownie",
    result = "butter",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("milk", 5)
    :quality("CHURN", 1, 1)
    :batch_discount(95, 2)
    :result_charges(99)
)

content.add(content.Recipe {
    id = "cheese_hard_brownie",
    result = "cheese_hard",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("milk", 2)
    :component("salt", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_cheesemaking_1")
    :proficiency("prof_cheesemaking_2")
    :batch_discount(50, 5)
    :result_charges(1)
)

content.replace(content.Recipe {
    id = "bread_flour",
    result = "bread_flour",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "BLIND_EASY", "SECRET" },
    name = content.text("brownie"),
}
    :tool("rock_quern", 1)
    :component("flour", 1)
    :component_any({
            { id = "wheat", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "acorns_cooked", count = 10 },
            { id = "oats", count = 4 },
            { id = "starch", count = 1 },
            { id = "dry_rice", count = 5 },
            { id = "dry_wild_rice", count = 5 },
            { id = "chestnut_roasted", count = 12 }
        })
    :batch_discount(83, 3)
    :result_charges(16)
)

content.add(content.Recipe {
    id = "cornmeal_brownie",
    result = "cornmeal",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component("dry_corn", 1)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "flour_brownie",
    result = "flour",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
    flags = { "SECRET" },
}
    :component_any({
            { id = "barley", count = 1 },
            { id = "starch", count = 1 },
            { id = "wheat", count = 1 },
            { id = "winter_wheat", count = 1 }
        })
    :result_charges(15)
)

-- 20u energy to cook a meat chunk per standard
content.add(content.Recipe {
    id = "fae_meat_cooked",
    result = "fae_meat_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("fae_meat", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 2u heat to cook 30g of flesh
content.add(content.Recipe {
    id = "fae_meat_scrap_cooked",
    result = "fae_meat_scrap_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 4500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("fae_meat_scrap", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)
