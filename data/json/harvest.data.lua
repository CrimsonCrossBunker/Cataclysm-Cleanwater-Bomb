local ccb = require("ccb")

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
ccb.content.define_harvest {
    id = "null",
    drops = {},
}

ccb.content.define_harvest {
    id = "exempt",
    drops = {},
}

ccb.content.define_harvest {
    id = "generic_flower_harv",
    drops = {
        { output = "withered", base_quantity = { 1, 2 } },
        { output = "seed_flower", base_quantity = { 1, 2 } },
    },
}

ccb.content.define_harvest {
    id = "dandelion_harv",
    drops = { { output = "raw_dandelion", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "burdock_harv",
    drops = { { output = "raw_burdock", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "burdock_summer_harv",
    drops = {
        { output = "raw_burdock", base_quantity = { 1, 4 } },
        { output = "plant_stalk", base_quantity = { 1, 4 } },
    },
}

ccb.content.define_harvest {
    id = "thistle_harv",
    drops = { { output = "plant_stalk", base_quantity = { 1, 2 } } },
}

ccb.content.define_harvest {
    id = "salsify_harv",
    drops = { { output = "salsify_raw" } },
}

ccb.content.define_harvest {
    id = "m_stellatum_harv",
    drops = { { output = "m_stellatum_berries", base_quantity = { 1, 3 } } },
}

ccb.content.define_harvest {
    id = "wild_carrot_harv",
    drops = { { output = "carrot_wild" } },
}

ccb.content.define_harvest {
    id = "wild_asparagus_harv",
    drops = { { output = "raw_asparagus" } },
}

ccb.content.define_harvest {
    id = "beehive_harv",
    message = ccb.content.text("You carefully crack open the hive structure and drain the liquid."),
    drops = {
        { output = "honeycomb", base_quantity = { 30, 180 } },
        { output = "wax", base_quantity = { 4, 5 } },
    },
}

ccb.content.define_harvest {
    id = "oyster_harv",
    message = ccb.content.text("You knock a few oysters loose from the rocks and gather them up."),
    drops = { { output = "oyster", base_quantity = { 1, 8 } } },
}

ccb.content.define_harvest {
    id = "jerusalem_artichoke_harv",
    drops = { { output = "jerusalem_artichoke", base_quantity = { 1, 3 } } },
}

ccb.content.define_harvest {
    id = "wild_sarsaparilla_harv",
    drops = { { output = "wild_sarsaparilla_root" } },
}

ccb.content.define_harvest {
    id = "salsify_seed_harv",
    drops = { { output = "seed_salsify_raw", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "chamomille_harv",
    drops = { { output = "chamomile", base_quantity = { 4, 8 } } },
}

ccb.content.define_harvest {
    id = "spurge_harv",
    drops = {
        { output = "withered", base_quantity = { 1, 2 } },
        { output = "seed_spurge", base_quantity = { 1, 2 } },
        { output = "spurge", base_quantity = { 1, 4 } },
    },
}

ccb.content.define_harvest {
    id = "sunflower_harv",
    drops = { { output = "sunflower" } },
}

ccb.content.define_harvest {
    id = "cattails_winter_harv",
    drops = { { output = "cattail_rhizome" } },
}

ccb.content.define_harvest {
    id = "cattails_summer_harv",
    drops = { { output = "cattail_rhizome" }, { output = "cattail_stalk", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "lotus_harv",
    drops = {
        { output = "withered", base_quantity = { 1, 2 } },
        { output = "lotus", base_quantity = { 1, 2 } },
    },
}

ccb.content.define_harvest {
    id = "lotus_summer_harv",
    drops = {
        { output = "withered", base_quantity = { 1, 2 } },
        { output = "lotus", base_quantity = { 1, 2 } },
        { output = "seed_lotus", base_quantity = { 1, 2 } },
    },
}

ccb.content.define_harvest {
    id = "lotus_autumn_harv",
    drops = {
        { output = "withered", base_quantity = { 1, 2 } },
        { output = "lotus", base_quantity = { 1, 2 } },
        { output = "lotus_rhizome", base_quantity = { 1, 2 } },
    },
}

ccb.content.define_harvest {
    id = "bluebell_harv",
    drops = {
        { output = "withered", base_quantity = { 1, 2 } },
        { output = "seed_flower", base_quantity = { 1, 2 } },
    },
}

ccb.content.define_harvest {
    id = "chicory_harv",
    drops = {
        { output = "chicory_raw", base_quantity = { 1, 2 } },
        { output = "chicory_leaves", base_quantity = { 1, 5 } },
    },
}

ccb.content.define_harvest {
    id = "datura_harv",
    drops = {
        { output = "datura_seed", base_quantity = { 2, 6 } },
        { output = "withered", base_quantity = { 1, 2 } },
    },
}

ccb.content.define_harvest {
    id = "mustard_harv",
    drops = { { output = "seed_mustard", base_quantity = { 2, 6 } } },
}

ccb.content.define_harvest {
    id = "walnut_harv",
    drops = { { output = "walnut", base_quantity = { 5, 12 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "butternut_harv",
    drops = { { output = "butternut", base_quantity = { 5, 12 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "fern_harv",
    drops = { { output = "fiddlehead_raw", base_quantity = { 1, 4 } } },
}

ccb.content.define_harvest {
    id = "bamboo_harv",
    drops = { { output = "raw_bamboo", base_quantity = { 4, 8 } } },
}

ccb.content.define_harvest {
    id = "shrub_rose_harv",
    drops = { { output = "rose_hips", base_quantity = { 1, 3 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "shrub_autumn_olive_harv",
    drops = { { output = "autumn_olive", base_quantity = { 4, 20 }, skill_quantity = { 0, 0.1 } } },
}

ccb.content.define_harvest {
    id = "shrub_chokeberry_harv",
    drops = { { output = "chokeberries", base_quantity = { 6, 12 }, skill_quantity = { 0, 0.1 } } },
}

ccb.content.define_harvest {
    id = "shrub_spicebush_harv",
    drops = { { output = "spicebush_berries", base_quantity = { 1, 4 }, skill_quantity = { 0, 0.1 } } },
}

ccb.content.define_harvest {
    id = "shrub_grape_harv",
    drops = {
        { output = "grapes", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } },
        { output = "grape_leaves", base_quantity = { 1, 4 } },
    },
}

ccb.content.define_harvest {
    id = "shrub_raspberry_harv",
    drops = { { output = "raspberries", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "shrub_huckleberry_harv",
    drops = { { output = "huckleberries", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "shrub_blackberry_harv",
    drops = { { output = "blackberries", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "shrub_strawberry_harv",
    drops = { { output = "strawberries", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "shrub_blueberry_harv",
    drops = { { output = "blueberries", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "shrub_hobblebush_harv",
    drops = { { output = "hobbleberries", base_quantity = { 1, 2 }, skill_quantity = { 0, 0.1 } } },
}

ccb.content.define_harvest {
    id = "shrub_peanut_harv",
    drops = { { output = "peanut", base_quantity = { 5, 10 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "pecan_harv",
    drops = { { output = "pecan", base_quantity = { 5, 12 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "almond_harv",
    drops = { { output = "almond", base_quantity = { 5, 12 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "pistachio_harv",
    drops = { { output = "pistachio", base_quantity = { 5, 12 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "hickory_harv",
    drops = { { output = "hickory_nut", base_quantity = { 5, 12 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "willow_harv",
    drops = { { output = "willowbark", base_quantity = { 2, 8 } } },
}

ccb.content.define_harvest {
    id = "birch_harv",
    drops = { { output = "birchbark", base_quantity = { 2, 8 } } },
}

ccb.content.define_harvest {
    id = "tree_dead_harv",
    drops = { { output = "stick", base_quantity = { 2, 5 } }, { output = "twig", base_quantity = { 6, 20 } } },
}

ccb.content.define_harvest {
    id = "pine_harv",
    drops = {
        { output = "pine_bough", base_quantity = { 2, 8 } },
        { output = "pinecone", base_quantity = { 1, 4 } },
        { output = "pine_resin", base_quantity = { 1, 3 } },
    },
}

ccb.content.define_harvest {
    id = "elderberry_harv",
    drops = { { output = "elderberries", base_quantity = { 8, 20 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "nannyberry_harv",
    drops = { { output = "nannyberries", base_quantity = { 8, 20 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "tupelo_harv",
    drops = { { output = "tupelo_fruit", base_quantity = { 8, 20 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "mulberry_harv",
    drops = { { output = "mulberries", base_quantity = { 8, 20 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "plum_harv",
    drops = { { output = "plums", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "apricot_harv",
    drops = { { output = "apricot", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "peach_harv",
    drops = { { output = "peach", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "juniper_harv",
    drops = { { output = "juniper", base_quantity = { 12, 24 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "cherry_harv",
    drops = { { output = "cherries", base_quantity = { 6, 18 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "coffee_harv",
    drops = { { output = "coffee_pod", base_quantity = { 4, 10 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "pear_harv",
    drops = { { output = "pear", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "apple_harv",
    drops = { { output = "apple", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "crabapple_harv",
    drops = { { output = "crabapple", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "sassafras_harv",
    drops = { { output = "sassafras_root", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "oak_harv",
    drops = { { output = "acorns", base_quantity = { 5, 12 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "cottonwood_harv",
    drops = { { output = "cottonwood_tree_boll", base_quantity = { 3, 6 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "beech_harv",
    drops = { { output = "beech_nuts", base_quantity = { 5, 12 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "hazelnut_harv",
    drops = { { output = "hazelnut", base_quantity = { 5, 12 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "chestnut_harv",
    drops = { { output = "chestnut", base_quantity = { 5, 12 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "blackjack_harv",
    drops = { { output = "tanbark", base_quantity = { 1, 2 } } },
}

ccb.content.define_harvest {
    id = "alder_harv",
    drops = { { output = "alder_bark", base_quantity = { 2, 5 }, skill_quantity = { 0, 1 } } },
}

ccb.content.define_harvest {
    id = "young_leaves_harv",
    drops = { { output = "young_leaves", base_quantity = { 2, 5 }, skill_quantity = { 0, 1 } } },
}

ccb.content.define_harvest {
    id = "shrub_alien_meadow_shrub_2_harv",
    drops = { { output = "alien_meadow_bush_2_fruit", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "tree_alien_meadow_tree_3_harv",
    drops = { { output = "alien_meadow_tree_3_fruit", base_quantity = { 1, 4 }, skill_quantity = { 1, 1 } } },
}

ccb.content.define_harvest {
    id = "generic_edible_flower_spring_harv",
    drops = {
        { output = "young_leaves", base_quantity = { 2, 5 }, skill_quantity = { 0, 1 } },
        { output = "withered", base_quantity = { 1, 2 }, skill_quantity = { 0, 1 } },
        { output = "plant_stalk", base_quantity = { 0, 1 } },
        { output = "plant_fibre", base_quantity = { 0, 2 }, skill_quantity = { 0, 1 } },
    },
}

ccb.content.define_harvest {
    id = "generic_edible_flower_harv",
    drops = {
        { output = "withered", base_quantity = { 1, 2 }, skill_quantity = { 0, 1 } },
        { output = "plant_fibre", base_quantity = { 0, 2 }, skill_quantity = { 0, 1 } },
    },
}

ccb.content.define_harvest {
    id = "dogbane_harv",
    drops = { { output = "dogbane", base_quantity = { 1, 3 }, skill_quantity = { 0, 1 } } },
}

ccb.content.define_harvest {
    id = "japanese_knotweed_harv",
    drops = { { output = "japanese_knotweed_stem", base_quantity = { 1, 2 } } },
}

ccb.content.define_harvest {
    id = "wild_rice_harv",
    drops = { { output = "wild_rice", base_quantity = { 2, 4 } } },
}

ccb.content.define_harvest {
    id = "wintergreen_harv",
    drops = {
        { output = "wintergreen_berry", base_quantity = { 1, 4 } },
        { output = "wintergreen_leaves", base_quantity = { 1, 2 } },
    },
}

ccb.content.define_harvest {
    id = "seaweed_harv",
    drops = { { output = "seaweed" } },
}

ccb.content.define_harvest {
    id = "kelp_sugar_harv",
    drops = { { output = "kelp_sugar" } },
}

ccb.content.define_harvest {
    id = "bladderwrack_harv",
    drops = { { output = "bladderwrack" } },
}

ccb.content.define_harvest {
    id = "sea_lettuce_harv",
    drops = { { output = "sea_lettuce" } },
}

ccb.content.define_harvest {
    id = "fish_tiny",
    drops = {
        { output = "fish", category = "flesh", mass_ratio = 0.32 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "fish_scrap", category = "flesh", mass_ratio = 0.08 },
    },
}

ccb.content.define_harvest {
    id = "fish_small",
    drops = {
        { output = "fish", category = "flesh", mass_ratio = 0.32 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "fish_scrap", category = "flesh", mass_ratio = 0.08 },
        { output = "bone", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "fish_large",
    message = ccb.content.text("You gut and fillet the fish."),
    drops = {
        { output = "fish", category = "flesh", mass_ratio = 0.38 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "fish_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "bone", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "mutant_fish",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.38 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_liver", category = "offal", mass_ratio = 0.01 },
        { output = "bone", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "shellfish",
    message = ccb.content.text("You carefully crack open its exoskeleton to get at the flesh beneath."),
    drops = {
        { output = "fish", category = "flesh", mass_ratio = 0.32 },
        { output = "fish_scrap", category = "flesh", mass_ratio = 0.03 },
        { output = "chitin_piece", category = "skin", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "lobster",
    message = ccb.content.text("You carefully crack open its exoskeleton to get at the flesh beneath."),
    drops = {
        { output = "lobster", category = "flesh", mass_ratio = 0.32 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.03 },
        { output = "chitin_piece", category = "skin", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "mutant_shellfish",
    message = ccb.content.text("You crack open its hard shell to get at the flesh beneath."),
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.32 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "chitin_piece", category = "skin", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "mon_broken_cyborg",
    message = ccb.content.text("You search for any salvageable hardware in what's left of this failed experiment."),
    drops = {
        { output = "skull_human", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        {
            output = "cable",
            base_quantity = { 1, 3 },
            skill_quantity = { 0.2, 0.6 },
            maximum = 8,
            category = "flesh",
        },
        {
            output = "bone_human",
            base_quantity = { 1, 2 },
            skill_quantity = { 0.4, 0.7 },
            maximum = 10,
            category = "bone",
        },
        { output = "blood", mass_ratio = 0.1, category = "blood" },
        {
            output = "scrap",
            base_quantity = { 1, 5 },
            skill_quantity = { 0.3, 0.7 },
            maximum = 12,
            category = "bone",
        },
    },
}

ccb.content.define_harvest {
    id = "mon_zomborg",
    message = ccb.content.text("You search for any salvageable hardware in what's left of this flesh and metal monster.  Much of it is just scrap metal, but some of the electronics look surprisingly intact."),
    drops = {
        { output = "skull_human_tainted", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.1 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.04 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.05 },
        { output = "tainted_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        {
            output = "cable",
            base_quantity = { 1, 3 },
            skill_quantity = { 0.2, 0.9 },
            maximum = 8,
            category = "flesh",
        },
        {
            output = "e_scrap",
            base_quantity = { 1, 5 },
            skill_quantity = { 0.3, 0.9 },
            maximum = 12,
            category = "offal",
        },
        {
            output = "scrap",
            base_quantity = { 1, 5 },
            skill_quantity = { 0.1, 0.5 },
            maximum = 12,
            category = "bone",
        },
        { output = "xlframe", skill_quantity = { 0.3, 0.9 }, maximum = 1, category = "bone" },
        {
            output = "sheet_metal_small",
            base_quantity = { 1, 5 },
            skill_quantity = { 0.3, 0.9 },
            maximum = 12,
            category = "skin",
        },
    },
}

-- animals so tiny they don't drop chunks of meat
ccb.content.define_harvest {
    id = "mammal_tiny",
    drops = {
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.5 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
    },
}

-- mutants so tiny they don't drop chunks of meat
ccb.content.define_harvest {
    id = "mutant_tiny",
    drops = {
        { output = "mutant_meat_scrap", category = "flesh", mass_ratio = 0.5 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
    },
}

-- does not drop stomach or other small organs
ccb.content.define_harvest {
    id = "mammal_small_fur",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.28 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.04 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_fur", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- does not drop stomach or other small organs
ccb.content.define_harvest {
    id = "mutant_mammal_small_fur",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.28 },
        { output = "mutant_meat_scrap", category = "flesh", mass_ratio = 0.04 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_lung", category = "offal", mass_ratio = 0.0035 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_liver", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_brain", category = "offal", mass_ratio = 0.005 },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_fur", category = "skin", mass_ratio = 0.02 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops regular stomach
ccb.content.define_harvest {
    id = "mammal_fur",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.3 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_fur", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops regular stomach
ccb.content.define_harvest {
    id = "mutant_mammal_fur",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "mutant_meat_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_lung", category = "offal", mass_ratio = 0.0035 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_liver", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_brain", category = "offal", mass_ratio = 0.05 },
        { output = "mutant_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "mutant_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_fur", category = "skin", mass_ratio = 0.02 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "mammal_large_fur",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.31 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_fur", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops large stomach & pork belly
ccb.content.define_harvest {
    id = "mammal_large_pig",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.28 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.04 },
        { output = "porkbelly", category = "flesh", mass_ratio = 0.06 },
    },
}

-- drops large stomach & pork belly & fur
ccb.content.define_harvest {
    id = "mammal_large_boar",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.28 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_fur", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.04 },
        { output = "porkbelly", category = "flesh", mass_ratio = 0.06 },
    },
}

-- does not drop organs and minimal porkbelly.
ccb.content.define_harvest {
    id = "mammal_small_boar",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.26 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.04 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_fur", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.05 },
        { output = "porkbelly", category = "flesh", mass_ratio = 0.04 },
    },
}

-- does not drop organs and minimal porkbelly
ccb.content.define_harvest {
    id = "mammal_small_pig",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.26 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.04 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.05 },
        { output = "porkbelly", category = "flesh", mass_ratio = 0.04 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "mutant_mammal_large_fur",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.31 },
        { output = "mutant_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "mutant_lung", category = "offal", mass_ratio = 0.0035 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_liver", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_brain", category = "offal", mass_ratio = 0.005 },
        { output = "mutant_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "mutant_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_fur", category = "skin", mass_ratio = 0.02 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops regular stomach
ccb.content.define_harvest {
    id = "human_fur",
    drops = {
        { output = "skull_human", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "mutant_human_flesh", category = "flesh", mass_ratio = 0.33 },
        { output = "mutant_human_heart", category = "offal", mass_ratio = 0.01 },
        { output = "hstomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "mutant_human_blood", category = "blood", mass_ratio = 0.1 },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "mutant_human_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_hfur", category = "skin", mass_ratio = 0.02 },
        { output = "mutant_human_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "human_large_fur",
    drops = {
        { output = "mutant_human_flesh", category = "flesh", mass_ratio = 0.33 },
        { output = "hstomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "mutant_human_heart", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_human_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "mutant_human_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_hfur", category = "skin", mass_ratio = 0.02 },
        { output = "mutant_human_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops regular stomach
ccb.content.define_harvest {
    id = "demihuman_fur",
    drops = {
        { output = "demihuman_flesh", category = "flesh", mass_ratio = 0.2 },
        { output = "demihuman_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "demihuman_blood", category = "blood", mass_ratio = 0.1 },
        { output = "demihuman_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "demihuman_liver", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_heart", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "demihuman_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "demihuman_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "demihuman_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "bone_demihuman", category = "bone", mass_ratio = 0.12 },
        { output = "demihuman_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        { output = "raw_hfur", category = "skin", mass_ratio = 0.01 },
        { output = "demihuman_fat", category = "flesh", mass_ratio = 0.1 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "demihuman_large_fur",
    drops = {
        { output = "demihuman_flesh", category = "flesh", mass_ratio = 0.31 },
        { output = "demihuman_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "demihuman_stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "demihuman_liver", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_heart", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "demihuman_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "demihuman_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "demihuman_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "bone_demihuman", category = "bone", mass_ratio = 0.15 },
        { output = "demihuman_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "demihuman_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_hfur", category = "skin", mass_ratio = 0.02 },
        { output = "demihuman_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- does not drop stomach or other small organs
ccb.content.define_harvest {
    id = "mammal_small_leather",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.28 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.04 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops regular stomach
ccb.content.define_harvest {
    id = "mammal_leather",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.3 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops regular stomach
ccb.content.define_harvest {
    id = "mutant_mammal_leather",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "mutant_meat_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "mutant_lung", category = "offal", mass_ratio = 0.0035 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_liver", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_brain", category = "offal", mass_ratio = 0.005 },
        { output = "mutant_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "mutant_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "mammal_large_leather",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.31 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "mutant_mammal_large_leather",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.31 },
        { output = "mutant_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "mutant_lung", category = "offal", mass_ratio = 0.0035 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_liver", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_brain", category = "offal", mass_ratio = 0.005 },
        { output = "mutant_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "mutant_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- does not drop stomach or other small organs
ccb.content.define_harvest {
    id = "mammal_small_wool",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.28 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.04 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "wool_staple", category = "skin", mass_ratio = 0.02 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "mammal_large_wool",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.31 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "wool_staple", category = "skin", mass_ratio = 0.21 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}

ccb.content.define_harvest {
    id = "kraken",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.36 },
        { output = "ballast", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "mutant_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "kraken_large",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.36 },
        { output = "ballast", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "mutant_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "sinew", category = "bone", mass_ratio = 0.0035 },
        { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- drops large stomach
ccb.content.define_harvest {
    id = "kraken_queen",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.36 },
        { output = "ballast", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "mutant_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "stomach_large", skill_quantity = { 3, 6 }, maximum = 6, category = "offal" },
        { output = "sinew", category = "bone", mass_ratio = 0.0075 },
        { output = "raw_leather", category = "skin", mass_ratio = 0.02 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- for those vertebrates that don't have something you can skin off of them
ccb.content.define_harvest {
    id = "animal_noskin",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.3 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- for those vertebrates that don't have something you can skin off of them
ccb.content.define_harvest {
    id = "mutant_animal_noskin",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "mutant_meat_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "mutant_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_liver", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "mutant_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "mutant_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- for those vertebrates that don't have something you can skin off of them
ccb.content.define_harvest {
    id = "animal_large_noskin",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.31 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "brain", category = "flesh", mass_ratio = 0.005 },
        { output = "sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "bone_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- for those vertebrates that don't have something you can skin off of them
ccb.content.define_harvest {
    id = "mutant_animal_large_noskin",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.31 },
        { output = "mutant_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "mutant_lung", category = "offal", mass_ratio = 0.0035 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_liver", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_brain", category = "offal", mass_ratio = 0.005 },
        { output = "mutant_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "stomach_large", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "mutant_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.07 },
    },
}

-- no bones or organs
ccb.content.define_harvest {
    id = "meatslug",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.4 },
        { output = "fat", category = "flesh", mass_ratio = 0.1 },
        { output = "fat", category = "offal", mass_ratio = 0.1 },
    },
}

-- no bones or organs
ccb.content.define_harvest {
    id = "mutant_meatslug",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.4 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "mutant_fat", category = "offal", mass_ratio = 0.1 },
    },
}

-- no bones or organs, copied from meatslug but may be expanded
ccb.content.define_harvest {
    id = "mollusk",
    drops = {
        { output = "mollusk", category = "flesh", mass_ratio = 0.4 },
        { output = "fat", category = "flesh", mass_ratio = 0.1 },
        { output = "fat", category = "offal", mass_ratio = 0.1 },
    },
}

-- no bones or organs, copied from mutant meatslug but may be expanded
ccb.content.define_harvest {
    id = "mutant_mollusk",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.4 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "mutant_fat", category = "offal", mass_ratio = 0.1 },
    },
}

-- no bones or organs, copied from mutant meatslug but may be expanded
ccb.content.define_harvest {
    id = "mutant_mollusk_acid",
    drops = {
        { output = "blood_acid_insect", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.4 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "mutant_fat", category = "offal", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "bird_tiny",
    drops = {
        { output = "poultry_scrap", category = "flesh", mass_ratio = 0.4 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "feather", category = "skin", mass_ratio = 0.01 },
        { output = "down_feather", category = "skin", mass_ratio = 0.005 },
    },
}

ccb.content.define_harvest {
    id = "bird_small",
    drops = {
        { output = "poultry", category = "flesh", mass_ratio = 0.3 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "poultry_scrap", category = "flesh", mass_ratio = 0.04 },
        { output = "liver", category = "offal", mass_ratio = 0.01 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "feather", category = "skin", mass_ratio = 0.01 },
        { output = "down_feather", category = "skin", mass_ratio = 0.005 },
    },
}

ccb.content.define_harvest {
    id = "bird_large",
    drops = {
        { output = "poultry", category = "flesh", mass_ratio = 0.3 },
        { output = "animal_blood", category = "blood", mass_ratio = 0.1 },
        { output = "poultry_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "heart", category = "offal", mass_ratio = 0.01 },
        { output = "fat", category = "flesh", mass_ratio = 0.18 },
        { output = "feather", category = "skin", mass_ratio = 0.02 },
        { output = "down_feather", category = "skin", mass_ratio = 0.01 },
        { output = "bone", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "mutant_bird",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_meat_scrap", category = "flesh", mass_ratio = 0.45 },
        { output = "mutant_lung", category = "offal", mass_ratio = 0.0035 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_liver", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_brain", category = "offal", mass_ratio = 0.003 },
        { output = "mutant_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "bone", category = "bone", mass_ratio = 0.05 },
        { output = "feather", category = "skin", mass_ratio = 0.01 },
        { output = "down_feather", category = "skin", mass_ratio = 0.005 },
    },
}

-- for mutant birds that are flightless: more fat, feathers & bone, since weight matters less for them
ccb.content.define_harvest {
    id = "mutant_bird_flightless",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_meat_scrap", category = "flesh", mass_ratio = 0.02 },
        { output = "mutant_lung", category = "offal", mass_ratio = 0.0035 },
        { output = "mutant_heart", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_liver", category = "offal", mass_ratio = 0.01 },
        { output = "mutant_brain", category = "offal", mass_ratio = 0.003 },
        { output = "mutant_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.18 },
        { output = "bone", category = "bone", mass_ratio = 0.1 },
        { output = "feather", category = "skin", mass_ratio = 0.02 },
        { output = "down_feather", category = "skin", mass_ratio = 0.01 },
    },
}

ccb.content.define_harvest {
    id = "flesh_golem",
    message = ccb.content.text("You messily hack apart the hulking mass of fused, rancid flesh, taking note of anything that stands out."),
    drops = {
        { output = "skull_human_tainted", category = "bone", base_quantity = { 0, 2 } },
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.33 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.01 },
        { output = "tainted_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.1 },
        { output = "tainted_innards", category = "offal", mass_ratio = 0.25 },
        {
            output = "flesh_golem_heart",
            base_quantity = { 0, 1 },
            skill_quantity = { 0.6, 0.9 },
            maximum = 3,
            category = "offal",
        },
    },
}

-- what, you thought jabberwocks only had one heart?
ccb.content.define_harvest {
    id = "jabberwock",
    message = ccb.content.text("You messily hack apart the colossal mass of fused, rancid flesh, taking note of anything that stands out."),
    drops = {
        { output = "skull_human_tainted", category = "bone", base_quantity = { 0, 3 } },
        { output = "skull_moose", category = "bone", base_quantity = { 0, 1 } },
        { output = "skull_cervine_spideer", category = "bone", base_quantity = { 0, 1 } },
        { output = "skull_canis_triclopean", category = "bone", base_quantity = { 0, 1 } },
        { output = "skull_rodent", category = "bone", base_quantity = { 0, 6 } },
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.33 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
        { output = "tainted_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.1 },
        { output = "tainted_innards", category = "offal", mass_ratio = 0.25 },
        {
            output = "jabberwock_heart",
            base_quantity = { 0, 1 },
            skill_quantity = { 0.6, 0.9 },
            maximum = 3,
            category = "offal",
        },
    },
}

ccb.content.define_harvest {
    id = "arachnid",
    message = "<arachnid_harvest>",
    drops = {
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.33 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.04 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_acid",
    message = "<acidant_harvest>",
    drops = {
        { output = "blood_acid_insect", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.33 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.04 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "acidchitin_piece", category = "bone", mass_ratio = 0.04 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.06 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_acid_queen",
    message = ccb.content.text("You laboriously dissect the colossal insect.  <acidant_harvest>"),
    drops = {
        {
            output = "mutant_meat",
            base_quantity = { 40, 55 },
            skill_quantity = { 0.5, 0.7 },
            maximum = 80,
            category = "flesh",
        },
        {
            output = "acidchitin_piece",
            base_quantity = { 2, 4 },
            skill_quantity = { 0.3, 0.6 },
            maximum = 10,
            category = "bone",
        },
        {
            output = "chitin_piece",
            base_quantity = { 0, 3 },
            skill_quantity = { 0.3, 0.6 },
            maximum = 10,
            category = "bone",
        },
        { output = "blood_acid_insect", category = "blood", mass_ratio = 0.1 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        {
            output = "mutant_fat",
            base_quantity = { 5, 8 },
            skill_quantity = { 0.6, 0.8 },
            maximum = 18,
            category = "flesh",
        },
    },
}

-- More legs = more sinew, more endochitin, less rest
ccb.content.define_harvest {
    id = "arachnid_centipede",
    message = "<centipede_harvest>",
    drops = {
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.2 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.01 },
        { output = "sinew", category = "bone", mass_ratio = 0.05 },
        { output = "endochitin", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.01 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.08 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_centipede_mom",
    message = "<centipede_mom_harvest>",
    drops = {
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.2 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.01 },
        { output = "sinew", category = "bone", mass_ratio = 0.05 },
        { output = "endochitin", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.01 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.08 },
        {
            output = "egg_centipede",
            category = "offal",
            base_quantity = { 3, 10 },
            skill_quantity = { 0.5, 1 },
            maximum = 30,
        },
    },
}

-- Chitin plate comes here, lots of muscle
ccb.content.define_harvest {
    id = "arachnid_centipede_mega",
    message = "<centipede_mega_harvest>",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.4 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.015 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.05 },
        { output = "endochitin", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.01 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.2 },
        {
            output = "egg_centipede",
            category = "offal",
            base_quantity = { 0, 3 },
            skill_quantity = { 0.5, 1 },
            maximum = 10,
        },
    },
}

-- replace some chitin with plate when added
ccb.content.define_harvest {
    id = "arachnid_beetle",
    message = "<ground_beetle_harvest>",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.25 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.06 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.035 },
        { output = "endochitin", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.005 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.03 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.3 },
    },
}

-- replace most chitin with plate when added
ccb.content.define_harvest {
    id = "arachnid_beetle_mega",
    message = "<ground_beetle_mega_harvest>",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.25 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.06 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.035 },
        { output = "endochitin", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.005 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.03 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.3 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_beetle_solar",
    message = "<solar_beetle_harvest>",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.25 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.06 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.035 },
        { output = "plastic_chunk", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.005 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.03 },
        { output = "glass_shard", category = "bone", mass_ratio = 0.3 },
        {
            output = "solar_cell",
            category = "bone",
            base_quantity = { 0, 8 },
            skill_quantity = { 0.5, 1 },
            maximum = 16,
        },
    },
}

ccb.content.define_harvest {
    id = "arachnid_beetle_solar_starving",
    message = "<solar_beetle_malnourished_harvest>",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.05 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.001 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.035 },
        { output = "plastic_chunk", category = "bone", mass_ratio = 0.2 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.005 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.01 },
        { output = "glass_shard", category = "bone", mass_ratio = 0.3 },
        {
            output = "solar_cell",
            category = "bone",
            base_quantity = { 0, 8 },
            skill_quantity = { 0.5, 1 },
            maximum = 16,
        },
    },
}

ccb.content.define_harvest {
    id = "arachnid_flying",
    message = "<arachnid_flying_harvest>",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.003 },
        { output = "endochitin", category = "bone", mass_ratio = 0.01 },
        { output = "mutant_bug_hydrogen_sacs", category = "flesh", mass_ratio = 0.1 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.01 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.03 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_bee",
    message = ccb.content.text("What appeared to be insect hairs on the chitin of this creature look more like tiny feathers as you pare them back.  Inside is a bundle of bubble-like tissue sacs that appear to be floating, which doesn't fit with what you know about real bees."),
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.23 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "mutant_bug_hydrogen_sacs", category = "flesh", mass_ratio = 0.1 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "bee_sting", base_quantity = { 0, 1 }, category = "bone" },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
        { output = "venom_bee", category = "offal", mass_ratio = 0.01 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_dragonfly_mega",
    message = ccb.content.text("As you hack away at the chitinous amalgamation you can't help but follow the tunnel the (male?) dragonfly's tail bore into the flesh of its mate, ending up at a formless amalgamation of eyes, jaws, eggs, and ganglia deep within.  Love truly knows no bounds."),
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.2 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.04 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
        {
            output = "egg_dragonfly",
            category = "offal",
            base_quantity = { 5, 35 },
            skill_quantity = { 0.3, 0.5 },
        },
    },
}

-- copied from arachnid_flying+egg
ccb.content.define_harvest {
    id = "arachnid_firefly",
    message = "<firefly_harvest>",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.01 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_bug_hydrogen_sacs", category = "flesh", mass_ratio = 0.2 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.01 },
        { output = "egg_firefly", category = "offal", base_quantity = { 0, 3 } },
    },
}

ccb.content.define_harvest {
    id = "arachnid_spider",
    message = "<spider_harvest>",
    copy_from = "arachnid",
    drops = {
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.33 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.04 },
        { output = "sinew", category = "bone", mass_ratio = 0.01 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.006 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_tainted",
    message = "<arachnid_harvest>",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.33 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.0035 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.015 },
        { output = "endochitin", category = "bone", mass_ratio = 0.1 },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "arachnid_wasp",
    message = "<wasp_harvest>",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.3 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.003 },
        { output = "endochitin", category = "bone", mass_ratio = 0.01 },
        { output = "mutant_bug_hydrogen_sacs", category = "flesh", mass_ratio = 0.1 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.01 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.03 },
        { output = "wasp_sting", base_quantity = { 0, 1 }, category = "bone" },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
        { output = "venom_wasp", category = "offal", base_quantity = { 0, 3 }, skill_quantity = { 0, 2 } },
    },
}

ccb.content.define_harvest {
    id = "arachnid_wasp_queen",
    message = "<wasp_queen_harvest>",
    drops = {
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.2 },
        { output = "mutant_blood", category = "blood", mass_ratio = 0.1 },
        { output = "sinew", category = "bone", mass_ratio = 0.003 },
        { output = "endochitin", category = "bone", mass_ratio = 0.01 },
        { output = "mutant_bug_hydrogen_sacs", category = "flesh", mass_ratio = 0.1 },
        { output = "mutant_bug_lungs", category = "flesh", mass_ratio = 0.01 },
        { output = "mutant_bug_organs", category = "offal", mass_ratio = 0.03 },
        { output = "wasp_sting", base_quantity = { 0, 1 }, category = "bone" },
        { output = "chitin_piece", category = "bone", mass_ratio = 0.1 },
        { output = "egg_wasp", category = "offal", base_quantity = { 10, 30 }, skill_quantity = { 5, 5 } },
        { output = "venom_wasp", category = "offal", base_quantity = { 5, 25 }, skill_quantity = { 5, 2 } },
    },
}

-- the larvae ate a lot of the good stuff, mutant meat represents the grubs
ccb.content.define_harvest {
    id = "incubator_mammal",
    message = "<incubator_mammal>",
    drops = {
        { output = "meat", category = "flesh", mass_ratio = 0.05 },
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.2 },
        { output = "meat_scrap", category = "flesh", mass_ratio = 0.1 },
        { output = "stomach", skill_quantity = { 0, 1 }, maximum = 1, category = "offal" },
        { output = "bone", category = "bone", mass_ratio = 0.15 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
    },
}

-- any zombie that might drop leather. mostly animals.
ccb.content.define_harvest {
    id = "zombie_leather",
    copy_from = "zombie_animal",
    extend = { drops = { { output = "raw_tainted_leather", category = "skin", mass_ratio = 0.02 } } },
}

-- any zombie that might drop fur. mostly animals.
ccb.content.define_harvest {
    id = "zombie_fur",
    copy_from = "zombie_animal",
    extend = { drops = { { output = "raw_tainted_fur", category = "skin", mass_ratio = 0.02 } } },
}

-- zombified dogs with harvestable fur.
ccb.content.define_harvest {
    id = "zombie_dog",
    copy_from = "zombie_fur",
    message = "<zombie_dog_harvest>",
}

-- no bones or organs
ccb.content.define_harvest {
    id = "zombie_meatslug",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.4 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.1 },
        { output = "fat_tainted", category = "offal", mass_ratio = 0.1 },
    },
}

-- just the bones for corpses to rot away into
ccb.content.define_harvest {
    id = "zombie_decay_bone",
    drops = { { output = "bone_tainted", category = "bone", mass_ratio = 0.1 } },
}

-- just the bones for corpses to rot away into + a human skull
ccb.content.define_harvest {
    id = "zombie_decay_bone_human_skull",
    copy_from = "zombie_decay_bone",
    extend = {
        drops = {
            { output = "skull_human_tainted", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
}

-- your bog standard humanoid zombie
ccb.content.define_harvest {
    id = "zombie_humanoid",
    copy_from = "zombie_decay_bone_human_skull",
    message = "<zombie_humanoid_generic_harvest>",
    extend = {
        drops = {
            { output = "meat_tainted_human", category = "flesh", mass_ratio = 0.25 },
            { output = "blood_tainted_human", category = "blood", mass_ratio = 0.1 },
            { output = "fat_tainted_human", category = "flesh", mass_ratio = 0.08 },
            { output = "tainted_innards_human", category = "offal", mass_ratio = 0.15 },
            { output = "tainted_marrow_human", category = "bone", mass_ratio = 0.005 },
            { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        },
    },
}

ccb.content.define_harvest {
    id = "zombie_decay_bone_human_skull_rust",
    copy_from = "zombie_decay_bone_human_skull",
    extend = {
        drops = {
            { output = "budget_steel_chunk", category = "flesh", mass_ratio = 0.075 },
            { output = "scrap", category = "flesh", mass_ratio = 0.025 },
        },
    },
}

ccb.content.define_harvest {
    id = "zombie_rust",
    copy_from = "zombie_humanoid",
    delete = { drops = { { output = "meat_tainted", category = "flesh", mass_ratio = 0.25 } } },
    extend = {
        drops = {
            { output = "meat_tainted", category = "flesh", mass_ratio = 0.175 },
            { output = "budget_steel_chunk", category = "flesh", mass_ratio = 0.075 },
            { output = "scrap", category = "flesh", mass_ratio = 0.025 },
        },
    },
}

-- humanoid zombies without a skull
ccb.content.define_harvest {
    id = "zombie_humanoid_headless",
    copy_from = "zombie_decay_bone",
    extend = {
        drops = {
            { output = "meat_tainted_human", category = "flesh", mass_ratio = 0.25 },
            { output = "blood_tainted_human", category = "blood", mass_ratio = 0.1 },
            { output = "fat_tainted_human", category = "flesh", mass_ratio = 0.08 },
            { output = "tainted_innards_human", category = "offal", mass_ratio = 0.15 },
            { output = "tainted_marrow_human", category = "bone", mass_ratio = 0.005 },
            { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        },
    },
    message = "<zombie_humanoid_headless_harvest>",
}

-- just the bones for corpses to rot away into + a human skull
ccb.content.define_harvest {
    id = "zombie_decay_bone_human_skull_multiple",
    copy_from = "zombie_decay_bone",
    extend = { drops = { { output = "skull_human_tainted", category = "bone", base_quantity = { 2, 5 } } } },
}

-- multiple humanoid zombies fused together
ccb.content.define_harvest {
    id = "zombie_humanoid_multiple",
    copy_from = "zombie_decay_bone_human_skull_multiple",
    message = "<zombie_humanoid_generic_harvest>",
    extend = {
        drops = {
            { output = "meat_tainted_human", category = "flesh", mass_ratio = 0.25 },
            { output = "blood_tainted_human", category = "blood", mass_ratio = 0.1 },
            { output = "fat_tainted_human", category = "flesh", mass_ratio = 0.08 },
            { output = "tainted_innards_human", category = "offal", mass_ratio = 0.15 },
            { output = "tainted_marrow_human", category = "bone", mass_ratio = 0.005 },
            { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        },
    },
}

-- any zombie animal that does not drop leather
ccb.content.define_harvest {
    id = "zombie_animal",
    copy_from = "zombie_decay_bone",
    message = "<zombie_animal_generic_harvest>",
    extend = {
        drops = {
            { output = "meat_tainted", category = "flesh", mass_ratio = 0.25 },
            { output = "blood_tainted", category = "blood", mass_ratio = 0.1 },
            { output = "fat_tainted", category = "flesh", mass_ratio = 0.08 },
            { output = "tainted_innards", category = "offal", mass_ratio = 0.15 },
            { output = "tainted_marrow", category = "bone", mass_ratio = 0.005 },
            { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        },
    },
}

-- acid blood instead of regular zombie blood
ccb.content.define_harvest {
    id = "zombie_humanoid_acid",
    copy_from = "zombie_humanoid",
    message = "<zombie_humanoid_acid_harvest>",
    delete = { drops = { { output = "blood_tainted_human", category = "blood", mass_ratio = 0.1 } } },
    extend = { drops = { { output = "blood_acid", category = "blood", mass_ratio = 0.1 } } },
}

-- any zombie animal with acid blood, their hide/fur or hide being too damaged to salvage.
ccb.content.define_harvest {
    id = "zombie_animal_acid",
    copy_from = "zombie_animal",
    message = "<zombie_animal_acid_harvest>",
    delete = { drops = { { output = "blood_tainted", category = "blood", mass_ratio = 0.1 } } },
    extend = { drops = { { output = "blood_acid", category = "blood", mass_ratio = 0.1 } } },
}

-- zombie dog with acid blood, their hide/fur being too damaged to salvage.
ccb.content.define_harvest {
    id = "zombie_dog_acid",
    copy_from = "zombie_dog",
    message = "<zombie_acid_dog_harvest>",
    delete = { drops = { { output = "blood_tainted", category = "blood", mass_ratio = 0.1 } } },
    extend = { drops = { { output = "blood_acid", category = "blood", mass_ratio = 0.1 } } },
}

-- emaciated, so less meat, fat, and innards
ccb.content.define_harvest {
    id = "zombie_screamer",
    copy_from = "zombie_humanoid",
    message = "<zombie_screamer_harvest>",
    delete = {
        drops = {
            { output = "meat_tainted_human", category = "flesh", mass_ratio = 0.25 },
            { output = "fat_tainted_human", category = "flesh", mass_ratio = 0.08 },
            { output = "tainted_innards_human", category = "offal", mass_ratio = 0.15 },
        },
    },
    extend = {
        drops = {
            { output = "meat_tainted_human", category = "flesh", mass_ratio = 0.15 },
            { output = "fat_tainted_human", category = "flesh", mass_ratio = 0.03 },
            { output = "tainted_innards_human", category = "offal", mass_ratio = 0.1 },
        },
    },
}

ccb.content.define_harvest {
    id = "zombie_grabber",
    copy_from = "zombie_humanoid",
    message = "<zombie_grabber_harvest>",
}

ccb.content.define_harvest {
    id = "zombie_humanoid_electric",
    copy_from = "zombie_humanoid",
    message = "<zombie_humanoid_electric_harvest>",
}

ccb.content.define_harvest {
    id = "zombie_animal_electric",
    copy_from = "zombie_animal",
    message = "<zombie_animal_electric_harvest>",
}

ccb.content.define_harvest {
    id = "zombie_pupating",
    copy_from = "zombie_humanoid",
    message = "<zombie_pupating_harvest>",
}

-- moldy humanoid zombie - fungus chunks replace a part of the innards
ccb.content.define_harvest {
    id = "zombie_humanoid_mushroom",
    copy_from = "zombie_humanoid",
    message = "<zombie_humanoid_mushroom_harvest>",
    delete = { drops = { { output = "tainted_innards_human", category = "offal", mass_ratio = 0.15 } } },
    extend = {
        drops = {
            { output = "veggy_tainted", category = "offal", mass_ratio = 0.07 },
            { output = "tainted_innards_human", category = "offal", mass_ratio = 0.08 },
        },
    },
}

ccb.content.define_harvest {
    id = "zombie_humanoid_mushroom_acid",
    copy_from = "zombie_humanoid_mushroom",
    delete = { drops = { { output = "blood_tainted_human", category = "blood", mass_ratio = 0.1 } } },
    extend = { drops = { { output = "blood_acid", category = "blood", mass_ratio = 0.1 } } },
}

-- moldy animal zombie - fungus chunks replace a part of the innards
ccb.content.define_harvest {
    id = "zombie_animal_mushroom",
    copy_from = "zombie_animal",
    message = "<zombie_animal_mushroom_harvest>",
    delete = { drops = { { output = "tainted_innards", category = "offal", mass_ratio = 0.15 } } },
    extend = {
        drops = {
            { output = "veggy_tainted", category = "offal", mass_ratio = 0.07 },
            { output = "tainted_innards", category = "offal", mass_ratio = 0.08 },
        },
    },
}

ccb.content.define_harvest {
    id = "zombie_humanoid_shadow",
    copy_from = "zombie_humanoid",
    message = "<zombie_humanoid_shadow_harvest>",
}

ccb.content.define_harvest {
    id = "zombie_humanoid_pupating_shadow",
    copy_from = "zombie_humanoid",
    message = "<zombie_pupating_shadow_harvest>",
}

ccb.content.define_harvest {
    id = "zombie_animal_shadow",
    copy_from = "zombie_animal",
    message = "<zombie_animal_shadow_harvest>",
}

-- shady animal zombie with additional harvestable fur
ccb.content.define_harvest {
    id = "zombie_fur_shadow",
    copy_from = "zombie_fur",
    message = "<zombie_animal_shadow_harvest>",
}

ccb.content.define_harvest {
    id = "zombie_hulk",
    copy_from = "zombie_humanoid",
    message = "<zombie_hulk_harvest>",
}

-- very big zombie with big holes in it
ccb.content.define_harvest {
    id = "zombie_pupating_hulk",
    message = "<zombie_pupating_hulk_harvest>",
    drops = {
        { output = "skull_human_tainted", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "meat_tainted_human", category = "flesh", mass_ratio = 0.18 },
        { output = "blood_tainted_human", category = "blood", mass_ratio = 0.8 },
        { output = "fat_tainted_human", category = "flesh", mass_ratio = 0.06 },
        { output = "tainted_innards_human", category = "offal", mass_ratio = 0.08 },
        { output = "tainted_marrow_human", category = "bone", mass_ratio = 0.003 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.07 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
    },
}

-- mix of animal and plant
ccb.content.define_harvest {
    id = "zombie_thorny",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.2 },
        { output = "fat_tainted", category = "flesh", mass_ratio = 0.05 },
        { output = "tainted_innards", category = "offal", mass_ratio = 0.08 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
        { output = "tainted_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "stick_fiber", category = "bone", mass_ratio = 0.1 },
    },
}

-- zombies with Kevlar infused into their skin
ccb.content.define_harvest {
    id = "zombie_kevlar",
    message = "<zombie_humanoid_kevlar_harvest>",
    drops = {
        { output = "skull_human_tainted", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "meat_tainted_human", category = "flesh", mass_ratio = 0.25 },
        { output = "fat_tainted_human", category = "flesh", mass_ratio = 0.08 },
        { output = "tainted_innards_human", category = "offal", mass_ratio = 0.15 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
        { output = "tainted_marrow_human", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "blood_tainted_human", category = "blood", mass_ratio = 0.1 },
        { output = "kevlar_patch", category = "skin", mass_ratio = 0.02, flags = { "FILTHY" } },
        { output = "sheet_kevlar", category = "skin", mass_ratio = 0.01, flags = { "FILTHY" } },
        { output = "sheet_kevlar_layered", category = "skin", mass_ratio = 0.01, flags = { "FILTHY" } },
        { output = "raw_tainted_leather", category = "skin", mass_ratio = 0.04 },
    },
}

-- hulks with Kevlar infused into their skin
ccb.content.define_harvest {
    id = "zombie_kevlar_hulk",
    message = "<zombie_kevlar_hulk_harvest>",
    drops = {
        { output = "skull_human_tainted", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "meat_tainted_human", category = "flesh", mass_ratio = 0.25 },
        { output = "fat_tainted_human", category = "flesh", mass_ratio = 0.08 },
        { output = "tainted_innards_human", category = "offal", mass_ratio = 0.15 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
        { output = "tainted_marrow_human", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "blood_tainted_human", category = "blood", mass_ratio = 0.1 },
        { output = "kevlar_patch", category = "skin", mass_ratio = 0.02, flags = { "FILTHY" } },
        { output = "sheet_kevlar", category = "skin", mass_ratio = 0.01, flags = { "FILTHY" } },
        { output = "sheet_kevlar_layered", category = "skin", mass_ratio = 0.01, flags = { "FILTHY" } },
        { output = "raw_tainted_leather", category = "skin", mass_ratio = 0.04 },
    },
}

-- zombies with Nomex infused into their skin
ccb.content.define_harvest {
    id = "zombie_nomex",
    drops = {
        { output = "skull_human_tainted", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "meat_tainted_human", category = "flesh", mass_ratio = 0.25 },
        { output = "fat_tainted_human", category = "flesh", mass_ratio = 0.08 },
        { output = "tainted_innards_human", category = "offal", mass_ratio = 0.15 },
        { output = "bone_tainted", category = "bone", mass_ratio = 0.1 },
        { output = "tainted_marrow_human", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.00035 },
        { output = "blood_tainted_human", category = "blood", mass_ratio = 0.1 },
        { output = "nomex", category = "skin", mass_ratio = 0.02, flags = { "FILTHY" } },
        { output = "sheet_nomex", category = "skin", mass_ratio = 0.01, flags = { "FILTHY" } },
        { output = "raw_tainted_leather", category = "skin", mass_ratio = 0.04 },
    },
}

-- No internal organs or bones, filled with pure hatred
ccb.content.define_harvest {
    id = "zombie_amalgamation",
    message = "<zombie_amalgamation_harvest>",
    drops = {
        { output = "meat_tainted", category = "flesh", mass_ratio = 0.5 },
        { output = "raw_tainted_leather", category = "skin", mass_ratio = 0.04 },
    },
}

ccb.content.define_harvest {
    id = "zombie_amalgamation_acid",
    copy_from = "zombie_amalgamation",
    message = "<zombie_amalgamation_harvest_acid>",
}

ccb.content.define_harvest {
    id = "zombie_amalgamation_electric",
    copy_from = "zombie_amalgamation",
    message = "<zombie_amalgamation_harvest_electric>",
}

-- spooky scary skeletons
ccb.content.define_harvest {
    id = "mr_bones",
    message = "<zombie_humanoid_bone_harvest>",
    drops = {
        { output = "skull_human_tainted", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "bone_tainted", category = "flesh", mass_ratio = 0.5 },
        { output = "tainted_marrow_human", category = "bone", mass_ratio = 0.005 },
        { output = "blood_tainted_human", category = "blood", mass_ratio = 0.01 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
    },
}

-- extra large spooky scary skeletons
ccb.content.define_harvest {
    id = "big_mr_bones",
    message = "<zombie_bone_hulk_harvest>",
    drops = {
        { output = "skull_human_tainted", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "bone_tainted", category = "flesh", mass_ratio = 0.5 },
        { output = "tainted_marrow_human", category = "bone", mass_ratio = 0.005 },
        { output = "blood_tainted_human", category = "blood", mass_ratio = 0.01 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
    },
}

-- spooky scary animal skeletons
ccb.content.define_harvest {
    id = "puppy_bones",
    message = "<zombie_animal_bone_harvest>",
    drops = {
        { output = "bone_tainted", category = "flesh", mass_ratio = 0.5 },
        { output = "tainted_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.01 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
    },
}

-- spooky scary dog skeletons
ccb.content.define_harvest {
    id = "doggy_bones",
    message = "<zombie_bone_dog_harvest>",
    drops = {
        { output = "bone_tainted", category = "flesh", mass_ratio = 0.5 },
        { output = "tainted_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "blood_tainted", category = "blood", mass_ratio = 0.01 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
    },
}

-- spooky scary moldy skeletons
ccb.content.define_harvest {
    id = "moldy_bones",
    message = "<zombie_humanoid_moldy_bone_harvest>",
    drops = {
        { output = "skull_human_tainted", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "bone_tainted", category = "flesh", mass_ratio = 0.5 },
        { output = "tainted_marrow_human", category = "bone", mass_ratio = 0.005 },
        { output = "blood_tainted_human", category = "blood", mass_ratio = 0.01 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
    },
}

-- a monstrous horror, probably the most destructive entity you will ever see
ccb.content.define_harvest {
    id = "human",
    drops = {
        { output = "skull_human", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "human_flesh", category = "flesh", mass_ratio = 0.2 },
        { output = "human_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "hstomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "human_liver", category = "offal", mass_ratio = 0.01 },
        { output = "human_heart", category = "offal", mass_ratio = 0.01 },
        { output = "human_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "human_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "human_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "human_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "human_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "blood", category = "blood", mass_ratio = 0.1 },
        { output = "bone_human", category = "bone", mass_ratio = 0.12 },
        { output = "human_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        { output = "raw_hleather", category = "skin", mass_ratio = 0.01 },
    },
}

-- a near human sapient being possibly from another dimension, some people will consider it human and some won't
ccb.content.define_harvest {
    id = "demihuman",
    drops = {
        { output = "demihuman_flesh", category = "flesh", mass_ratio = 0.2 },
        { output = "demihuman_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "demihuman_blood", category = "blood", mass_ratio = 0.1 },
        { output = "demihuman_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "demihuman_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "demihuman_liver", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_heart", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "demihuman_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "demihuman_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "demihuman_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "bone_demihuman", category = "bone", mass_ratio = 0.12 },
        { output = "demihuman_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        { output = "raw_demihumanleather", category = "skin", mass_ratio = 0.01 },
    },
}

ccb.content.define_harvest {
    id = "demihuman_snail",
    drops = {
        { output = "demihuman_flesh", category = "flesh", mass_ratio = 0.2 },
        { output = "demihuman_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "demihuman_blood", category = "blood", mass_ratio = 0.1 },
        { output = "demihuman_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "demihuman_liver", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "demihuman_heart", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "demihuman_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "demihuman_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "demihuman_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "bone_demihuman", category = "bone", mass_ratio = 0.12 },
        { output = "demihuman_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        { output = "raw_demihumanleather", category = "skin", mass_ratio = 0.01 },
    },
}

ccb.content.define_harvest {
    id = "mutant_human",
    drops = {
        { output = "skull_human", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        { output = "mutant_human_flesh", category = "flesh", mass_ratio = 0.19 },
        { output = "mutant_human_blood", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_human_heart", category = "offal", mass_ratio = 0.01 },
        { output = "hstomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "mutant_human_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "bone_human", category = "bone", mass_ratio = 0.12 },
        { output = "mutant_human_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        { output = "raw_hleather", category = "skin", mass_ratio = 0.01 },
    },
}

ccb.content.define_harvest {
    id = "gozu",
    drops = {
        { output = "demihuman_flesh", category = "flesh", mass_ratio = 0.2 },
        { output = "demihuman_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "demihuman_blood", category = "blood", mass_ratio = 0.1 },
        { output = "demihuman_stomach", skill_quantity = { 1, 1 }, maximum = 1, category = "offal" },
        { output = "demihuman_liver", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_heart", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "demihuman_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "demihuman_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "demihuman_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "demihuman_fat", category = "flesh", mass_ratio = 0.1 },
        { output = "bone_demihuman", category = "bone", mass_ratio = 0.12 },
        { output = "demihuman_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        { output = "raw_demihumanleather", category = "skin", mass_ratio = 0.009 },
        { output = "raw_hfur", category = "skin", mass_ratio = 0.001 },
    },
}

ccb.content.define_harvest {
    id = "nether_huntsman",
    drops = {
        { output = "demihuman_flesh", category = "flesh", mass_ratio = 0.15 },
        { output = "demihuman_meat_scrap", category = "flesh", mass_ratio = 0.01 },
        { output = "demihuman_blood", category = "blood", mass_ratio = 0.05 },
        {
            output = "demihuman_stomach",
            base_quantity = { 2, 2 },
            skill_quantity = { 1, 1 },
            maximum = 2,
            category = "offal",
        },
        { output = "demihuman_fat", category = "flesh", mass_ratio = 0.05 },
        { output = "demihuman_liver", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_heart", category = "offal", mass_ratio = 0.01 },
        { output = "demihuman_lung", category = "flesh", mass_ratio = 0.0035 },
        { output = "demihuman_brain", category = "flesh", mass_ratio = 0.005 },
        { output = "demihuman_sweetbread", category = "flesh", mass_ratio = 0.002 },
        { output = "demihuman_kidney", category = "offal", mass_ratio = 0.002 },
        { output = "bone_demihuman", category = "bone", mass_ratio = 0.12 },
        { output = "demihuman_marrow", category = "bone", mass_ratio = 0.005 },
        { output = "sinew", category = "bone", mass_ratio = 0.001 },
        { output = "nether_huntsman_armorpiece_small", category = "skin", mass_ratio = 0.05 },
        { output = "nether_huntsman_armorpiece_big", category = "skin", mass_ratio = 0.05 },
        {
            output = "nether_huntsman_organ",
            base_quantity = { 1, 1 },
            skill_quantity = { 1, 1 },
            maximum = 1,
            category = "offal",
        },
        { output = "nether_huntsman_spike", category = "skin", mass_ratio = 0.1 },
        { output = "raw_demihumanleather", category = "skin", mass_ratio = 0.005 },
    },
}

ccb.content.define_harvest {
    id = "fungaloid",
    message = "<fungaloid_harvest>",
    drops = {
        { output = "veggy_tainted", category = "flesh", mass_ratio = 0.5 },
        { output = "plant_sac", category = "offal", mass_ratio = 0.2 },
        { output = "stick_fiber", category = "bone", mass_ratio = 0.1 },
    },
}

ccb.content.define_harvest {
    id = "fungaloid_mass",
    message = ccb.content.text("You laboriously hack and dig through the remains of the fungal mass."),
    drops = {
        {
            output = "veggy_tainted",
            base_quantity = { 16, 25 },
            skill_quantity = { 0.6, 0.8 },
            maximum = 50,
            category = "flesh",
        },
        {
            output = "plant_sac",
            base_quantity = { 3, 6 },
            skill_quantity = { 0.7, 0.9 },
            maximum = 10,
            category = "offal",
        },
        {
            output = "stick_fiber",
            base_quantity = { 4, 8 },
            skill_quantity = { 0.5, 0.7 },
            maximum = 10,
            category = "bone",
        },
    },
}

ccb.content.define_harvest {
    id = "flesh_plant",
    message = "<power_leech_harvest>",
    drops = {
        { output = "meat_bark", category = "flesh", mass_ratio = 0.05 },
        { output = "meat_frond", category = "flesh", mass_ratio = 0.5 },
    },
}

ccb.content.define_harvest {
    id = "flesh_plant_bloom",
    drops = {
        { output = "meat_bark", category = "flesh", mass_ratio = 0.05 },
        { output = "leech_flower", category = "flesh", mass_ratio = 0.25 },
        { output = "meat_frond", category = "flesh", mass_ratio = 0.5 },
    },
}

-- todo: add biollante item
ccb.content.define_harvest {
    id = "biollante",
    message = "<triffid_harvest>",
    drops = {
        { output = "stick_fiber", category = "bone", mass_ratio = 0.5 },
        { output = "veggy", category = "flesh", mass_ratio = 0.2 },
        { output = "veggy", category = "offal", mass_ratio = 0.05 },
    },
}

ccb.content.define_harvest {
    id = "triffid_small",
    message = "<triffid_harvest>",
    drops = {
        { output = "stick_fiber", category = "bone", mass_ratio = 0.5 },
        { output = "veggy", category = "flesh", mass_ratio = 0.2 },
        { output = "veggy", category = "offal", mass_ratio = 0.05 },
    },
}

ccb.content.define_harvest {
    id = "triffid_paralytic",
    message = "<triffid_harvest>",
    drops = {
        { output = "stick_fiber", category = "bone", mass_ratio = 0.4 },
        { output = "veggy", category = "flesh", mass_ratio = 0.2 },
        { output = "veggy", category = "offal", mass_ratio = 0.05 },
        { output = "stick", category = "bone", mass_ratio = 0.05 },
        { output = "latex", category = "blood", mass_ratio = 0.1 },
        { output = "venom_paralytic", category = "offal", mass_ratio = 0.0075 },
    },
}

-- acid blood type for plant based creaturs.
ccb.content.define_harvest {
    id = "triffid_acid",
    message = "<triffid_harvest>",
    drops = {
        { output = "blood_acid_plant", category = "blood", mass_ratio = 0.1 },
        { output = "stick_fiber", category = "bone", mass_ratio = 0.5 },
        { output = "veggy", category = "flesh", mass_ratio = 0.2 },
        { output = "veggy", category = "offal", mass_ratio = 0.05 },
    },
}

ccb.content.define_harvest {
    id = "triffid_fungal_fighter",
    message = "<triffid_harvest>",
    drops = {
        { output = "stick_fiber", category = "bone", mass_ratio = 0.4 },
        { output = "veggy", category = "flesh", mass_ratio = 0.2 },
        { output = "veggy", category = "offal", mass_ratio = 0.05 },
        { output = "stick", category = "bone", mass_ratio = 0.05 },
        { output = "venom_paralytic", category = "offal", mass_ratio = 0.0075 },
        { output = "triffid_fungicide", category = "offal", mass_ratio = 0.0075 },
    },
}

ccb.content.define_harvest {
    id = "triffid_queen",
    message = "<triffid_harvest>",
    drops = {
        { output = "log", category = "bone", mass_ratio = 0.35 },
        { output = "stick_fiber", category = "bone", mass_ratio = 0.15 },
        { output = "veggy", category = "flesh", mass_ratio = 0.2 },
        { output = "veggy", category = "offal", mass_ratio = 0.05 },
        { output = "latex", category = "blood", mass_ratio = 0.1 },
        { output = "venom_paralytic", category = "offal", mass_ratio = 0.02 },
    },
}

-- acid blood type for underground or digging based creaturs.
ccb.content.define_harvest {
    id = "underground_acid",
    drops = {
        { output = "blood_acid_underground", category = "blood", mass_ratio = 0.1 },
        { output = "mutant_meat", category = "flesh", mass_ratio = 0.36 },
        { output = "mutant_fat", category = "flesh", mass_ratio = 0.08 },
        { output = "acidchitin_piece", category = "bone", mass_ratio = 0.06 },
    },
}

ccb.content.define_harvest {
    id = "rat_with_skull",
    copy_from = "mammal_tiny",
    extend = {
        drops = { { output = "skull_rodent", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "shrew_with_skull",
    copy_from = "mammal_tiny",
    extend = {
        drops = { { output = "skull_rodent", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "mole_with_skull",
    copy_from = "mammal_tiny",
    extend = {
        drops = { { output = "skull_rodent", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "porcupine_with_skull",
    copy_from = "mammal_small_leather",
    extend = {
        drops = { { output = "skull_rodent", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "dog_small_with_skull",
    copy_from = "mammal_tiny",
    extend = {
        drops = {
            { output = "skull_canis_medium", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
}

ccb.content.define_harvest {
    id = "dog_small_with_skull_mutant",
    copy_from = "mutant_tiny",
    extend = {
        drops = {
            { output = "skull_canis_medium", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
}

ccb.content.define_harvest {
    id = "cat_small_with_skull",
    copy_from = "mammal_tiny",
    extend = {
        drops = {
            { output = "skull_feline_small", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
}

ccb.content.define_harvest {
    id = "pig_with_skull",
    copy_from = "mammal_large_pig",
    extend = {
        drops = { { output = "skull_pig", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "boar_with_skull",
    copy_from = "mammal_large_boar",
    extend = {
        drops = { { output = "skull_pig", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "sheep_with_skull",
    copy_from = "mammal_large_wool",
    extend = {
        drops = { { output = "skull_sheep", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "goat_with_skull",
    copy_from = "mammal_large_wool",
    extend = {
        drops = { { output = "skull_goat", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "cow_with_skull",
    copy_from = "mammal_large_leather",
    extend = {
        drops = { { output = "skull_bovine", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "horse_with_skull",
    copy_from = "mammal_large_leather",
    extend = {
        drops = { { output = "skull_equine", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "deer_with_skull",
    copy_from = "mammal_large_leather",
    extend = {
        drops = { { output = "skull_cervine", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "moose_with_skull",
    copy_from = "mammal_large_fur",
    extend = {
        drops = { { output = "skull_moose", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "tusked_moose_with_skull",
    copy_from = "mutant_mammal_large_fur",
    extend = {
        drops = {
            { output = "skull_moose_tusked", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
}

ccb.content.define_harvest {
    id = "dog_small_with_skull_leather",
    copy_from = "mammal_small_leather",
    extend = {
        drops = {
            { output = "skull_canis_medium", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
}

ccb.content.define_harvest {
    id = "dog_small_with_skull_fur",
    copy_from = "mammal_small_fur",
    extend = {
        drops = {
            { output = "skull_canis_medium", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
}

ccb.content.define_harvest {
    id = "incubator_mammal_deer",
    copy_from = "incubator_mammal",
    extend = {
        drops = { { output = "skull_cervine", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "incubator_mammal_dog",
    copy_from = "incubator_mammal",
    extend = {
        drops = { { output = "skull_canis", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "dog_with_skull_fur",
    copy_from = "mammal_fur",
    extend = {
        drops = { { output = "skull_canis", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "dog_with_skull_fur_mutant",
    copy_from = "mutant_mammal_fur",
    extend = {
        drops = { { output = "skull_canis", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "dog_with_skull_leather",
    copy_from = "mammal_leather",
    extend = {
        drops = { { output = "skull_canis", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "dog_tiny_with_skull",
    copy_from = "mammal_tiny",
    extend = {
        drops = { { output = "skull_canis_small", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "dog_tiny_with_skull_mutant",
    copy_from = "mutant_tiny",
    extend = {
        drops = { { output = "skull_canis_small", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "llama_with_skull",
    copy_from = "mammal_large_wool",
    extend = {
        drops = { { output = "skull_llama", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "cat_medium_with_skull",
    copy_from = "mammal_small_fur",
    extend = {
        drops = {
            { output = "skull_feline_medium", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
}

ccb.content.define_harvest {
    id = "cougar_with_skull",
    copy_from = "mammal_fur",
    extend = {
        drops = { { output = "skull_cougar", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "raccoon_with_skull",
    copy_from = "mammal_small_fur",
    extend = {
        drops = { { output = "skull_raccoon", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "raccoon_with_skull_mutant",
    copy_from = "mutant_mammal_small_fur",
    extend = {
        drops = { { output = "skull_raccoon", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "bear_with_skull",
    copy_from = "mammal_large_fur",
    extend = {
        drops = { { output = "skull_bear", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "opossum_with_skull",
    copy_from = "mammal_small_fur",
    extend = {
        drops = { { output = "skull_opossum", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "skunk_with_skull",
    copy_from = "mammal_small_fur",
    extend = {
        drops = { { output = "skull_skunk", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "beaver_with_skull",
    copy_from = "mammal_small_fur",
    extend = {
        drops = { { output = "skull_beaver", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "beaver_with_skull_fur_mutant",
    copy_from = "mutant_mammal_fur",
    extend = {
        drops = { { output = "skull_beaver_huge", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "beaver_with_skull_feather_mutant",
    copy_from = "mutant_bird_flightless",
    extend = {
        drops = { { output = "skull_beaver", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

ccb.content.define_harvest {
    id = "dog_triclopean_with_skull",
    copy_from = "mammal_small_fur",
    extend = {
        drops = {
            { output = "skull_canis_triclopean", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
}

ccb.content.define_harvest {
    id = "spideer_with_skull",
    copy_from = "mutant_mammal_large_leather",
    extend = {
        drops = {
            { output = "skull_cervine_spideer", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 },
        },
    },
}

ccb.content.define_harvest {
    id = "cerbearus_with_skulls",
    copy_from = "mutant_mammal_large_fur",
    extend = {
        drops = { { output = "skull_bear", category = "bone", skill_quantity = { 3, 3 }, maximum = 3 } },
    },
}

ccb.content.define_harvest {
    id = "rabbit_with_skull",
    copy_from = "mammal_small_fur",
    extend = {
        drops = { { output = "skull_rabbit", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}

-- The various mi-go variants
ccb.content.define_harvest {
    id = "mi-go",
    message = "<mi-go_harvest>",
    drops = {
        { output = "meat_mi-go", category = "flesh", mass_ratio = 0.25 },
        { output = "blood_mi-go", category = "blood", mass_ratio = 0.1 },
        { output = "bone_mi-go", category = "bone", mass_ratio = 0.1 },
    },
}

-- Frog legs, but the rest of the frog is mostly inedible
ccb.content.define_harvest {
    id = "bullfrog",
    drops = { { output = "froglegs", category = "flesh", skill_quantity = { 1, 1 }, maximum = 1 } },
}

ccb.content.define_harvest {
    id = "nl_shrub_glowberries_harv",
    drops = { { output = "nl_shrub_glowberries", base_quantity = { 2, 5 }, skill_quantity = { 0, 0.5 } } },
}

ccb.content.define_harvest {
    id = "saguaro_harv",
    drops = { { output = "saguaro_fruit", base_quantity = { 2, 4 } } },
}

ccb.content.define_harvest {
    id = "prickly_pear_harv",
    drops = { { output = "prickly_pear_fruit", base_quantity = { 2, 4 } } },
}
