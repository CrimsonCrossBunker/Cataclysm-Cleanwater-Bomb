local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

-- fruit = 1u, flour = 1u, blood = 15u, broth = 4u
content.add(content.Recipe {
    id = "soup_blood",
    result = "soup_blood",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 21, true)
    :component_any({
            { id = "broth", count = 2 },
            { id = "broth_bone", count = 2 }
        })
    :component("edible_blood", 1, true)
    :component("dry_fruit", 1)
    :component("flour", 1)
    :quality("COOK", 3, 1)
    :book("cookbook_bloodforgood", 2)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(2)
)

-- very little is needed to make this strictly edible beyond boiling the water
content.add(content.Recipe {
    id = "soup_instant_chicken_noodle_prepared",
    result = "soup_instant_chicken_noodle_prepared",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("soup_instant_chicken_noodle_powder", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
    :result_charges(1)
)

-- very little is needed to make this strictly edible beyond boiling the water
content.add(content.Recipe {
    id = "soup_instant_vegetable_prepared",
    result = "soup_instant_vegetable_prepared",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component("soup_instant_vegetable_powder", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(80, 4)
    :result_charges(1)
)

-- 1u for the mushrooms, 1u for the broth, 2u for the time spent boiling.
content.add(content.Recipe {
    id = "soup_mushroom",
    result = "soup_mushroom",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 4, true)
    :quality("COOK", 3, 1)
    :requirement("mushroom_soup_ingredients", 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(1)
)

-- 1u for the veggy, 1u for the broth, 2u for the time spent boiling.
content.add(content.Recipe {
    id = "soup_veggy",
    result = "soup_veggy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 4, true)
    :quality("COOK", 3, 1)
    :requirement("veggy_soup_ingredients", 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(1)
)

-- rice: 4u, beans: 4u, corn: 2u, 3u for the pumpkin, 2u for oil/broth, 1u flex
content.add(content.Recipe {
    id = "soup_three_sisters",
    result = "soup_three_sisters",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 16, true)
    :component_any({
            { id = "dry_wild_rice", count = 1 },
            { id = "wild_rice_cooked", count = 1 }
        })
    :component_any({
            { id = "dry_beans", count = 1 },
            { id = "can_beans", count = 1 }
        })
    :component_any({
            { id = "corn_kernels", count = 1 },
            { id = "can_corn", count = 1 }
        })
    :component("pumpkin_cut", 1)
    :component("any_butter_or_oil", 1, true)
    :component("broth", 1)
    :quality("COOK", 3, 1)
    :book("cookbook_native", 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(4)
)

-- 3u for the ingredients, 1u for the broth, 2u for the time spent boiling.
content.add(content.Recipe {
    id = "soup_meat",
    result = "soup_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 6, true)
    :quality("COOK", 3, 1)
    :requirement("meat_soup_ingredients", 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(2)
)

-- 2u for the ingredients, 1u for the broth, 2u for the time spent boiling.
content.add(content.Recipe {
    id = "soup_fish",
    result = "soup_fish",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 6, true)
    :quality("COOK", 3, 1)
    :requirement("fish_soup_ingredients", 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(2)
)

-- 2u for the ingredients, 1u for the broth, 2u for the time spent boiling.
content.add(content.Recipe {
    id = "soup_lobsterstew",
    result = "soup_lobsterstew",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 5, true)
    :quality("COOK", 3, 1)
    :requirement("lobster_stew_ingredients", 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(2)
)

-- 3u for the ingredients, 1u for the broth, 2u for the time spent boiling.
content.add(content.Recipe {
    id = "soup_woods",
    result = "soup_woods",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 6, true)
    :quality("COOK", 3, 1)
    :requirement("woods_soup_ingredients", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 4)
    :result_charges(2)
)

-- 5u for the ingredients, 1u for the broth, 2u for the time spent boiling.
content.add(content.Recipe {
    id = "soup_woods_egg",
    result = "soup_woods_egg",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 6, true)
    :quality("COOK", 3, 1)
    :requirement("woods_soup_ingredients_veggy", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 4)
    :result_charges(1)
)

-- 18u for the ingredients, 1u for the water, 2u for the time spent frying.
content.add(content.Recipe {
    id = "hellfire_stew",
    result = "hellfire_stew",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("hardtack", 6)
    :component("salt", 2)
    :component("pepper", 2)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("COOK", 3, 1)
    :requirement("edible_fat", 5)
    :batch_setup(36000)
    :result_charges(10)
)

-- 4u for beans/veggy, 4u for meat, 1u for tomato
content.add(content.Recipe {
    id = "curry_meat",
    result = "curry_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 9, true)
    :component_any({
            { id = "veggy", count = 2 },
            { id = "veggy_wild", count = 2 },
            { id = "veggy_salted", count = 2 },
            { id = "rehydrated_veggy", count = 2 },
            { id = "dry_veggy", count = 2 },
            { id = "rehydrated_corn_kernels", count = 2 },
            { id = "dry_corn", count = 2 },
            { id = "corn_kernels", count = 2 },
            { id = "mushroom", count = 2 },
            { id = "dry_mushroom", count = 2 },
            { id = "morel_cooked", count = 2 },
            { id = "mushroom_cooked", count = 2 },
            { id = "bamboo_cooked", count = 2 },
            { id = "can_beans", count = 1 },
            { id = "dry_beans", count = 1 },
            { id = "raw_beans", count = 1 },
            { id = "dry_lentils", count = 1 },
            { id = "dry_rice", count = 1 },
            { id = "soybean", count = 1 },
            { id = "dry_soybean", count = 1 },
            { id = "dry_wild_rice", count = 1 },
            { id = "wheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "buckwheat", count = 1 }
        })
    :component("any_tomato", 1, true)
    :component_any({
            { id = "meat_cooked", count = 1, requirement = true },
            { id = "dry_meat", count = 1 },
            { id = "can_chicken", count = 1 }
        })
    :component_any({
            { id = "curry_powder", count = 4 },
            { id = "chilly-p", count = 4 }
        })
    :quality("COOK", 2, 1)
    :book("cookbook_indian", 1)
    :book("cookbook_curry", 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(1)
)

-- 4u for beans/veggy, 1u for tomato
content.add(content.Recipe {
    id = "curry_veggy",
    result = "curry_veggy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "veggy", count = 2 },
            { id = "veggy_wild", count = 2 },
            { id = "veggy_salted", count = 2 },
            { id = "rehydrated_veggy", count = 2 },
            { id = "dry_veggy", count = 2 },
            { id = "rehydrated_corn_kernels", count = 2 },
            { id = "dry_corn", count = 2 },
            { id = "corn_kernels", count = 2 },
            { id = "mushroom", count = 2 },
            { id = "dry_mushroom", count = 2 },
            { id = "morel_cooked", count = 2 },
            { id = "mushroom_cooked", count = 2 },
            { id = "bamboo_cooked", count = 2 },
            { id = "can_beans", count = 1 },
            { id = "dry_beans", count = 1 },
            { id = "raw_beans", count = 1 },
            { id = "tofu", count = 1 },
            { id = "dry_tofu", count = 1 },
            { id = "dry_lentils", count = 1 },
            { id = "dry_rice", count = 1 },
            { id = "dry_wild_rice", count = 1 },
            { id = "soybean", count = 1 },
            { id = "dry_soybean", count = 1 },
            { id = "wheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "buckwheat", count = 1 }
        })
    :component("any_tomato", 1, true)
    :component_any({
            { id = "curry_powder", count = 4 },
            { id = "chilly-p", count = 4 }
        })
    :quality("COOK", 2, 1)
    :book("cookbook_indian", 1)
    :book("cookbook_curry", 1)
    :proficiency("prof_food_prep")
    :batch_discount(80, 4)
    :result_charges(1)
)

-- 150g of meat for 10u + 1u for milk
content.add(content.Recipe {
    id = "soup_cullenskink",
    result = "soup_cullenskink",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 11, true)
    :component("water_clean", 1)
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "milk_powder", count = 1 },
            { id = "con_milk", count = 1 }
        })
    :component_any({
            { id = "dry_fish", count = 1 },
            { id = "salted_fish", count = 1 },
            { id = "fish_smoked", count = 1 },
            { id = "fish_pickled", count = 1 }
        })
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :book("family_cookbook", 4)
    :book("scots_cookbook", 2)
    :batch_discount(50, 4)
    :result_charges(1)
)

-- I KNOW coq au vin is French food, I deeply apologize for the heresy I've committed
-- 4 servings worth of chicken cooked on surface heat, boiling heat 2u for broth, 3u for ingredients, 4u for
-- time spent reducing everything
content.add(content.Recipe {
    id = "coqauvin",
    result = "coqauvin",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 6, true)
    :tool_charges("surface_heat", 28, true)
    :component("poultry_raw_any", 3, true)
    :component("bacon", 2)
    :component("flour_any", 1, true)
    :component("sauce_red", 1)
    :component_any({
            { id = "worthy_wine", count = 4, requirement = true },
            { id = "fruit_wine", count = 4 }
        })
    :component("broth", 2)
    :component_any({
            { id = "garlic_clove", count = 2 },
            { id = "rehydrated_garlic", count = 2 },
            { id = "garlic_powder", count = 2 }
        })
    :component("pepper", 2)
    :component("salt", 2)
    :component("seasoning_italian", 2)
    :component("any_butter", 1, true)
    :component_any({
            { id = "vinegar", count = 2 },
            { id = "lemon", count = 1 }
        })
    :component("veggy_any_fresh_uncooked", 2, true)
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :book("cookbook_italian", 4)
    :proficiency("prof_food_prep")
    :batch_discount(60, 2)
    :result_charges(4)
)
