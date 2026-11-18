local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

-- Oil extraction yield is around ~40% by weight, 600g input ~> 250 mL oil
content.add(content.Recipe {
    id = "cooking_oil",
    result = "cooking_oil",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "oil_press_manual", charges = 50 },
            { id = "oil_press_primitive", charges = 50 }
        })
    :component_any({
            { id = "almond_shelled", count = 20 },
            { id = "peanut_shelled", count = 20 },
            { id = "walnut_shelled", count = 20 },
            { id = "butternut_shelled", count = 20 },
            { id = "pecan_shelled", count = 20 },
            { id = "hazelnut_shelled", count = 20 },
            { id = "pistachio_shelled", count = 20 },
            { id = "hickory_nut_shelled", count = 20 },
            { id = "acorns_blanched", count = 20 },
            { id = "cashews", count = 20 },
            { id = "beech_nuts", count = 20 },
            { id = "soybean", count = 10 },
            { id = "seed_cotton_boll", count = 20 },
            { id = "seed_pumpkin", count = 20 },
            { id = "seed_sunflower", count = 20 },
            { id = "seed_canola", count = 5 },
            { id = "seed_grapes", count = 20 },
            { id = "seed_poppy_bud", count = 20 },
            { id = "seed_weed", count = 20 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("BOIL", 1, 1)
    :proficiency("prof_food_prep")
    :result_charges(16)
    :byproduct("press_cake", 1)
)

-- capacity: 50kg/hour * 40% efficiency = 20 L/hour -> 45s / 250 mL
-- 45 s * 5.5kW = 250 kJ
content.add(content.Recipe {
    id = "cooking_oil_electric",
    result = "cooking_oil",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 4500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("fake_oil_press_industrial", 250)
    :component_any({
            { id = "almond_shelled", count = 20 },
            { id = "peanut_shelled", count = 20 },
            { id = "walnut_shelled", count = 20 },
            { id = "butternut_shelled", count = 20 },
            { id = "pecan_shelled", count = 20 },
            { id = "hazelnut_shelled", count = 20 },
            { id = "pistachio_shelled", count = 20 },
            { id = "hickory_nut_shelled", count = 20 },
            { id = "acorns_blanched", count = 20 },
            { id = "cashews", count = 20 },
            { id = "beech_nuts", count = 20 },
            { id = "soybean", count = 10 },
            { id = "seed_cotton_boll", count = 20 },
            { id = "seed_pumpkin", count = 20 },
            { id = "seed_sunflower", count = 20 },
            { id = "seed_canola", count = 5 },
            { id = "seed_grapes", count = 20 },
            { id = "seed_poppy_bud", count = 20 },
            { id = "seed_weed", count = 20 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("BOIL", 1, 1)
    :proficiency("prof_food_prep")
    :result_charges(16)
    :byproduct("press_cake", 1)
)

-- 5L/h, 7.2kg material for nuts (~120 nuts per pressing), ~2.4+kg (~600 seeds per pressing, much less for
-- cotton, soy) for seeds because of weight missmatches
content.add(content.Recipe {
    id = "cooking_oil_coldpressed",
    result = "cooking_oil",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool("screw_press", 1)
    :component("bag_canvas_small", 5)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :component_any({
            { id = "paste_seed", count = 12 },
            { id = "paste_nut", count = 12 }
        })
    :quality("CONTAIN", 1, 1)
    :proficiency("prof_food_prep")
    :result_charges(160)
    :byproduct("press_cake", 4)
    :byproduct("bag_canvas_small", 5)
)

content.add(content.Recipe {
    id = "mayonnaise",
    result = "mayonnaise",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :component("any_butter_or_oil", 2, true)
    :component("eggs_any_shape", 1, true)
    :component_any({
            { id = "lemon", count = 1 },
            { id = "mustard", count = 1 },
            { id = "horseradish", count = 1 },
            { id = "pickle", count = 1 },
            { id = "veggy_pickled", count = 1 },
            { id = "vinegar", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "pepper", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :book("cookbook", 1)
    :book("mag_cooking", 1)
    :book("cookbook_foodfashions", 1)
    :proficiency("prof_food_prep")
    :result_charges(4)
)

-- need to roast the beans - 3u veggie (6u heat) + the sugar
content.add(content.Recipe {
    id = "coffee_syrup",
    result = "coffee_syrup",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 8, true)
    :component("coffee_raw", 3)
    :component("sugar_standard", 2, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 3, 1)
    :proficiency("prof_food_prep")
    :batch_discount(60, 3)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "ketchup",
    result = "ketchup",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 108000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :component_any({
            { id = "any_tomato", count = 1, requirement = true },
            { id = "autumn_olive", count = 1 }
        })
    :component_any({
            { id = "salt", count = 2 },
            { id = "salt_water", count = 1 },
            { id = "saline", count = 2 },
            { id = "seasoning_salt", count = 2 },
            { id = "soysauce", count = 1 }
        })
    :component("vinegar", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :batch_discount(67, 5)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "barbecue_sauce",
    result = "barbecue_sauce",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component("ketchup", 2)
    :component("seasoning_mild", 2, true)
    :component("sugar_standard", 1, true)
    :component("vinegar", 1)
    :quality("COOK", 2, 1)
    :batch_discount(40, 5)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "honey_mustard",
    result = "honey_mustard",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 42000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :component_any({
            { id = "honey_bottled", count = 1 },
            { id = "honeycomb", count = 1 },
            { id = "honey_glassed", count = 1 }
        })
    :component("mustard", 2)
    :component("vinegar", 1)
    :component("mayonnaise", 1)
    :component("seasoning_mild", 1, true)
    :quality("CONTAIN", 1, 1)
    :book("cookbook", 1)
    :book("mag_cooking", 1)
    :book("cookbook_foodfashions", 1)
    :proficiency("prof_food_prep")
    :batch_discount(40, 5)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "vinegar",
    result = "vinegar",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
}
    :component("chem_acetic_acid", 1)
    :component("water_clean", 9)
    :book("vinegar_maker", 1)
    :result_charges(160)
)

content.add(content.Recipe {
    id = "honey_bottled",
    result = "honey_bottled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("honeycomb", 1)
    :quality("CUT", 2, 1)
    :quality("STRAIN", 2, 1)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "honey_bottled_from_honey_glassed",
    result = "honey_bottled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("honey_glassed", 5)
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :batch_discount(80, 4)
    :result_charges(15)
)

-- 1u water + 1u tomato boils and reduces for 45 min = 2u + 6u
content.add(content.Recipe {
    id = "sauce_red",
    result = "sauce_red",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 8, true)
    :component("any_tomato", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :quality("BOIL", 1, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "horseradish",
    result = "horseradish",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("horseradish_root", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 4 },
            { id = "artificial_sweetener", count = 4 }
        })
    :component("water_clean", 1)
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("CUT", 2, 1)
    :batch_discount(67, 5)
    :result_charges(8)
)

content.add(content.Recipe {
    id = "mustard",
    result = "mustard",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 108000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :component("mustard_powder", 20)
    :component_any({
            { id = "salt", count = 2 },
            { id = "seasoning_salt", count = 2 }
        })
    :component("vinegar", 1)
    :component_any({
            { id = "sugar", count = 1 },
            { id = "artificial_sweetener", count = 1 }
        })
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(67, 5)
    :result_charges(2)
)
