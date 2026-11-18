local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "salt_distill_salt_water",
    result = "salt",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 1200000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
}
    :tool_charges("water_boiling_heat", 35, true)
    :component("salt_water", 5)
    :quality("BOIL", 1, 1)
    :quality("DISTILL", 2, 1)
    :proficiency("prof_distilling")
    :batch_discount(80, 4)
    :result_charges(50)
    :byproduct("water_clean", 4)
)

-- Too simple for any chemistry knowledge. No actual chemical reactions present.
-- additional 6u of water_boiling_heat to turn 1u water into vapor
content.add(content.Recipe {
    id = "salt_from_mineral",
    result = "salt",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
}
    :tool_charges("water_boiling_heat", 7, true)
    :component("material_rocksalt", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
    :result_charges(100)
)

-- 2u for fruit/sugar, 1u for other stuff.
content.add(content.Recipe {
    id = "seasoning_salt",
    result = "seasoning_salt",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 3, true)
    :component("salt", 50)
    :component_any({
            { id = "sugar_standard", count = 2, requirement = true },
            { id = "honeycomb", count = 1 },
            { id = "rehydrated_fruit", count = 2 },
            { id = "dry_fruit", count = 2 },
            { id = "juice_pulp", count = 4 }
        })
    :component_any({
            { id = "seasoning_italian", count = 20 },
            { id = "wild_herbs", count = 20 },
            { id = "pepper", count = 20 },
            { id = "cinnamon", count = 20 },
            { id = "chilly-p", count = 20 },
            { id = "curry_powder", count = 20 },
            { id = "mustard_powder", count = 20 },
            { id = "garlic_powder", count = 20 },
            { id = "garlic_clove", count = 6 },
            { id = "rehydrated_garlic", count = 6 },
            { id = "wild_garlic", count = 3 },
            { id = "rehydrated_veggy", count = 1 },
            { id = "rehydrated_corn_kernels", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "dry_mushroom", count = 1 },
            { id = "dry_veggy", count = 1 },
            { id = "dry_corn", count = 1 }
        })
    :quality("COOK", 2, 1)
    :book("cookbook_mexican", 2)
    :batch_discount(80, 2)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "seasoning_italian",
    result = "seasoning_italian",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 1, true)
    :component("salt", 10)
    :component_any({
            { id = "garlic_clove", count = 3 },
            { id = "rehydrated_garlic", count = 3 },
            { id = "garlic_powder", count = 20 }
        })
    :component("thyme", 1)
    :component("wild_herbs", 100)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_italian", 2)
    :batch_discount(80, 4)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "salt",
    result = "salt",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 288000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 10, true)
    :component("lye_powder", 190)
    :component("chem_muriatic_acid", 1)
    :quality("CHEM", 2, 1)
    :book("textbook_chemistry", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(147)
)

