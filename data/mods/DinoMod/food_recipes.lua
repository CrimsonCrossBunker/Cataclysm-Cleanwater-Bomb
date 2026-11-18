local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "scrambled_eggs_dinosaur",
    result = "scrambled_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 168000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 40, true)
    :component("eggs_dino", 1, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(40)
)

content.add(content.Recipe {
    id = "scrambled_eggs_large dinosaur",
    result = "scrambled_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 312000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 80, true)
    :component("eggs_dino_large", 1, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(80)
)

content.add(content.Recipe {
    id = "fried_eggs_dinosaur",
    result = "fried_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 126000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 40, true)
    :component("eggs_dino", 1, true)
    :component("any_butter_or_oil", 40, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "fried_eggs_large dinosaur",
    result = "fried_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 222000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 80, true)
    :component("eggs_dino_large", 1, true)
    :component("any_butter_or_oil", 80, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(40)
)

content.add(content.Recipe {
    id = "fried_egg_sandwich_dinosaur",
    result = "fried_egg_sandwich",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 168000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 40, true)
    :component("eggs_dino", 1, true)
    :component("any_butter_or_oil", 40, true)
    :component("bread_sandwich", 40, true)
    :component("condiment", 40, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "deluxe_fried_egg_sandwich_dinosaur",
    result = "deluxe_fried_egg_sandwich",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 228000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 40, true)
    :component("eggs_dino", 1, true)
    :component("any_butter_or_oil", 40, true)
    :component_any({
            { id = "mushroom", count = 20 },
            { id = "mushroom_morel", count = 20 },
            { id = "garlic_clove", count = 20 },
            { id = "onion", count = 20 }
        })
    :component_any({
            { id = "cheese", count = 20 },
            { id = "cheese_hard", count = 20 },
            { id = "can_cheese", count = 20 },
            { id = "veggy_green", count = 20, requirement = true }
        })
    :component_any({
            { id = "salt", count = 40 },
            { id = "soysauce", count = 40 },
            { id = "seasoning_salt", count = 40 },
            { id = "pepper", count = 80 }
        })
    :component("condiment", 40, true)
    :component("bread_sandwich", 40, true)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "boiled_egg_dino_small",
    result = "boiled_egg_dino_small",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 1, true)
    :component("eggs_dino_small", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "boiled_egg_dino",
    result = "boiled_egg_dino",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 300000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 40, true)
    :component("eggs_dino", 1, true)
    :component_any({
            { id = "water", count = 40 },
            { id = "water_clean", count = 40 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "boiled_egg_dino_large",
    result = "boiled_egg_dino_large",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 80, true)
    :component("eggs_dino_large", 1, true)
    :component_any({
            { id = "water", count = 80 },
            { id = "water_clean", count = 80 }
        })
    :quality("BOIL", 2, 1)
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "deluxe_eggs_dinosaur",
    result = "deluxe_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 40, true)
    :component("eggs_dino", 1, true)
    :component("meat_cooked", 20, true)
    :quality("COOK", 2, 1)
    :result_charges(60)
)

content.add(content.Recipe {
    id = "pancakes_dinosaur",
    result = "pancakes",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 320, true)
    :component("flour_any", 40, true)
    :component_any({
            { id = "milk_standard_raw", count = 40, requirement = true },
            { id = "milk_powder", count = 40 }
        })
    :component("eggs_dino", 1, true)
    :component("syrup", 40)
    :component("any_butter_or_oil", 40, true)
    :component_any({
            { id = "water", count = 40 },
            { id = "water_clean", count = 40 }
        })
    :quality("COOK", 2, 1)
    :result_charges(160)
)

content.add(content.Recipe {
    id = "fruit_pancakes_dinosaur",
    result = "fruit_pancakes",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 320, true)
    :component("flour_any", 40, true)
    :component_any({
            { id = "milk_standard_raw", count = 40, requirement = true },
            { id = "milk_powder", count = 40 }
        })
    :component("eggs_dino", 1, true)
    :component("syrup", 40)
    :component("any_butter_or_oil", 40, true)
    :component_any({
            { id = "water", count = 40 },
            { id = "water_clean", count = 40 }
        })
    :component_any({
            { id = "sweet_fruit_like", count = 40, requirement = true },
            { id = "jam_fruit", count = 40 }
        })
    :quality("COOK", 2, 1)
    :result_charges(40)
)

content.add(content.Recipe {
    id = "choc_pancakes_dinosaur",
    result = "choc_pancakes",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 320, true)
    :component("flour_any", 40, true)
    :component_any({
            { id = "milk_standard_raw", count = 40, requirement = true },
            { id = "milk_powder", count = 40 }
        })
    :component("eggs_dino", 1, true)
    :component("syrup", 40)
    :component("any_butter_or_oil", 40, true)
    :component_any({
            { id = "water", count = 40 },
            { id = "water_clean", count = 40 }
        })
    :component_any({
            { id = "chocolate", count = 40 },
            { id = "choc_drink", count = 80 }
        })
    :quality("COOK", 2, 1)
    :result_charges(40)
)

content.add(content.Recipe {
    id = "frenchtoast_dinosaur",
    result = "frenchtoast",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 320, true)
    :component("milk_standard_raw", 40, true)
    :component("eggs_dino", 1, true)
    :component("cinnamon", 80)
    :component("bread_sandwich", 80, true)
    :quality("COOK", 2, 1)
    :result_charges(120)
)

content.add(content.Recipe {
    id = "waffles_dinosaur",
    result = "waffles",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 320, true)
    :tool("waffleiron", 1)
    :component("flour_any", 40, true)
    :component_any({
            { id = "milk_standard_raw", count = 40, requirement = true },
            { id = "milk_powder", count = 40 }
        })
    :component("eggs_dino", 1, true)
    :component("syrup", 40)
    :component_any({
            { id = "sugar", count = 80 },
            { id = "artificial_sweetener", count = 80 }
        })
    :component("any_butter_or_oil", 40, true)
    :component_any({
            { id = "water", count = 40 },
            { id = "water_clean", count = 40 }
        })
    :result_charges(40)
)

content.add(content.Recipe {
    id = "fruit_waffles_dinosaur",
    result = "fruit_waffles",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 320, true)
    :tool("waffleiron", 1)
    :component("flour_any", 40, true)
    :component_any({
            { id = "milk_standard_raw", count = 40, requirement = true },
            { id = "milk_powder", count = 40 }
        })
    :component("eggs_dino", 1, true)
    :component("syrup", 40)
    :component_any({
            { id = "sugar", count = 80 },
            { id = "artificial_sweetener", count = 80 }
        })
    :component("any_butter_or_oil", 40, true)
    :component_any({
            { id = "water", count = 40 },
            { id = "water_clean", count = 40 }
        })
    :component_any({
            { id = "sweet_fruit_like", count = 40, requirement = true },
            { id = "jam_fruit", count = 40 }
        })
    :result_charges(40)
)

content.add(content.Recipe {
    id = "choc_waffles_dinosaur",
    result = "choc_waffles",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 320, true)
    :tool("waffleiron", 1)
    :component("flour_any", 40, true)
    :component_any({
            { id = "milk_standard_raw", count = 40, requirement = true },
            { id = "milk_powder", count = 40 }
        })
    :component("eggs_dino", 1, true)
    :component("syrup", 40)
    :component_any({
            { id = "sugar", count = 80 },
            { id = "artificial_sweetener", count = 80 }
        })
    :component("any_butter_or_oil", 40, true)
    :component_any({
            { id = "water", count = 40 },
            { id = "water_clean", count = 40 }
        })
    :component_any({
            { id = "chocolate", count = 40 },
            { id = "choc_drink", count = 80 }
        })
    :result_charges(40)
)

content.add(content.Recipe {
    id = "powder_eggs_dinosaur",
    result = "powder_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "dehydrator", charges = 60 },
            { id = "char_smoker", charges = 60 }
        })
    :component("eggs_dino", 1, true)
    :batch_discount(67, 5)
    :result_charges(90)
)

content.add(content.Recipe {
    id = "powder_eggs_frozen_dino_ingredients",
    result = "powder_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 204000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "dehydrator", charges = 60 },
            { id = "char_smoker", charges = 60 }
        })
    :tool_charges("surface_heat", 15, true)
    :component("eggs_dino", 1, true)
    :batch_discount(67, 5)
    :result_charges(90)
)

content.add(content.Recipe {
    id = "powder_eggs_large dinosaur",
    result = "powder_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "dehydrator", charges = 140 },
            { id = "char_smoker", charges = 140 }
        })
    :component("eggs_dino_large", 1, true)
    :batch_discount(67, 5)
    :result_charges(490)
)

content.add(content.Recipe {
    id = "powder_eggs_frozen_lg_dino_ingredients",
    result = "powder_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "dehydrator", charges = 140 },
            { id = "char_smoker", charges = 140 }
        })
    :tool_charges("surface_heat", 35, true)
    :component("eggs_dino_large", 1, true)
    :batch_discount(67, 5)
    :result_charges(490)
)

content.add(content.Recipe {
    id = "stewed_tripe_sauropod",
    result = "stewed_tripe",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 1320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 100, true)
    :component("sauropod_stomach_boiled", 1)
    :component_any({
            { id = "water", count = 16 },
            { id = "water_clean", count = 16 }
        })
    :component_any({
            { id = "veggy_any", count = 8, requirement = true },
            { id = "powder_eggs", count = 8 },
            { id = "eggs_bird", count = 8, requirement = true },
            { id = "eggs_reptile", count = 8, requirement = true },
            { id = "mushroom_cooked", count = 8 },
            { id = "morel_cooked", count = 8 },
            { id = "mushroom", count = 8 },
            { id = "dry_mushroom", count = 8 }
        })
    :component_any({
            { id = "seasoning_italian", count = 24 },
            { id = "wild_herbs", count = 24 },
            { id = "seasoning_salt", count = 8 },
            { id = "soysauce", count = 8 },
            { id = "pepper", count = 8 },
            { id = "garlic_clove", count = 8 },
            { id = "salt_water", count = 8 },
            { id = "salt", count = 8 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requires_skill("survival", 2)
    :book("cookbook", 1)
    :book("scots_cookbook", 2)
    :result_charges(32)
    :byproduct("broth", 16)
)

content.add(content.Recipe {
    id = "sausage_casings_sauropod",
    result = "sausage_casings",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :component("stomach_sauropod", 1)
    :component("salt", 80)
    :component_any({
            { id = "water", count = 8 },
            { id = "water_clean", count = 8 }
        })
    :quality("COOK", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :book("offalcooking", 3)
    :batch_discount(83, 5)
    :result_charges(960)
    :byproduct("ruined_chunks", 8)
)

content.add(content.Recipe {
    id = "sauropod_stomach_boiled",
    result = "sauropod_stomach_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 150000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 7, true)
    :component("stomach_sauropod", 1)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("BOIL", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "haggis_sauropod",
    result = "haggis",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 660000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :component("stomach_sauropod", 1)
    :component("meat_offal", 4, true)
    :component_any({
            { id = "oatmeal", count = 16 },
            { id = "buckwheat", count = 4 }
        })
    :quality("BOIL", 1, 1)
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :requirement("sewing_standard", 4)
    :requires_skill("tailor", 1)
    :book("survival_book", 6)
    :book("scots_cookbook", 3)
    :batch_discount(50, 4)
    :result_charges(4)
)
