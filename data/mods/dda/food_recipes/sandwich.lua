local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "fish_sandwich",
    result = "fish_sandwich",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component_any({
            { id = "fish_cooked", count = 1 },
            { id = "fish_fried", count = 1 },
            { id = "fish_scrap_cooked", count = 10 }
        })
    :component("bread_sandwich", 2, true)
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
            { id = "soysauce", count = 1 }
        })
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "lobster_roll",
    result = "lobster_roll",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component_any({
            { id = "lobster_cooked", count = 1 },
            { id = "lobster_cakes", count = 1 }
        })
    :component("bread_sandwich", 2, true)
    :component_any({
            { id = "onion", count = 1 },
            { id = "lemon", count = 1 },
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
            { id = "butter", count = 1 },
            { id = "raw_butter", count = 1 },
            { id = "horseradish", count = 1 },
            { id = "mayonnaise", count = 1 },
            { id = "bacon", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "soysauce", count = 1 }
        })
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "fish_bagel",
    result = "fish_bagel",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :component_any({
            { id = "fish_cooked", count = 1 },
            { id = "can_salmon", count = 1 },
            { id = "fish_scrap_cooked", count = 10 }
        })
    :component("bread_sandwich", 2, true)
    :component("spinach", 1)
    :component("cooking_oil", 1)
    :component("lemon", 1)
    :component("vinegar", 1)
    :component_any({
            { id = "scrambled_eggs", count = 1 },
            { id = "boiled_egg", count = 1 },
            { id = "fried_eggs", count = 1 }
        })
    :quality("CUT", 2, 1)
    :book("family_cookbook", 2)
    :book("mag_cooking", 2)
)

