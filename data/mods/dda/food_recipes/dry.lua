local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
-- 150g of stuff
content.add(content.Recipe {
    id = "dry_fish",
    result = "dry_fish",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 15, true)
    :component_any({
            { id = "fish", count = 1 },
            { id = "fish_scrap", count = 10 }
        })
    :batch_discount(67, 5)
)

-- 100g of stuff
content.add(content.Recipe {
    id = "dry_froglegs_frozen_ingredients",
    result = "dry_froglegs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 10, true)
    :tool_charges("surface_heat", 7, true)
    :component("froglegs", 1)
    :batch_discount(67, 5)
)

-- 100g of stuff
content.add(content.Recipe {
    id = "dry_froglegs",
    result = "dry_froglegs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 10, true)
    :component("froglegs", 1)
    :batch_discount(67, 5)
    :remove_result_flag("BAD_TASTE")
)

-- 150g of stuff
content.add(content.Recipe {
    id = "dry_fish_frozen_ingredients",
    result = "dry_fish",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 15, true)
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "fish", count = 1 },
            { id = "fish_scrap", count = 10 }
        })
    :batch_discount(67, 5)
)

-- 150g of stuff
content.add(content.Recipe {
    id = "dry_lobster",
    result = "dry_lobster",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 15, true)
    :component("lobster", 1)
    :batch_discount(67, 5)
)

-- 150g of stuff
content.add(content.Recipe {
    id = "dry_lobster_frozen_ingredients",
    result = "dry_lobster",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 15, true)
    :tool_charges("surface_heat", 10, true)
    :component("lobster", 1)
    :batch_discount(67, 5)
)

