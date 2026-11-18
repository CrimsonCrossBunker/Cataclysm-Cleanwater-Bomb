local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

-- 20u energy to cook a meat chunk per standard
content.add(content.Recipe {
    id = "meat_cooked",
    result = "meat_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("meat", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 20u energy to cook a meat chunk per standard
content.add(content.Recipe {
    id = "peppermeat",
    result = "peppermeat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 102000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("meat", 1)
    :component("pepper", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- same weight as chunk of meat, so same power cost
content.add(content.Recipe {
    id = "meat_fatty_cooked",
    result = "meat_fatty_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "porkbelly", count = 1 },
            { id = "raw_curing_fatty_meat_active", count = 1 },
            { id = "raw_cured_fatty_meat", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- same weight as chunk of meat, so same power cost
content.add(content.Recipe {
    id = "pepperfat",
    result = "pepperfat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 102000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "porkbelly", count = 1 },
            { id = "raw_curing_fatty_meat_active", count = 1 },
            { id = "raw_cured_fatty_meat", count = 1 }
        })
    :component("pepper", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "raw_curing_fatty_meat_active",
    result = "raw_curing_fatty_meat_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component_any({
            { id = "salt_water", count = 1 },
            { id = "saline", count = 1 },
            { id = "salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "pepper", count = 2 },
            { id = "chem_saltpetre", count = 1 },
            { id = "chem_black_powder", count = 47 }
        })
    :component("sugar_standard", 1, true)
    :component("porkbelly", 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 2)
)

content.add(content.Recipe {
    id = "raw_curing_meat_active",
    result = "raw_curing_meat_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component("salt_preservation", 1, true)
    :component("meat_red_raw_curable", 1, true)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 2)
    :remove_result_flag("BAD_TASTE")
)

-- 4u heat to cook 60g of flesh
content.add(content.Recipe {
    id = "cooked_marrow",
    result = "cooked_marrow",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 4, true)
    :component("edible_bonemarrow", 1, true)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "pepperbone",
    result = "pepperbone",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 132000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 5, true)
    :component("edible_bonemarrow", 1, true)
    :component("pepper", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 2u heat to cook 30g of flesh
content.add(content.Recipe {
    id = "meat_scrap_cooked",
    result = "meat_scrap_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 4500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "meat_scrap", count = 1 },
            { id = "human_meat_scrap", count = 1 },
            { id = "demihuman_meat_scrap", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 2u heat to cook 30g of flesh
content.add(content.Recipe {
    id = "pepperscrap",
    result = "pepperscrap",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 4500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "meat_scrap", count = 1 },
            { id = "human_meat_scrap", count = 1 },
            { id = "demihuman_meat_scrap", count = 1 }
        })
    :component("pepper", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- fish scrap weighs 1/2 meat scrap = 1u energy
content.add(content.Recipe {
    id = "fish_scrap_cooked",
    result = "fish_scrap_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 4500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 1, true)
    :component("fish_scrap", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- half the calories of meat chunk but still same weight so same cost at 20u
content.add(content.Recipe {
    id = "mutant_meat_cooked",
    result = "mutant_meat_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("mutant_meat", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 20u heat to cook 300g of flesh
content.add(content.Recipe {
    id = "peppermutant",
    result = "peppermutant",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 102000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("mutant_meat", 1)
    :component("pepper", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- half the calories of meat scrap but still same weight so same cost at 2u
content.add(content.Recipe {
    id = "mutant_meat_scrap_cooked",
    result = "mutant_meat_scrap_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 4500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("mutant_meat_scrap", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
    :remove_result_flag("BAD_TASTE")
)

-- 2u heat to cook 30g of flesh
content.add(content.Recipe {
    id = "pepperscrap_mutant",
    result = "pepperscrap_mutant",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 4700,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("mutant_meat_scrap", 1)
    :component("pepper", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
    :remove_result_flag("BAD_TASTE")
)

-- 300g meat = 20u heat per usual
content.add(content.Recipe {
    id = "mutant_human_cooked",
    result = "mutant_human_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("mutant_human_flesh", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 20u heat to cook 300g of flesh
content.add(content.Recipe {
    id = "peppermutant_human",
    result = "peppermutant_human",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 102000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("mutant_human_flesh", 1)
    :component("pepper", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 2u for the water and boiling for 15 minutes, 1u for the weight of the stomach (144g, half a meat chunk)
content.add(content.Recipe {
    id = "stomach_boiled",
    result = "stomach_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 3, true)
    :component("stomach_large", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 2u for the water and boiling for 15 minutes, 1u for the weight of the stomach (144g, half a meat chunk)
content.add(content.Recipe {
    id = "hstomach_boiled",
    result = "hstomach_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 3, true)
    :component("hstomach_large", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- small stomach is half weight of large stomach (72g) plus doesn't boil for full 15 extra minutes, so 2u
-- boiling
content.add(content.Recipe {
    id = "small_stomach_boiled",
    result = "small_stomach_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("stomach", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- small stomach is half weight of large stomach (72g) plus doesn't boil for full 15 extra minutes, so 2u
-- boiling
content.add(content.Recipe {
    id = "small_hstomach_boiled",
    result = "small_hstomach_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("hstomach", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 100g weight so 10u power.
content.add(content.Recipe {
    id = "froglegs_cooked",
    result = "froglegs_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 10, true)
    :component("froglegs", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- half weight of a meat chunk so 10u power.
content.add(content.Recipe {
    id = "fish_cooked",
    result = "fish_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 10, true)
    :component("fish", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- half weight of a meat chunk so 10u power.
content.add(content.Recipe {
    id = "lobster_cooked",
    result = "lobster_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 10, true)
    :component("lobster", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- half weight of a meat chunk so 10u power.
content.add(content.Recipe {
    id = "mollusk_cooked",
    result = "mollusk_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 10, true)
    :component("mollusk", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 2u of boiling heat since you boil them for a little while
content.add(content.Recipe {
    id = "gastropod_purged",
    result = "gastropod_purged",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("snail_garden", 2)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "salt_water", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(67, 5)
    :result_charges(2)
)

-- 1u of surface heat since 30g of snails
content.add(content.Recipe {
    id = "gastropod_cooked",
    result = "gastropod_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 1, true)
    :component("gastropod_purged", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(67, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "oyster_shucked",
    result = "oyster_shucked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :component("oyster", 1)
    :quality("CUT", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(10, 11)
    :result_charges(1)
)

-- total is 660g of fat, 5960 calories.  https://heygrillhey.com/beef-tallow/ shows 4 hours of low boil to
-- make 11610 calories of tallow, so halve that, 2 hours boiling ish
content.add(content.Recipe {
    id = "tallow",
    result = "tallow",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 20, true)
    :component("fat", 30)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(90, 2)
    :result_charges(30)
)

content.add(content.Recipe {
    id = "mutant_tallow",
    result = "mutant_tallow",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 20, true)
    :component("mutant_fat", 30)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(90, 2)
    :result_charges(30)
)

content.add(content.Recipe {
    id = "mutant_human_tallow",
    result = "mutant_human_tallow",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 20, true)
    :component("mutant_human_fat", 30)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(90, 2)
    :result_charges(30)
)

-- 300g of meat for 30 smoking_heats
content.add(content.Recipe {
    id = "meat_smoked",
    result = "meat_smoked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("smoking_heat", 30, true)
    :component("meat_red_raw", 1, true)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 3)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "meat_mutant_tainted_cooked",
    result = "meat_mutant_tainted_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("meat_mutant_tainted", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "meat_mutant_tainted_smoked",
    result = "meat_mutant_tainted_smoked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("smoking_heat", 30, true)
    :component("meat_mutant_tainted", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 3)
    :result_charges(1)
)

-- 100g of meat would be 10 smoking_heats
content.add(content.Recipe {
    id = "froglegs_smoked",
    result = "froglegs_smoked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("smoking_heat", 10, true)
    :component("froglegs", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 3)
    :result_charges(1)
)

-- 150g of meat would be 15 smoking_heats
content.add(content.Recipe {
    id = "fish_smoked",
    result = "fish_smoked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("smoking_heat", 15, true)
    :component("fish", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 3)
    :result_charges(1)
)

-- 150g of meat would be 15 smoking_heats
content.add(content.Recipe {
    id = "lobster_smoked",
    result = "lobster_smoked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("smoking_heat", 15, true)
    :component("lobster", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 3)
    :result_charges(1)
)

-- 150g of meat would be 15 smoking_heats
content.add(content.Recipe {
    id = "mollusk_smoked",
    result = "mollusk_smoked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("smoking_heat", 15, true)
    :component("mollusk", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 3)
    :result_charges(1)
)

-- 100g of meat for 10 smoking_heats
content.add(content.Recipe {
    id = "poultry_smoked",
    result = "poultry_smoked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("smoking_heat", 10, true)
    :component("poultry_raw_any", 1, true)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 9)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "human_tallow",
    result = "human_tallow",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 20, true)
    :component("human_fat", 30)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(90, 2)
    :result_charges(30)
)

-- as usual, 300g of meat = 20u surface_heat
content.add(content.Recipe {
    id = "human_cooked",
    result = "human_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("human_flesh", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(67, 5)
)

-- 20u heat to cook 300g of flesh
content.add(content.Recipe {
    id = "pepperhuman",
    result = "pepperhuman",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 102000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 20, true)
    :component("human_flesh", 1)
    :component("pepper", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(67, 5)
)

-- 300g meat + 25% to dry it out a bit more
content.add(content.Recipe {
    id = "jerky",
    result = "jerky",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 25, true)
    :component("salt_preservation", 1, true)
    :component("meat_red_raw", 1, true)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :batch_discount(83, 5)
    :result_charges(1)
    :remove_result_flag("BAD_TASTE")
)

-- 150g meat + 25%
content.add(content.Recipe {
    id = "salted_fish",
    result = "salted_fish",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 13, true)
    :component("salt_preservation", 1, true)
    :component("fish", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :batch_discount(83, 5)
    :result_charges(2)
)

-- 150g meat + 25%
content.add(content.Recipe {
    id = "salted_mollusk",
    result = "salted_mollusk",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 13, true)
    :component("salt_preservation", 1, true)
    :component("mollusk", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :batch_discount(83, 5)
)

content.add(content.Recipe {
    id = "salted_fish_vacuum_packed",
    result = "salted_fish",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
    container = "plastic_bag_vac",
}
    :component("fish", 5)
    :component("salt_preservation", 5, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requirement("vacuum_sealing_standard", 1)
    :book("vacuum_sealing", 1)
    :proficiency("prof_preservation")
    :batch_discount(10, 3)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "demihuman_cooked",
    result = "demihuman_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 7, true)
    :component("demihuman_flesh", 1)
    :quality("COOK", 1, 1)
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "demihuman_tallow",
    result = "demihuman_tallow",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 20, true)
    :component("demihuman_fat", 30)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(90, 2)
    :result_charges(30)
)

-- small stomach is half weight of large stomach (72g) plus doesn't boil for full 15 extra minutes, so 2u
-- boiling
content.add(content.Recipe {
    id = "small_demihuman_stomach_boiled",
    result = "small_demihuman_stomach_boiled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("demihuman_stomach", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :batch_discount(67, 5)
)

-- 300g meat = 20u
content.add(content.Recipe {
    id = "meat_fried",
    result = "meat_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 20, true)
    :component("meat_red", 1, true)
    :component("fry_oil", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills", { time_multiplier = 1.5 })
    :proficiency("prof_frying")
    :batch_discount(67, 5)
)

-- 6.66... unit heat to cook 100g of meat
content.add(content.Recipe {
    id = "poultry_cooked",
    result = "poultry_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 7, true)
    :component("poultry", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

-- 2u heat to cook 30g of flesh, one scrap is 20g but close enough
content.add(content.Recipe {
    id = "poultry_scrap_cooked",
    result = "poultry_scrap_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 4500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("poultry_scrap", 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "poultry_pepper",
    result = "poultry_pepper",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 102000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 7, true)
    :component("poultry", 1)
    :component("pepper", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)

content.add(content.Recipe {
    id = "poultry_scrap_pepper",
    result = "poultry_scrap_pepper",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 4500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 2, true)
    :component("poultry_scrap", 1)
    :component("pepper", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :batch_discount(67, 5)
)