content.add(content.Recipe {
    id = "sandwich_deluxe",
    result = "sandwich_deluxe",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 45000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component_any({
            { id = "meat_cooked", count = 1, requirement = true },
            { id = "scrambled_eggs", count = 2 },
            { id = "boiled_egg", count = 2 },
            { id = "fried_eggs", count = 1 },
            { id = "omelet", count = 1 }
        })
    :component("bread_sandwich", 2, true)
    :component("cheese_standard", 2, true)
    :component_any({
            { id = "veggy_cooked", count = 1 },
            { id = "veggy_wild_cooked", count = 1 },
            { id = "veggy_salted", count = 1 },
            { id = "celery", count = 1 },
            { id = "grape_leaves", count = 1 },
            { id = "cabbage", count = 1 },
            { id = "radish_taproot", count = 1 },
            { id = "sauerkraut", count = 1 },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "pumpkin_cut", count = 1 },
            { id = "onion", count = 1 },
            { id = "broccoli", count = 1 },
            { id = "rehydrated_veggy", count = 1 },
            { id = "rehydrated_corn_kernels", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "morel_cooked", count = 1 },
            { id = "mushroom_cooked", count = 1 },
            { id = "sauerkraut_onions", count = 1 },
            { id = "pickle", count = 1 },
            { id = "veggy_canned", count = 1 },
            { id = "salsa", count = 1 },
            { id = "beans_cooked", count = 1 },
            { id = "carrot", count = 1 },
            { id = "carrot_wild", count = 1 },
            { id = "any_zucchini", count = 1, requirement = true },
            { id = "lettuce", count = 1 },
            { id = "pine_nuts", count = 1 },
            { id = "morel_fried", count = 1 },
            { id = "veggy_aspic", count = 1 },
            { id = "dahlia_baked", count = 1 },
            { id = "any_salad_cucumber", count = 1, requirement = true },
            { id = "any_gherkin_cucumber", count = 1, requirement = true },
            { id = "veggy_pickled", count = 1 },
            { id = "cooked_cattail_stalk", count = 1 },
            { id = "cooked_burdock_stalk", count = 1 },
            { id = "cooked_pumpkin", count = 1 },
            { id = "potato_baked", count = 1 },
            { id = "dandelion_cooked", count = 1 },
            { id = "young_leaves", count = 2 },
            { id = "chicory_leaves", count = 2 },
            { id = "burdock_cooked", count = 1 }
        })
    :component_any({
            { id = "ketchup", count = 1 },
            { id = "barbecue_sauce", count = 1 },
            { id = "honey_mustard", count = 1 },
            { id = "mustard", count = 1 },
            { id = "horseradish", count = 1 },
            { id = "mayonnaise", count = 1 },
            { id = "seasoning_salt", count = 5 },
            { id = "soysauce", count = 1 }
        })
    :quality("CUT", 2, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "sandwich_reuben",
    result = "sandwich_reuben",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 45000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component("meat_red_cooked", 1, true)
    :component("cheese_standard", 2, true)
    :component("bread_sandwich", 2, true)
    :component("sauerkraut", 1)
    :component("ketchup", 1)
    :component("onion", 1)
    :component("horseradish", 1)
    :component("mayonnaise", 1)
    :component("seasoning_salt", 5)
    :component("hot_sauce", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "blt",
    result = "blt",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("bacon", 1)
    :component_any({
            { id = "lettuce", count = 1 },
            { id = "young_leaves", count = 2 },
            { id = "chicory_leaves", count = 2 }
        })
    :component("any_tomato", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "sandwich_t",
    result = "sandwich_t",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("meat_cooked", 1, true)
    :quality("CUT", 2, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "sandwich_pb",
    result = "sandwich_pb",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("any_peanutbutter", 1, true)
)

content.add(content.Recipe {
    id = "sandwich_pbj",
    result = "sandwich_pbj",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("jam_fruit", 1)
    :component("any_peanutbutter", 1, true)
)

content.add(content.Recipe {
    id = "sandwich_pbh",
    result = "sandwich_pbh",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component_any({
            { id = "honey_bottled", count = 3 },
            { id = "honey_glassed", count = 1 }
        })
    :component("any_peanutbutter", 1, true)
)

content.add(content.Recipe {
    id = "sandwich_pbm",
    result = "sandwich_pbm",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("syrup", 1)
    :component("any_peanutbutter", 1, true)
)

content.add(content.Recipe {
    id = "sandwich_fairy",
    result = "sandwich_fairy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
}
    :component("bread_sandwich", 1, true)
    :component("any_butter", 1, true)
    :component("sprinkles", 3)
    :book("mag_glam", 1)
)

content.add(content.Recipe {
    id = "sandwich_veggy_cheese",
    result = "sandwich_veggy_cheese",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("cheese_standard", 1, true)
    :component_any({
            { id = "veggy_cooked", count = 1 },
            { id = "veggy_wild_cooked", count = 1 },
            { id = "veggy_salted", count = 1 },
            { id = "celery", count = 1 },
            { id = "grape_leaves", count = 1 },
            { id = "radish_taproot", count = 1 },
            { id = "cabbage", count = 1 },
            { id = "sauerkraut", count = 1 },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "pumpkin_cut", count = 1 },
            { id = "onion", count = 1 },
            { id = "broccoli", count = 1 },
            { id = "rehydrated_veggy", count = 1 },
            { id = "rehydrated_corn_kernels", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "morel_cooked", count = 1 },
            { id = "mushroom_cooked", count = 1 },
            { id = "sauerkraut_onions", count = 1 },
            { id = "pickle", count = 1 },
            { id = "veggy_canned", count = 1 },
            { id = "beans_cooked", count = 1 },
            { id = "carrot", count = 1 },
            { id = "any_zucchini", count = 1, requirement = true },
            { id = "lettuce", count = 1 },
            { id = "pine_nuts", count = 1 },
            { id = "morel_fried", count = 1 },
            { id = "veggy_aspic", count = 1 },
            { id = "dahlia_baked", count = 1 },
            { id = "any_salad_cucumber", count = 1, requirement = true },
            { id = "veggy_pickled", count = 1 },
            { id = "cooked_cattail_stalk", count = 1 },
            { id = "cooked_burdock_stalk", count = 1 },
            { id = "cooked_pumpkin", count = 1 },
            { id = "potato_baked", count = 1 },
            { id = "dandelion_cooked", count = 1 },
            { id = "young_leaves", count = 2 },
            { id = "chicory_leaves", count = 2 },
            { id = "wild_garlic", count = 1 },
            { id = "burdock_cooked", count = 1 }
        })
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "sandwich_veggy",
    result = "sandwich_veggy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component_any({
            { id = "veggy_cooked", count = 1 },
            { id = "veggy_wild_cooked", count = 1 },
            { id = "veggy_salted", count = 1 },
            { id = "celery", count = 1 },
            { id = "grape_leaves", count = 1 },
            { id = "radish_taproot", count = 1 },
            { id = "cabbage", count = 1 },
            { id = "sauerkraut", count = 1 },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "pumpkin_cut", count = 1 },
            { id = "onion", count = 1 },
            { id = "broccoli", count = 1 },
            { id = "rehydrated_veggy", count = 1 },
            { id = "rehydrated_corn_kernels", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "morel_cooked", count = 1 },
            { id = "mushroom_cooked", count = 1 },
            { id = "sauerkraut_onions", count = 1 },
            { id = "pickle", count = 1 },
            { id = "veggy_canned", count = 1 },
            { id = "salsa", count = 1 },
            { id = "beans_cooked", count = 1 },
            { id = "carrot", count = 1 },
            { id = "carrot_wild", count = 1 },
            { id = "any_zucchini", count = 1, requirement = true },
            { id = "lettuce", count = 1 },
            { id = "pine_nuts", count = 1 },
            { id = "morel_fried", count = 1 },
            { id = "veggy_aspic", count = 1 },
            { id = "dahlia_baked", count = 1 },
            { id = "any_salad_cucumber", count = 1, requirement = true },
            { id = "veggy_pickled", count = 1 },
            { id = "cooked_cattail_stalk", count = 1 },
            { id = "cooked_burdock_stalk", count = 1 },
            { id = "cooked_pumpkin", count = 1 },
            { id = "potato_baked", count = 1 },
            { id = "dandelion_cooked", count = 1 },
            { id = "young_leaves", count = 2 },
            { id = "chicory_leaves", count = 2 },
            { id = "wild_garlic", count = 1 },
            { id = "burdock_cooked", count = 1 }
        })
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "sandwich_cucumber",
    result = "sandwich_cucumber",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("any_salad_cucumber", 1, true)
    :component_any({
            { id = "mayonnaise", count = 1 },
            { id = "mustard", count = 1 },
            { id = "horseradish", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "sandwich_sauce",
    result = "sandwich_sauce",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component_any({
            { id = "cooking_oil", count = 1 },
            { id = "edible_tallow", count = 2, requirement = true },
            { id = "mayonnaise", count = 1 },
            { id = "ketchup", count = 1 },
            { id = "barbecue_sauce", count = 1 },
            { id = "honey_mustard", count = 1 },
            { id = "sauce_pesto", count = 1 },
            { id = "sauce_red", count = 1 },
            { id = "mustard", count = 1 },
            { id = "any_butter", count = 1, requirement = true }
        })
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sandwich_jam",
    result = "sandwich_jam",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("jam_fruit", 1)
)

content.add(content.Recipe {
    id = "sandwich_jam_cheese",
    result = "sandwich_jam_cheese",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("jam_fruit", 1)
    :component("cheese_standard", 1, true)
)

content.add(content.Recipe {
    id = "sandwich_jam_butter",
    result = "sandwich_jam_butter",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("jam_fruit", 1)
    :component("any_butter", 1, true)
)

content.add(content.Recipe {
    id = "sandwich_honey",
    result = "sandwich_honey",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component_any({
            { id = "honey_bottled", count = 3 },
            { id = "honey_glassed", count = 1 }
        })
)

content.add(content.Recipe {
    id = "sandwich_cheese",
    result = "sandwich_cheese",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("cheese_standard", 1, true)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "sandwich_egg_salad",
    result = "sandwich_egg_salad",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("egg_salad", 2)
    :quality("CUT", 2, 1)
)

-- 1u for each bread slice and 1u for the cheese
content.add(content.Recipe {
    id = "sandwich_cheese_grilled",
    result = "sandwich_cheese_grilled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 3, true)
    :component("sandwich_cheese", 1)
    :quality("COOK", 1, 1)
)

content.add(content.Recipe {
    id = "sandwich_pbf",
    result = "sandwich_pbf",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("bread_sandwich", 2, true)
    :component("marshmallow_fluff", 1)
    :component("any_peanutbutter", 1, true)
)
