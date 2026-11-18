local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "seed_lotus_boiled",
    result = "seed_lotus_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("seed_lotus", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(80, 1)
)

content.add(content.Recipe {
    id = "fried_seeds",
    result = "fried_seeds",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :tool_charges("frying_oil", 1, true)
    :component_any({
            { id = "seed_weed", count = 1 },
            { id = "seed_poppy_bud", count = 1 },
            { id = "seed_sunflower", count = 1 },
            { id = "seed_pumpkin", count = 1 }
        })
    :quality("COOK", 2, 1)
    :batch_discount(80, 1)
)

content.add(content.Recipe {
    id = "roasted_coffee_bean",
    result = "roasted_coffee_bean",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 8, true)
    :component("coffee_bean", 1)
    :quality("COOK", 2, 1)
    :batch_discount(80, 4)
)

-- about 450-500 seeds per pumpkin, which is about a cup. these are fairly small pumpkins.
content.add(content.Recipe {
    id = "seed_pumpkin",
    result = "seed_pumpkin",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 6,
}
    :component("pumpkin", 1)
    :quality("CUT", 1, 1)
    :byproduct("pumpkin_cut", 4)
)

content.add(content.Recipe {
    id = "seed_watermelon",
    result = "seed_watermelon",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 5,
}
    :component("watermelon", 1)
    :quality("CUT", 1, 1)
    :byproduct("watermelon_wedge", 16)
)

content.add(content.Recipe {
    id = "seed_melon",
    result = "seed_melon",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 3,
}
    :component("melon", 1)
    :quality("CUT", 1, 1)
    :byproduct("melon_chunks", 4)
)

content.add(content.Recipe {
    id = "seed_cucumber",
    result = "seed_cucumber",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 2,
}
    :component("cucumber", 1)
    :quality("CUT", 1, 1)
    :byproduct("cucumber_cut", 1)
)

content.add(content.Recipe {
    id = "seed_gherkin",
    result = "seed_gherkin",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 2,
}
    :component("gherkin", 1)
    :quality("CUT", 1, 1)
    :byproduct("gherkin_cut", 1)
)

content.add(content.Recipe {
    id = "seed_eggplant_with_cutting_tool",
    result = "seed_eggplant",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 2,
}
    :component("eggplant", 1)
    :quality("CUT", 1, 1)
    :byproduct("eggplant_cut", 2)
)

content.add(content.Recipe {
    id = "seed_oats",
    result = "seed_oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("oats", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_oats_bulk",
    result = "seed_oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("oats", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "oats_seed_designation",
    result = "oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s from seeds"),
}
    :component("seed_oats", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "oats_bulk_seed_designation",
    result = "oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s from seeds"),
}
    :component("seed_oats", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_cattail",
    result = "seed_cattail",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("cattail_stalk", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_corn",
    result = "seed_corn",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("dry_corn", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_corn_bulk",
    result = "seed_corn",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("dry_corn", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "dry_corn_seed_designation",
    result = "dry_corn",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s from seeds"),
}
    :component("seed_corn", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "dry_corn_bulk_seed_designation",
    result = "dry_corn",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s from seeds"),
}
    :component("seed_corn", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_popcorn",
    result = "seed_popcorn",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("kernels", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_popcorn_bulk",
    result = "seed_popcorn",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("kernels", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "kernels_seed_designation",
    result = "kernels",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s from seeds"),
}
    :component("seed_popcorn", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "kernels_bulk_seed_designation",
    result = "kernels",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s from seeds"),
}
    :component("seed_popcorn", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_zucchini",
    result = "seed_zucchini",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 2,
}
    :component("zucchini", 1)
    :quality("CUT", 1, 1)
    :byproduct("zucchini_cut", 1)
)

content.add(content.Recipe {
    id = "seed_barley",
    result = "seed_barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("barley", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_barley_bulk",
    result = "seed_barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("barley", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "barley_seed_designation",
    result = "barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s from seeds"),
}
    :component("seed_barley", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "barley_bulk_seed_designation",
    result = "barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s from seeds"),
}
    :component("seed_barley", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_tomato",
    result = "seed_tomato",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("tomato", 1)
    :quality("CUT", 1, 1)
    :byproduct("tomato_cut", 1)
)

content.add(content.Recipe {
    id = "seed_cranberries",
    result = "seed_cranberries",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("cranberries", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_blackberries",
    result = "seed_blackberries",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("blackberries", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_blueberries",
    result = "seed_blueberries",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("blueberries", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_poppy_bud",
    result = "seed_poppy_bud",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 2,
}
    :component("poppy_bud", 4)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_salsify_raw",
    result = "seed_salsify_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("salsify_raw", 1)
)

content.add(content.Recipe {
    id = "seed_salsify_raw_bulk",
    result = "seed_salsify_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("salsify_raw", 10)
)

content.add(content.Recipe {
    id = "seed_chicory",
    result = "seed_chicory",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("chicory_raw", 1)
)

content.add(content.Recipe {
    id = "seed_chicory_bulk",
    result = "seed_chicory",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("chicory_raw", 10)
)

content.add(content.Recipe {
    id = "seed_wildcarrot",
    result = "seed_wildcarrot",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("carrot_wild", 3)
)

content.add(content.Recipe {
    id = "seed_wildcarrot_bulk",
    result = "seed_wildcarrot",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("carrot_wild", 30)
)

content.add(content.Recipe {
    id = "seed_raspberries",
    result = "seed_raspberries",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("raspberries", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_strawberries",
    result = "seed_strawberries",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("strawberries", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_elderberries",
    result = "seed_elderberries",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("elderberries", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_mulberries",
    result = "seed_mulberries",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("mulberries", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_huckleberries",
    result = "seed_huckleberries",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("huckleberries", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_grapes",
    result = "seed_grapes",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("grapes", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_rose",
    result = "seed_rose",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("rose_hips", 1)
    :quality("CUT", 1, 1)
    :byproduct("rose_hips_cut", 1)
)

content.add(content.Recipe {
    id = "seed_chili_pepper",
    result = "seed_chili_pepper",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 2,
}
    :component("chili_pepper", 1)
    :quality("CUT", 1, 1)
    :byproduct("chili_pepper_cut", 1)
)

content.add(content.Recipe {
    id = "seed_bell_pepper",
    result = "seed_bell_pepper",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 2,
}
    :component("bell_pepper", 1)
    :quality("CUT", 1, 1)
    :byproduct("bell_pepper_cut", 1)
)

content.add(content.Recipe {
    id = "seed_wheat",
    result = "seed_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("wheat", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_wheat_bulk",
    result = "seed_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("wheat", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_red_winter_wheat",
    result = "seed_red_winter_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("winter_wheat", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_red_winter_wheat_bulk",
    result = "seed_red_winter_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("winter_wheat", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "wheat_seed_designation",
    result = "wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s from seeds"),
}
    :component("seed_wheat", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "wheat_bulk_seed_designation",
    result = "wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s from seeds"),
}
    :component("seed_wheat", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_bee_balm",
    result = "seed_bee_balm",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("bee_balm", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_buckwheat",
    result = "seed_buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("buckwheat", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_buckwheat_bulk",
    result = "seed_buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("buckwheat", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "buckwheat_seed_designation",
    result = "buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s from seeds"),
}
    :component("seed_buckwheat", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "buckwheat_bulk_seed_designation",
    result = "buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s from seeds"),
}
    :component("seed_buckwheat", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_dogbane",
    result = "seed_dogbane",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("dogbane", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_garlic_clove",
    result = "seed_garlic_clove",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("garlic_clove", 6)
)

content.add(content.Recipe {
    id = "seed_garlic_clove_bulk",
    result = "seed_garlic_clove",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("garlic_clove", 60)
)

content.add(content.Recipe {
    id = "garlic_clove_seed_designation",
    result = "garlic_clove",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 6,
    name = content.text("%s from seeds"),
}
    :component("seed_garlic_clove", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "garlic_clove_bulk_seed_designatin",
    result = "garlic_clove",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 60,
    name = content.text("bulk %s from seeds"),
}
    :component("seed_garlic_clove", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_mugwort",
    result = "seed_mugwort",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("mugwort", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_mushroom",
    result = "seed_mushroom",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 4,
}
    :component("mushroom", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_mushroom_morel",
    result = "seed_mushroom_morel",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 5,
}
    :component("mushroom_morel", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_raw_dandelion",
    result = "seed_raw_dandelion",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 2,
}
    :component("raw_dandelion", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_raw_burdock",
    result = "seed_raw_burdock",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("raw_burdock", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_japanese_knotweed",
    result = "seed_japanese_knotweed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("japanese_knotweed_stem", 1)
)

content.add(content.Recipe {
    id = "seed_japanese_knotweed_bulk",
    result = "seed_japanese_knotweed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("japanese_knotweed_stem", 10)
)

content.add(content.Recipe {
    id = "seed_wild_rice",
    result = "seed_wild_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("wild_rice", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_wild_rice_bulk",
    result = "seed_wild_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("wild_rice", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "wild_rice_seed_designation",
    result = "wild_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s from seeds"),
}
    :component("seed_wild_rice", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "wild_rice_bulk_seed_designation",
    result = "wild_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s from seeds"),
}
    :component("seed_wild_rice", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_jerusalem_artichoke",
    result = "seed_jerusalem_artichoke",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("jerusalem_artichoke", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_maianthemum_stellatum",
    result = "seed_maianthemum_stellatum",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("m_stellatum_berries", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_wild_sarsaparilla",
    result = "seed_wild_sarsaparilla",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("wild_sarsaparilla_root", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_mayapple",
    result = "seed_mayapple",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("mayapple", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_wintergreen",
    result = "seed_wintergreen",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("wintergreen_berry", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_groundnut",
    result = "seed_groundnut",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("groundnut", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_wild_garlic",
    result = "seed_wild_garlic",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("wild_garlic", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_rhubarb",
    result = "seed_rhubarb",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :component("rhubarb", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_thyme",
    result = "seed_thyme",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("thyme", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_veggy_wild",
    result = "seed_veggy_wild",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("veggy_wild", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_wild_herbs",
    result = "seed_wild_herbs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("wild_herbs", 10)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_potato_raw",
    result = "seed_potato_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("potato", 1)
    :quality("CUT", 1, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "seed_potato_raw_bulk",
    result = "seed_potato_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("potato", 10)
    :quality("CUT", 1, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "seed_sunflower",
    result = "seed_sunflower",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 6,
}
    :component("sunflower", 1)
)

content.add(content.Recipe {
    id = "seed_sunflower_bulk",
    result = "seed_sunflower",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 60,
    name = content.text("bulk %s"),
}
    :component("sunflower", 10)
)

content.add(content.Recipe {
    id = "seed_beans",
    result = "seed_beans",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("dry_beans", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_beans_bulk",
    result = "seed_beans",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("dry_beans", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "dry_beans_seed_designation",
    result = "dry_beans",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s from seeds"),
}
    :component("seed_beans", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "dry_beans_bulk_seed_designation",
    result = "dry_beans",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s from seeds"),
}
    :component("seed_beans", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "soybean_seed",
    result = "soybean_seed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("dry_soybean", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "soybean_seed_bulk",
    result = "soybean_seed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("dry_soybean", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "dry_soybean_seed_designation",
    result = "dry_soybean",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s from seeds"),
}
    :component("soybean_seed", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "dry_soybean_bulk_seed_designation",
    result = "dry_soybean",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s from seeds"),
}
    :component("soybean_seed", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_lentils",
    result = "seed_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("dry_lentils", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_lentils_bulk",
    result = "seed_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("dry_lentils", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "dry_lentils_seed_designation",
    result = "dry_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s from seeds"),
}
    :component("seed_lentils", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "dry_lentils_bulk_seed_designation",
    result = "dry_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s from seeds"),
}
    :component("seed_lentils", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_chamomile",
    result = "seed_chamomile",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("chamomile", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "seed_sugar_beet",
    result = "seed_sugar_beet",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("sugar_beet", 1)
)

content.add(content.Recipe {
    id = "seed_sugar_beet_bulk",
    result = "seed_sugar_beet",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("sugar_beet", 10)
)

content.add(content.Recipe {
    id = "seed_bottle_gourd",
    result = "seed_bottle_gourd",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("raw_bottle_gourd", 3)
)

content.add(content.Recipe {
    id = "seed_bottle_gourd_bulk",
    result = "seed_bottle_gourd",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("raw_bottle_gourd", 30)
)

content.add(content.Recipe {
    id = "seed_cauliflower",
    result = "seed_cauliflower",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("cauliflower_head", 1)
)

content.add(content.Recipe {
    id = "seed_cauliflower_bulk",
    result = "seed_cauliflower",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("cauliflower_head", 10)
)

content.add(content.Recipe {
    id = "seed_artichoke",
    result = "seed_artichoke",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("raw_artichoke", 1)
)

content.add(content.Recipe {
    id = "seed_artichoke_bulk",
    result = "seed_artichoke",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("raw_artichoke", 10)
)

content.add(content.Recipe {
    id = "seed_asparagus",
    result = "seed_asparagus",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("raw_asparagus", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_asparagus_bulk",
    result = "seed_asparagus",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("raw_asparagus", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_brussels_sprout",
    result = "seed_brussels_sprout",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("brussels_sprout_stalk", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_brussels_sprout_bulk",
    result = "seed_brussels_sprout",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("brussels_sprout_stalk", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_kale",
    result = "seed_kale",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("kale_head", 1)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_kale_bulk",
    result = "seed_kale",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("kale_head", 10)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "seed_pea",
    result = "seed_pea",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("pea", 1)
)

content.add(content.Recipe {
    id = "seed_pea_bulk",
    result = "seed_pea",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SEEDS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("pea", 10)
)
