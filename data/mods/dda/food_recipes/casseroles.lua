local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- 33u for corn (1680g), 2u for oil, 6u for cheese, 3u for the peppers/onion/garlic
content.add(content.Recipe {
    id = "hot_corn_casserole",
    result = "hot_corn_casserole",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 44, true)
    :tool("casserole", 1)
    :component("veggy_any_corn_uncooked", 8, true)
    :component_any({
            { id = "salt", count = 7 },
            { id = "seasoning_salt", count = 7 },
            { id = "soysauce", count = 4 }
        })
    :component_any({
            { id = "seasoning_italian", count = 7 },
            { id = "wild_herbs", count = 7 },
            { id = "pepper", count = 7 },
            { id = "cinnamon", count = 7 },
            { id = "mustard_powder", count = 7 }
        })
    :component("any_butter_or_oil", 4, true)
    :component("any_bell_pepper", 1, true)
    :component("onion", 1)
    :component_any({
            { id = "cheese", count = 6 },
            { id = "can_cheese", count = 6 },
            { id = "cheese_hard", count = 6 }
        })
    :component_any({
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 }
        })
    :component_any({
            { id = "chilly-p", count = 7 },
            { id = "curry_powder", count = 7 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("mag_cooking", 1)
    :batch_discount(50, 2)
    :result_charges(8)
)

content.add(content.Recipe {
    id = "cheesy_spinach_casserole",
    result = "cheesy_spinach_casserole",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :tool("casserole", 1)
    :component("spinach", 30)
    :component_any({
            { id = "salt", count = 7 },
            { id = "seasoning_salt", count = 7 },
            { id = "soysauce", count = 4 }
        })
    :component_any({
            { id = "seasoning_italian", count = 7 },
            { id = "wild_herbs", count = 7 },
            { id = "pepper", count = 7 },
            { id = "cinnamon", count = 7 },
            { id = "curry_powder", count = 7 },
            { id = "mustard_powder", count = 7 }
        })
    :component("any_butter_or_oil", 4, true)
    :component("onion", 1)
    :component("cheese_standard", 6, true)
    :component_any({
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("mag_cooking", 1)
    :batch_discount(50, 2)
    :result_charges(8)
)

-- 20u for the fish (300g), 9u for the pasta (120g), 8u for the beans/corn, 4u for the broth, 2u for the
-- carrot, 4u for the milk, 1u for the oil, 1u for bread
content.add(content.Recipe {
    id = "tuna_noodle_casserole",
    result = "tuna_noodle_casserole",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 49, true)
    :tool("casserole", 1)
    :component_any({
            { id = "fish", count = 2 },
            { id = "can_tuna", count = 2 },
            { id = "can_salmon", count = 2 },
            { id = "can_herring", count = 2 },
            { id = "fish_canned", count = 2 }
        })
    :component_any({
            { id = "spaghetti_raw", count = 2 },
            { id = "macaroni_raw", count = 2 },
            { id = "noodles_fast", count = 2 }
        })
    :component_any({
            { id = "corn", count = 2 },
            { id = "dry_beans", count = 2 },
            { id = "raw_beans", count = 2 }
        })
    :component("broth", 2)
    :component_any({
            { id = "carrot", count = 1 },
            { id = "carrot_wild", count = 1 }
        })
    :component_any({
            { id = "milk_standard_raw", count = 4, requirement = true },
            { id = "lf_milk_standard", count = 4, requirement = true }
        })
    :component_any({
            { id = "seasoning_italian", count = 7 },
            { id = "wild_herbs", count = 7 },
            { id = "pepper", count = 7 },
            { id = "curry_powder", count = 7 },
            { id = "mustard_powder", count = 7 }
        })
    :component("any_butter_or_oil", 1, true)
    :component("bread_sandwich", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("mag_cooking", 1)
    :batch_discount(50, 2)
    :result_charges(4)
)

-- 20u for the lobster (300g), 2u for the flour, 2u for the sherry, 2u for the milk, 1u for the cheese, 2u
-- for the oil, 4u for the crackers
content.add(content.Recipe {
    id = "lazy_lobster_casserole",
    result = "lazy_lobster_casserole",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 33, true)
    :tool("casserole", 1)
    :component_any({
            { id = "lobster", count = 2 },
            { id = "lobster_canned", count = 2 }
        })
    :component_any({
            { id = "crackers", count = 2 },
            { id = "oyster_crackers", count = 2 }
        })
    :component("flour", 2)
    :component("sherry", 2)
    :component_any({
            { id = "milk_standard_raw", count = 2, requirement = true },
            { id = "lf_milk_standard", count = 2, requirement = true }
        })
    :component_any({
            { id = "cheese", count = 1 },
            { id = "cheese_hard", count = 1 }
        })
    :component_any({
            { id = "seasoning_italian", count = 7 },
            { id = "wild_herbs", count = 7 },
            { id = "pepper", count = 7 },
            { id = "curry_powder", count = 7 },
            { id = "mustard_powder", count = 7 }
        })
    :component("any_butter_or_oil", 3, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("mag_cooking", 1)
    :batch_discount(50, 2)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "eggplant_parmigiana",
    result = "eggplant_parmigiana",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 44, true)
    :tool("casserole", 1)
    :component("any_eggplant", 3, true)
    :component("salt", 3)
    :component_any({
            { id = "seasoning_italian", count = 5 },
            { id = "wild_herbs", count = 5 },
            { id = "pepper", count = 5 }
        })
    :component("any_butter_or_oil", 4, true)
    :component_any({
            { id = "cheese", count = 4 },
            { id = "can_cheese", count = 4 },
            { id = "mozzarella_cheese", count = 4 }
        })
    :component("sauce_red", 4)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("cookbook_italian", 2)
    :batch_discount(50, 2)
    :result_charges(4)
)
