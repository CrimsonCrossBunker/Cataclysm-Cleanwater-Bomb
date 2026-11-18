local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "earthworm_boiled",
    result = "earthworm_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 2, true)
    :component_any({
            { id = "earthworm", count = 10 },
            { id = "earthworm_handful", count = 1 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "salt_water", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(85, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "earthworm_fried",
    result = "earthworm_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 1, true)
    :tool_charges("frying_oil", 1, true)
    :component("earthworm_boiled", 1)
    :component("salt", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :proficiency("prof_frying")
    :batch_discount(67, 5)
    :result_charges(1)
)

-- water alone is 4u boiling, then there is 1.25L of soymilk - assuming roughly half water by weight, another
-- 10u heat
content.add(content.Recipe {
    id = "tofu",
    result = "tofu",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 14, true)
    :component("soy_milk", 5)
    :component("water_clean", 1)
    :component_any({
            { id = "lemon", count = 1 },
            { id = "vinegar", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :book("cookbook_sushi", 3)
    :book("cookbook_eatyrway", 4)
    :proficiency("prof_food_prep")
    :batch_discount(50, 2)
    :result_charges(4)
)

-- Not exactly meat but weighs 3x scrap of meat so 6u heat, which is the given standard
content.add(content.Recipe {
    id = "tofu_fried",
    result = "tofu_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 6, true)
    :component("tofu", 1)
    :quality("CONTAIN", 1, 1)
    :book("cookbook_sushi", 2)
    :book("cookbook_eatyrway", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_frying")
)

-- rice = 4u, blood = 15u
content.add(content.Recipe {
    id = "blood_rice_pudding",
    result = "blood_rice_pudding",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 19, true)
    :component_any({
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 }
        })
    :component("edible_blood", 1, true)
    :component("salt", 1)
    :component_any({
            { id = "seasoning_mild", count = 1, requirement = true },
            { id = "peanut", count = 1 },
            { id = "chilly-p", count = 1 },
            { id = "curry_powder", count = 1 }
        })
    :quality("COOK", 2, 1)
    :quality("CONTAIN", 1, 1)
    :book("cookbook_bloodforgood", 2)
    :proficiency("prof_food_prep")
    :batch_discount(50, 2)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "dogfood_raw",
    result = "dogfood_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component_any({
            { id = "meat_nofish", count = 1, requirement = true },
            { id = "fish", count = 1 },
            { id = "lobster", count = 1 }
        })
    :component("veggy_green", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_knife_skills")
)

content.add(content.Recipe {
    id = "dogfood_from_raw_dogfood",
    result = "dogfood",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 57000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 12, true)
    :component("dogfood_raw", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- dogs can eat raw meat, but should cook this just to be safe. 2u for veggy, 10u for meat (red meat will be
-- undercooked, not a big deal)
content.add(content.Recipe {
    id = "dogfood_from_ingredients",
    result = "dogfood",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 12, true)
    :component_any({
            { id = "meat_nofish", count = 1, requirement = true },
            { id = "fish", count = 1 },
            { id = "lobster", count = 1 }
        })
    :component("veggy_green", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "catfood_raw",
    result = "catfood_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component_any({
            { id = "meat_nofish", count = 2, requirement = true },
            { id = "fish", count = 2 },
            { id = "lobster", count = 2 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_knife_skills")
)

content.add(content.Recipe {
    id = "catfood_from_raw_catfood",
    result = "catfood",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 57000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :component("catfood_raw", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- cats can eat raw meat, but should cook this just to be safe. 20u for meat (red meat will be undercooked,
-- not a big deal)
content.add(content.Recipe {
    id = "catfood_from_ingredients",
    result = "catfood",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "meat_nofish", count = 2, requirement = true },
            { id = "fish", count = 2 },
            { id = "lobster", count = 2 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "coffee_raw",
    result = "coffee_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
    contained = true,
}
    :component("roasted_coffee_bean", 1)
    :component_any({
            { id = "bag_plastic", count = 1 },
            { id = "bag_plastic_small", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :batch_discount(80, 1)
)

-- 2 hours of roasting are required to fully break up the toxins in raw pods
content.add(content.Recipe {
    id = "coffee_raw_kentucky",
    result = "coffee_raw_kentucky",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 30, true)
    :component("water_clean", 1)
    :component("coffee_pod", 1)
    :quality("HAMMER", 1, 1)
    :quality("BOIL", 1, 1)
    :book("survival_book", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(90, 1)
    :result_charges(5)
    :remove_result_flag("HIDDEN_POISON")
)

content.add(content.Recipe {
    id = "beans_cooked",
    result = "beans_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 4, true)
    :component_any({
            { id = "can_beans", count = 1 },
            { id = "dry_beans", count = 1 },
            { id = "raw_beans", count = 1 }
        })
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :batch_discount(82, 4)
)

content.add(content.Recipe {
    id = "lentils_cooked",
    result = "lentils_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 4, true)
    :component("dry_lentils", 1)
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :batch_discount(82, 4)
    :result_charges(1)
)

-- unfortunately I have no experience with this recipe in real life so I cannot comment on its accuracy.
content.add(content.Recipe {
    id = "cola_meth",
    result = "cola_meth",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 42000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 4, true)
    :component("meth", 4)
    :component("cola", 2)
    :quality("COOK", 2, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "honey_glassed",
    result = "honey_glassed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("honey_bottled", 15)
    :quality("CONTAIN", 1, 1)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "cattlefodder",
    result = "cattlefodder",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component_any({
            { id = "oats", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "wheat", count = 1 },
            { id = "veggy_potatolike", count = 1, requirement = true },
            { id = "barley", count = 1 },
            { id = "can_corn", count = 1 },
            { id = "raw_beans", count = 1 },
            { id = "dry_beans", count = 1 },
            { id = "dry_lentils", count = 1 },
            { id = "dry_corn", count = 1 },
            { id = "corn", count = 1 },
            { id = "popcorn_cob", count = 1 },
            { id = "seed_canola", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "soybean", count = 2 },
            { id = "dry_soybean", count = 2 },
            { id = "raw_edamame", count = 2 },
            { id = "straw_pile", count = 12 },
            { id = "chaff", count = 17 },
            { id = "veggy_green", count = 2, requirement = true },
            { id = "press_cake", count = 1 }
        })
)

content.add(content.Recipe {
    id = "cattlefodder_medium",
    result = "cattlefodder_medium",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component_any({
            { id = "cattlefodder", count = 7 },
            { id = "oats", count = 4 },
            { id = "buckwheat", count = 4 },
            { id = "wheat", count = 4 },
            { id = "veggy_potatolike", count = 7, requirement = true },
            { id = "barley", count = 4 },
            { id = "can_corn", count = 7 },
            { id = "raw_beans", count = 7 },
            { id = "dry_beans", count = 7 },
            { id = "dry_lentils", count = 7 },
            { id = "dry_corn", count = 7 },
            { id = "corn", count = 7 },
            { id = "popcorn_cob", count = 7 },
            { id = "seed_canola", count = 4 },
            { id = "corn_kernels", count = 4 },
            { id = "soybean", count = 14 },
            { id = "dry_soybean", count = 14 },
            { id = "raw_edamame", count = 14 },
            { id = "straw_pile", count = 80 },
            { id = "chaff", count = 120 },
            { id = "veggy_green", count = 6, requirement = true },
            { id = "press_cake", count = 7 }
        })
)

content.add(content.Recipe {
    id = "cattlefodder_large",
    result = "cattlefodder_large",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component_any({
            { id = "cattlefodder", count = 36 },
            { id = "oats", count = 18 },
            { id = "buckwheat", count = 10 },
            { id = "wheat", count = 9 },
            { id = "veggy_potatolike", count = 30, requirement = true },
            { id = "barley", count = 9 },
            { id = "can_corn", count = 18 },
            { id = "raw_beans", count = 30 },
            { id = "dry_beans", count = 30 },
            { id = "dry_lentils", count = 26 },
            { id = "dry_corn", count = 46 },
            { id = "corn", count = 46 },
            { id = "popcorn_cob", count = 46 },
            { id = "seed_canola", count = 26 },
            { id = "corn_kernels", count = 46 },
            { id = "soybean", count = 107 },
            { id = "dry_soybean", count = 107 },
            { id = "raw_edamame", count = 107 },
            { id = "straw_pile", count = 400 },
            { id = "chaff", count = 600 },
            { id = "veggy_green", count = 150, requirement = true },
            { id = "press_cake", count = 30 }
        })
)

content.add(content.Recipe {
    id = "birdfood",
    result = "birdfood",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component_any({
            { id = "can_corn", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "oats", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "wheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "raw_beans", count = 1 },
            { id = "seed_blackberries", count = 3 },
            { id = "seed_blueberries", count = 3 },
            { id = "seed_cranberries", count = 3 },
            { id = "seed_huckleberries", count = 3 },
            { id = "seed_mulberries", count = 3 },
            { id = "seed_elderberries", count = 3 },
            { id = "seed_grapes", count = 3 },
            { id = "seed_rose", count = 3 },
            { id = "seed_cattail", count = 3 },
            { id = "seed_dahlia", count = 3 },
            { id = "seed_eggplant", count = 3 },
            { id = "seed_artichoke", count = 3 },
            { id = "seed_flower", count = 3 },
            { id = "seed_cactus", count = 3 },
            { id = "seed_hops", count = 3 },
            { id = "seed_raspberries", count = 3 },
            { id = "seed_strawberries", count = 3 },
            { id = "seed_sugar_beet", count = 3 },
            { id = "seed_lettuce", count = 3 },
            { id = "seed_cabbage", count = 3 },
            { id = "seed_radish", count = 3 },
            { id = "seed_tomato", count = 3 },
            { id = "seed_cotton_boll", count = 3 },
            { id = "seed_broccoli", count = 3 },
            { id = "seed_brussels_sprout", count = 3 },
            { id = "seed_asparagus", count = 3 },
            { id = "seed_zucchini", count = 3 },
            { id = "seed_onion", count = 3 },
            { id = "seed_garlic", count = 3 },
            { id = "seed_carrot", count = 3 },
            { id = "seed_chili_pepper", count = 3 },
            { id = "seed_cucumber", count = 3 },
            { id = "seed_gherkin", count = 3 },
            { id = "seed_weed", count = 3 },
            { id = "seed_thyme", count = 3 },
            { id = "seed_canola", count = 1 },
            { id = "seed_watermelon", count = 3 },
            { id = "seed_wintergreen", count = 3 },
            { id = "seed_pumpkin", count = 3 },
            { id = "seed_sunflower", count = 3 },
            { id = "seed_dogbane", count = 3 },
            { id = "seed_bee_balm", count = 3 },
            { id = "seed_mugwort", count = 3 },
            { id = "seed_buckwheat", count = 3 },
            { id = "seed_wild_herbs", count = 3 },
            { id = "seed_veggy_wild", count = 3 },
            { id = "seed_raw_dandelion", count = 3 },
            { id = "seed_cauliflower", count = 3 },
            { id = "seed_kale", count = 3 },
            { id = "seed_pea", count = 3 },
            { id = "seed_raw_burdock", count = 3 },
            { id = "seed_raw_bamboo", count = 3 },
            { id = "seed_rhubarb", count = 3 },
            { id = "seed_celery", count = 3 },
            { id = "seed_poppy_bud", count = 3 },
            { id = "chaff", count = 25 },
            { id = "soybean", count = 1 },
            { id = "dry_soybean", count = 1 },
            { id = "bread", count = 1 },
            { id = "cornbread", count = 1 },
            { id = "wastebread", count = 1 },
            { id = "sourdough_bread", count = 1 },
            { id = "hardtack", count = 1 },
            { id = "brioche", count = 1 }
        })
)

content.add(content.Recipe {
    id = "molasses",
    result = "molasses",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 300000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 16, true)
    :component("beet_syrup", 5)
    :quality("BOIL", 2, 1)
    :batch_discount(20, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "young_yeast",
    result = "young_yeast",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("sweet_fruit", 1, true)
    :component("sugar", 10)
    :quality("BOIL", 2, 1)
    :requires_skill("survival", 4)
    :batch_discount(90, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "young_yeast_from_honey",
    result = "young_yeast",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("honey_bottled", 1)
    :quality("BOIL", 2, 1)
    :requires_skill("survival", 4)
    :batch_discount(90, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "young_koji_active",
    result = "young_koji_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :component("rice_cooked", 1)
    :component("ash", 1)
    :component("empty_corn_cob", 1)
    :requires_skill("survival", 6)
    :book("brewing_cookbook", 6)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
)

content.add(content.Recipe {
    id = "soy_wheat_dough_active",
    result = "soy_wheat_dough_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 80, true)
    :tool_any({
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 20 }
        })
    :component("soybean", 1)
    :component("flour", 10)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :component("paper", 1)
    :quality("COOK", 3, 1)
    :book("cookbook_sushi", 6)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
)

-- Needs to be pastuerized but this is a very very small quantity
content.add(content.Recipe {
    id = "soysauce",
    result = "soysauce",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 2, true)
    :component("soy_sauce_unstrained", 1)
    :quality("BOIL", 2, 1)
    :quality("STRAIN", 2, 1)
    :book("cookbook_sushi", 3)
    :batch_discount(95, 4)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "freeze_dried_meal_hydrated",
    result = "freeze_dried_meal_hydrated",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
}
    :component("water_clean", 1)
    :component("freeze_dried_meal", 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "freeze_dried_stroganoff_hydrated",
    result = "freeze_dried_stroganoff_hydrated",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
}
    :component("water_clean", 1)
    :component("freeze_dried_stroganoff", 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "freeze_dried_veggypasta_hydrated",
    result = "freeze_dried_veggypasta_hydrated",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
}
    :component("water_clean", 1)
    :component("freeze_dried_veggypasta", 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "acid_soaked_hide",
    result = "acid_soaked_hide",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 48000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :component("formic_acid", 10)
    :component_any({
            { id = "water", count = 10 },
            { id = "water_clean", count = 10 }
        })
    :component_any({
            { id = "raw_leather", count = 1 },
            { id = "raw_hleather", count = 1 },
            { id = "raw_demihumanleather", count = 1 }
        })
    :book("textbook_chemistry", 3)
    :book("adv_chemistry", 3)
    :proficiency("prof_intro_chemistry")
    :batch_discount(50, 4)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "gelatin_fresh",
    result = "gelatin_fresh",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component("gelatin_extracted", 1)
    :quality("STRAIN", 1, 1)
    :batch_discount(90, 1)
    :result_charges(12)
    :byproduct("formic_acid", 1)
    :byproduct("ruined_chunks", 1)
)

content.add(content.Recipe {
    id = "gelatin_dessert_processed",
    result = "gelatin_dessert_processed",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 16, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("gelatin_dessert_powder", 1)
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(20, 1)
    :result_charges(5)
)

-- 2u for the sugar and 2u for the gelatin, adding 6u for the water
content.add(content.Recipe {
    id = "gelatin_dessert_base",
    result = "gelatin_dessert_base",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :component("water_clean", 2)
    :component_any({
            { id = "gelatin_powder", count = 10 },
            { id = "gelatin_fresh", count = 1 }
        })
    :component("sugar", 20)
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(20, 1)
    :result_charges(5)
)

-- 2u for the sugar and 2u for the gelatin, 6u for water and juice
content.add(content.Recipe {
    id = "gelatin_dessert_homemade",
    result = "gelatin_dessert_homemade",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "sweet_water", count = 1 }
        })
    :component_any({
            { id = "gelatin_powder", count = 5 },
            { id = "gelatin_fresh", count = 1 }
        })
    :component("sugar", 20)
    :component_any({
            { id = "sweet_juice", count = 1, requirement = true },
            { id = "soda_pop", count = 1, requirement = true }
        })
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :book("sweets_book", 1)
    :book("baking_book", 1)
    :book("mag_cooking", 3)
    :book("family_cookbook", 3)
    :batch_discount(20, 1)
    :result_charges(5)
)

-- 1u for the sugar and 2u for the gelatin, 6u for water and juice, 1u for fruit
content.add(content.Recipe {
    id = "gelatin_dessert_fruit",
    result = "gelatin_dessert_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "sweet_water", count = 1 }
        })
    :component_any({
            { id = "gelatin_powder", count = 5 },
            { id = "gelatin_fresh", count = 1 }
        })
    :component("sugar", 10)
    :component_any({
            { id = "sweet_juice", count = 1, requirement = true },
            { id = "soda_pop", count = 1, requirement = true }
        })
    :component("sweet_fruit", 1, true)
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :book("sweets_book", 1)
    :book("baking_book", 1)
    :book("mag_cooking", 3)
    :book("family_cookbook", 3)
    :batch_discount(20, 1)
    :result_charges(5)
)

-- 2u for the sugar and 2u for the agar, 6u for water and juice
content.add(content.Recipe {
    id = "gelatin_dessert_vegan",
    result = "gelatin_dessert_vegan",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "sweet_water", count = 1 }
        })
    :component("chem_agar", 5)
    :component("sugar", 20)
    :component_any({
            { id = "sweet_juice", count = 1, requirement = true },
            { id = "soda_pop", count = 1, requirement = true }
        })
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :book("sweets_book", 1)
    :book("baking_book", 1)
    :book("mag_cooking", 1)
    :book("family_cookbook", 1)
    :batch_discount(20, 1)
    :result_charges(5)
)

-- 1u for the sugar and 2u for the agar, 6u for water and juice, 1u for fruit
content.add(content.Recipe {
    id = "gelatin_dessert_vegan_fruit",
    result = "gelatin_dessert_vegan_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "sweet_water", count = 1 }
        })
    :component("chem_agar", 5)
    :component("sugar", 10)
    :component_any({
            { id = "sweet_juice", count = 1, requirement = true },
            { id = "soda_pop", count = 1, requirement = true }
        })
    :component("sweet_fruit", 1, true)
    :quality("BOIL", 1, 1)
    :quality("CONTAIN", 1, 1)
    :book("sweets_book", 1)
    :book("baking_book", 1)
    :book("mag_cooking", 1)
    :book("family_cookbook", 1)
    :batch_discount(20, 1)
    :result_charges(5)
)

-- 5u for sugar, 4u for gelatin, 1 for syrup, 6 for water and juice
content.add(content.Recipe {
    id = "candy4",
    result = "candy4",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 16, true)
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "sweet_water", count = 1 }
        })
    :component("beet_syrup", 1)
    :component_any({
            { id = "gelatin_powder", count = 25 },
            { id = "gelatin_fresh", count = 2 }
        })
    :component("sugar", 50)
    :component_any({
            { id = "sweet_juice", count = 1, requirement = true },
            { id = "soda_pop", count = 1, requirement = true }
        })
    :quality("BOIL", 1, 1)
    :book("sweets_book", 2)
    :book("baking_book", 2)
    :book("family_cookbook", 2)
    :batch_discount(20, 1)
    :result_charges(12)
)

-- 5u for sugar, 10u for agar, 1 for syrup, 6 for water and juice
content.add(content.Recipe {
    id = "candy5",
    result = "candy5",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 22, true)
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "sweet_water", count = 1 }
        })
    :component("beet_syrup", 1)
    :component("chem_agar", 25)
    :component("sugar", 50)
    :component_any({
            { id = "sweet_juice", count = 1, requirement = true },
            { id = "soda_pop", count = 1, requirement = true }
        })
    :quality("BOIL", 1, 1)
    :book("sweets_book", 2)
    :book("baking_book", 2)
    :book("family_cookbook", 2)
    :batch_discount(20, 1)
    :result_charges(12)
)

content.add(content.Recipe {
    id = "menemen",
    result = "menemen",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :component("any_bell_pepper", 1, true)
    :component("onion", 1)
    :component("salt", 1)
    :component("pepper", 1)
    :component("any_tomato", 2, true)
    :component("any_butter_or_oil", 1, true)
    :component("eggs_bird", 4, true)
    :component("water", 2)
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :book("cookbook_turkish", 2)
    :batch_discount(80, 1)
    :result_charges(2)
)

-- Uses four instead of 1 because our water is locked to 250ml, and you don't always need 250 ml of gravy
content.add(content.Recipe {
    id = "gravy_prepared",
    result = "gravy_prepared",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 1, true)
    :component("water_clean", 1)
    :component_any({
            { id = "vegan_gravy_mix", count = 4 },
            { id = "gravy_mix", count = 4 }
        })
    :quality("COOK", 2, 1)
    :batch_discount(95, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "poutine",
    result = "poutine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    result_multiplier = 2,
}
    :tool_charges("surface_heat", 1, true)
    :component("fries", 2)
    :component("cheese", 2)
    :component("gravy_prepared", 1)
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :batch_discount(80, 1)
)
