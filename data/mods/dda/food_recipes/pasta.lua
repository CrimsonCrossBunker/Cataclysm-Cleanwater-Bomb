local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

-- There are ways to cook pasta that don't require boiling the water, and they are a lot more efficient, so
-- this uses surface_heat
-- pasta by weight is 5u flour, 1u for the cheese + heating the water (2u)
content.add(content.Recipe {
    id = "macaroni_cooked",
    result = "macaroni_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 8, true)
    :component_any({
            { id = "spaghetti_raw", count = 1 },
            { id = "macaroni_raw", count = 1 },
            { id = "noodles_fast", count = 1 }
        })
    :component_any({
            { id = "cheese_standard", count = 1, requirement = true },
            { id = "cheese_powder", count = 1 }
        })
    :component("water_clean", 1)
    :quality("COOK", 3, 1)
)

-- There are ways to cook pasta that don't require boiling the water, and they are a lot more efficient, so
-- this uses surface_heat
-- pasta by weight is 5u flour, 1u for sauce, 20u for meat + heating the water (2u)
content.add(content.Recipe {
    id = "spaghetti_bolognese",
    result = "spaghetti_bolognese",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 28, true)
    :component("spaghetti_raw", 1)
    :component("water_clean", 1)
    :component_any({
            { id = "seasoning_italian", count = 4 },
            { id = "sauce_red", count = 2 },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "wild_herbs", count = 10 }
        })
    :component_any({
            { id = "meat_red", count = 1, requirement = true },
            { id = "meatball", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("cookbook_italian", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(3)
)

-- There are ways to cook pasta that don't require boiling the water, and they are a lot more efficient, so
-- this uses surface_heat
-- pasta by weight is 5u flour, 1u for cheese, 1u for sauce, 4u for meat + heating the water (2u)
content.add(content.Recipe {
    id = "lasagne",
    result = "lasagne",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 13, true)
    :component("lasagne_raw", 1)
    :component("water_clean", 1)
    :component_any({
            { id = "seasoning_italian", count = 4 },
            { id = "sauce_red", count = 2 },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "wild_herbs", count = 10 }
        })
    :component("cheese_standard", 1, true)
    :component_any({
            { id = "meat_cooked", count = 1, requirement = true },
            { id = "can_chicken", count = 1 },
            { id = "dry_meat", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_italian", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(4)
)

-- There are ways to cook pasta that don't require boiling the water, and they are a lot more efficient, so
-- this uses surface_heat
-- pasta by weight is 5u flour + heating the water (2u)
content.add(content.Recipe {
    id = "spaghetti_pesto",
    result = "spaghetti_pesto",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 7, true)
    :component("spaghetti_raw", 1)
    :component("water_clean", 1)
    :component("sauce_pesto", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("cookbook_italian", 3)
    :book("cookbook_foodfashions", 4, { name = content.text("Spaghetti Luchetto") })
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(1)
)

-- 7u heat to process the flour plus 4u to dry it out a bit
content.add(content.Recipe {
    id = "noodles_fast",
    result = "noodles_fast",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 11, true)
    :tool("pastaextruder", 1)
    :component("flour_any", 7, true)
    :component("water_clean", 1)
    :batch_discount(95, 1)
)

-- 5u heat to process the flour plus 3u to dry it out a bit
content.add(content.Recipe {
    id = "spaghetti_raw",
    result = "spaghetti_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 8, true)
    :tool("pastaextruder", 1)
    :component("flour_any", 5, true)
    :component("water_clean", 1)
    :batch_discount(95, 1)
)

-- 5u heat to process the flour plus 3u to dry it out a bit
content.add(content.Recipe {
    id = "lasagne_raw",
    result = "lasagne_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 8, true)
    :tool("pastaextruder", 1)
    :component("flour_any", 5, true)
    :component("water_clean", 1)
    :batch_discount(95, 1)
)

-- 5u heat to process the flour plus 3u to dry it out a bit
content.add(content.Recipe {
    id = "macaroni_raw",
    result = "macaroni_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 8, true)
    :tool("pastaextruder", 1)
    :component("flour_any", 5, true)
    :component("water_clean", 1)
    :batch_discount(95, 1)
)

-- pasta by weight is 5u flour, 2u for the cheese, 4u for meat + heating the water (2u)
content.add(content.Recipe {
    id = "macaroni_helper",
    result = "macaroni_helper",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 13, true)
    :component_any({
            { id = "spaghetti_raw", count = 1 },
            { id = "macaroni_raw", count = 1 },
            { id = "noodles_fast", count = 1 }
        })
    :component("meat_red_cooked", 1, true)
    :component_any({
            { id = "cheese_standard", count = 2, requirement = true },
            { id = "cheese_powder", count = 2 }
        })
    :component("water_clean", 1)
    :quality("COOK", 3, 1)
    :book("cookbook", 1)
    :book("cookbook_daintydishes", 4)
    :result_charges(2)
)

-- There are ways to cook pasta that don't require boiling the water, and they are a lot more efficient, so
-- this uses surface_heat
-- pasta by weight is 5u flour, 1u for cheese, 2u of egg, 20u for meat, heating the water (2u)
content.add(content.Recipe {
    id = "pasta_carbonara",
    result = "pasta_carbonara",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 31, true)
    :component("spaghetti_raw", 1)
    :component("water_clean", 1)
    :component("eggs_any_shape", 3, true)
    :component_any({
            { id = "cheese_standard", count = 1, requirement = true },
            { id = "pecorino_cheese", count = 1 }
        })
    :component_any({
            { id = "meat_red", count = 1, requirement = true },
            { id = "bacon", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("cookbook_italian", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(4)
)

-- There are ways to cook pasta that don't require boiling the water, and they are a lot more efficient, so
-- this uses surface_heat
-- pasta by weight is 5u flour, 1u for cheese, 4u of red sauce, 20u for meat, heating the water (2u)
content.add(content.Recipe {
    id = "amatriciana_pasta",
    result = "amatriciana_pasta",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_PASTA",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 31, true)
    :component("spaghetti_raw", 1)
    :component("water_clean", 1)
    :component("sauce_red", 3)
    :component_any({
            { id = "cheese_standard", count = 1, requirement = true },
            { id = "pecorino_cheese", count = 1 }
        })
    :component_any({
            { id = "meat_red", count = 1, requirement = true },
            { id = "bacon", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("cookbook_italian", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(4)
)
