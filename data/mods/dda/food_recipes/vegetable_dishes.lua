local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

-- 2u energy to roast 100g vegetable per standard, bell pepper is 110g
content.add(content.Recipe {
    id = "cooked_bell_pepper",
    result = "cooked_bell_pepper",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("any_bell_pepper", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "rehydrated_veggy",
    result = "rehydrated_veggy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("dry_veggy", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 1)
)

content.add(content.Recipe {
    id = "rehydrated_chili",
    result = "rehydrated_chili",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("dry_chili", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 1)
)

content.add(content.Recipe {
    id = "rehydrated_garlic",
    result = "rehydrated_garlic",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("dry_garlic", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 1)
)

content.add(content.Recipe {
    id = "rehydrated_corn_kernels",
    result = "rehydrated_corn_kernels",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 18000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("dry_corn", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 1)
)

-- rice weight roughly 4-5x 1u of flour, not much cooking is going on here, so not much power
content.add(content.Recipe {
    id = "sushi_rice",
    result = "sushi_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 5, true)
    :component("water_clean", 1)
    :component_any({
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 }
        })
    :component("vinegar", 1)
    :component_any({
            { id = "sugar", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "artificial_sweetener", count = 1 }
        })
    :quality("COOK", 2, 1)
    :quality("CONTAIN", 1, 1)
    :book("cookbook_sushi", 2)
    :proficiency("prof_food_prep")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "onigiri",
    result = "onigiri",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :component("sushi_rice", 1)
    :component_any({
            { id = "lettuce", count = 1 },
            { id = "cabbage", count = 1 },
            { id = "grape_leaves", count = 1 },
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
    :book("cookbook_sushi", 2)
    :book("cookbook_daintydishes", 3, { name = content.text("Sticky Rice Hedgerows") })
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(3)
)

content.add(content.Recipe {
    id = "sushi_veggyroll",
    result = "sushi_veggyroll",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :component("sushi_rice", 1)
    :component_any({
            { id = "any_salad_cucumber", count = 1, requirement = true },
            { id = "carrot", count = 6 },
            { id = "carrot_wild", count = 6 },
            { id = "celery", count = 3 },
            { id = "tofu", count = 1 },
            { id = "veggy_wild", count = 3 },
            { id = "veggy", count = 3 },
            { id = "rehydrated_veggy", count = 3 },
            { id = "rehydrated_corn_kernels", count = 3 },
            { id = "corn_kernels", count = 3 }
        })
    :component_any({
            { id = "lettuce", count = 2 },
            { id = "grape_leaves", count = 2 },
            { id = "cabbage", count = 2 },
            { id = "dandelion_cooked", count = 2 },
            { id = "burdock_cooked", count = 2 },
            { id = "bamboo_cooked", count = 2 },
            { id = "wild_garlic", count = 2 },
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

-- 4 tofus = 24u, rice = 16u, veggies (200g) = 4u, sugar/oil: 1u, total = 45u.  it's a big dish!
content.add(content.Recipe {
    id = "tofu_stirfry",
    result = "tofu_stirfry",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 45, true)
    :component_any({
            { id = "tofu", count = 4 },
            { id = "dry_tofu", count = 4 }
        })
    :component_any({
            { id = "dry_rice", count = 4 },
            { id = "sushi_rice", count = 4 },
            { id = "rice_cooked", count = 4 },
            { id = "dry_wild_rice", count = 4 },
            { id = "wild_rice_cooked", count = 4 }
        })
    :component("cooking_oil", 1)
    :component("sugar_standard_half", 1, true)
    :component_any({
            { id = "broccoli", count = 2 },
            { id = "veggy_wild_cooked", count = 2 },
            { id = "veggy_cooked", count = 2 }
        })
    :component("soysauce", 1)
    :quality("CONTAIN", 1, 1)
    :quality("COOK", 3, 1)
    :book("cookbook_sushi", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(25, 2)
    :result_charges(4)
)

-- 2u to cook a veggy weighing 100u, these clock in at 119g
content.add(content.Recipe {
    id = "veggy_cooked",
    result = "veggy_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("veggy", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(1)
)

-- 2u to cook a veggy weighing 100u, these clock in at 119g
content.add(content.Recipe {
    id = "veggy_wild_cooked",
    result = "veggy_wild_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("veggy_wild", 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 4)
    :result_charges(1)
)

-- not starchy like the rhizome, basically just bigger leeks, weighing 100g.  power cost 2u
content.add(content.Recipe {
    id = "cooked_cattail_stalk",
    result = "cooked_cattail_stalk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 108000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 2, true)
    :component("cattail_stalk", 1)
    :quality("CUT", 1, 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(40, 5)
    :byproduct("plant_fibre", 1)
)

content.add(content.Recipe {
    id = "cooked_burdock_stalk",
    result = "cooked_burdock_stalk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 108000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 2, true)
    :component("plant_stalk", 1)
    :quality("CUT", 1, 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(40, 5)
    :byproduct("plant_fibre", 1)
)

-- starch equivalent to 16u of flour by weight
content.add(content.Recipe {
    id = "roasted_cattail_rhizome",
    result = "roasted_cattail_rhizome",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 16, true)
    :component("cattail_rhizome", 1)
    :quality("COOK", 1, 1)
    :requires_skill("survival", 2)
    :book("pocket_survival", 1)
    :book("manual_survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 3)
)

-- starchy, though low calorie - regardless, it's 190g, so about 15u flour's worth
content.add(content.Recipe {
    id = "dahlia_baked",
    result = "dahlia_baked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component("dahlia_root", 1)
    :quality("COOK", 2, 1)
    :quality("OVEN", 1, 1)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 4)
)

-- starchy root equivalent to 10u of flour in weight
content.add(content.Recipe {
    id = "salsify_baked",
    result = "salsify_baked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :component("salsify_raw", 1)
    :quality("COOK", 2, 1)
    :quality("OVEN", 1, 1)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "dandelion_cooked",
    result = "dandelion_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("raw_dandelion", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 4)
)

-- Small amounts of oil will be absorbed by the batter, real fried food 8-25% by weight
-- 3u heat for 136g of dandelion + 2u for the batter
content.add(content.Recipe {
    id = "dandelion_fried",
    result = "dandelion_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :tool_charges("frying_oil", 1, true)
    :component("any_butter_or_oil", 1, true)
    :component("raw_dandelion", 2)
    :component("batter", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
)

content.add(content.Recipe {
    id = "burdock_cooked",
    result = "burdock_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("raw_burdock", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 2)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :book("mag_survival", 1)
    :book("family_cookbook", 1)
    :book("cookbook_daintydishes", 2, { name = content.text("Royal Penny Tea") })
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "bamboo_cooked",
    result = "bamboo_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 3, true)
    :tool_charges("frying_oil", 1, true)
    :component("raw_bamboo", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 2)
    :book("cookbook_sushi", 2)
    :book("family_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 4)
)

-- 3u heat for 136g of burdock + 2u heat for batter
content.add(content.Recipe {
    id = "burdock_fried",
    result = "burdock_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :tool_charges("frying_oil", 1, true)
    :component("raw_burdock", 2)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 2)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :book("mag_survival", 1)
    :book("family_cookbook", 1)
    :book("cookbook_daintydishes", 2, { name = content.text("Royal Penny Tea") })
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
)

-- 300g of veggy for 6u + 2u heat for batter
content.add(content.Recipe {
    id = "bamboo_fried",
    result = "bamboo_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 8, true)
    :tool_charges("frying_oil", 2, true)
    :component("raw_bamboo", 2)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :requires_skill("cooking", 2)
    :book("cookbook_sushi", 2)
    :book("family_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
)

-- the cooking oil isn't supposed to be expended since you can recycle it after frying the burdocks
-- 136g of dandelion/burdock + batter
content.add(content.Recipe {
    id = "dandelionburdock_fried",
    result = "dandelionburdock_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :tool_charges("frying_oil", 1, true)
    :component("raw_dandelion", 1)
    :component("raw_burdock", 1)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 2)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :book("mag_survival", 1)
    :book("family_cookbook", 1)
    :book("cookbook_daintydishes", 2, { name = content.text("Royal Penny Tea") })
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
)

content.add(content.Recipe {
    id = "cooked_pumpkin",
    result = "cooked_pumpkin",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component("pumpkin_cut", 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :result_charges(2)
)

-- potatoes microwave in about 3-7 minutes, faster if diced.  even just cutting it in half makes a big
-- difference
content.add(content.Recipe {
    id = "potato_baked",
    result = "potato_baked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :component("veggy_potatolike", 1, true)
    :quality("OVEN", 1, 1)
    :quality("CUT", 1, 1)
    :proficiency("prof_food_prep")
)

content.add(content.Recipe {
    id = "potato_boiled",
    result = "potato_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 3, true)
    :component("veggy_potatolike", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "lotus_rhizome_boiled",
    result = "lotus_rhizome_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 3, true)
    :component("lotus_rhizome", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
)

-- Carrot crudely chopped (so it cooks faster) and roasted on a skewer, the carrot needs some time to cook
-- and soften up so batch-making these, aka having multiple batches of carrots roast simultaneously, is way
-- more efficient
content.add(content.Recipe {
    id = "carrot_roasted",
    result = "carrot_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "carrot", count = 1 },
            { id = "carrot_wild", count = 1 }
        })
    :quality("COOK", 1, 1)
    :quality("CUT", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(90, 1)
)

content.add(content.Recipe {
    id = "carrot_glazed",
    result = "carrot_glazed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "carrot", count = 1 },
            { id = "carrot_wild", count = 1 }
        })
    :component_any({
            { id = "wild_herbs", count = 2 },
            { id = "seasoning_italian", count = 1 }
        })
    :component("any_butter_or_oil", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :batch_discount(90, 1)
)

content.add(content.Recipe {
    id = "starch",
    result = "starch",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component_any({
            { id = "dahlia_root", count = 10 },
            { id = "veggy_potatolike", count = 5, requirement = true },
            { id = "plantain", count = 5 }
        })
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(53, 1)
)

content.add(content.Recipe {
    id = "starch_from_fibrous_stuff",
    result = "starch",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("cattail_rhizome", 2)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(53, 1)
    :byproduct("plant_fibre", 5)
)

-- Gelatin from bones is just boiling them long enough.  Gelatin from pectin is harder.  Instead of duping
-- the ingredients, *1.5 them for aforementioned pectin.
-- 8u for veggy, 10u for gelatin, 5u for water
content.add(content.Recipe {
    id = "veggy_aspic",
    result = "veggy_aspic",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 23, true)
    :component_any({
            { id = "gelatin_fresh", count = 1 },
            { id = "gelatin_powder", count = 25 },
            { id = "chem_agar", count = 25 }
        })
    :component("veggy_any", 4, true)
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :book("cookbook_daintydishes", 4)
    :book("textbook_chemistry", 3)
    :proficiency("prof_food_prep")
    :batch_discount(50, 5)
    :result_charges(2)
)

-- beans = 2u (precooked), veggy = 2u, sugar = 1u
content.add(content.Recipe {
    id = "deluxe_veggy_beans",
    result = "deluxe_veggy_beans",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "can_beans", count = 1 },
            { id = "beans_cooked", count = 1 }
        })
    :component("veggy_any", 1, true)
    :component("sugar_standard", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
)

-- standard is 4u surface_heat for 1u of rice
content.add(content.Recipe {
    id = "rice_cooked",
    result = "rice_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 4, true)
    :component("dry_rice", 1)
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :batch_discount(82, 4)
)

-- standard is 4u surface_heat for 1u of rice
content.add(content.Recipe {
    id = "wild_rice_cooked",
    result = "wild_rice_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 4, true)
    :component("dry_wild_rice", 1)
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :batch_discount(82, 4)
)

-- rice = 2u (precooked), tofu = 2u, oil = 1u
content.add(content.Recipe {
    id = "tofu_rice",
    result = "tofu_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "rice_cooked", count = 1 },
            { id = "dry_rice", count = 1 },
            { id = "wild_rice_cooked", count = 1 },
            { id = "dry_wild_rice", count = 1 }
        })
    :component_any({
            { id = "tofu", count = 1 },
            { id = "dry_tofu", count = 1 }
        })
    :component("cooking_oil", 1)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
)

-- rice = 2u (precooked), veggy = 2u, oil = 1u
content.add(content.Recipe {
    id = "deluxe_veggy_rice",
    result = "deluxe_veggy_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 1800,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "rice_cooked", count = 1 },
            { id = "wild_rice_cooked", count = 1 }
        })
    :component("veggy_any", 1, true)
    :component("any_butter_or_oil", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
)

-- rice = 4u, beans = 2u (precooked)
content.add(content.Recipe {
    id = "beansnrice",
    result = "beansnrice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "can_beans", count = 1 },
            { id = "dry_beans", count = 1 },
            { id = "raw_beans", count = 1 }
        })
    :component_any({
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 }
        })
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :book("cookbook_mexican", 1)
    :batch_discount(82, 4)
)

-- rice = 4u, beans = 2u (precooked), veggy = 2u
content.add(content.Recipe {
    id = "deluxe_veggy_beansnrice",
    result = "deluxe_veggy_beansnrice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 8, true)
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
            { id = "veggy_any", count = 1, requirement = true },
            { id = "mushroom", count = 1 },
            { id = "tofu", count = 1 },
            { id = "dry_mushroom", count = 1 },
            { id = "morel_cooked", count = 1 },
            { id = "mushroom_cooked", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "wild_garlic", count = 1 },
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "pepper", count = 1 }
        })
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :book("cookbook_mexican", 1)
    :proficiency("prof_food_prep")
)

-- weighs about 14u flour or so. cooking process is a bit more efficient though.
content.add(content.Recipe {
    id = "buckwheat_cooked",
    result = "buckwheat_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 54000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 12, true)
    :component("buckwheat", 1)
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sauce_pesto",
    result = "sauce_pesto",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :component_any({
            { id = "cooking_oil", count = 2 },
            { id = "edible_tallow", count = 2, requirement = true }
        })
    :component("pine_nuts", 1)
    :component_any({
            { id = "seasoning_italian", count = 5 },
            { id = "wild_herbs", count = 10 },
            { id = "wild_garlic", count = 2 }
        })
    :component_any({
            { id = "salt", count = 5 },
            { id = "seasoning_salt", count = 5 }
        })
    :quality("CONTAIN", 1, 1)
    :book("cookbook_italian", 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "veggy_salted_vacuum_packed",
    result = "veggy_salted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
    container = "plastic_bag_vac",
}
    :component("veggy_any_uncooked", 2, true)
    :component("salt_preservation", 2, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requirement("vacuum_sealing_standard", 1)
    :book("vacuum_sealing", 1)
    :proficiency("prof_preservation")
    :batch_discount(10, 3)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "sauerkraut_onions",
    result = "sauerkraut_onions",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 7, true)
    :component("sauerkraut", 1)
    :component("any_butter_or_oil", 1, true)
    :component("onion", 1)
    :quality("COOK", 1, 1)
    :book("fermenting_book", 2)
    :book("cookbook_foodfashions", 3)
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "veggy_salad",
    result = "veggy_salad",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component_any({
            { id = "lettuce", count = 2 },
            { id = "broccoli", count = 2 },
            { id = "dandelion_cooked", count = 2 },
            { id = "burdock_cooked", count = 2 },
            { id = "bamboo_cooked", count = 2 },
            { id = "veggy_wild_cooked", count = 2 },
            { id = "fiddlehead_boiled", count = 2 },
            { id = "fiddlehead_sauteed", count = 2 },
            { id = "young_leaves", count = 4 },
            { id = "chicory_leaves", count = 4 },
            { id = "sauerkraut", count = 2 },
            { id = "grape_leaves", count = 2 },
            { id = "radish_taproot", count = 2 },
            { id = "cabbage", count = 2 }
        })
    :component_any({
            { id = "any_salad_cucumber", count = 1, requirement = true },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "carrot", count = 2 },
            { id = "carrot_wild", count = 2 },
            { id = "pineapple_chunks", count = 1 },
            { id = "cranberries", count = 1 },
            { id = "raspberries", count = 1 },
            { id = "blackberries", count = 1 },
            { id = "sugar_beet", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 1 },
            { id = "artificial_sweetener", count = 1 },
            { id = "mustard", count = 1 },
            { id = "honey_mustard", count = 1 },
            { id = "mayonnaise", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "pepper", count = 1 },
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "wild_garlic", count = 2 },
            { id = "garlic_powder", count = 1 },
            { id = "vinegar", count = 1 },
            { id = "seasoning_italian", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("CONTAIN", 1, 1)
    :proficiency("prof_knife_skills")
)

content.add(content.Recipe {
    id = "insta_salad",
    result = "insta_salad",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    flags = { "BLIND_HARD" },
}
    :component("dried_salad", 1)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
)

-- about 150g of veggy matter that cooks down into 100g, so 2-3 seems right
content.add(content.Recipe {
    id = "nopalitos",
    result = "nopalitos",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 3, true)
    :component("cactus_pad", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :book("cookbook_mexican", 0)
    :batch_discount(80, 4)
    :result_charges(1)
)

-- 0.25L of water and it boils for 10-15 minutes, so 2u of boiling heat
content.add(content.Recipe {
    id = "fiddlehead_boiled",
    result = "fiddlehead_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("fiddlehead_raw", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 2)
)

-- The batch time adj. is because they need to be boiled before you can safely eat them, even if you pan-fry
-- them.
-- This recipe is boiled+sauteed combined into one, so power requirement is all of those together.
content.add(content.Recipe {
    id = "fiddlehead_sauteed_from_raw",
    result = "fiddlehead_sauteed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 5, true)
    :tool_charges("water_boiling_heat", 4, true)
    :component("fiddlehead_raw", 2)
    :component("any_butter_or_oil", 1, true)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("COOK", 2, 1)
    :quality("BOIL", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(40, 2)
)

-- 4u for fiddleheads and 1u for oil.
content.add(content.Recipe {
    id = "fiddlehead_sauteed_from_boiled",
    result = "fiddlehead_sauteed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 5, true)
    :component("fiddlehead_boiled", 2)
    :component("any_butter_or_oil", 1, true)
    :quality("COOK", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
)

content.add(content.Recipe {
    id = "hominy",
    result = "hominy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 20, true)
    :component("kernels", 1)
    :component_any({
            { id = "water", count = 8 },
            { id = "water_clean", count = 8 }
        })
    :component_any({
            { id = "lye_powder", count = 15 },
            { id = "chem_potassium_hydroxide", count = 75 },
            { id = "lye", count = 1 },
            { id = "lye_potassium", count = 1 },
            { id = "material_quicklime", count = 1 },
            { id = "chem_slaked_lime", count = 10 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("COOK", 3, 1)
    :book("cookbook_mexican", 4)
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "salsa_with_knife",
    result = "salsa",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component("any_tomato", 1, true)
    :component_any({
            { id = "veggy_any_uncooked", count = 1, requirement = true },
            { id = "rehydrated_corn_kernels", count = 1 },
            { id = "can_beans", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_mild", count = 1, requirement = true }
        })
    :quality("CONTAIN", 1, 1)
    :quality("CUT", 2, 1)
    :book("cookbook_mexican", 1)
    :batch_discount(20, 2)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "salsa_with_food_processor",
    result = "salsa",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 4500,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("food_processor", 20)
    :component("any_tomato", 1, true)
    :component_any({
            { id = "veggy_any_uncooked", count = 1, requirement = true },
            { id = "rehydrated_corn_kernels", count = 1 },
            { id = "can_beans", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_mild", count = 1, requirement = true }
        })
    :quality("CONTAIN", 1, 1)
    :book("cookbook_mexican", 1)
    :batch_discount(50, 2)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "melitzanosalata_with_knife",
    result = "melitzanosalata",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 312000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 44, true)
    :component("eggplant_cut", 2)
    :component_any({
            { id = "garlic_clove", count = 4 },
            { id = "rehydrated_garlic", count = 4 },
            { id = "wild_garlic", count = 4 },
            { id = "garlic_powder", count = 18 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :component_any({
            { id = "seasoning_mild", count = 1, requirement = true },
            { id = "chilly-p", count = 1 }
        })
    :component_any({
            { id = "vinegar", count = 1 },
            { id = "lemon", count = 1 }
        })
    :component("any_butter_or_oil", 4, true)
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :book("family_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(50, 2)
    :result_charges(4)
)

-- Just baking for most of the time
content.add(content.Recipe {
    id = "melitzanosalata_with_food_processor",
    result = "melitzanosalata",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 282000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "surface_heat", charges = 44, requirement = true },
            { id = "food_processor", charges = 20 }
        })
    :component("eggplant_cut", 2)
    :component_any({
            { id = "garlic_clove", count = 4 },
            { id = "rehydrated_garlic", count = 4 },
            { id = "wild_garlic", count = 4 },
            { id = "garlic_powder", count = 18 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :component_any({
            { id = "seasoning_mild", count = 1, requirement = true },
            { id = "chilly-p", count = 1 }
        })
    :component_any({
            { id = "vinegar", count = 1 },
            { id = "lemon", count = 1 }
        })
    :component("any_butter_or_oil", 4, true)
    :quality("COOK", 3, 1)
    :book("family_cookbook", 2)
    :proficiency("prof_food_prep")
    :batch_discount(80, 2)
    :result_charges(4)
)

-- 2u for flour, 3u for veggies, 1u for oil
content.add(content.Recipe {
    id = "veggy_pickled_fried",
    result = "veggy_pickled_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :tool_charges("frying_oil", 1, true)
    :component("veggy_pickled", 1)
    :component("flour_any", 1, true)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :component("any_butter_or_oil", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_frying")
    :batch_discount(50, 2)
)

content.add(content.Recipe {
    id = "veggy_salad_with_food_processor",
    result = "veggy_salad",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("food_processor", 10)
    :component_any({
            { id = "lettuce", count = 2 },
            { id = "broccoli", count = 2 },
            { id = "dandelion_cooked", count = 2 },
            { id = "burdock_cooked", count = 2 },
            { id = "veggy_wild_cooked", count = 2 },
            { id = "fiddlehead_boiled", count = 2 },
            { id = "fiddlehead_sauteed", count = 2 },
            { id = "young_leaves", count = 4 },
            { id = "sauerkraut", count = 2 },
            { id = "grape_leaves", count = 2 },
            { id = "cabbage", count = 2 },
            { id = "radish_taproot", count = 2 }
        })
    :component_any({
            { id = "any_salad_cucumber", count = 1, requirement = true },
            { id = "japanese_knotweed_stem", count = 2 },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "carrot", count = 2 },
            { id = "pineapple_chunks", count = 1 },
            { id = "cranberries", count = 1 },
            { id = "raspberries", count = 1 },
            { id = "blackberries", count = 1 },
            { id = "sugar_beet", count = 1 }
        })
    :component_any({
            { id = "sugar", count = 1 },
            { id = "artificial_sweetener", count = 1 },
            { id = "mustard", count = 1 },
            { id = "honey_mustard", count = 1 },
            { id = "mayonnaise", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "pepper", count = 1 },
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "wild_garlic", count = 2 },
            { id = "vinegar", count = 1 },
            { id = "seasoning_italian", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(80, 1)
)

-- typical veggy is 2u per 100g but these are starchier, so guessing 4u or so
content.add(content.Recipe {
    id = "plantain_cooked",
    result = "plantain_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component("plantain", 1)
    :quality("COOK", 1, 1)
)

-- 16u flour by weight
content.add(content.Recipe {
    id = "grain_boiled",
    result = "grain_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 54000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 16, true)
    :component_any({
            { id = "wheat", count = 1 },
            { id = "barley", count = 1 }
        })
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :batch_discount(67, 5)
)

-- 2u for roasting a veggy and 1u for the oil
content.add(content.Recipe {
    id = "garlic_roasted",
    result = "garlic_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 3, true)
    :component_any({
            { id = "garlic", count = 1 },
            { id = "garlic_clove", count = 6 },
            { id = "rehydrated_garlic", count = 6 }
        })
    :component("any_butter_or_oil", 1, true)
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
    :batch_discount(67, 5)
)

-- 2u for roasting a veggy and 1u for the oil
content.add(content.Recipe {
    id = "jerusalem_artichoke_sauteed",
    result = "jerusalem_artichoke_sauteed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 3, true)
    :component("any_butter_or_oil", 1, true)
    :component("jerusalem_artichoke", 1)
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
    :batch_discount(50, 3)
)

content.add(content.Recipe {
    id = "jerusalem_artichoke_boiled",
    result = "jerusalem_artichoke_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("jerusalem_artichoke", 1)
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_forage_cooking")
    :batch_discount(90, 2)
)

content.add(content.Recipe {
    id = "jerusalem_artichoke_fruitmash",
    result = "jerusalem_artichoke_fruitmash",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component("jerusalem_artichoke_boiled", 2)
    :component("sweet_fruit", 1, true)
    :quality("CUT", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_forage_cooking")
    :batch_discount(67, 5)
    :result_charges(4)
)

-- 2u for roasting a veggy
content.add(content.Recipe {
    id = "chili_pepper_roasted",
    result = "chili_pepper_roasted",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 2, true)
    :component("any_chili_pepper", 1, true)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "peanut_shelled",
    result = "peanut_shelled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "bag_canvas", count = 1 },
            { id = "pillowcase", count = 1 },
            { id = "sheet", count = 1 }
        })
    :component("peanut", 20)
    :quality("ANVIL", 1, 1)
    :batch_discount(20, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "hickory_nut_shelled",
    result = "hickory_nut_shelled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "bag_canvas", count = 1 },
            { id = "pillowcase", count = 1 },
            { id = "sheet", count = 1 }
        })
    :component("hickory_nut", 20)
    :quality("ANVIL", 1, 1)
    :batch_discount(20, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "walnut_shelled",
    result = "walnut_shelled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "bag_canvas", count = 1 },
            { id = "pillowcase", count = 1 },
            { id = "sheet", count = 1 }
        })
    :component("walnut", 20)
    :quality("ANVIL", 1, 1)
    :batch_discount(20, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "butternut_shelled",
    result = "butternut_shelled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "bag_canvas", count = 1 },
            { id = "pillowcase", count = 1 },
            { id = "sheet", count = 1 }
        })
    :component("butternut", 20)
    :quality("ANVIL", 1, 1)
    :batch_discount(20, 1)
    :result_charges(20)
    :byproduct("butternut_husk", 20)
)

content.add(content.Recipe {
    id = "vegan_butter_from_butternuts",
    result = "vegan_butter",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 20, true)
    :tool_any({
            { id = "bag_canvas", count = 1 },
            { id = "pillowcase", count = 1 },
            { id = "sheet", count = 1 }
        })
    :component_any({
            { id = "water", count = 10 },
            { id = "water_clean", count = 10 }
        })
    :component("butternut_shelled", 20)
    :quality("ANVIL", 1, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_forage_cooking")
    :batch_discount(90, 2)
)

content.add(content.Recipe {
    id = "hazelnut_shelled",
    result = "hazelnut_shelled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "bag_canvas", count = 1 },
            { id = "pillowcase", count = 1 },
            { id = "sheet", count = 1 }
        })
    :component("hazelnut", 20)
    :quality("ANVIL", 1, 1)
    :batch_discount(20, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "chestnut_shelled",
    result = "chestnut_shelled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "bag_canvas", count = 1 },
            { id = "pillowcase", count = 1 },
            { id = "sheet", count = 1 }
        })
    :component("chestnut", 20)
    :quality("ANVIL", 1, 1)
    :batch_discount(20, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "pecan_shelled",
    result = "pecan_shelled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "bag_canvas", count = 1 },
            { id = "pillowcase", count = 1 },
            { id = "sheet", count = 1 }
        })
    :component("pecan", 20)
    :quality("ANVIL", 1, 1)
    :batch_discount(20, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "almond_shelled",
    result = "almond_shelled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "bag_canvas", count = 1 },
            { id = "pillowcase", count = 1 },
            { id = "sheet", count = 1 }
        })
    :component("almond", 20)
    :quality("ANVIL", 1, 1)
    :batch_discount(20, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "pistachio_shelled",
    result = "pistachio_shelled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_any({
            { id = "bag_canvas", count = 1 },
            { id = "pillowcase", count = 1 },
            { id = "sheet", count = 1 }
        })
    :component("pistachio", 20)
    :quality("ANVIL", 1, 1)
    :batch_discount(20, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "acorns_blanching_active",
    result = "acorns_blanching_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 18000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_any({
            { id = "bag_canvas", count = 1 },
            { id = "pillowcase", count = 1 },
            { id = "sheet", count = 1 }
        })
    :component("acorns", 2)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :quality("HAMMER", 2, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(15, 10)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "groundnut_prepared",
    result = "groundnut_prepared",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("groundnut", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :proficiency("prof_knife_skills")
    :batch_discount(80, 4)
)

-- No proficiencies required. This is literally just boiling them in a pot of water
content.add(content.Recipe {
    id = "groundnut_boiled",
    result = "groundnut_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("groundnut_prepared", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :requires_skill("survival", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "succotash",
    result = "succotash",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "corn_kernels", count = 1 },
            { id = "can_corn", count = 1 },
            { id = "hominy", count = 1 }
        })
    :component_any({
            { id = "raw_beans", count = 1 },
            { id = "can_beans", count = 1 },
            { id = "dry_beans", count = 1 },
            { id = "dry_lentils", count = 1 },
            { id = "soybean", count = 1 },
            { id = "dry_soybean", count = 1 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "garlic_powder", count = 1 },
            { id = "seasoning_italian", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "wild_herbs", count = 1 }
        })
    :quality("COOK", 2, 1)
    :requires_skill("survival", 1)
    :book("cookbook_native", 1)
    :batch_discount(90, 1)
)

content.add(content.Recipe {
    id = "succotash_deluxe",
    result = "succotash_deluxe",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 78000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 7, true)
    :component_any({
            { id = "corn_kernels", count = 1 },
            { id = "can_corn", count = 1 },
            { id = "hominy", count = 1 }
        })
    :component_any({
            { id = "raw_beans", count = 1 },
            { id = "can_beans", count = 1 },
            { id = "dry_beans", count = 1 },
            { id = "dry_lentils", count = 1 },
            { id = "soybean", count = 1 },
            { id = "dry_soybean", count = 1 }
        })
    :component_any({
            { id = "onion", count = 2 },
            { id = "any_tomato", count = 1, requirement = true },
            { id = "jerusalem_artichoke", count = 1 },
            { id = "jerusalem_artichoke_boiled", count = 1 },
            { id = "groundnut_prepared", count = 1 },
            { id = "potato", count = 1 },
            { id = "any_zucchini", count = 1, requirement = true },
            { id = "any_bell_pepper", count = 1, requirement = true },
            { id = "pumpkin_cut", count = 1 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "garlic_powder", count = 1 },
            { id = "seasoning_italian", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "wild_herbs", count = 1 }
        })
    :component("any_butter_or_oil", 1, true)
    :quality("COOK", 2, 1)
    :requires_skill("survival", 1)
    :book("cookbook_native", 1)
    :batch_discount(90, 1)
)

-- 3u for 250g onion, and 1u for oil.
content.add(content.Recipe {
    id = "onion_sauteed",
    result = "onion_sauteed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component("onion", 1)
    :component("any_butter_or_oil", 2, true)
    :component_any({
            { id = "seasoning_mild", count = 1, requirement = true },
            { id = "salt", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(67, 1)
)

content.add(content.Recipe {
    id = "mashed_potato",
    result = "mashed_potato",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "potato", count = 1 },
            { id = "potato_boiled", count = 1 },
            { id = "veggy_potatolike", count = 1, requirement = true }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("any_butter_or_oil", 1, true)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("BOIL", 2, 1)
    :proficiency("prof_food_prep")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "vegetarian_dolmas",
    result = "vegetarian_dolmas",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 8, true)
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