-- 1u base cost, 6u more for evaporation, 1u for ingredients
content.add(content.Recipe {
    id = "salt_from_hickory",
    result = "salt",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 288000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 8, true)
    :component("hickory_root", 10)
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "water", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :requires_skill("survival", 2)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "crystallizing_sugar_active_from_sweets",
    result = "crystallizing_sugar_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 630000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 8, true)
    :tool("screw_press", 1)
    :component_any({
            { id = "sweet_fruit_like_no_pulp", count = 2, requirement = true },
            { id = "coconut_flesh", count = 2 },
            { id = "corn_kernels", count = 3 },
            { id = "rehydrated_corn_kernels", count = 3 },
            { id = "honeydew", count = 3 },
            { id = "honeycomb", count = 1 },
            { id = "can_corn", count = 3 },
            { id = "juice", count = 3 }
        })
    :component_any({
            { id = "water_clean", count = 2 },
            { id = "water", count = 2 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :quality("STRAIN", 2, 1)
    :book("cookbook_foodfashions", 5, { name = content.text("Improvised Fruit Sugar") })
    :proficiency("prof_knife_skills")
    :batch_discount(20, 1)
    :result_charges(10)
    :byproduct("juice_pulp", 3)
)

content.add(content.Recipe {
    id = "crystallizing_sugar_active_from_sweets_no_pulp",
    result = "crystallizing_sugar_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 630000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 8, true)
    :tool("screw_press", 1)
    :component_any({
            { id = "sweet_fruit_like_no_pulp", count = 2, requirement = true },
            { id = "coconut_flesh", count = 2 },
            { id = "corn_kernels", count = 3 },
            { id = "rehydrated_corn_kernels", count = 3 },
            { id = "honeydew", count = 3 },
            { id = "honeycomb", count = 1 },
            { id = "can_corn", count = 3 },
            { id = "juice", count = 3 }
        })
    :component_any({
            { id = "water_clean", count = 2 },
            { id = "water", count = 2 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :quality("STRAIN", 2, 1)
    :book("cookbook_foodfashions", 5, { name = content.text("Improvised Fruit Sugar") })
    :proficiency("prof_knife_skills")
    :batch_discount(20, 1)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "sugar_from_processed",
    result = "sugar",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 50, true)
    :component_any({
            { id = "coffee_syrup", count = 4 },
            { id = "cola", count = 5 },
            { id = "con_milk", count = 4 },
            { id = "honey_bottled", count = 6 },
            { id = "molasses", count = 2 },
            { id = "purple_drink", count = 7 },
            { id = "rootbeer", count = 4 },
            { id = "syrup", count = 8 },
            { id = "beet_syrup", count = 10 }
        })
    :quality("BOIL", 2, 1)
    :batch_discount(20, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "sugar_from_candy",
    result = "sugar",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("food_processor", 20)
    :component_any({
            { id = "candy3", count = 5 },
            { id = "candy3gator", count = 5 },
            { id = "maltballs", count = 1 },
            { id = "mintpatties", count = 2 },
            { id = "honey_glassed", count = 2 },
            { id = "honeycomb", count = 1 },
            { id = "homeopathic_pills", count = 120 },
            { id = "cow_candy", count = 2 },
            { id = "candycigarette", count = 3 },
            { id = "maple_candy", count = 7 },
            { id = "powder_candy", count = 2 }
        })
    :batch_discount(50, 1)
    :result_charges(10)
)

-- high-temperature acid hydrolysis, to extract edible wood sugars
content.add(content.Recipe {
    id = "sugar_from_wood",
    result = "sugar",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 50, true)
    :component_any({
            { id = "pine_bough", count = 6 },
            { id = "2x4", count = 8 },
            { id = "stick", count = 8 },
            { id = "splinter", count = 16 }
        })
    :component("any_strong_acid", 1, true)
    :quality("CHEM", 2, 1)
    :book("adv_chemistry", 7)
    :book("textbook_chemistry", 8)
    :book("recipe_labchem", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(20, 1)
    :result_charges(71)
)

-- process sugar beets into sugar
-- 1u base + 1u ingredient + 6u evaporation
content.add(content.Recipe {
    id = "crystallizing_sugar_active_from_beets",
    result = "crystallizing_sugar_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 8, true)
    :tool("screw_press", 1)
    :component("sugar_beet", 1)
    :component_any({
            { id = "water_clean", count = 4 },
            { id = "water", count = 4 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :quality("STRAIN", 2, 1)
    :book("cookbook_foodfashions", 5, { name = content.text("Natural Beet Sugar") })
    :proficiency("prof_knife_skills")
    :batch_discount(20, 1)
    :result_charges(30)
    :byproduct("molasses", 1)
)

content.add(content.Recipe {
    id = "mustard_powder",
    result = "mustard_powder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool("rock_quern", 1)
    :component("seed_mustard", 1)
    :batch_discount(83, 3)
    :result_charges(25)
)

content.add(content.Recipe {
    id = "mustard_powder_with_from_food_processor",
    result = "mustard_powder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("food_processor", 5)
    :component("seed_mustard", 1)
    :batch_discount(83, 3)
    :result_charges(25)
)
