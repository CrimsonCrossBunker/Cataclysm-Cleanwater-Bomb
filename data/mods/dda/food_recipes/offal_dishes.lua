local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- raw brain weighs 56g, per scrap of meat standard this is 4u heat
content.add(content.Recipe {
    id = "brain_cooked",
    result = "brain_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component_any({
            { id = "brain", count = 1 },
            { id = "human_brain", count = 1 },
            { id = "demihuman_brain", count = 1 }
        })
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- raw brain weighs 56g, per scrap of meat standard this is 4u heat
content.add(content.Recipe {
    id = "mutant_brain_cooked",
    result = "mutant_brain_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component("mutant_brain", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- raw lung weighs 56g, per scrap of meat standard this is 4u heat
content.add(content.Recipe {
    id = "lung_cooked",
    result = "lung_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component_any({
            { id = "lung", count = 1 },
            { id = "human_lung", count = 1 },
            { id = "demihuman_lung", count = 1 }
        })
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- raw lung weighs 56g, per scrap of meat standard this is 4u heat
content.add(content.Recipe {
    id = "mutant_lung_cooked",
    result = "mutant_lung_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component_any({
            { id = "mutant_lung", count = 1 },
            { id = "mutant_bug_lungs", count = 1 }
        })
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- raw heart weighs 45g, per scrap of meat standard this is 4u heat
content.add(content.Recipe {
    id = "heart_cooked",
    result = "heart_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component_any({
            { id = "heart", count = 1 },
            { id = "human_heart", count = 1 },
            { id = "demihuman_heart", count = 1 }
        })
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- raw heart weighs 45g, per scrap of meat standard this is 4u heat
content.add(content.Recipe {
    id = "mutant_heart_cooked",
    result = "mutant_heart_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component_any({
            { id = "mutant_heart", count = 1 },
            { id = "mutant_human_heart", count = 1 }
        })
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- raw kidney weighs 56g, per scrap of meat standard this is 4u heat
content.add(content.Recipe {
    id = "kidney_cooked",
    result = "kidney_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component_any({
            { id = "kidney", count = 1 },
            { id = "human_kidney", count = 1 },
            { id = "demihuman_kidney", count = 1 }
        })
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- raw kidney weighs 56g, per scrap of meat standard this is 4u heat
content.add(content.Recipe {
    id = "mutant_kidney_cooked",
    result = "mutant_kidney_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component("mutant_kidney", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- sweetbread weighs 56g, per scrap of meat standard this is 4u heat
content.add(content.Recipe {
    id = "sweetbread_cooked",
    result = "sweetbread_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component_any({
            { id = "sweetbread", count = 1 },
            { id = "human_sweetbread", count = 1 },
            { id = "demihuman_sweetbread", count = 1 }
        })
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- sweetbread weighs 56g, per scrap of meat standard this is 4u heat
content.add(content.Recipe {
    id = "liver_cooked",
    result = "liver_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component_any({
            { id = "liver", count = 1 },
            { id = "human_liver", count = 1 },
            { id = "demihuman_liver", count = 1 },
            { id = "canned_liver", count = 1 }
        })
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- raw liver weighs 56g, per scrap of meat standard this is 4u heat
content.add(content.Recipe {
    id = "mutant_liver_cooked",
    result = "mutant_liver_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 4, true)
    :component("mutant_liver", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- double the power requirement of regular meat chunks (20u for 300g), since these are very sus as far as
-- meat goes
content.add(content.Recipe {
    id = "mutant_bug_organs_cooked",
    result = "mutant_bug_organs_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 40, true)
    :component("mutant_bug_organs", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
    :result_charges(1)
    :remove_result_flag("RAW")
    :remove_result_flag("PREDATOR_FUN")
)

-- strictly in terms of power usage this is only about 13u of power. bumping it to 15 assuming some heat is
-- wasted by slow cooking it.
content.add(content.Recipe {
    id = "foie_gras",
    result = "foie_gras",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 6,
}
    :tool_charges("surface_heat", 15, true)
    :component("meat_liver", 3, true)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :component("sweet_fruit_like", 1, true)
    :component("vinegar", 2)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("mag_glam", 5)
    :book("cookbook_liverforkids", 5, { name = content.text("Buttery Duck Bites") })
    :result_charges(1)
)

-- liver is 32u total and onions are 2u, adding 2u on top since the onions are cooked more thoroughly than
-- usual.
content.add(content.Recipe {
    id = "liver_onion",
    result = "liver_onion",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 36, true)
    :component("meat_liver", 8, true)
    :component("onion", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("scots_cookbook", 2)
    :book("cookbook", 0)
    :book("cookbook_liverforkids", 1, { name = content.text("Candied Onions and Giblets") })
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :batch_discount(83, 5)
    :result_charges(2)
)

-- 12u from the liver, 8u for the batter, 1u for the milk, 2u flex
content.add(content.Recipe {
    id = "fried_livers",
    result = "fried_livers",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 23, true)
    :component("meat_liver", 3, true)
    :component("fry_oil", 1, true)
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "con_milk", count = 1 },
            { id = "can_coconut", count = 1 }
        })
    :component("batter", 4, true)
    :component("salt", 1)
    :component_any({
            { id = "seasoning_mild", count = 1, requirement = true },
            { id = "chilly-p", count = 1 },
            { id = "curry_powder", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("family_cookbook", 2)
    :book("cookbook", 2)
    :book("cookbook_liverforkids", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :batch_discount(83, 5)
    :result_charges(3)
)

-- 20u for flour, 20u for the meat
content.add(content.Recipe {
    id = "humble_pie",
    result = "humble_pie",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 40, true)
    :component("flour_any", 20, true)
    :component("meat_offal", 1, true)
    :component("water_clean", 1)
    :quality("COOK", 2, 1)
    :book("cookbook", 1)
    :book("scots_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_baking")
    :result_charges(3)
)

content.add(content.Recipe {
    id = "fried_heart",
    result = "fried_heart",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 42000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 11, true)
    :component("meat_heart", 1, true)
    :component("batter", 3, true)
    :component("fry_oil", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requires_skill("survival", 2)
    :book("cookbook", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
)

content.add(content.Recipe {
    id = "stuffed_heart",
    result = "stuffed_heart",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 930000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 40, true)
    :component("meat_heart", 4, true)
    :component("veggy_any_fresh_uncooked", 2, true)
    :component("any_bread", 2, true)
    :component("salt", 6)
    :component("pepper", 6)
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :book("offalcooking", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(85, 4)
)

-- 4u of water boils for 60 minutes each +
content.add(content.Recipe {
    id = "stewed_tripe",
    result = "stewed_tripe",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 24, true)
    :component("meat_stomach_boiled", 1, true)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :component_any({
            { id = "veggy_any", count = 2, requirement = true },
            { id = "powder_eggs", count = 2 },
            { id = "eggs_bird", count = 2, requirement = true },
            { id = "eggs_reptile", count = 2, requirement = true },
            { id = "mushroom_cooked", count = 2 },
            { id = "morel_cooked", count = 2 },
            { id = "mushroom", count = 2 },
            { id = "dry_mushroom", count = 2 }
        })
    :component_any({
            { id = "seasoning_italian", count = 6 },
            { id = "wild_herbs", count = 6 },
            { id = "seasoning_salt", count = 2 },
            { id = "soysauce", count = 2 },
            { id = "pepper", count = 2 },
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "garlic_powder", count = 2 },
            { id = "wild_garlic", count = 1 },
            { id = "salt_water", count = 1 },
            { id = "salt", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requires_skill("survival", 2)
    :book("cookbook", 1)
    :book("scots_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :result_charges(2)
    :byproduct("broth", 4)
)

-- 70g of tripe, so roughly 5 (2.5 scraps' worth) plus 6 for the batter and oil
content.add(content.Recipe {
    id = "fried_tripe",
    result = "fried_tripe",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 96000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 11, true)
    :tool_charges("cooking_oil", 19)
    :component("stewed_tripe", 1)
    :component("batter", 3, true)
    :component("cooking_oil", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requires_skill("survival", 2)
    :book("cookbook", 1)
    :book("scots_cookbook", 2)
    :proficiency("prof_food_prep", { time_multiplier = 1 })
    :proficiency("prof_knife_skills", { time_multiplier = 1 })
    :proficiency("prof_frying", { time_multiplier = 1.2 })
    :proficiency("prof_frying_bread", { time_multiplier = 1 })
    :batch_discount(70, 1)
    :byproduct("cooking_oil", 19)
)

-- https://www.fabfood4all.co.uk/leverpostej-danish-liver-pate/ 472g of meat: 20u, ~300g fat = 20u, eggs =
-- 6u, flour = 2u, milk = 2u, onion = 2u
content.add(content.Recipe {
    id = "leverpostej",
    result = "leverpostej",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 52, true)
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "food_processor", charges = 20 }
        })
    :component("meat_liver", 8, true)
    :component_any({
            { id = "edible_fat", count = 10, requirement = true },
            { id = "edible_tallow", count = 7, requirement = true },
            { id = "bacon_uncut", count = 1 },
            { id = "bacon", count = 3 }
        })
    :component_any({
            { id = "powder_eggs", count = 2 },
            { id = "eggs_bird", count = 2, requirement = true }
        })
    :component("onion", 1)
    :component("flour_any", 2, true)
    :component("salt", 3)
    :component_any({
            { id = "milk_standard_raw", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true },
            { id = "con_milk", count = 1 },
            { id = "can_coconut", count = 1 }
        })
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :book("cookbook", 3)
    :book("family_cookbook", 3)
    :book("cookbook_liverforkids", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(83, 5)
    :result_charges(9)
)

-- brains: 8u heat, egg: 3u heat, batter: 6u heat
content.add(content.Recipe {
    id = "fried_brain",
    result = "fried_brain",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 17, true)
    :component("meat_brain", 2, true)
    :component("eggs_bird", 1, true)
    :component("batter", 3, true)
    :component("salt", 1)
    :component("seasoning_mild", 4, true)
    :component("fry_oil", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :book("cookbook", 2)
    :book("scots_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
    :batch_discount(83, 5)
    :result_charges(3)
)

-- kidney: 8u heat, flour: 2u, onion: 2u, sauce etc: 1u
content.add(content.Recipe {
    id = "deviled_kidney",
    result = "deviled_kidney",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 13, true)
    :component("meat_kidney", 2, true)
    :component("flour_any", 2, true)
    :component("onion", 1)
    :component("soysauce", 1)
    :component("salt", 1)
    :component("water_clean", 1)
    :component("mustard", 1)
    :component_any({
            { id = "sauce_pesto", count = 1 },
            { id = "sauce_red", count = 1 },
            { id = "any_tomato", count = 1, requirement = true }
        })
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :book("cookbook", 2)
    :book("family_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(83, 5)
    :result_charges(1)
)

-- sweetbread: 4u, additional stuff: 3u
content.add(content.Recipe {
    id = "grilled_sweetbread",
    result = "grilled_sweetbread",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 7, true)
    :component_any({
            { id = "sweetbread", count = 1 },
            { id = "human_sweetbread", count = 1 },
            { id = "demihuman_sweetbread", count = 1 }
        })
    :component("water_clean", 2)
    :component("vinegar", 1)
    :component("salt", 2)
    :quality("COOK", 3, 1)
    :book("scots_cookbook", 2)
    :book("cookbook", 1)
    :book("textbook_survival", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(83, 5)
    :result_charges(1)
)

-- lung: 8u, flour: 4u, onion: 2u, oil: 1u, sauce: 1u, wine: 3u
content.add(content.Recipe {
    id = "lung_provence",
    result = "lung_provence",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 330000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 19, true)
    :component("meat_lung", 4, true)
    :component("flour_any", 4, true)
    :component("onion", 1)
    :component_any({
            { id = "cooking_oil", count = 1 },
            { id = "edible_tallow", count = 2, requirement = true }
        })
    :component("salt", 6)
    :component("pepper", 6)
    :component("worthy_wine", 3, true)
    :component_any({
            { id = "garlic_clove", count = 1 },
            { id = "rehydrated_garlic", count = 1 },
            { id = "garlic_powder", count = 6 }
        })
    :component_any({
            { id = "sauce_pesto", count = 1 },
            { id = "sauce_red", count = 1 },
            { id = "any_tomato", count = 1, requirement = true }
        })
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :book("offalcooking", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(83, 5)
    :result_charges(8)
)

-- lung: 8u, kidney: 8u, brain: 8u, onion: 6u, butter: 2u, sugar: 3u, batter: 8u, sauce: 1u, wine: 3u
content.add(content.Recipe {
    id = "tÖttchen",
    result = "tÖttchen",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 47, true)
    :component("meat_lung", 4, true)
    :component("meat_kidney", 4, true)
    :component("meat_brain", 4, true)
    :component("onion", 3)
    :component("any_butter", 4, true)
    :component("salt", 6)
    :component("mustard", 3)
    :component_any({
            { id = "sugar_standard", count = 3, requirement = true },
            { id = "artificial_sweetener", count = 42 }
        })
    :component("worthy_wine", 3, true)
    :component("batter", 4, true)
    :component_any({
            { id = "sauce_pesto", count = 1 },
            { id = "sauce_red", count = 1 },
            { id = "any_tomato", count = 1, requirement = true }
        })
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :book("offalcooking", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_baking")
    :batch_discount(83, 5)
    :result_charges(8)
)

-- eggs: 9u, garlic: 1u, brains: 8u, batter: 8u, onion: 2u, butter: 2u, milk: 2u
content.add(content.Recipe {
    id = "scrambledeggsandbrain",
    result = "scrambledeggsandbrain",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 32, true)
    :component("eggs_any_shape", 3, true)
    :component_any({
            { id = "garlic_clove", count = 2 },
            { id = "rehydrated_garlic", count = 2 },
            { id = "garlic_powder", count = 6 }
        })
    :component("meat_brain", 4, true)
    :component("batter", 4, true)
    :component("onion", 1)
    :component("any_butter", 4, true)
    :component("salt", 6)
    :component("pepper", 3)
    :component_any({
            { id = "milk_standard", count = 1, requirement = true },
            { id = "lf_milk_standard", count = 1, requirement = true }
        })
    :quality("COOK", 3, 1)
    :quality("CUT", 2, 1)
    :book("offalcooking", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(83, 5)
    :result_charges(3)
)

-- Charcuterie: The Craft of Salting, Smoking, and Curing would be a good book for someone to use for further
-- meat products recipes.
content.add(content.Recipe {
    id = "sausage_casings",
    result = "sausage_casings",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :component("meat_stomach", 1, true)
    :component("salt", 20)
    :component("water_clean", 2)
    :quality("COOK", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :book("offalcooking", 3)
    :book("scots_cookbook", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 5)
    :result_charges(60)
    :byproduct("ruined_chunks", 2)
)

content.add(content.Recipe {
    id = "sausage_casings_artificial",
    result = "sausage_casings_artificial",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :component_any({
            { id = "bag_plastic", count = 1 },
            { id = "bag_plastic_small", count = 1 }
        })
    :quality("COOK", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :book("offalcooking", 3)
    :batch_discount(83, 5)
    :result_charges(60)
)

content.add(content.Recipe {
    id = "homemade_hotdogs",
    result = "homemade_hotdogs",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component_any({
            { id = "meat_nofish", count = 2, requirement = true },
            { id = "bacon", count = 8 },
            { id = "bologna", count = 10 },
            { id = "meat_pickled", count = 2 },
            { id = "dry_meat", count = 2 },
            { id = "jerky", count = 2 },
            { id = "meat_smoked", count = 2 },
            { id = "meat_salted", count = 2 },
            { id = "meat_fried", count = 2 }
        })
    :component_any({
            { id = "sausage_casings", count = 6 },
            { id = "sausage_casings_artificial", count = 6 }
        })
    :component_any({
            { id = "salt_water", count = 4 },
            { id = "saline", count = 8 },
            { id = "salt", count = 4 },
            { id = "chem_saltpetre", count = 2 },
            { id = "chem_black_powder", count = 94 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 4 },
            { id = "wild_herbs", count = 4 },
            { id = "seasoning_salt", count = 4 },
            { id = "garlic_powder", count = 4 },
            { id = "pepper", count = 4 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :book("offalcooking", 3)
    :batch_discount(50, 3)
    :result_charges(12)
)
