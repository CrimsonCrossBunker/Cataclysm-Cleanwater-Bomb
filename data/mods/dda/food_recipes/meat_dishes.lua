local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

-- 250g of raw cured meat, so 25u of smoking_heat to smoke it.
content.add(content.Recipe {
    id = "bacon_hand_smoked",
    result = "bacon",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("smoking_heat", 25, true)
    :component("raw_cured_fatty_meat", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 5)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "bacon_uncooked",
    result = "bacon_uncooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_EASY" },
}
    :component("bacon_uncut", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(3)
)

content.add(content.Recipe {
    id = "bacon",
    result = "bacon",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    flags = { "BLIND_EASY" },
}
    :component("bacon_uncooked", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_setup(27000)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "rehydrated_meat",
    result = "rehydrated_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("dry_meat", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 1)
)

content.add(content.Recipe {
    id = "washed_cured_meat",
    result = "washed_cured_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "raw_cured_meat", count = 1 },
            { id = "dehydrated_cured_meat", count = 1 }
        })
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 1)
)

content.add(content.Recipe {
    id = "cooked_cured_meat",
    result = "cooked_cured_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("washed_cured_meat", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "rehydrated_fish",
    result = "rehydrated_fish",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("dry_fish", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 1)
)

content.add(content.Recipe {
    id = "rehydrated_froglegs",
    result = "rehydrated_froglegs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("dry_froglegs", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 1)
)

content.add(content.Recipe {
    id = "rehydrated_lobster",
    result = "rehydrated_lobster",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("dry_lobster", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 1)
)

content.add(content.Recipe {
    id = "rehydrated_mollusk",
    result = "rehydrated_mollusk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("dry_mollusk", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 1)
)

-- 100g of legs, 10u of cooking, plus 2u for batter
content.add(content.Recipe {
    id = "fried_froglegs",
    result = "fried_froglegs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 12, true)
    :component("froglegs", 1)
    :component("any_butter_or_oil", 1, true)
    :component("milk", 1)
    :component("batter", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :result_charges(1)
)

-- 300g of meat, 20u of cooking, plus 2u for batter/oil
content.add(content.Recipe {
    id = "fish_fried",
    result = "fish_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 96000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 22, true)
    :component("fish", 2)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :result_charges(1)
)

-- 300g of meat, 20u of cooking, plus 2u for batter/oil
content.add(content.Recipe {
    id = "lobster_cakes",
    result = "lobster_cakes",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 96000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 22, true)
    :component("lobster", 2)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :result_charges(1)
)

-- 170g of meat, 11u of cooking, plus 2u for batter/oil
content.add(content.Recipe {
    id = "stuffed_clams",
    result = "stuffed_clams",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 96000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 13, true)
    :component("can_clams", 1)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :result_charges(5)
)

content.add(content.Recipe {
    id = "sushi_fishroll",
    result = "sushi_fishroll",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :component("sushi_rice", 1)
    :component("fish", 2)
    :component_any({
            { id = "lettuce", count = 1 },
            { id = "grape_leaves", count = 1 },
            { id = "cabbage", count = 1 },
            { id = "dandelion_cooked", count = 1 },
            { id = "burdock_cooked", count = 1 },
            { id = "bamboo_cooked", count = 1 },
            { id = "veggy_wild_cooked", count = 1 },
            { id = "veggy_cooked", count = 1 }
        })
    :component_any({
            { id = "soysauce", count = 1 },
            { id = "horseradish", count = 1 },
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("CONTAIN", 1, 1)
    :book("cookbook_sushi", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "sushi_meatroll",
    result = "sushi_meatroll",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :component("sushi_rice", 2)
    :component("meat_red", 1, true)
    :component_any({
            { id = "lettuce", count = 2 },
            { id = "grape_leaves", count = 2 },
            { id = "cabbage", count = 2 },
            { id = "dandelion_cooked", count = 2 },
            { id = "burdock_cooked", count = 2 },
            { id = "bamboo_cooked", count = 2 },
            { id = "veggy_wild_cooked", count = 2 },
            { id = "veggy_cooked", count = 2 }
        })
    :component_any({
            { id = "soysauce", count = 1 },
            { id = "horseradish", count = 1 },
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("CONTAIN", 1, 1)
    :book("cookbook_sushi", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "sashimi",
    result = "sashimi",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :component("fish", 1)
    :component_any({
            { id = "any_salad_cucumber", count = 1, requirement = true },
            { id = "carrot", count = 3 },
            { id = "carrot_wild", count = 3 },
            { id = "celery", count = 3 },
            { id = "veggy_wild", count = 3 },
            { id = "veggy", count = 3 },
            { id = "wild_garlic", count = 3 },
            { id = "rehydrated_veggy", count = 3 },
            { id = "rehydrated_corn_kernels", count = 3 },
            { id = "corn_kernels", count = 3 }
        })
    :component_any({
            { id = "soysauce", count = 1 },
            { id = "horseradish", count = 1 },
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("CONTAIN", 1, 1)
    :book("cookbook_sushi", 4)
    :book("cookbook_foodfashions", 4, { name = content.text("Low-Carb Sashimi Donburi") })
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(2)
)

-- 820g of flesh would be 82 smoking_heats
content.add(content.Recipe {
    id = "sausage",
    result = "sausage",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("smoking_heat", 82, true)
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component_any({
            { id = "meat_red", count = 2, requirement = true },
            { id = "meat_liver", count = 10, requirement = true }
        })
    :component_any({
            { id = "edible_fat", count = 10, requirement = true },
            { id = "edible_tallow", count = 10, requirement = true }
        })
    :component_any({
            { id = "salt", count = 4 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 4 },
            { id = "wild_herbs", count = 4 },
            { id = "seasoning_salt", count = 4 },
            { id = "pepper", count = 4 }
        })
    :component_any({
            { id = "sausage_casings", count = 6 },
            { id = "sausage_casings_artificial", count = 6 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :book("family_cookbook", 2)
    :book("scots_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 3)
    :result_charges(6)
)

-- fat = 15u, blood = 30u, meat = 20u
content.add(content.Recipe {
    id = "blutwurst_sausage",
    result = "blutwurst_sausage",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 65, true)
    :component("meat_red", 1, true)
    :component("edible_blood", 2, true)
    :component_any({
            { id = "edible_fat", count = 10, requirement = true },
            { id = "edible_tallow", count = 10, requirement = true }
        })
    :component_any({
            { id = "salt", count = 4 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 4 },
            { id = "wild_herbs", count = 4 },
            { id = "seasoning_salt", count = 4 },
            { id = "pepper", count = 4 }
        })
    :component("sausage_casings", 8)
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :book("cookbook_bloodforgood", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_preservation")
    :batch_discount(83, 3)
    :result_charges(8)
)

-- fat = 15u, meat = 40u
content.add(content.Recipe {
    id = "bratwurst_sausage",
    result = "bratwurst_sausage",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 55, true)
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component_any({
            { id = "meat_red", count = 2, requirement = true },
            { id = "can_chicken", count = 2 }
        })
    :component_any({
            { id = "edible_fat", count = 10, requirement = true },
            { id = "edible_tallow", count = 10, requirement = true }
        })
    :component_any({
            { id = "salt", count = 4 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 4 },
            { id = "wild_herbs", count = 4 },
            { id = "seasoning_salt", count = 4 },
            { id = "pepper", count = 4 }
        })
    :component_any({
            { id = "sausage_casings", count = 8 },
            { id = "sausage_casings_artificial", count = 8 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :book("family_cookbook", 2)
    :book("scots_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_preservation")
    :batch_discount(83, 3)
    :result_charges(8)
)

content.add(content.Recipe {
    id = "sausage_raw",
    result = "sausage_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component_any({
            { id = "meat_red", count = 2, requirement = true },
            { id = "meat_liver", count = 10, requirement = true }
        })
    :component_any({
            { id = "edible_fat", count = 10, requirement = true },
            { id = "edible_tallow", count = 10, requirement = true }
        })
    :component_any({
            { id = "salt", count = 4 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 4 },
            { id = "wild_herbs", count = 4 },
            { id = "seasoning_salt", count = 4 },
            { id = "pepper", count = 4 }
        })
    :component_any({
            { id = "sausage_casings", count = 6 },
            { id = "sausage_casings_artificial", count = 6 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :book("family_cookbook", 2)
    :book("scots_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(50, 3)
    :result_charges(6)
)

-- 150g of sausage = 10u heat
content.add(content.Recipe {
    id = "sausage_cooked",
    result = "sausage_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 10, true)
    :component("sausage_raw", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
    :result_charges(1)
)

-- 600g meat being smoked = 60 smoking_heats
content.add(content.Recipe {
    id = "bologna",
    result = "bologna",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("smoking_heat", 60, true)
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component("meat_red", 2, true)
    :component_any({
            { id = "salt", count = 2 },
            { id = "soysauce", count = 1 },
            { id = "seasoning_italian", count = 2 },
            { id = "wild_herbs", count = 2 },
            { id = "seasoning_salt", count = 2 }
        })
    :component_any({
            { id = "sausage_casings", count = 8 },
            { id = "sausage_casings_artificial", count = 8 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 3)
    :result_charges(8)
)

-- not sure how to price this so just doing 300g meat (20u) + the gelatin (10u) + water (5u)
content.add(content.Recipe {
    id = "meat_aspic",
    result = "meat_aspic",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 35, true)
    :component_any({
            { id = "gelatin_fresh", count = 1 },
            { id = "gelatin_powder", count = 25 },
            { id = "chem_agar", count = 25 }
        })
    :component_any({
            { id = "meat_red", count = 1, requirement = true },
            { id = "meat_cooked", count = 1 },
            { id = "mutant_meat_cooked", count = 1 },
            { id = "can_salmon", count = 2 },
            { id = "can_herring", count = 2 },
            { id = "fish", count = 2 },
            { id = "fish_cooked", count = 2 },
            { id = "lobster", count = 2 },
            { id = "lobster_cooked", count = 2 },
            { id = "can_tuna", count = 2 },
            { id = "can_sardine", count = 2 },
            { id = "can_clams", count = 2 },
            { id = "fish_canned", count = 2 },
            { id = "lobster_canned", count = 2 }
        })
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(50, 5)
)

-- 440g of fat cooked to a crisp instead of being boiled.  basing off chunk of meat use 30u of charge.
content.add(content.Recipe {
    id = "cracklins",
    result = "cracklins",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 30, true)
    :component("edible_fat", 10, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :result_charges(7)
)

-- meat = 20u, fat = 15u, veggy/fruit = 4u, give or take
content.add(content.Recipe {
    id = "pemmican",
    result = "pemmican",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 40, true)
    :component_any({
            { id = "edible_tallow", count = 5, requirement = true },
            { id = "ghee", count = 2 }
        })
    :component_any({
            { id = "jerky", count = 2 },
            { id = "dry_meat", count = 2 },
            { id = "meat_smoked", count = 2 },
            { id = "dry_fish", count = 2 },
            { id = "fish_smoked", count = 2 },
            { id = "dry_lobster", count = 2 },
            { id = "lobster_smoked", count = 2 },
            { id = "poultry_smoked", count = 2 }
        })
    :component_any({
            { id = "dry_fruit", count = 2 },
            { id = "juice_pulp", count = 4 },
            { id = "strawberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "cherries", count = 1 },
            { id = "cranberries", count = 1 },
            { id = "raspberries", count = 1 },
            { id = "prickly_pear_fruit", count = 1 },
            { id = "saguaro_fruit", count = 2 },
            { id = "wintergreen_berry", count = 4 },
            { id = "m_stellatum_berries", count = 4 },
            { id = "blackberries", count = 1 }
        })
    :quality("CUT", 2, 1)
    :book("cookbook_native", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :batch_discount(80, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "pemmican_veggy",
    result = "pemmican_veggy",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "edible_tallow", count = 5, requirement = true },
            { id = "ghee", count = 2 }
        })
    :component_any({
            { id = "jerky", count = 2 },
            { id = "dry_meat", count = 2 },
            { id = "meat_smoked", count = 2 },
            { id = "dry_fish", count = 2 },
            { id = "fish_smoked", count = 2 },
            { id = "dry_lobster", count = 2 },
            { id = "lobster_smoked", count = 2 }
        })
    :component_any({
            { id = "dry_veggy", count = 2 },
            { id = "dry_corn", count = 2 },
            { id = "dry_mushroom", count = 2 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :batch_discount(80, 1)
    :result_charges(4)
)

-- meat = 20u, fat = 15u, give or take
content.add(content.Recipe {
    id = "pemmican_meat",
    result = "pemmican_meat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 36, true)
    :component_any({
            { id = "edible_tallow", count = 5, requirement = true },
            { id = "ghee", count = 2 }
        })
    :component_any({
            { id = "jerky", count = 2 },
            { id = "dry_meat", count = 2 },
            { id = "meat_smoked", count = 2 },
            { id = "dry_fish", count = 2 },
            { id = "fish_smoked", count = 2 },
            { id = "dry_lobster", count = 2 },
            { id = "lobster_smoked", count = 2 }
        })
    :quality("CUT", 2, 1)
    :book("cookbook_native", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :batch_discount(80, 1)
    :result_charges(4)
)

-- ingredients are mostly prepped already.
content.add(content.Recipe {
    id = "can_chowder",
    result = "can_chowder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 7, true)
    :component("can_clams", 1)
    :component_any({
            { id = "veggy_potatolike", count = 1, requirement = true },
            { id = "meat_smoked", count = 1 },
            { id = "dry_meat", count = 1 },
            { id = "rehydrated_meat", count = 1 },
            { id = "meat_salted", count = 1 },
            { id = "sausage", count = 1 },
            { id = "sausage_cooked", count = 1 },
            { id = "bratwurst_sausage", count = 2 },
            { id = "bacon", count = 1 },
            { id = "onion", count = 1 }
        })
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
    :quality("COOK", 3, 1)
    :result_charges(3)
)

-- veggy = 2u, oil = 4u, 300g steak = 20u, sugar = 4u
content.add(content.Recipe {
    id = "glazed_tenderloin",
    result = "glazed_tenderloin",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 30, true)
    :component_any({
            { id = "sugar_standard", count = 2, requirement = true },
            { id = "honeycomb", count = 1 }
        })
    :component("meat_red_raw_steak", 1, true)
    :component("any_butter_or_oil", 8, true)
    :component("veggy_any", 1, true)
    :component_any({
            { id = "salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "pepper", count = 1 }
        })
    :quality("BUTCHER", 20, 1)
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :book("family_cookbook", 5)
    :book("cookbook_daintydishes", 5, { name = content.text("Sir Tenderloin the Toothsome") })
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(3)
)

-- lobster = 10u, lemon = 1u, veggy = 2u, oil = 4u
content.add(content.Recipe {
    id = "lobster_platter",
    result = "lobster_platter",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 17, true)
    :component("lemon", 1)
    :component("lobster", 1)
    :component("any_butter_or_oil", 8, true)
    :component("veggy_any", 1, true)
    :component_any({
            { id = "salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "pepper", count = 1 }
        })
    :quality("BUTCHER", 20, 1)
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :book("family_cookbook", 5)
    :book("cookbook_daintydishes", 5, { name = content.text("Lobsterman's Delight") })
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(3)
)

-- 900g meat = 90u, fat = 22u, syrup = 2u, 114 smoking_heats total
content.add(content.Recipe {
    id = "sweet_sausage",
    result = "sweet_sausage",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("smoking_heat", 114, true)
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component_any({
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 }
        })
    :component_any({
            { id = "meat_red", count = 3, requirement = true },
            { id = "can_chicken", count = 3 }
        })
    :component_any({
            { id = "edible_fat", count = 10, requirement = true },
            { id = "edible_tallow", count = 10, requirement = true }
        })
    :component_any({
            { id = "salt", count = 10 },
            { id = "soysauce", count = 1 },
            { id = "seasoning_italian", count = 10 },
            { id = "wild_herbs", count = 10 },
            { id = "seasoning_salt", count = 10 },
            { id = "pepper", count = 10 }
        })
    :component_any({
            { id = "sausage_casings", count = 6 },
            { id = "sausage_casings_artificial", count = 6 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :book("family_cookbook", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(83, 3)
    :result_charges(6)
)

-- beans = 2u (precooked), egg = 6u (minimum), sugar = 1u
content.add(content.Recipe {
    id = "deluxe_beans",
    result = "deluxe_beans",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 9, true)
    :component_any({
            { id = "can_beans", count = 1 },
            { id = "beans_cooked", count = 1 }
        })
    :component_any({
            { id = "meat_cooked", count = 1, requirement = true },
            { id = "eggs_any_shape", count = 2, requirement = true }
        })
    :component("sugar_standard", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
    :result_charges(2)
)

-- rice = 2u (precooked), egg = 6u, meat = 2u, (just heating it), oil = 1u
content.add(content.Recipe {
    id = "deluxe_rice",
    result = "deluxe_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 11, true)
    :component_any({
            { id = "rice_cooked", count = 1 },
            { id = "wild_rice_cooked", count = 1 }
        })
    :component("eggs_any_shape", 2, true)
    :component("meat_cooked", 1, true)
    :component("any_butter_or_oil", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
    :result_charges(2)
)

-- rice = 4u, beans = 2u (precooked), egg/meat = 6u
content.add(content.Recipe {
    id = "deluxe_beansnrice",
    result = "deluxe_beansnrice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 12, true)
    :component_any({
            { id = "can_beans", count = 1 },
            { id = "dry_beans", count = 1 },
            { id = "raw_beans", count = 1 }
        })
    :component_any({
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 }
        })
    :component_any({
            { id = "meat_smoked", count = 1 },
            { id = "dry_meat", count = 1 },
            { id = "can_chicken", count = 1 },
            { id = "can_spam", count = 2 },
            { id = "fish", count = 1 },
            { id = "fish_smoked", count = 1 },
            { id = "dry_fish", count = 1 },
            { id = "rehydrated_fish", count = 1 },
            { id = "salted_fish", count = 1 },
            { id = "meat_salted", count = 1 },
            { id = "fish_canned", count = 1 },
            { id = "lobster", count = 1 },
            { id = "lobster_smoked", count = 1 },
            { id = "dry_lobster", count = 1 },
            { id = "rehydrated_lobster", count = 1 },
            { id = "lobster_canned", count = 1 },
            { id = "can_salmon", count = 1 },
            { id = "can_tuna", count = 1 },
            { id = "sausage", count = 2 },
            { id = "sausage_cooked", count = 2 },
            { id = "bratwurst_sausage", count = 2 },
            { id = "bacon", count = 2 },
            { id = "eggs_any_shape", count = 2, requirement = true }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "wild_garlic", count = 1 },
            { id = "garlic_powder", count = 1 },
            { id = "pepper", count = 1 }
        })
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :book("cookbook_mexican", 2)
    :proficiency("prof_food_prep")
    :result_charges(2)
)

-- 6u for the egg, meat not needed since it's just diced up and mixed in
content.add(content.Recipe {
    id = "deluxe_eggs",
    result = "deluxe_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true }
        })
    :component("meat_cooked", 1, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(3)
)

-- 4u for beans/veggy, 4u for meat, 1u for tomato, 1u for pepper, 4u for beans again
content.add(content.Recipe {
    id = "chili",
    result = "chili",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 14, true)
    :component_any({
            { id = "veggy", count = 2 },
            { id = "veggy_wild", count = 2 },
            { id = "veggy_salted", count = 2 },
            { id = "rehydrated_veggy", count = 2 },
            { id = "rehydrated_corn_kernels", count = 2 },
            { id = "corn_kernels", count = 2 },
            { id = "mushroom", count = 2 },
            { id = "dry_mushroom", count = 2 },
            { id = "morel_cooked", count = 2 },
            { id = "mushroom_cooked", count = 2 },
            { id = "dry_veggy", count = 2 },
            { id = "dry_corn", count = 2 }
        })
    :component("any_tomato", 1, true)
    :component_any({
            { id = "meat_cooked", count = 1, requirement = true },
            { id = "dry_meat", count = 1 },
            { id = "can_chicken", count = 1 }
        })
    :component_any({
            { id = "can_beans", count = 1 },
            { id = "raw_beans", count = 1 },
            { id = "dry_beans", count = 1 }
        })
    :component_any({
            { id = "chilly-p", count = 2 },
            { id = "any_chili_pepper", count = 1, requirement = true }
        })
    :book("cookbook_italian", 2)
    :book("cookbook_mexican", 2)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "meat_salted_vacuum_packed",
    result = "meat_salted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    container = "plastic_bag_vac",
}
    :component("meat_vacuum_packable", 2, true)
    :requirement("vacuum_sealing_standard", 1)
    :book("vacuum_sealing", 1)
    :proficiency("prof_preservation")
    :batch_discount(10, 3)
    :result_charges(2)
)

-- by weight, this would be 4u heat, but it is already edible, so thorough cooking is not necessary.
content.add(content.Recipe {
    id = "fried_spam",
    result = "fried_spam",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 16500,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 3, true)
    :component("can_spam", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "cheeseburger",
    result = "cheeseburger",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component_any({
            { id = "meat_red_cooked", count = 1, requirement = true },
            { id = "scrambled_eggs", count = 2 },
            { id = "boiled_egg", count = 2 },
            { id = "fried_eggs", count = 1 },
            { id = "omelet", count = 1 }
        })
    :component("bread_sandwich", 2, true)
    :component("cheese_standard", 1, true)
    :component_any({
            { id = "pickle", count = 1 },
            { id = "veggy_pickled", count = 1 },
            { id = "onion", count = 1 },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "young_leaves", count = 2 },
            { id = "chicory_leaves", count = 2 },
            { id = "lettuce", count = 1 }
        })
    :component_any({
            { id = "ketchup", count = 1 },
            { id = "barbecue_sauce", count = 1 },
            { id = "honey_mustard", count = 1 },
            { id = "mustard", count = 1 },
            { id = "horseradish", count = 1 },
            { id = "mayonnaise", count = 1 },
            { id = "bacon", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "sauerkraut", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "deluxe_cheeseburger",
    result = "deluxe_cheeseburger",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component_any({
            { id = "meat_red_cooked", count = 1, requirement = true },
            { id = "scrambled_eggs", count = 2 },
            { id = "boiled_egg", count = 2 },
            { id = "fried_eggs", count = 1 },
            { id = "omelet", count = 1 }
        })
    :component("bread_sandwich", 2, true)
    :component("cheese_standard", 1, true)
    :component_any({
            { id = "pickle", count = 1 },
            { id = "veggy_pickled", count = 1 },
            { id = "sauerkraut", count = 1 }
        })
    :component("onion", 1)
    :component("any_tomato", 1, true)
    :component_any({
            { id = "young_leaves", count = 2 },
            { id = "chicory_leaves", count = 2 },
            { id = "lettuce", count = 1 }
        })
    :component_any({
            { id = "ketchup", count = 1 },
            { id = "barbecue_sauce", count = 1 }
        })
    :component_any({
            { id = "mustard", count = 1 },
            { id = "honey_mustard", count = 1 }
        })
    :component_any({
            { id = "horseradish", count = 1 },
            { id = "mayonnaise", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :result_charges(2)
)

-- 10u to cook the 150g fish, the rest is just the lye.
content.add(content.Recipe {
    id = "lutefisk",
    result = "lutefisk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 108000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 6,
}
    :tool_charges("surface_heat", 21, true)
    :component("fish", 1)
    :component("water_clean", 2)
    :component("lye_powder", 5)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("cookbook", 4)
    :book("cookbook_foodfashions", 4)
)

content.add(content.Recipe {
    id = "hamburger",
    result = "hamburger",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component_any({
            { id = "meat_red_cooked", count = 1, requirement = true },
            { id = "scrambled_eggs", count = 2 },
            { id = "boiled_egg", count = 2 },
            { id = "fried_eggs", count = 1 },
            { id = "omelet", count = 1 }
        })
    :component("bread_sandwich", 2, true)
    :component_any({
            { id = "pickle", count = 1 },
            { id = "veggy_pickled", count = 1 },
            { id = "onion", count = 1 },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "lettuce", count = 1 },
            { id = "young_leaves", count = 2 },
            { id = "chicory_leaves", count = 2 }
        })
    :component_any({
            { id = "ketchup", count = 1 },
            { id = "barbecue_sauce", count = 1 },
            { id = "honey_mustard", count = 1 },
            { id = "mustard", count = 1 },
            { id = "horseradish", count = 1 },
            { id = "mayonnaise", count = 1 },
            { id = "bacon", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "sauerkraut", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "ndn_taco",
    result = "ndn_taco",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component("meat_red_cooked", 1, true)
    :component("frybread", 3)
    :component_any({
            { id = "can_beans", count = 1 },
            { id = "beans_cooked", count = 1 }
        })
    :component_any({
            { id = "lettuce", count = 1 },
            { id = "cabbage", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_native", 1)
    :result_charges(4)
)

-- 4u for the meat, which is pre cooked. 3u for the tortillas, which are already prepped.
content.add(content.Recipe {
    id = "taco",
    result = "taco",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 7, true)
    :component_any({
            { id = "meat_cooked", count = 1, requirement = true },
            { id = "dry_meat", count = 1 },
            { id = "can_chicken", count = 1 }
        })
    :component("tortilla_corn", 3)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_mexican", 1)
    :result_charges(3)
)

-- as much as 300g meat total for 20u, 2u fat = 30u, flour = 2-5u, mushroom = 4u.
content.add(content.Recipe {
    id = "sausagegravy",
    result = "sausagegravy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 55, true)
    :component_any({
            { id = "sausage", count = 1 },
            { id = "sausage_cooked", count = 1 },
            { id = "bratwurst_sausage", count = 1 },
            { id = "meat_red", count = 1, requirement = true },
            { id = "dry_meat", count = 1 },
            { id = "can_chicken", count = 1 },
            { id = "poultry_raw_any", count = 1, requirement = true }
        })
    :component("edible_tallow", 5, true)
    :component_any({
            { id = "flour_any", count = 2, requirement = true },
            { id = "cornmeal", count = 1 }
        })
    :component_any({
            { id = "mushroom", count = 2 },
            { id = "dry_mushroom", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :result_charges(4)
)

content.add(content.Recipe {
    id = "currywurst",
    result = "currywurst",
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
            { id = "sausage", count = 1 },
            { id = "sausage_cooked", count = 1 },
            { id = "bratwurst_sausage", count = 2 }
        })
    :component_any({
            { id = "curry_powder", count = 10 },
            { id = "chilly-p", count = 10 }
        })
    :component("ketchup", 2)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :result_charges(2)
)

-- 4u for meat 1u for sauce = 5u
content.add(content.Recipe {
    id = "sloppyjoe",
    result = "sloppyjoe",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component("bread_sandwich", 2, true)
    :component_any({
            { id = "sauce_red", count = 2 },
            { id = "any_tomato", count = 1, requirement = true }
        })
    :component("meat_red_cooked", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("sweets_book", 1)
    :book("mag_cooking", 1)
    :book("family_cookbook", 1)
    :result_charges(2)
)

-- royal jelly essentially edible as is, but is half the weight of the meat, so going with 20u for meat + 5u
-- for jelly
content.add(content.Recipe {
    id = "royal_beef",
    result = "royal_beef",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 25, true)
    :component("meat_red", 1, true)
    :component("royal_jelly", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
)

-- 300g raw meat (20u) + 26g of flour (2u) for a total of 22
content.add(content.Recipe {
    id = "pelmeni",
    result = "pelmeni",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 22, true)
    :component("flour_any", 2, true)
    :component_any({
            { id = "meat_red", count = 1, requirement = true },
            { id = "poultry_raw_any", count = 2, requirement = true },
            { id = "dry_meat", count = 1 }
        })
    :component("water_clean", 1)
    :quality("COOK", 1, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
    :result_charges(2)
)

-- 12 for 4 oatmeal, 5u for 72g stomach, 20u for 300g of offal
content.add(content.Recipe {
    id = "haggis",
    result = "haggis",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 37, true)
    :component("water_clean", 1)
    :component("meat_stomach_small", 1, true)
    :component("meat_offal", 1, true)
    :component_any({
            { id = "oatmeal", count = 4 },
            { id = "buckwheat", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :requirement("sewing_standard", 2)
    :requires_skill("tailor", 1)
    :book("scots_cookbook", 3)
    :book("cookbook_liverforkids", 4, { name = content.text("Leprechaun Sausage") })
    :proficiency("prof_food_prep")
    :batch_discount(50, 4)
)

-- 24u for 8 oatmeal, 10u for 144g stomach, 40u for 600g of offal
content.add(content.Recipe {
    id = "haggis_large",
    result = "haggis",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 75, true)
    :component("water_clean", 2)
    :component("meat_stomach_large", 1, true)
    :component("meat_offal", 2, true)
    :component_any({
            { id = "oatmeal", count = 8 },
            { id = "buckwheat", count = 2 }
        })
    :quality("BOIL", 1, 1)
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :requirement("sewing_standard", 4)
    :requires_skill("tailor", 1)
    :book("survival_book", 6)
    :book("scots_cookbook", 3)
    :proficiency("prof_food_prep")
    :batch_discount(50, 4)
    :result_charges(2)
)

-- You are smoking roughly 600g of meat, so roughly 60u of smoking_heat.
content.add(content.Recipe {
    id = "sausage_wasteland",
    result = "sausage_wasteland",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 420000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("smoking_heat", 160, true)
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component_any({
            { id = "offal", count = 4 },
            { id = "mutant_bug_organs", count = 4 },
            { id = "meat_nofish", count = 2, requirement = true },
            { id = "bacon", count = 8 },
            { id = "bologna", count = 10 },
            { id = "meat_pickled", count = 2 },
            { id = "dry_meat", count = 2 },
            { id = "jerky", count = 2 },
            { id = "meat_smoked", count = 2 },
            { id = "meat_salted", count = 2 },
            { id = "meat_fried", count = 2 },
            { id = "meat_brain", count = 10, requirement = true }
        })
    :component_any({
            { id = "sausage_casings", count = 2 },
            { id = "sausage_casings_artificial", count = 2 }
        })
    :component_any({
            { id = "salt_water", count = 4 },
            { id = "saline", count = 8 },
            { id = "salt", count = 4 },
            { id = "chem_saltpetre", count = 2 },
            { id = "chem_black_powder", count = 94 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 4 },
            { id = "wild_herbs", count = 4 },
            { id = "seasoning_salt", count = 4 },
            { id = "garlic_powder", count = 4 },
            { id = "pepper", count = 4 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_scav_cooking")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 3)
    :result_charges(2)
)

-- You are smoking roughly 600g of meat, so roughly 60u of smoking_heat.
content.add(content.Recipe {
    id = "sausage_wasteland_smoke",
    result = "sausage_wasteland",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("smoking_heat", 60, true)
    :component("sausage_wasteland_raw", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 6)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sausage_wasteland_raw",
    result = "sausage_wasteland_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component_any({
            { id = "offal", count = 4 },
            { id = "mutant_bug_organs", count = 4 },
            { id = "meat_nofish", count = 2, requirement = true },
            { id = "bacon", count = 8 },
            { id = "bologna", count = 10 },
            { id = "meat_pickled", count = 2 },
            { id = "dry_meat", count = 2 },
            { id = "jerky", count = 2 },
            { id = "meat_smoked", count = 2 },
            { id = "meat_salted", count = 2 },
            { id = "meat_fried", count = 2 },
            { id = "meat_brain", count = 10, requirement = true }
        })
    :component_any({
            { id = "sausage_casings", count = 2 },
            { id = "sausage_casings_artificial", count = 2 }
        })
    :component_any({
            { id = "salt_water", count = 4 },
            { id = "saline", count = 8 },
            { id = "salt", count = 4 },
            { id = "chem_saltpetre", count = 2 },
            { id = "chem_black_powder", count = 94 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 4 },
            { id = "garlic_powder", count = 4 },
            { id = "wild_herbs", count = 4 },
            { id = "seasoning_salt", count = 4 },
            { id = "pepper", count = 4 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_scav_cooking")
    :proficiency("prof_preservation")
    :batch_discount(50, 3)
    :result_charges(2)
)

-- 4u for meat (precooked), 3u for tortiilas, 4u for beans/rice, 1u for sauce
content.add(content.Recipe {
    id = "homemade_burrito",
    result = "homemade_burrito",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 12, true)
    :component_any({
            { id = "meat_cooked", count = 1, requirement = true },
            { id = "dry_meat", count = 1 },
            { id = "can_chicken", count = 1 },
            { id = "meat_smoked", count = 1 },
            { id = "scrambled_eggs", count = 2 },
            { id = "boiled_egg", count = 2 },
            { id = "fried_eggs", count = 1 },
            { id = "omelet", count = 1 }
        })
    :component("tortilla_any", 3, true)
    :component_any({
            { id = "dry_beans", count = 1 },
            { id = "raw_beans", count = 1 },
            { id = "dry_lentils", count = 1 },
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 },
            { id = "can_beans", count = 1 },
            { id = "beans_cooked", count = 1 }
        })
    :component_any({
            { id = "lettuce", count = 2 },
            { id = "dandelion_cooked", count = 2 },
            { id = "burdock_cooked", count = 2 },
            { id = "veggy_wild_cooked", count = 2 },
            { id = "grape_leaves", count = 2 },
            { id = "cabbage", count = 2 }
        })
    :component_any({
            { id = "any_tomato", count = 1, requirement = true },
            { id = "onion", count = 1 },
            { id = "salsa", count = 1 }
        })
    :component_any({
            { id = "pepper", count = 20 },
            { id = "chilly-p", count = 20 },
            { id = "garlic_clove", count = 6 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "garlic_powder", count = 20 },
            { id = "any_chili_pepper", count = 2, requirement = true }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_mexican", 3)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "meatball_raw",
    result = "meatball_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :component("meat_red", 2, true)
    :component("any_bread", 1, true)
    :component_any({
            { id = "salt", count = 2 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 2 },
            { id = "wild_herbs", count = 2 },
            { id = "seasoning_salt", count = 2 },
            { id = "wild_garlic", count = 1 },
            { id = "garlic_powder", count = 2 },
            { id = "pepper", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :book("family_cookbook", 2)
    :book("cookbook_italian", 2)
    :proficiency("prof_knife_skills", { time_multiplier = 1.5 })
    :batch_discount(50, 3)
    :result_charges(6)
)

-- 90g meat = 6u
content.add(content.Recipe {
    id = "meatball",
    result = "meatball",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 6, true)
    :component("meatball_raw", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

-- 4u for beans, 4u for rice, 20u for meat, 1u for other stuff
content.add(content.Recipe {
    id = "paella_valenciana",
    result = "paella_valenciana",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 29, true)
    :component_any({
            { id = "can_beans", count = 1 },
            { id = "dry_beans", count = 1 },
            { id = "raw_beans", count = 1 }
        })
    :component_any({
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 }
        })
    :component_any({
            { id = "meat_red", count = 1, requirement = true },
            { id = "poultry_raw_any", count = 1, requirement = true },
            { id = "meat_smoked", count = 1 },
            { id = "dry_meat", count = 1 },
            { id = "can_chicken", count = 1 },
            { id = "can_spam", count = 2 },
            { id = "meat_salted", count = 1 },
            { id = "gastropod_purged", count = 4 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "wild_garlic", count = 1 },
            { id = "garlic_powder", count = 1 },
            { id = "any_tomato", count = 1, requirement = true }
        })
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :book("family_cookbook", 2)
    :result_charges(2)
)

-- 90g of snail meat.  treating it like scrap of meat, that's 6u + 1u for butter and aromatics
content.add(content.Recipe {
    id = "escargot",
    result = "escargot",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 7, true)
    :component("gastropod_purged", 6)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "wild_garlic", count = 1 },
            { id = "garlic_powder", count = 1 }
        })
    :component_any({
            { id = "butter", count = 1 },
            { id = "raw_butter", count = 1 }
        })
    :component("wild_herbs", 6)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :book("family_cookbook", 2)
    :proficiency("prof_forage_cooking")
    :result_charges(6)
)

content.add(content.Recipe {
    id = "confit_meat",
    result = "confit_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 50, true)
    :component_any({
            { id = "edible_tallow", count = 2, requirement = true },
            { id = "any_butter", count = 5, requirement = true }
        })
    :component_any({
            { id = "meat_red_raw", count = 1, requirement = true },
            { id = "fish", count = 1 },
            { id = "meat_offal", count = 1, requirement = true }
        })
    :component("salt_preservation", 1, true)
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
    :book("family_cookbook", 3)
    :book("scots_cookbook", 2)
    :book("survival_book", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_frying")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "kiymali_pide",
    result = "kiymali_pide",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 30, true)
    :component("flatbread", 1)
    :component("meat_red_raw", 1, true)
    :component("salt", 1)
    :component("onion", 1)
    :component("any_tomato", 2, true)
    :component("any_butter_or_oil", 1, true)
    :component("sugar", 1)
    :component("any_bell_pepper", 1, true)
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_turkish", 2)
    :batch_discount(80, 1)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "lahmacun",
    result = "lahmacun",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 40, true)
    :component("flatbread", 1)
    :component_any({
            { id = "meat_red_raw", count = 1, requirement = true },
            { id = "poultry_raw_any", count = 2, requirement = true }
        })
    :component("salt", 1)
    :component("onion", 1)
    :component("any_tomato", 1, true)
    :component("any_butter_or_oil", 1, true)
    :component("any_bell_pepper", 1, true)
    :component_any({
            { id = "garlic_clove", count = 2 },
            { id = "rehydrated_garlic", count = 2 }
        })
    :component("seasoning_mild", 2, true)
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_turkish", 2)
    :batch_discount(80, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "iskender",
    result = "iskender",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 540000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 40, true)
    :component("meat_red_raw", 1, true)
    :component("salt", 1)
    :component("pepper", 1)
    :component("onion", 2)
    :component("any_tomato", 4, true)
    :component("any_bell_pepper", 2, true)
    :component_any({
            { id = "garlic_clove", count = 2 },
            { id = "rehydrated_garlic", count = 2 }
        })
    :component("seasoning_mild", 2, true)
    :component("yoghurt", 1)
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_turkish", 2)
    :batch_discount(80, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "manti",
    result = "manti",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 40, true)
    :component("meat_red_raw", 1, true)
    :component("salt", 1)
    :component("pepper", 1)
    :component("onion", 2)
    :component("wild_herbs", 1)
    :component("eggs_bird", 2, true)
    :component("any_butter", 1, true)
    :component_any({
            { id = "garlic_clove", count = 2 },
            { id = "rehydrated_garlic", count = 2 }
        })
    :component("flour_any", 20, true)
    :component("yoghurt", 1)
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_turkish", 2)
    :batch_discount(80, 1)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "sarma",
    result = "sarma",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 1080000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :component("meat_red_raw", 2, true)
    :component("salt", 1)
    :component("garlic_powder", 1)
    :component("onion", 1)
    :component("tomato_juice", 1)
    :component("pepper", 1)
    :component("cabbage", 2)
    :component("rice_cooked", 1)
    :component("eggs_bird", 1, true)
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_turkish", 2)
    :batch_discount(80, 1)
    :result_charges(4)
)

-- 200g of meat, 14u of cooking, plus 2u for batter/oil; value copied from batter fried fish
content.add(content.Recipe {
    id = "chicken_fried",
    result = "chicken_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 16, true)
    :component("poultry", 2)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :result_charges(2)
)

-- 200g of meat, 14u of cooking, plus 2u for batter/oil; value copied from batter fried fish
content.add(content.Recipe {
    id = "chicken_fried_buttermilk",
    result = "chicken_fried_buttermilk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 330000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 16, true)
    :component("poultry", 2)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 1, true)
    :component("buttermilk", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("family_cookbook", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :result_charges(2)
)

-- 7u per portion of poultry plus 1u of everything else
content.add(content.Recipe {
    id = "chicken_tandoori",
    result = "chicken_tandoori",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 15, true)
    :component("poultry", 2)
    :component("curry_powder", 2)
    :component("chilly-p", 2)
    :component("yoghurt", 1)
    :component_any({
            { id = "garlic_clove", count = 2 },
            { id = "rehydrated_garlic", count = 2 },
            { id = "garlic_powder", count = 2 }
        })
    :component("pepper", 1)
    :component("salt", 2)
    :quality("OVEN", 1, 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_indian", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "chicken_sandwich",
    result = "chicken_sandwich",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component("chicken_fried", 1)
    :component("bread_sandwich", 2, true)
    :component("condiment", 2, true)
    :component("veggy_any_fresh_uncooked", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(2)
)

-- 1L of water, chicken is poached for 40m for total of 12u boiling heat, everything else for 12u surface
-- heat including reducing the sauce
content.add(content.Recipe {
    id = "chicken_rice_hianese",
    result = "chicken_rice_hianese",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 12, true)
    :tool_charges("surface_heat", 12, true)
    :component("poultry_raw_any", 2, true)
    :component_any({
            { id = "dry_rice", count = 2 },
            { id = "dry_wild_rice", count = 2 }
        })
    :component("garlic_clove", 2)
    :component("veggy_any_fresh_uncooked", 2, true)
    :component("salt", 2)
    :component("pepper", 1)
    :component("seasoning_mild", 1, true)
    :component("vinegar", 1)
    :component("water_clean", 4)
    :component("sugar_standard_half", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(70, 2)
    :result_charges(4)
)

-- 2 portions of chicken, frying oil and ingredients for 29u surface, 1L water to boil the noodles for 5u,
-- reducing the sauce for 3u
content.add(content.Recipe {
    id = "chicken_parm",
    result = "chicken_parm",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("water_boiling_heat", 8, true)
    :tool_charges("surface_heat", 29, true)
    :component("poultry_raw_any", 2, true)
    :component("any_butter_or_oil", 1, true)
    :component("garlic_clove", 4)
    :component("sauce_red", 12)
    :component("onion", 1)
    :component("salt", 2)
    :component("pepper", 2)
    :component("seasoning_italian", 2)
    :component("flour_any", 1, true)
    :component("batter", 2, true)
    :component("eggs_bird", 1, true)
    :component("spaghetti_raw", 4)
    :component("cheese_hard", 2)
    :component("water_clean", 4)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_italian", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(65, 2)
    :result_charges(4)
)

-- grain = 12u, meat = 20u
content.add(content.Recipe {
    id = "scrapple",
    result = "scrapple",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 32, true)
    :component_any({
            { id = "meat_offal", count = 2, requirement = true },
            { id = "meat_nofish", count = 1, requirement = true }
        })
    :component_any({
            { id = "salt", count = 2 },
            { id = "syrup", count = 1 },
            { id = "seasoning_italian", count = 2 },
            { id = "wild_herbs", count = 2 },
            { id = "seasoning_salt", count = 2 },
            { id = "pepper", count = 2 },
            { id = "hot_sauce", count = 1 }
        })
    :component_any({
            { id = "corn", count = 1 },
            { id = "barley", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "oats", count = 1 },
            { id = "wheat", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("cookbook", 2)
    :book("family_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :batch_discount(83, 4)
    :result_charges(8)
)

content.add(content.Recipe {
    id = "meat_dolmas",
    result = "meat_dolmas",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 8, true)
    :component_any({
            { id = "meat_cooked", count = 1, requirement = true },
            { id = "dry_meat", count = 1 }
        })
    :component_any({
            { id = "rice_cooked", count = 1 },
            { id = "wild_rice_cooked", count = 1 }
        })
    :component_any({
            { id = "burdock_cooked", count = 4 },
            { id = "grape_leaves", count = 4 }
        })
    :component_any({
            { id = "broth", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "broth_bone", count = 1 },
            { id = "broth_meat", count = 1 }
        })
    :component("any_butter_or_oil", 2, true)
    :component_any({
            { id = "onion", count = 1 },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "garlic_clove", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "pepper", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_turkish", 2)
    :result_charges(4)
)
