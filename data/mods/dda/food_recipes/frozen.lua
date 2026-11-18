local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "milkshake",
    result = "milkshake",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 },
            { id = "can_coconut", count = 1 }
        })
    :component_any({
            { id = "chocolate", count = 1 },
            { id = "peanutbutter", count = 2 },
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "candy", count = 1 },
            { id = "candy2", count = 1 },
            { id = "candy3", count = 1 },
            { id = "maple_candy", count = 1 },
            { id = "strawberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "prickly_pear_fruit", count = 1 },
            { id = "saguaro_fruit", count = 2 },
            { id = "wintergreen_berry", count = 4 },
            { id = "blackberries", count = 1 },
            { id = "cherries", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 10 },
            { id = "artificial_sweetener", count = 10 }
        })
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
)

content.add(content.Recipe {
    id = "milkshake_choc",
    result = "milkshake_choc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component("milk_choc", 1)
    :component_any({
            { id = "chocolate", count = 1 },
            { id = "peanutbutter", count = 2 },
            { id = "candy", count = 1 },
            { id = "candy2", count = 1 },
            { id = "candy3", count = 1 },
            { id = "maple_candy", count = 1 },
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "strawberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "prickly_pear_fruit", count = 1 },
            { id = "saguaro_fruit", count = 2 },
            { id = "wintergreen_berry", count = 4 },
            { id = "blackberries", count = 1 },
            { id = "cherries", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 10 },
            { id = "artificial_sweetener", count = 10 }
        })
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
)

content.add(content.Recipe {
    id = "milkshake_deluxe",
    result = "milkshake_deluxe",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 75000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :component_any({
            { id = "chocolate", count = 2 },
            { id = "peanutbutter", count = 2 },
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "candy", count = 2 },
            { id = "candy2", count = 2 },
            { id = "candy3", count = 2 },
            { id = "maple_candy", count = 2 },
            { id = "syrup", count = 2 },
            { id = "strawberries", count = 2 },
            { id = "blueberries", count = 2 },
            { id = "wintergreen_berry", count = 4 },
            { id = "blackberries", count = 2 },
            { id = "cherries", count = 2 }
        })
    :component_any({
            { id = "sugar", count = 20 },
            { id = "artificial_sweetener", count = 20 }
        })
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
)

content.add(content.Recipe {
    id = "milkshake_deluxe_choc",
    result = "milkshake_deluxe_choc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 75000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component("milk_choc", 1)
    :component_any({
            { id = "chocolate", count = 2 },
            { id = "peanutbutter", count = 2 },
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "candy", count = 2 },
            { id = "candy2", count = 2 },
            { id = "candy3", count = 2 },
            { id = "maple_candy", count = 2 },
            { id = "syrup", count = 2 },
            { id = "strawberries", count = 2 },
            { id = "blueberries", count = 2 },
            { id = "wintergreen_berry", count = 4 },
            { id = "blackberries", count = 2 },
            { id = "cherries", count = 2 }
        })
    :component_any({
            { id = "sugar", count = 20 },
            { id = "artificial_sweetener", count = 20 }
        })
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
)

content.add(content.Recipe {
    id = "frozen_lemonade",
    result = "frozen_lemonade",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component("lemon", 1)
    :component("lemonade", 1)
    :component_any({
            { id = "sugar", count = 10 },
            { id = "artificial_sweetener", count = 10 }
        })
    :component("water_clean", 1)
    :quality("COOK", 3, 1)
)

content.add(content.Recipe {
    id = "snowcone",
    result = "snowcone",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("water_clean", 2)
    :component_any({
            { id = "sweet_juice", count = 1, requirement = true },
            { id = "soda_pop", count = 1, requirement = true },
            { id = "soda_pop_diet", count = 1, requirement = true },
            { id = "can_coconut", count = 1 },
            { id = "chai_tea", count = 1 },
            { id = "chamomile_tea", count = 1 },
            { id = "choc_drink", count = 1 },
            { id = "coconut_water", count = 1 },
            { id = "coffee", count = 1 },
            { id = "dandelion_tea", count = 1 },
            { id = "dandelionburdock_tea", count = 1 },
            { id = "drink_pinitacolada", count = 1 },
            { id = "foodplace_zero_drink", count = 1 },
            { id = "grapeade", count = 1 },
            { id = "grenadine_syrup", count = 1 },
            { id = "herbal_tea", count = 1 },
            { id = "lotus_tea", count = 1 },
            { id = "milk_tea", count = 1 },
            { id = "orangeade", count = 1 },
            { id = "pine_tea", count = 1 },
            { id = "pineapple_juice", count = 1 },
            { id = "rootbeer_brewed", count = 1 },
            { id = "sparkling_peach", count = 1 },
            { id = "sparkling_pomegranate", count = 1 },
            { id = "spurge_tea", count = 1 },
            { id = "sweet_water", count = 1 },
            { id = "syrup", count = 1 },
            { id = "syrup_simple", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "tea", count = 1 },
            { id = "tea_bark", count = 1 },
            { id = "tea_fruit", count = 1 },
            { id = "tea_green", count = 1 },
            { id = "tea_willowbark", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("SNOW_MAKING", 1, 1)
    :result_charges(3)
)

-- Do not add fruit wine/player crafted wine to this component list, it will break the contextual naming
-- I also did not add beers/ales/etc. to this list because one it would be disgusting, and two because of how
-- weak those beverages are in terms of alcohol it would not make sense with the resulting alcohol content of
-- the snow cone.
content.add(content.Recipe {
    id = "snowcone_alcoholic",
    result = "snowcone_alcoholic",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("water_clean", 2)
    :component_any({
            { id = "sweet_juice", count = 1, requirement = true },
            { id = "soda_pop_diet", count = 1, requirement = true },
            { id = "can_coconut", count = 1 },
            { id = "chai_tea", count = 1 },
            { id = "chamomile_tea", count = 1 },
            { id = "choc_drink", count = 1 },
            { id = "coconut_water", count = 1 },
            { id = "coffee", count = 1 },
            { id = "soda_pop", count = 1, requirement = true },
            { id = "dandelion_tea", count = 1 },
            { id = "dandelionburdock_tea", count = 1 },
            { id = "drink_pinitacolada", count = 1 },
            { id = "foodplace_zero_drink", count = 1 },
            { id = "grapeade", count = 1 },
            { id = "grenadine_syrup", count = 1 },
            { id = "herbal_tea", count = 1 },
            { id = "lotus_tea", count = 1 },
            { id = "milk_tea", count = 1 },
            { id = "orangeade", count = 1 },
            { id = "pine_tea", count = 1 },
            { id = "pineapple_juice", count = 1 },
            { id = "rootbeer_brewed", count = 1 },
            { id = "sparkling_peach", count = 1 },
            { id = "sparkling_pomegranate", count = 1 },
            { id = "spurge_tea", count = 1 },
            { id = "sweet_water", count = 1 },
            { id = "syrup", count = 1 },
            { id = "syrup_simple", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "tea", count = 1 },
            { id = "tea_bark", count = 1 },
            { id = "tea_fruit", count = 1 },
            { id = "tea_green", count = 1 },
            { id = "tea_willowbark", count = 1 }
        })
    :component_any({
            { id = "brandy", count = 1 },
            { id = "bristol_sherry", count = 1 },
            { id = "bum_wine", count = 1 },
            { id = "burdock_wine", count = 1 },
            { id = "canadian_whiskey", count = 1 },
            { id = "cheap_whiskey", count = 1 },
            { id = "gin", count = 1 },
            { id = "madeira", count = 1 },
            { id = "moonshine", count = 1 },
            { id = "pine_wine", count = 1 },
            { id = "sake_filtered", count = 1 },
            { id = "sake_unfiltered", count = 1 },
            { id = "rum", count = 1 },
            { id = "sherry", count = 1 },
            { id = "single_malt_whiskey", count = 1 },
            { id = "single_pot_whiskey", count = 1 },
            { id = "tequila", count = 1 },
            { id = "triple_sec", count = 1 },
            { id = "vodka", count = 1 },
            { id = "whiskey", count = 1 },
            { id = "wine_cabernet", count = 1 },
            { id = "wine_chardonnay", count = 1 },
            { id = "wine_marsala", count = 1 },
            { id = "wine_noir", count = 1 },
            { id = "wine_riesling", count = 1 },
            { id = "wine_vermouth", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("SNOW_MAKING", 1, 1)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "icecream",
    result = "icecream",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component("milk_standard", 2, true)
    :component_any({
            { id = "chocolate", count = 1 },
            { id = "peanutbutter", count = 1 },
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "candy", count = 1 },
            { id = "candy2", count = 1 },
            { id = "candy3", count = 1 },
            { id = "candy4", count = 1 },
            { id = "candy5", count = 1 },
            { id = "candy3gator", count = 1 },
            { id = "cow_candy", count = 1 },
            { id = "marshmallow", count = 1 },
            { id = "maple_candy", count = 1 },
            { id = "strawberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "prickly_pear_fruit", count = 1 },
            { id = "saguaro_fruit", count = 2 },
            { id = "wintergreen_berry", count = 4 },
            { id = "blackberries", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 20 },
            { id = "artificial_sweetener", count = 20 }
        })
    :quality("COOK", 3, 1)
    :book("dairy_book", 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "icecream_choc",
    result = "icecream_choc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component("milk_choc", 2)
    :component_any({
            { id = "chocolate", count = 1 },
            { id = "peanutbutter", count = 1 },
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "candy", count = 1 },
            { id = "candy2", count = 1 },
            { id = "candy3", count = 1 },
            { id = "candy4", count = 1 },
            { id = "candy5", count = 1 },
            { id = "candy3gator", count = 1 },
            { id = "cow_candy", count = 1 },
            { id = "sprinkles", count = 2 },
            { id = "marshmallow", count = 1 },
            { id = "maple_candy", count = 1 },
            { id = "strawberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "prickly_pear_fruit", count = 1 },
            { id = "saguaro_fruit", count = 2 },
            { id = "wintergreen_berry", count = 4 },
            { id = "blackberries", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 20 },
            { id = "artificial_sweetener", count = 20 }
        })
    :quality("COOK", 3, 1)
    :book("dairy_book", 2)
    :result_charges(2)
)

-- in real life, you can use some plastic bags with the correct materials and shake up to make ice cream!
content.add(content.Recipe {
    id = "icecream_from_bags",
    result = "icecream",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
}
    :tool("bag_plastic", 1)
    :component("water_clean", 2)
    :component("milk_standard", 2, true)
    :component_any({
            { id = "chocolate", count = 1 },
            { id = "peanutbutter", count = 1 },
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "candy", count = 1 },
            { id = "candy2", count = 1 },
            { id = "candy3", count = 1 },
            { id = "candy4", count = 1 },
            { id = "candy5", count = 1 },
            { id = "candy3gator", count = 1 },
            { id = "cow_candy", count = 1 },
            { id = "marshmallow", count = 1 },
            { id = "maple_candy", count = 1 },
            { id = "strawberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "prickly_pear_fruit", count = 1 },
            { id = "saguaro_fruit", count = 2 },
            { id = "wintergreen_berry", count = 4 },
            { id = "blackberries", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 20 },
            { id = "artificial_sweetener", count = 20 }
        })
    :component("salt", 5)
    :book("mag_cooking", 0)
    :result_charges(2)
)

-- in real life, you can use some plastic bags with the correct materials and shake up to make ice cream!
content.add(content.Recipe {
    id = "icecream_choc_from_bags",
    result = "icecream_choc",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
}
    :tool("bag_plastic", 1)
    :component("water_clean", 2)
    :component("milk_choc", 2)
    :component_any({
            { id = "chocolate", count = 1 },
            { id = "peanutbutter", count = 1 },
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "candy", count = 1 },
            { id = "candy2", count = 1 },
            { id = "candy3", count = 1 },
            { id = "candy4", count = 1 },
            { id = "candy5", count = 1 },
            { id = "candy3gator", count = 1 },
            { id = "cow_candy", count = 1 },
            { id = "sprinkles", count = 2 },
            { id = "marshmallow", count = 1 },
            { id = "maple_candy", count = 1 },
            { id = "strawberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "prickly_pear_fruit", count = 1 },
            { id = "saguaro_fruit", count = 2 },
            { id = "wintergreen_berry", count = 4 },
            { id = "blackberries", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 20 },
            { id = "artificial_sweetener", count = 20 }
        })
    :component("salt", 5)
    :book("mag_cooking", 0)
    :result_charges(2)
)

-- On the other hand, why make base ice cream with candy, then add even more candy?
content.add(content.Recipe {
    id = "icecream_candy",
    result = "icecream_candy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component_any({
            { id = "icecream", count = 1 },
            { id = "icecream_artificial", count = 1 }
        })
    :component_any({
            { id = "chocolate", count = 1 },
            { id = "candy", count = 1 },
            { id = "candy2", count = 1 },
            { id = "candy3", count = 1 },
            { id = "candy4", count = 1 },
            { id = "candy5", count = 1 },
            { id = "candy3gator", count = 1 },
            { id = "cow_candy", count = 1 },
            { id = "sprinkles", count = 2 },
            { id = "marshmallow", count = 1 },
            { id = "maple_candy", count = 1 },
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 5 },
            { id = "artificial_sweetener", count = 5 }
        })
    :result_charges(2)
)

content.add(content.Recipe {
    id = "icecream_fruit",
    result = "icecream_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component_any({
            { id = "icecream", count = 1 },
            { id = "icecream_artificial", count = 1 }
        })
    :component_any({
            { id = "sweet_fruit_like", count = 1, requirement = true },
            { id = "jam_fruit", count = 1 }
        })
    :result_charges(2)
)

content.add(content.Recipe {
    id = "icecream_custard",
    result = "icecream_custard",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component_any({
            { id = "milk_standard", count = 2, requirement = true },
            { id = "lf_milk_standard", count = 2, requirement = true }
        })
    :component_any({
            { id = "chocolate", count = 1 },
            { id = "peanutbutter", count = 1 },
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "candy", count = 1 },
            { id = "candy2", count = 1 },
            { id = "candy3", count = 1 },
            { id = "candy4", count = 1 },
            { id = "candy5", count = 1 },
            { id = "candy3gator", count = 1 },
            { id = "cow_candy", count = 1 },
            { id = "sprinkles", count = 2 },
            { id = "marshmallow", count = 1 },
            { id = "maple_candy", count = 1 },
            { id = "strawberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "prickly_pear_fruit", count = 1 },
            { id = "saguaro_fruit", count = 2 },
            { id = "wintergreen_berry", count = 4 },
            { id = "blackberries", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 10 },
            { id = "artificial_sweetener", count = 10 }
        })
    :component_any({
            { id = "powder_eggs", count = 5 },
            { id = "eggs_bird", count = 1, requirement = true },
            { id = "eggs_reptile", count = 1, requirement = true }
        })
    :quality("COOK", 3, 1)
    :book("dairy_book", 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "icecream_yogurt",
    result = "icecream_yogurt",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component("yoghurt", 1)
    :component_any({
            { id = "sugar", count = 5 },
            { id = "artificial_sweetener", count = 5 }
        })
    :quality("COOK", 3, 1)
    :book("dairy_book", 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "icecream_sorbet",
    result = "icecream_sorbet",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "kompot", count = 1 }
        })
    :component("sweet_juice", 1, true)
    :component_any({
            { id = "sugar", count = 5 },
            { id = "artificial_sweetener", count = 5 }
        })
    :quality("COOK", 2, 1)
    :book("dairy_book", 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "icecream_gelato",
    result = "icecream_gelato",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component("milk_standard", 1, true)
    :component_any({
            { id = "chocolate", count = 1 },
            { id = "peanutbutter", count = 1 },
            { id = "syrup", count = 1 },
            { id = "syrup_corn", count = 1 },
            { id = "candy", count = 1 },
            { id = "candy2", count = 1 },
            { id = "candy3", count = 1 },
            { id = "candy4", count = 1 },
            { id = "candy5", count = 1 },
            { id = "candy3gator", count = 1 },
            { id = "cow_candy", count = 1 },
            { id = "marshmallow", count = 1 },
            { id = "maple_candy", count = 1 },
            { id = "strawberries", count = 1 },
            { id = "blueberries", count = 1 },
            { id = "prickly_pear_fruit", count = 1 },
            { id = "saguaro_fruit", count = 2 },
            { id = "wintergreen_berry", count = 4 },
            { id = "blackberries", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 15 },
            { id = "artificial_sweetener", count = 15 }
        })
    :quality("COOK", 3, 1)
    :book("cookbook_italian", 1)
    :result_charges(2)
)
