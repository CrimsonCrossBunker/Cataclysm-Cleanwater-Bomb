local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.replace(content.Recipe {
    id = "brew_milk_curdled",
    result = "brew_milk_curdled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :component("vinegar", 3)
    :component_any({
            { id = "wild_herbs", count = 40 },
            { id = "meat_stomach", count = 1, requirement = true }
        })
    :requirement("milk_standard_raw_fresh", 15)
    :requires_skill("survival", 4)
    :batch_discount(50, 4)
    :result_charges(18)
)

content.replace(content.Recipe {
    id = "brew_whiskey",
    result = "brew_whiskey",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component("malted_grain", 2)
    :component("sugar", 50)
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :batch_discount(95, 4)
    :result_charges(21)
)

content.replace(content.Recipe {
    id = "brew_gin",
    result = "brew_gin",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :component_any({
            { id = "corn", count = 3 },
            { id = "popcorn_cob", count = 3 },
            { id = "cornmeal", count = 3 },
            { id = "barley", count = 3 },
            { id = "buckwheat", count = 3 },
            { id = "oats", count = 3 }
        })
    :component("juniper", 10)
    :quality("BOIL", 2, 1)
    :batch_discount(95, 4)
    :result_charges(21)
)

content.replace(content.Recipe {
    id = "brew_rum",
    result = "brew_rum",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component_any({
            { id = "molasses", count = 2 },
            { id = "sugar_beet", count = 5 }
        })
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :batch_discount(95, 4)
    :result_charges(21)
)

content.replace(content.Recipe {
    id = "brew_moonshine",
    result = "brew_moonshine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 30, true)
    :component_any({
            { id = "water", count = 15 },
            { id = "water_clean", count = 15 }
        })
    :component_any({
            { id = "cornmeal", count = 12 },
            { id = "corn", count = 2 },
            { id = "popcorn_cob", count = 2 }
        })
    :component("sugar", 100)
    :component("yeast", 2)
    :quality("BOIL", 2, 1)
    :batch_discount(95, 4)
    :result_charges(105)
)

content.replace(content.Recipe {
    id = "brew_hb_seltzer",
    result = "brew_hb_seltzer",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "water", count = 10 },
            { id = "water_clean", count = 10 }
        })
    :component("sugar", 2)
    :component("yeast", 1)
    :component_any({
            { id = "juice", count = 2 },
            { id = "apple_cider", count = 4 },
            { id = "cheap_wine", count = 2, requirement = true },
            { id = "worthy_wine", count = 1, requirement = true },
            { id = "sweet_fruit", count = 1, requirement = true }
        })
    :quality("BOIL", 2, 1)
    :batch_discount(95, 4)
    :result_charges(10)
)

content.replace(content.Recipe {
    id = "brew_moonshine_pumpkin",
    result = "brew_moonshine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 30, true)
    :component_any({
            { id = "water", count = 15 },
            { id = "water_clean", count = 15 }
        })
    :component("pumpkin", 12)
    :component("sugar", 50)
    :component("yeast", 2)
    :quality("BOIL", 2, 1)
    :batch_discount(95, 4)
    :result_charges(105)
)

content.add(content.Recipe {
    id = "brew_moonshine_forage",
    result = "brew_moonshine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 30, true)
    :component_any({
            { id = "water", count = 15 },
            { id = "water_clean", count = 15 }
        })
    :component_any({
            { id = "cattail_rhizome", count = 12 },
            { id = "buckwheat", count = 15 }
        })
    :component("sugar", 100)
    :component("yeast", 2)
    :quality("BOIL", 2, 1)
    :batch_discount(95, 4)
    :result_charges(105)
)

content.replace(content.Recipe {
    id = "brew_fruit_wine",
    result = "brew_fruit_wine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component("juice", 2)
    :component("yeast", 1)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 4)
    :result_charges(21)
)

content.replace(content.Recipe {
    id = "brew_hb_beer",
    result = "brew_hb_beer",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "water", count = 10 },
            { id = "water_clean", count = 10 }
        })
    :component("malted_grain", 2)
    :component("hops", 1)
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :batch_discount(95, 4)
    :result_charges(10)
)

content.replace(content.Recipe {
    id = "brew_mead",
    result = "brew_mead",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component("water_clean", 3)
    :component_any({
            { id = "honey_bottled", count = 12 },
            { id = "honeycomb", count = 2 },
            { id = "honey_glassed", count = 4 }
        })
    :component("yeast", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 4)
    :result_charges(21)
)

content.replace(content.Recipe {
    id = "brew_dandelion_wine",
    result = "brew_dandelion_wine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component("water_clean", 3)
    :component("soaked_dandelion", 10)
    :component_any({
            { id = "sugar_standard", count = 2, requirement = true },
            { id = "honeycomb", count = 1 }
        })
    :component("yeast", 1)
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 4)
    :result_charges(21)
)

content.replace(content.Recipe {
    id = "brew_burdock_wine",
    result = "brew_burdock_wine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component("raw_burdock", 10)
    :component_any({
            { id = "sugar_standard", count = 2, requirement = true },
            { id = "honeycomb", count = 1 }
        })
    :component("yeast", 1)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :batch_discount(95, 4)
    :result_charges(21)
)

content.replace(content.Recipe {
    id = "brew_pine_wine",
    result = "brew_pine_wine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component("pine_bough", 5)
    :component_any({
            { id = "sugar_standard", count = 2, requirement = true },
            { id = "honeycomb", count = 1 }
        })
    :component("yeast", 1)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :batch_discount(95, 4)
    :result_charges(21)
)

content.add(content.Recipe {
    id = "malting_grain",
    result = "malting_grain",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component_any({
            { id = "corn", count = 1 },
            { id = "popcorn_cob", count = 1 },
            { id = "barley", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "oats", count = 1 },
            { id = "wheat", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :batch_discount(95, 4)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "soaking_dandelion",
    result = "soaking_dandelion",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("raw_dandelion", 1)
    :quality("BOIL", 2, 1)
    :batch_discount(95, 4)
    :result_charges(1)
)

content.replace(content.Recipe {
    id = "brew_vinegar",
    result = "brew_vinegar",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :component_any({
            { id = "juice", count = 2 },
            { id = "apple_cider", count = 4 },
            { id = "cheap_wine", count = 2, requirement = true },
            { id = "worthy_wine", count = 1, requirement = true },
            { id = "sweet_fruit", count = 1, requirement = true },
            { id = "wild_herbs", count = 40 }
        })
    :batch_discount(50, 4)
    :result_charges(32)
)

content.replace(content.Recipe {
    id = "gin_from_mash",
    result = "gin",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("gin_mash", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :batch_discount(50, 4)
    :result_charges(7)
)

content.replace(content.Recipe {
    id = "vodka_from_wash",
    result = "vodka",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("wash_vodka", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :batch_discount(50, 4)
    :result_charges(7)
)

content.replace(content.Recipe {
    id = "rum",
    result = "rum",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("wash_rum", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :batch_discount(50, 4)
    :result_charges(7)
)

content.replace(content.Recipe {
    id = "whiskey",
    result = "whiskey",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("wash_whiskey", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 2, 1)
    :batch_discount(50, 4)
    :result_charges(7)
)

-- should produce 12-15% foreshot with significant methanol
-- 1 unit of methanol in the JSON is 250 units in game
content.replace(content.Recipe {
    id = "moonshine",
    result = "moonshine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 21, true)
    :component("wash_moonshine", 21)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 1, 1)
    :batch_discount(50, 4)
    :result_charges(7)
)

content.replace(content.Recipe {
    id = "tea_willowbark",
    result = "tea_willowbark",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 72000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("water_boiling_heat", 8, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("willowbark", 1)
    :quality("BOIL", 1, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 5)
    :batch_discount(80, 4)
)

content.replace(content.Recipe {
    id = "dahlia_baked",
    result = "dahlia_baked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component("dahlia_root", 1)
    :quality("COOK", 2, 1)
    :quality("OVEN", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
)

content.replace(content.Recipe {
    id = "burdock_cooked",
    result = "burdock_cooked",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 5, true)
    :component("raw_burdock", 1)
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

content.replace(content.Recipe {
    id = "burdock_fried",
    result = "burdock_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 8, true)
    :component("raw_burdock", 2)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
)

-- the cooking oil isn't supposed to be expended since you can recycle it after frying the burdocks
content.replace(content.Recipe {
    id = "dandelionburdock_fried",
    result = "dandelionburdock_fried",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 8, true)
    :component("raw_dandelion", 1)
    :component("raw_burdock", 1)
    :component("any_butter_or_oil", 1, true)
    :component("batter", 1, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :proficiency("prof_frying")
    :proficiency("prof_frying_bread")
)

content.replace(content.Recipe {
    id = "chicory_coffee",
    result = "chicory_coffee",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRINKS",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("water_boiling_heat", 2, true)
    :component("chicory_raw", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_forage_cooking")
    :batch_discount(80, 4)
)

-- 2 hours of roasting are required to fully break up the toxins in raw pods
content.replace(content.Recipe {
    id = "coffee_raw_kentucky",
    result = "coffee_raw_kentucky",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 30, true)
    :component("water_clean", 1)
    :component("coffee_pod", 1)
    :quality("HAMMER", 1, 1)
    :quality("BOIL", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_forage_cooking")
    :batch_discount(90, 1)
    :result_charges(5)
    :remove_result_flag("HIDDEN_POISON")
)

content.replace(content.Recipe {
    id = "blood_pancakes",
    result = "blood_pancakes",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 8, true)
    :component("flour", 1)
    :component("edible_blood", 2, true)
    :component_any({
            { id = "sugar", count = 1 },
            { id = "artificial_sweetener", count = 1 }
        })
    :component("any_butter_or_oil", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 2, 1)
)

content.replace(content.Recipe {
    id = "soup_blood",
    result = "soup_blood",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "broth", count = 2 },
            { id = "broth_bone", count = 2 }
        })
    :component("edible_blood", 1, true)
    :component("dry_fruit", 1)
    :component("flour", 1)
    :quality("COOK", 3, 1)
    :batch_discount(80, 4)
    :result_charges(2)
)

content.replace(content.Recipe {
    id = "blutwurst_sausage",
    result = "blutwurst_sausage",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 7, true)
    :component("meat_cooked", 1, true)
    :component("edible_blood", 2, true)
    :component_any({
            { id = "edible_fat", count = 10, requirement = true },
            { id = "edible_tallow", count = 10, requirement = true }
        })
    :component_any({
            { id = "salt", count = 4 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 4 },
            { id = "wild_herbs", count = 4 },
            { id = "seasoning_salt", count = 4 },
            { id = "pepper", count = 4 }
        })
    :component("sausage_casings", 8)
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :batch_discount(83, 3)
    :result_charges(8)
)

-- Online recipe says prep time 5 min, cook time 1hr. Adjusted batch time to mimic that.
content.replace(content.Recipe {
    id = "hardtack",
    result = "hardtack",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREAD",
    duration_moves = 450000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 16, true)
    :component("flour_any", 6, true)
    :component_any({
            { id = "salt", count = 1 },
            { id = "soysauce", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("COOK", 2, 1)
    :quality("OVEN", 1, 1)
    :batch_discount(85, 1)
    :result_charges(1)
)

-- Charcuterie: The Craft of Salting, Smoking, and Curing would be a good book for someone to use for further
-- meat products recipes.
content.replace(content.Recipe {
    id = "sausage_casings",
    result = "sausage_casings",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :component("meat_stomach", 1, true)
    :component("salt", 20)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("COOK", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :batch_discount(83, 5)
    :result_charges(60)
    :byproduct("ruined_chunks", 2)
)

content.replace(content.Recipe {
    id = "sausage",
    result = "sausage",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("char_smoker", 10)
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component_any({
            { id = "meat_red", count = 2, requirement = true },
            { id = "meat_liver", count = 10, requirement = true }
        })
    :component_any({
            { id = "edible_fat", count = 10, requirement = true },
            { id = "edible_tallow", count = 10, requirement = true }
        })
    :component_any({
            { id = "salt", count = 4 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 4 },
            { id = "wild_herbs", count = 4 },
            { id = "seasoning_salt", count = 4 },
            { id = "pepper", count = 4 }
        })
    :component_any({
            { id = "sausage_casings", count = 6 },
            { id = "sausage_casings_artificial", count = 6 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_preservation")
    :proficiency("prof_food_curing")
    :batch_discount(83, 3)
    :result_charges(6)
)

content.replace(content.Recipe {
    id = "sausage_raw",
    result = "sausage_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component_any({
            { id = "meat_red", count = 2, requirement = true },
            { id = "meat_liver", count = 10, requirement = true }
        })
    :component_any({
            { id = "edible_fat", count = 10, requirement = true },
            { id = "edible_tallow", count = 10, requirement = true }
        })
    :component_any({
            { id = "salt", count = 4 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 4 },
            { id = "wild_herbs", count = 4 },
            { id = "seasoning_salt", count = 4 },
            { id = "pepper", count = 4 }
        })
    :component_any({
            { id = "sausage_casings", count = 6 },
            { id = "sausage_casings_artificial", count = 6 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(50, 3)
    :result_charges(6)
)

content.replace(content.Recipe {
    id = "sweet_sausage",
    result = "sweet_sausage",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("char_smoker", 10)
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :component("syrup", 1)
    :component_any({
            { id = "meat_red", count = 3, requirement = true },
            { id = "can_chicken", count = 3 }
        })
    :component_any({
            { id = "edible_fat", count = 10, requirement = true },
            { id = "edible_tallow", count = 10, requirement = true }
        })
    :component_any({
            { id = "salt", count = 10 },
            { id = "soysauce", count = 1 },
            { id = "seasoning_italian", count = 10 },
            { id = "wild_herbs", count = 10 },
            { id = "seasoning_salt", count = 10 },
            { id = "pepper", count = 10 }
        })
    :component_any({
            { id = "sausage_casings", count = 6 },
            { id = "sausage_casings_artificial", count = 6 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :batch_discount(83, 3)
    :result_charges(6)
)

-- Increased recipe size, due to such minuscule amounts would have excessive loss in the straining step
-- otherwise. Made it X8
content.replace(content.Recipe {
    id = "ghee",
    result = "ghee",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 2, true)
    :tool_any({
            { id = "colander_steel", count = 1 },
            { id = "sieve_steel", count = 1 },
            { id = "sieve_primitive", count = 1 },
            { id = "cotton_patchwork", count = 1 }
        })
    :component_any({
            { id = "raw_butter", count = 8 },
            { id = "butter", count = 8 }
        })
    :quality("BOIL", 1, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_indian", 1)
    :batch_discount(70, 1)
    :result_charges(8)
)

-- Book Things to do with milk.  Add curdled milk and cheese recipes to the book.  Also consider adding to
-- brewing json Airag from this book.
content.replace(content.Recipe {
    id = "raw_butter",
    result = "raw_butter",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :component("milk_cream", 5)
    :quality("CHURN", 1, 1)
    :book("dairy_book", 3)
    :batch_discount(95, 2)
    :result_charges(99)
)

-- Book Things to do with milk.  Add curdled milk and cheese recipes to the book.  Also consider adding to
-- brewing json Airag from this book.
content.replace(content.Recipe {
    id = "raw_butter_shake",
    result = "raw_butter",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool("jar_glass_sealed", 1)
    :component("water_clean", 1)
    :component("milk_cream", 3)
    :book("dairy_book", 3)
    :result_charges(33)
    :byproduct("buttermilk", 3)
)

content.replace(content.Recipe {
    id = "offal_pickled_jarred",
    result = "offal_pickled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 6,
    container = "jar_glass_sealed",
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "salt_water", count = 1 },
            { id = "saline", count = 5 }
        })
    :component("jar_glass_sealed", 1)
    :component("meat_offal", 2, true)
    :component("vinegar", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("cookbook", 6)
    :book("manual_canning", 4)
    :batch_discount(83, 5)
    :result_charges(2)
)

content.replace(content.Recipe {
    id = "offal_pickled_jarred_3l",
    result = "offal_pickled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 6,
    container = "jar_3l_glass_sealed",
}
    :tool_charges("surface_heat", 100, true)
    :component_any({
            { id = "water", count = 6 },
            { id = "water_clean", count = 6 },
            { id = "salt_water", count = 6 },
            { id = "saline", count = 30 }
        })
    :component("jar_3l_glass_sealed", 1)
    :component("meat_offal", 12, true)
    :component("vinegar", 6)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("cookbook", 6)
    :book("manual_canning", 4)
    :batch_discount(83, 5)
    :result_charges(12)
)

content.replace(content.Recipe {
    id = "fried_brain",
    result = "fried_brain",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 45, true)
    :component("meat_brain", 2, true)
    :component("eggs_bird", 1, true)
    :component("batter", 3, true)
    :component("salt", 1)
    :component("seasoning_mild", 4, true)
    :quality("COOK", 2, 1)
    :quality("CUT", 2, 1)
    :book("cookbook", 2)
    :book("scots_cookbook", 2)
    :batch_discount(83, 5)
    :result_charges(3)
)

content.replace(content.Recipe {
    id = "grilled_sweetbread",
    result = "grilled_sweetbread",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 50, true)
    :component_any({
            { id = "sweetbread", count = 1 },
            { id = "human_sweetbread", count = 1 },
            { id = "demihuman_sweetbread", count = 1 }
        })
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :component("vinegar", 1)
    :component("salt", 2)
    :quality("COOK", 3, 1)
    :book("scots_cookbook", 2)
    :book("cookbook", 1)
    :book("textbook_survival", 3)
    :batch_discount(83, 5)
    :result_charges(1)
)

content.replace(content.Recipe {
    id = "cheese_hard",
    result = "cheese_hard",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 4, true)
    :tool("cotton_patchwork", 1)
    :component("milk_curdled", 2)
    :component_any({
            { id = "salt_water", count = 1 },
            { id = "saline", count = 1 },
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :quality("BOIL", 2, 1)
    :quality("CONTAIN", 1, 1)
    :book("survival_book", 7)
    :book("dairy_book", 3)
    :batch_discount(50, 5)
)

content.replace(content.Recipe {
    id = "seasoning_italian",
    result = "seasoning_italian",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 2, true)
    :component("salt", 20)
    :component("garlic_clove", 6)
    :component("thyme", 2)
    :component("wild_herbs", 200)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :book("cookbook_italian", 2)
    :result_charges(2)
)

content.replace(content.Recipe {
    id = "pie",
    result = "pie",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component("flour_any", 30, true)
    :component("sweet_fruit_like", 8, true)
    :component_any({
            { id = "sugar", count = 20 },
            { id = "syrup", count = 4 },
            { id = "beet_syrup", count = 4 },
            { id = "molasses", count = 4 },
            { id = "artificial_sweetener", count = 20 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 2, 1)
    :quality("OVEN", 1, 1)
    :book("baking_book", 3)
    :book("family_cookbook", 3)
    :book("sweets_book", 3)
    :result_charges(8)
)

content.replace(content.Recipe {
    id = "pie_veggy",
    result = "pie_veggy",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component("flour_any", 30, true)
    :component_any({
            { id = "veggy_any", count = 8, requirement = true },
            { id = "wild_herbs", count = 40 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 2, 1)
    :quality("OVEN", 1, 1)
    :book("baking_book", 2)
    :book("scots_cookbook", 3)
    :book("cookbook", 3)
    :result_charges(4)
)

content.replace(content.Recipe {
    id = "pie_meat",
    result = "pie_meat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component("flour_any", 30, true)
    :component_any({
            { id = "meat_red", count = 1, requirement = true },
            { id = "dry_meat", count = 1 },
            { id = "can_chicken", count = 1 },
            { id = "fish", count = 1 },
            { id = "rehydrated_fish", count = 1 },
            { id = "dry_fish", count = 1 },
            { id = "salted_fish", count = 1 },
            { id = "meat_salted", count = 1 },
            { id = "fish_canned", count = 1 },
            { id = "can_tuna", count = 1 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 2, 1)
    :quality("OVEN", 1, 1)
    :book("baking_book", 2)
    :book("scots_cookbook", 3)
    :result_charges(4)
)

content.replace(content.Recipe {
    id = "humble_pie",
    result = "humble_pie",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 45, true)
    :component("flour_any", 20, true)
    :component("meat_offal", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("COOK", 2, 1)
    :quality("OVEN", 1, 1)
    :book("cookbook", 1)
    :book("scots_cookbook", 2)
    :result_charges(3)
)

-- Canned tomatoes aren't an option as they've already been preserved.
content.replace(content.Recipe {
    id = "veggy_pickled_jarred",
    result = "veggy_pickled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
    container = "jar_glass_sealed",
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "salt_water", count = 1 },
            { id = "saline", count = 5 }
        })
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "veggy", count = 2 },
            { id = "veggy_wild", count = 2 },
            { id = "mushroom", count = 2 },
            { id = "tomato", count = 2 },
            { id = "broccoli", count = 2 },
            { id = "zucchini", count = 2 },
            { id = "cucumber", count = 2 },
            { id = "potato", count = 2 },
            { id = "corn", count = 2 },
            { id = "onion", count = 2 },
            { id = "garlic_clove", count = 12 },
            { id = "carrot", count = 4 }
        })
    :component("vinegar", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("manual_canning", 4)
    :batch_discount(83, 5)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "sauerkraut_ferment",
    result = "sauerkraut_ferment",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component_any({
            { id = "salt_water", count = 1 },
            { id = "saline", count = 2 },
            { id = "salt", count = 2 }
        })
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "veggy", count = 2 },
            { id = "lettuce", count = 2 },
            { id = "veggy_wild", count = 2 },
            { id = "cabbage", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("fermenting_book", 2)
    :book("cookbook_foodfashions", 4)
)

content.add(content.Recipe {
    id = "pickles_ferment",
    result = "pickles_ferment",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("vinegar", 1)
    :component_any({
            { id = "saline", count = 1 },
            { id = "salt", count = 2 }
        })
    :component("jar_glass_sealed", 1)
    :component("cucumber", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("fermenting_book", 3)
)

content.add(content.Recipe {
    id = "eggs_ferment",
    result = "eggs_ferment",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("vinegar", 1)
    :component_any({
            { id = "saline", count = 1 },
            { id = "salt", count = 2 }
        })
    :component("jar_glass_sealed", 1)
    :component("boiled_egg", 10)
    :quality("COOK", 3, 1)
    :book("fermenting_book", 4)
)

content.replace(content.Recipe {
    id = "meat_pickled_jarred",
    result = "meat_pickled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 6,
    container = "jar_glass_sealed",
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "salt_water", count = 1 },
            { id = "saline", count = 5 }
        })
    :component("jar_glass_sealed", 1)
    :component("meat_red_raw", 2, true)
    :component("vinegar", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("manual_canning", 4)
    :batch_discount(83, 5)
    :result_charges(2)
)

content.replace(content.Recipe {
    id = "fish_pickled_jarred",
    result = "fish_pickled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 6,
    container = "jar_glass_sealed",
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
            { id = "salt_water", count = 1 },
            { id = "saline", count = 5 }
        })
    :component("jar_glass_sealed", 1)
    :component("fish", 2)
    :component("vinegar", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("manual_canning", 4)
    :batch_discount(83, 5)
    :result_charges(2)
)

content.replace(content.Recipe {
    id = "jam_fruit",
    result = "jam_fruit",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 2, true)
    :component("sweet_fruit", 1, true)
    :component("sugar_powdered", 10, true)
    :quality("COOK", 2, 1)
    :book("sweets_book", 1)
    :book("cookbook", 1)
    :batch_discount(80, 4)
    :result_charges(8)
)

content.replace(content.Recipe {
    id = "fish_pickled_jarred_3l",
    result = "fish_pickled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 6,
    container = "jar_3l_glass_sealed",
}
    :tool_charges("surface_heat", 100, true)
    :component_any({
            { id = "water", count = 6 },
            { id = "water_clean", count = 6 },
            { id = "salt_water", count = 6 },
            { id = "saline", count = 30 }
        })
    :component("jar_3l_glass_sealed", 1)
    :component("fish", 12)
    :component("vinegar", 6)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("manual_canning", 4)
    :batch_discount(83, 5)
    :result_charges(12)
)

content.replace(content.Recipe {
    id = "meat_pickled_jarred_3l",
    result = "meat_pickled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 6,
    container = "jar_3l_glass_sealed",
}
    :tool_charges("surface_heat", 100, true)
    :component_any({
            { id = "water", count = 6 },
            { id = "water_clean", count = 6 },
            { id = "salt_water", count = 6 },
            { id = "saline", count = 30 }
        })
    :component("jar_3l_glass_sealed", 1)
    :component("meat_red_raw", 12, true)
    :component("vinegar", 6)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("manual_canning", 4)
    :batch_discount(83, 5)
    :result_charges(12)
)

-- Canned tomatoes aren't an option as they've already been preserved.
content.replace(content.Recipe {
    id = "veggy_pickled_jarred_3l",
    result = "veggy_pickled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
    container = "jar_3l_glass_sealed",
}
    :tool_charges("surface_heat", 100, true)
    :component_any({
            { id = "water", count = 6 },
            { id = "water_clean", count = 6 },
            { id = "salt_water", count = 6 },
            { id = "saline", count = 30 }
        })
    :component("jar_3l_glass_sealed", 1)
    :component_any({
            { id = "veggy", count = 12 },
            { id = "veggy_wild", count = 12 },
            { id = "mushroom", count = 12 },
            { id = "tomato", count = 12 },
            { id = "broccoli", count = 12 },
            { id = "zucchini", count = 12 },
            { id = "cucumber", count = 12 },
            { id = "potato", count = 12 },
            { id = "corn", count = 12 },
            { id = "onion", count = 12 },
            { id = "garlic_clove", count = 72 },
            { id = "carrot", count = 24 }
        })
    :component("vinegar", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("manual_canning", 4)
    :batch_discount(83, 5)
    :result_charges(12)
)

content.replace(content.Recipe {
    id = "meatball_raw",
    result = "meatball_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_MEAT",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 4,
}
    :component("meat_red", 2, true)
    :component("any_bread", 1, true)
    :component_any({
            { id = "salt", count = 2 },
            { id = "soysauce", count = 2 },
            { id = "seasoning_italian", count = 2 },
            { id = "wild_herbs", count = 2 },
            { id = "seasoning_salt", count = 2 },
            { id = "pepper", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 1, 1)
    :book("family_cookbook", 2)
    :book("cookbook_italian", 2)
    :batch_discount(50, 3)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "honeydew",
    result = "honeydew",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :tool_charges("surface_heat", 2, true)
    :component("fresh_honeydew", 2)
    :quality("COOK", 2, 1)
    :batch_discount(80, 2)
    :result_charges(1)
)