-- 150g of stuff
content.add(content.Recipe {
    id = "dry_mollusk",
    result = "dry_mollusk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 15, true)
    :component("mollusk", 1)
    :batch_discount(67, 5)
)

-- 150g of stuff
content.add(content.Recipe {
    id = "dry_mollusk_frozen_ingredients",
    result = "dry_mollusk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 15, true)
    :tool_charges("surface_heat", 10, true)
    :component("mollusk", 1)
    :batch_discount(67, 5)
)

-- 194g of stuff
content.add(content.Recipe {
    id = "dry_beans",
    result = "dry_beans",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 19, true)
    :component("raw_beans", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

-- 194g of stuff
content.add(content.Recipe {
    id = "dry_beans_frozen_ingredients",
    result = "dry_beans",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 19, true)
    :tool_charges("surface_heat", 8, true)
    :component("raw_beans", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

-- 85g of stuff
content.add(content.Recipe {
    id = "dry_tofu",
    result = "dry_tofu",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 9, true)
    :component("tofu", 1)
    :batch_discount(67, 5)
)

-- 85g of stuff
content.add(content.Recipe {
    id = "dry_tofu_frozen_ingredients",
    result = "dry_tofu",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 9, true)
    :tool_charges("surface_heat", 6, true)
    :component("tofu", 1)
    :batch_discount(67, 5)
)

-- Variable weights, around averaging around 150g
content.add(content.Recipe {
    id = "dry_fruit",
    result = "dry_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 15, true)
    :component_any({
            { id = "sweet_fruit", count = 1, requirement = true },
            { id = "coconut_flesh", count = 1 }
        })
    :batch_discount(67, 5)
)

-- Variable weights, around averaging around 150g + 1u to heat the fruit
content.add(content.Recipe {
    id = "dry_fruit_frozen_ingredients",
    result = "dry_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 15, true)
    :tool_charges("surface_heat", 1, true)
    :component_any({
            { id = "sweet_fruit", count = 1, requirement = true },
            { id = "coconut_flesh", count = 1 }
        })
    :batch_discount(67, 5)
)

-- 300g of stuff, 20u to cook it
content.add(content.Recipe {
    id = "dry_meat_frozen_ingredients",
    result = "dry_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 30, true)
    :tool_charges("surface_heat", 20, true)
    :component("meat_red_raw", 1, true)
    :batch_discount(67, 5)
)

-- 238g of stuff
content.add(content.Recipe {
    id = "dry_meat_tainted",
    result = "dry_meat_tainted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 24, true)
    :component_any({
            { id = "meat_tainted", count = 1 },
            { id = "meat_tainted_human", count = 1 }
        })
    :batch_discount(67, 5)
)

-- 238g of stuff, 16u to cook it
content.add(content.Recipe {
    id = "dry_meat_tainted_frozen_ingredients",
    result = "dry_meat_tainted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 24, true)
    :tool_charges("surface_heat", 16, true)
    :component_any({
            { id = "meat_tainted", count = 1 },
            { id = "meat_tainted_human", count = 1 }
        })
    :batch_discount(67, 5)
)

-- 69g of stuff
content.add(content.Recipe {
    id = "dry_mushroom",
    result = "dry_mushroom",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 7, true)
    :component_any({
            { id = "mushroom", count = 1 },
            { id = "mushroom_morel", count = 1 }
        })
    :batch_discount(67, 5)
)

-- 69g of stuff, 2u to cook
content.add(content.Recipe {
    id = "dry_mushroom_frozen_ingredients",
    result = "dry_mushroom",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 7, true)
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "mushroom", count = 1 },
            { id = "mushroom_morel", count = 1 }
        })
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "kombu",
    result = "kombu",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 7, true)
    :component("kelp_sugar", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "kombu_frozen_ingredients",
    result = "kombu",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 132000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 7, true)
    :tool_charges("surface_heat", 2, true)
    :component("kelp_sugar", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_seaweed",
    result = "dry_seaweed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 5, true)
    :component("seaweed", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_seaweed_frozen_ingredients",
    result = "dry_seaweed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 5, true)
    :tool_charges("surface_heat", 2, true)
    :component("seaweed", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

-- highly variable - most hover around 100-120g but some (tomato) are much heavier.  Basing this off plant
-- marrow (119g) since it's the most common ingredient
content.add(content.Recipe {
    id = "dry_veggy",
    result = "dry_veggy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :component_any({
            { id = "veggy_any_fresh_uncooked", count = 1, requirement = true },
            { id = "dandelion_cooked", count = 1 },
            { id = "burdock_cooked", count = 1 },
            { id = "bamboo_cooked", count = 1 },
            { id = "groundnut_prepared", count = 5 },
            { id = "wild_herbs", count = 40 }
        })
    :batch_discount(67, 5)
    :result_charges(1)
)

-- highly variable - most hover around 100-120g but some (tomato) are much heavier.  Basing this off plant
-- marrow (119g) since it's the most common ingredient
content.add(content.Recipe {
    id = "dry_veggy_frozen_ingredients",
    result = "dry_veggy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "veggy_any_fresh_uncooked", count = 1, requirement = true },
            { id = "dandelion_cooked", count = 1 },
            { id = "burdock_cooked", count = 1 },
            { id = "bamboo_cooked", count = 1 },
            { id = "groundnut_prepared", count = 5 },
            { id = "wild_herbs", count = 40 }
        })
    :batch_discount(67, 5)
    :result_charges(1)
)

-- I pretty much made up all the relating numbers, feel free to change them
content.add(content.Recipe {
    id = "dry_chili_frozen_ingredients",
    result = "dry_chili",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "chili_pepper", count = 1 },
            { id = "chili_pepper_cut", count = 1 }
        })
    :batch_discount(67, 5)
)

-- I pretty much made up all the relating numbers, feel free to change them
content.add(content.Recipe {
    id = "dry_chili",
    result = "dry_chili",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 72000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :component_any({
            { id = "chili_pepper", count = 1 },
            { id = "chili_pepper_cut", count = 1 }
        })
    :batch_discount(67, 5)
)

-- I pretty much made up all the relating numbers, feel free to change them
content.add(content.Recipe {
    id = "dry_garlic_frozen_ingredients",
    result = "dry_garlic",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :tool_charges("surface_heat", 2, true)
    :component("garlic_clove", 1)
    :batch_discount(67, 5)
)

-- I pretty much made up all the relating numbers, feel free to change them
content.add(content.Recipe {
    id = "dry_garlic",
    result = "dry_garlic",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :component("garlic_clove", 1)
    :batch_discount(67, 5)
)

-- 210g of stuff - kernels are rather heavy
content.add(content.Recipe {
    id = "dry_corn",
    result = "dry_corn",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 21, true)
    :component("corn_kernels", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

-- 210g of stuff - kernels are rather heavy, 8u to cook
content.add(content.Recipe {
    id = "dry_corn_frozen_ingredients",
    result = "dry_corn",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 21, true)
    :tool_charges("surface_heat", 8, true)
    :component("corn_kernels", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_wheat_stalks",
    result = "dry_wheat_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :component("wheat_stalks", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_wheat_stalks_frozen_ingredients",
    result = "dry_wheat_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :tool_charges("surface_heat", 2, true)
    :component("wheat_stalks", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_winter_wheat_stalks",
    result = "dry_winter_wheat_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :component("red_winter_wheat_stalks", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_winter_wheat_stalks_frozen_ingredients",
    result = "dry_winter_wheat_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :tool_charges("surface_heat", 2, true)
    :component("red_winter_wheat_stalks", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_barley_stalks",
    result = "dry_barley_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :component("barley_stalks", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_barley_stalks_frozen_ingredients",
    result = "dry_barley_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :tool_charges("surface_heat", 2, true)
    :component("barley_stalks", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_oat_stalks",
    result = "dry_oat_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :component("oat_stalks", 1)
    :batch_discount(67, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_oat_stalks_frozen_ingredients",
    result = "dry_oat_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :tool_charges("surface_heat", 2, true)
    :component("oat_stalks", 1)
    :batch_discount(67, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_wild_rice_stalks",
    result = "dry_wild_rice_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :component("wild_rice_stalks", 1)
    :batch_discount(67, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_wild_rice_stalks_frozen_ingredients",
    result = "dry_wild_rice_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :tool_charges("surface_heat", 2, true)
    :component("wild_rice_stalks", 1)
    :batch_discount(67, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_buckwheat_stalks",
    result = "dry_buckwheat_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :component("buckwheat_stalks", 1)
    :batch_discount(67, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_buckwheat_stalks_frozen_ingredients",
    result = "dry_buckwheat_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :tool_charges("surface_heat", 2, true)
    :component("buckwheat_stalks", 1)
    :batch_discount(67, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_canola_stalks",
    result = "dry_canola_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :component("canola_stalks", 1)
    :batch_discount(67, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "dry_canola_stalks_frozen_ingredients",
    result = "dry_canola_stalks",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :tool_charges("surface_heat", 2, true)
    :component("canola_stalks", 1)
    :batch_discount(67, 2)
    :result_charges(1)
)

-- 119g of stuff
content.add(content.Recipe {
    id = "dry_veggy_tainted",
    result = "dry_veggy_tainted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :component("veggy_tainted", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

-- 119g of stuff, 2u heat to 'cook'
content.add(content.Recipe {
    id = "dry_veggy_tainted_frozen_ingredients",
    result = "dry_veggy_tainted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 12, true)
    :tool_charges("surface_heat", 2, true)
    :component("veggy_tainted", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

-- 259g of stuff, liquids are naturally inefficient for this
content.add(content.Recipe {
    id = "milk_powder",
    result = "milk_powder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 13, true)
    :component("milk", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

-- by weight of unfertilized bird egg 550g of stuff
content.add(content.Recipe {
    id = "powder_eggs",
    result = "powder_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 55, true)
    :component_any({
            { id = "eggs_bird", count = 12, requirement = true },
            { id = "eggs_reptile", count = 12, requirement = true },
            { id = "eggs_invert", count = 1, requirement = true }
        })
    :batch_discount(67, 5)
    :result_charges(12)
)

-- by weight of unfertilized bird egg 550g of stuff plus 36u heat for the eggs (standard is 3 per egg)
content.add(content.Recipe {
    id = "powder_eggs_frozen_ingredients",
    result = "powder_eggs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 55, true)
    :tool_charges("surface_heat", 36, true)
    :component_any({
            { id = "eggs_bird", count = 12, requirement = true },
            { id = "eggs_reptile", count = 12, requirement = true },
            { id = "eggs_invert", count = 1, requirement = true }
        })
    :batch_discount(67, 5)
    :result_charges(12)
)

content.add(content.Recipe {
    id = "protein_powder",
    result = "protein_powder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 25, true)
    :component_any({
            { id = "dry_meat", count = 1 },
            { id = "dry_fish", count = 2 },
            { id = "dry_lobster", count = 2 },
            { id = "dry_poultry", count = 2 }
        })
    :quality("CHEM", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :batch_discount(83, 3)
    :result_charges(4)
)

-- 194g of stuff
content.add(content.Recipe {
    id = "dry_soybean",
    result = "dry_soybean",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 19, true)
    :component("soybean", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

-- 194g of stuff, 8u to cook the soybeans
content.add(content.Recipe {
    id = "dry_soybean_frozen_ingredients",
    result = "dry_soybean",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 19, true)
    :tool_charges("surface_heat", 8, true)
    :component("soybean", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

-- 25g of stuff
content.add(content.Recipe {
    id = "gelatin_powder",
    result = "gelatin_powder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 42000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 3, true)
    :component("gelatin_fresh", 1)
    :batch_discount(67, 5)
    :result_charges(25)
)

-- 30 g acorns
content.add(content.Recipe {
    id = "acorns_cooked_from blanched",
    result = "acorns_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("dehydrating_heat", 3, true)
    :tool_charges("surface_heat", 3, true)
    :component("acorns_blanched", 1)
    :batch_discount(67, 5)
    :result_charges(1)
)

-- 100g of stuff
content.add(content.Recipe {
    id = "dry_poultry",
    result = "dry_poultry",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 72000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 10, true)
    :component("poultry_raw_any", 1, true)
    :batch_discount(67, 5)
    :remove_result_flag("BAD_TASTE")
)

-- 100g of stuff, 6.6u to cook it
content.add(content.Recipe {
    id = "dry_poultry_frozen_ingredients",
    result = "dry_poultry",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 10, true)
    :tool_charges("surface_heat", 7, true)
    :component("poultry_raw_any", 1, true)
    :batch_discount(67, 5)
)
