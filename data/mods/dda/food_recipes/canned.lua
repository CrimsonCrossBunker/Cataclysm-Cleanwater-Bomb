local content = require("ccb").content

local NO_EXERCISE = 1

-- --------------------Pressure canning recipes begin here--------------------
-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "offal_canned_jarred",
    result = "offal_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :component("meat_offal", 2, true)
    :component("water_clean", 1)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :requirement("canning_high_heat", 1)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "dogfood_jarred",
    result = "dogfood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "meat_nofish", count = 1, requirement = true },
            { id = "fish", count = 1 },
            { id = "lobster", count = 1 }
        })
    :component("veggy_green", 1, true)
    :requirement("canning_high_heat", 1)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "dogfood_jarred_3l",
    result = "dogfood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component_any({
            { id = "meat_nofish", count = 6, requirement = true },
            { id = "fish", count = 6 },
            { id = "lobster", count = 6 }
        })
    :component("veggy_green", 6, true)
    :requirement("canning_high_heat", 6)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(6)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "catfood_jarred",
    result = "catfood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "meat_nofish", count = 4, requirement = true },
            { id = "fish", count = 4 },
            { id = "fish", count = 4 }
        })
    :requirement("canning_high_heat", 1)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "catfood_jarred_3l",
    result = "catfood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component_any({
            { id = "meat_nofish", count = 24, requirement = true },
            { id = "fish", count = 24 },
            { id = "lobster", count = 24 }
        })
    :requirement("canning_high_heat", 6)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "soup_mushroom_jarred",
    result = "soup_mushroom",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :component("water_clean", 1)
    :requirement("mushroom_soup_ingredients", 2)
    :requirement("canning_high_heat", 1)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "soup_mushroom_jarred_3l",
    result = "soup_mushroom",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :component("water_clean", 10)
    :requirement("mushroom_soup_ingredients", 12)
    :requirement("canning_high_heat", 6)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "meat_canned_jarred",
    result = "meat_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component("meat_red_raw", 2, true)
    :requirement("canning_high_heat", 1)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "fish_canned_jarred",
    result = "fish_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component("fish", 2)
    :requirement("canning_high_heat", 1)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "lobster_canned_jarred",
    result = "lobster_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component("lobster", 2)
    :requirement("canning_high_heat", 1)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "veggy_canned_jarred",
    result = "veggy_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "mushroom", count = 4 },
            { id = "veggy_any_uncooked", count = 2, requirement = true }
        })
    :requirement("canning_high_heat", 1)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "can_chicken_jarred",
    result = "can_chicken",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component("poultry_raw_any", 4, true)
    :requirement("canning_high_heat", 1)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "soup_woods_jarred",
    result = "soup_woods",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :requirement("woods_soup_ingredients", 1)
    :requirement("canning_high_heat", 1)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "soup_meat_jarred",
    result = "soup_meat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :requirement("meat_soup_ingredients", 1)
    :requirement("canning_high_heat", 1)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "soup_veggy_jarred",
    result = "soup_veggy",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :requirement("veggy_soup_ingredients", 2)
    :requirement("canning_high_heat", 1)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "soup_fish_jarred",
    result = "soup_fish",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :requirement("fish_soup_ingredients", 1)
    :requirement("canning_high_heat", 1)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "broth_jarred",
    result = "broth",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :requirement("broth_ingredients", 2)
    :requirement("canning_high_heat", 1)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "broth_meat_jarred",
    result = "broth_meat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :requirement("broth_meat_ingredients", 2)
    :requirement("canning_high_heat", 1)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- this was using 20 bones (2.3kg), so it was lowered.  Bone broth uses 1:2-1:4 bone:water per weight.
-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "broth_bone_jarred",
    result = "broth_bone",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :component("water_clean", 2)
    :component("bone_edible", 2, true)
    :requirement("canning_high_heat", 1)
    :book("cookbook_eatyrway", 5)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
    :byproduct("gelatin_fresh", 2)
)

content.add(content.Recipe {
    id = "can_beans_jarred",
    result = "can_beans",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "beans_cooked", count = 2 },
            { id = "dry_beans", count = 2 },
            { id = "raw_beans", count = 2 }
        })
    :requirement("canning_high_heat", 1)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "meat_canned_jarred_3l",
    result = "meat_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component("meat_red_raw", 12, true)
    :requirement("canning_high_heat", 6)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "veggy_canned_jarred_3l",
    result = "veggy_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component_any({
            { id = "mushroom", count = 24 },
            { id = "veggy_any_uncooked", count = 12, requirement = true }
        })
    :requirement("canning_high_heat", 6)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "fish_canned_jarred_3l",
    result = "fish_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component("fish", 12)
    :requirement("canning_high_heat", 6)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "lobster_canned_jarred_3l",
    result = "lobster_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component("lobster", 12)
    :requirement("canning_high_heat", 6)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "offal_canned_jarred_3l",
    result = "offal_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component("meat_offal", 12, true)
    :requirement("canning_high_heat", 6)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "can_beans_jarred_3l",
    result = "can_beans",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component_any({
            { id = "beans_cooked", count = 12 },
            { id = "dry_beans", count = 12 },
            { id = "raw_beans", count = 12 }
        })
    :requirement("canning_high_heat", 6)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "can_chicken_jarred_3l",
    result = "can_chicken",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component("poultry_raw_any", 24, true)
    :requirement("canning_high_heat", 6)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "soup_woods_jarred_3l",
    result = "soup_woods",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :requirement("woods_soup_ingredients", 6)
    :requirement("canning_high_heat", 6)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "soup_meat_jarred_3l",
    result = "soup_meat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :requirement("meat_soup_ingredients", 6)
    :requirement("canning_high_heat", 6)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "soup_veggy_jarred_3l",
    result = "soup_veggy",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :requirement("veggy_soup_ingredients", 12)
    :requirement("canning_high_heat", 6)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "soup_fish_jarred_3l",
    result = "soup_fish",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :requirement("fish_soup_ingredients", 6)
    :requirement("canning_high_heat", 6)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "broth_jarred_3l",
    result = "broth",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :component("water_clean", 10)
    :requirement("broth_ingredients", 12)
    :requirement("canning_high_heat", 6)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "broth_meat_jarred_3l",
    result = "broth_meat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :component("water_clean", 10)
    :requirement("broth_meat_ingredients", 12)
    :requirement("canning_high_heat", 6)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- this was using 120 bones (13.8kg), so it was lowered.  Bone broth uses 1:2-1:4 bone:water per weight.
-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "broth_bone_jarred_3l",
    result = "broth_bone",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 420000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :component("water_clean", 12)
    :component("bone_edible", 12, true)
    :requirement("canning_high_heat", 6)
    :book("cookbook_eatyrway", 5)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
    :byproduct("gelatin_fresh", 12)
)

-- 6192g of milk is dehydrated halfway before canning giving 310u of dehydrating
-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "con_milk_jarred_3l",
    result = "con_milk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :tool_charges("dehydrating_heat", 310, true)
    :component("jar_3l_glass_sealed", 1)
    :component("milk_standard_raw_fresh", 24, true)
    :component("sugar_standard", 36, true)
    :requirement("canning_high_heat", 6)
    :book("cookbook_italian", 3)
    :book("family_cookbook", 3)
    :book("dairy_book", 2)
    :book("mag_cooking", 3)
    :book("manual_canning", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(120)
    :byproduct("water_clean", 12)
)

-- 1032g of milk is dehydrated halfway before canning giving 52u of dehydrating
-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "con_milk_jarred",
    result = "con_milk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :tool_charges("dehydrating_heat", 26, true)
    :component("jar_glass_sealed", 1)
    :component("milk_standard_raw_fresh", 4, true)
    :component("sugar_standard", 6, true)
    :requirement("canning_high_heat", 1)
    :book("cookbook_italian", 3)
    :book("family_cookbook", 3)
    :book("dairy_book", 2)
    :book("mag_cooking", 3)
    :book("manual_canning", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(20)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "canned_liver_jarred",
    result = "canned_liver",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "liver", count = 10 },
            { id = "human_liver", count = 10 },
            { id = "demihuman_liver", count = 10 }
        })
    :requirement("canning_high_heat", 1)
    :book("cookbook", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(10)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "canned_liver_jarred_3l",
    result = "canned_liver",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component_any({
            { id = "liver", count = 60 },
            { id = "human_liver", count = 60 },
            { id = "demihuman_liver", count = 60 }
        })
    :requirement("canning_high_heat", 6)
    :book("cookbook", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(60)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "canned_heart_jarred",
    result = "canned_heart",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "heart", count = 10 },
            { id = "human_heart", count = 10 },
            { id = "demihuman_heart", count = 10 }
        })
    :requirement("canning_high_heat", 1)
    :book("cookbook", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(10)
    :byproduct("water_clean", 2)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "canned_heart_jarred_3l",
    result = "canned_heart",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component_any({
            { id = "heart", count = 60 },
            { id = "human_heart", count = 60 },
            { id = "demihuman_heart", count = 60 }
        })
    :requirement("canning_high_heat", 6)
    :book("cookbook", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(60)
    :byproduct("water_clean", 12)
)

-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat. Minor acid addition for
-- safety of an aqueous solution.
content.add(content.Recipe {
    id = "V8_jarred",
    result = "V8",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :component("water_clean", 6)
    :component("any_tomato", 4, true)
    :component("broccoli", 4)
    :component("any_zucchini", 4, true)
    :component("canning_acid_large", 1, true)
    :requirement("canning_high_heat", 6)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- https://www.clemson.edu/extension/food/canning/canning-tips/32acidifying-pressure-canned-tomatoes.html
-- Tomatoes are borderline and should be pressure canned and acidified for maximum safety.
-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "sauce_red_jarred_3l",
    result = "sauce_red",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :component("water_clean", 12)
    :component("any_tomato", 24, true)
    :component("canning_acid_large", 1, true)
    :requirement("canning_low_heat", 6)
    :book("cookbook_italian", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(48)
    :byproduct("water_clean", 12)
)

-- https://www.clemson.edu/extension/food/canning/canning-tips/32acidifying-pressure-canned-tomatoes.html
-- Tomatoes are borderline and should be pressure canned and acidified for maximum safety.
-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "sauce_red_jarred",
    result = "sauce_red",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :component("any_tomato", 4, true)
    :component("water_clean", 2)
    :component("canning_acid_small", 1, true)
    :requirement("canning_low_heat", 1)
    :book("cookbook_italian", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(8)
    :byproduct("water_clean", 2)
)

-- https://www.clemson.edu/extension/food/canning/canning-tips/32acidifying-pressure-canned-tomatoes.html
-- Tomatoes are borderline and should be pressure canned and acidified for maximum safety.
-- pressure canning is measured in 0.5 liter quantities, so 1u of canning_high_heat.
content.add(content.Recipe {
    id = "can_tomato_jarred",
    result = "can_tomato",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "tomato", count = 4 },
            { id = "tomato_cut", count = 4 }
        })
    :component("canning_acid_small", 1, true)
    :requirement("canning_low_heat", 1)
    :book("cookbook_italian", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(4)
    :byproduct("water_clean", 2)
)

-- https://www.clemson.edu/extension/food/canning/canning-tips/32acidifying-pressure-canned-tomatoes.html
-- Tomatoes are borderline and should be pressure canned and acidified for maximum safety.
-- pressure canning is measured in 0.5 liter quantities, so 6u of canning_high_heat.
content.add(content.Recipe {
    id = "can_tomato_jarred_3l",
    result = "can_tomato",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component_any({
            { id = "tomato", count = 24 },
            { id = "tomato_cut", count = 24 }
        })
    :component("canning_acid_large", 1, true)
    :requirement("canning_low_heat", 6)
    :book("cookbook_italian", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(24)
    :byproduct("water_clean", 12)
)

-- --------------------Water bath canning recipes begin here--------------------
-- waterbath canning is measured in 0.5 liter quantities, so 1u of canning_low_heat. Due to pickling,
-- ordinarily pressure canned meat can be water bathed.
content.add(content.Recipe {
    id = "offal_pickled_jarred",
    result = "offal_pickled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 6,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component_any({
            { id = "salt", count = 10 },
            { id = "saline", count = 10 }
        })
    :component("jar_glass_sealed", 1)
    :component("meat_offal", 2, true)
    :component("vinegar", 16)
    :requirement("canning_low_heat", 1)
    :book("cookbook", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat. Due to pickling,
-- ordinarily pressure canned meat can be water bathed.
content.add(content.Recipe {
    id = "offal_pickled_jarred_3l",
    result = "offal_pickled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 300000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 6,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component_any({
            { id = "salt", count = 60 },
            { id = "saline", count = 60 }
        })
    :component("jar_3l_glass_sealed", 1)
    :component("meat_offal", 12, true)
    :component("vinegar", 96)
    :requirement("canning_low_heat", 6)
    :book("cookbook", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- Canned tomatoes aren't an option as they've already been preserved.
-- waterbath canning is measured in 0.5 liter quantities, so 1u of canning_low_heat. Due to pickling,
-- ordinarily pressure canned veggy can be water bathed.
content.add(content.Recipe {
    id = "veggy_pickled_jarred",
    result = "veggy_pickled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :component_any({
            { id = "salt", count = 10 },
            { id = "saline", count = 10 }
        })
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "veggy", count = 2 },
            { id = "veggy_wild", count = 2 },
            { id = "mushroom", count = 2 },
            { id = "tomato", count = 2 },
            { id = "tomato_cut", count = 2 },
            { id = "broccoli", count = 2 },
            { id = "zucchini_cut", count = 2 },
            { id = "zucchini", count = 2 },
            { id = "cucumber_cut", count = 2 },
            { id = "cucumber", count = 2 },
            { id = "gherkin_cut", count = 2 },
            { id = "gherkin", count = 2 },
            { id = "veggy_potatolike", count = 2, requirement = true },
            { id = "corn", count = 2 },
            { id = "onion", count = 2 },
            { id = "wild_garlic", count = 4 },
            { id = "garlic_clove", count = 12 },
            { id = "rehydrated_garlic", count = 12 },
            { id = "carrot", count = 4 }
        })
    :component("vinegar", 16)
    :requirement("canning_low_heat", 1)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- Canned tomatoes aren't an option as they've already been preserved.
-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat. Due to pickling,
-- ordinarily pressure canned veggy can be water bathed.
content.add(content.Recipe {
    id = "veggy_pickled_jarred_3l",
    result = "veggy_pickled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component_any({
            { id = "salt", count = 60 },
            { id = "saline", count = 60 }
        })
    :component("jar_3l_glass_sealed", 1)
    :component_any({
            { id = "veggy", count = 12 },
            { id = "veggy_wild", count = 12 },
            { id = "mushroom", count = 12 },
            { id = "tomato", count = 12 },
            { id = "tomato_cut", count = 12 },
            { id = "broccoli", count = 12 },
            { id = "zucchini_cut", count = 12 },
            { id = "zucchini", count = 12 },
            { id = "cucumber_cut", count = 12 },
            { id = "cucumber", count = 12 },
            { id = "gherkin_cut", count = 12 },
            { id = "gherkin", count = 12 },
            { id = "veggy_potatolike", count = 12, requirement = true },
            { id = "corn", count = 12 },
            { id = "onion", count = 12 },
            { id = "wild_garlic", count = 24 },
            { id = "garlic_clove", count = 72 },
            { id = "rehydrated_garlic", count = 72 },
            { id = "carrot", count = 24 }
        })
    :component("vinegar", 96)
    :requirement("canning_low_heat", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- waterbath canning is measured in 0.5 liter quantities, so 1u of canning_low_heat. Due to pickling,
-- ordinarily pressure canned veggy can be water bathed.
content.add(content.Recipe {
    id = "meat_pickled_jarred",
    result = "meat_pickled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 6,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component_any({
            { id = "salt", count = 10 },
            { id = "saline", count = 10 }
        })
    :component("jar_glass_sealed", 1)
    :component("meat_red_raw", 2, true)
    :component("vinegar", 16)
    :requirement("canning_low_heat", 1)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat. Due to pickling,
-- ordinarily pressure canned veggy can be water bathed.
content.add(content.Recipe {
    id = "meat_pickled_jarred_3l",
    result = "meat_pickled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 6,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component_any({
            { id = "salt", count = 60 },
            { id = "saline", count = 60 }
        })
    :component("jar_3l_glass_sealed", 1)
    :component("meat_red_raw", 12, true)
    :component("vinegar", 96)
    :requirement("canning_low_heat", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- waterbath canning is measured in 0.5 liter quantities, so 1u of canning_low_heat. Due to pickling,
-- ordinarily pressure canned veggy can be water bathed.
content.add(content.Recipe {
    id = "fish_pickled_jarred",
    result = "fish_pickled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 6,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component_any({
            { id = "salt", count = 10 },
            { id = "saline", count = 10 }
        })
    :component("jar_glass_sealed", 1)
    :component("fish", 2)
    :component("vinegar", 16)
    :requirement("canning_low_heat", 1)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat. Due to pickling,
-- ordinarily pressure canned veggy can be water bathed.
content.add(content.Recipe {
    id = "fish_pickled_jarred_3l",
    result = "fish_pickled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 6,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component_any({
            { id = "salt", count = 60 },
            { id = "saline", count = 60 }
        })
    :component("jar_3l_glass_sealed", 1)
    :component("fish", 12)
    :component("vinegar", 96)
    :requirement("canning_low_heat", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- Close but potentially not acidic enough by itself, so requires canning_acid
-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat.
content.add(content.Recipe {
    id = "kompot_jarred_3l",
    result = "kompot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :component("sweet_fruit_like", 6, true)
    :component("sugar", 30)
    :component("water_clean", 6)
    :component("canning_acid_large", 1, true)
    :requirement("canning_low_heat", 6)
    :book("manual_canning", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
)

-- Close but potentially not acidic enough by itself, so requires canning_acid
-- waterbath canning is measured in 0.5 liter quantities, so 1u of canning_low_heat.
content.add(content.Recipe {
    id = "jam_fruit_jarred",
    result = "jam_fruit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("sweet_fruit", 4, true)
    :component("sugar_standard", 4, true)
    :component("jar_glass_sealed", 1)
    :component("canning_acid_small", 1, true)
    :requirement("canning_low_heat", 1)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(32)
    :byproduct("water_clean", 12)
)

-- Close but potentially not acidic enough by itself, so requires canning_acid
-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat.
content.add(content.Recipe {
    id = "jam_fruit_jarred_3L",
    result = "jam_fruit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("sweet_fruit", 24, true)
    :component("sugar_standard", 24, true)
    :component("jar_3l_glass_sealed", 1)
    :component("canning_acid_large", 1, true)
    :requirement("canning_high_heat", 6)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(192)
    :byproduct("water_clean", 12)
)

-- Close but potentially not acidic enough by itself, so requires canning_acid
-- waterbath canning is measured in 0.5 liter quantities, so 1u of canning_low_heat.
content.add(content.Recipe {
    id = "kompot_jarred",
    result = "kompot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :component("water_clean", 2)
    :component("sweet_fruit_like", 1, true)
    :component("sugar", 5)
    :component("canning_acid_small", 1, true)
    :requirement("canning_low_heat", 1)
    :book("manual_canning", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
)

-- Acidic enough on their own that no canning_acid is needed
-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat.
content.add(content.Recipe {
    id = "cranberry_juice_jarred_3l",
    result = "cranberry_juice",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :component("cranberries", 36)
    :component("water_clean", 12)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :requirement("canning_low_heat", 6)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
    :byproduct("juice_pulp", 24)
)

-- Acidic enough on their own that no canning_acid is needed
-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat.
content.add(content.Recipe {
    id = "juice_jarred",
    result = "juice",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :component("sweet_fruit", 2, true)
    :component("water_clean", 2)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :requirement("canning_low_heat", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(4)
    :byproduct("water_clean", 2)
    :byproduct("juice_pulp", 2)
)

-- Acidic enough on their own that no canning_acid is needed
-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat.
content.add(content.Recipe {
    id = "juice_jarred_3l",
    result = "juice",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :component("sweet_fruit", 12, true)
    :component("water_clean", 12)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :requirement("canning_low_heat", 6)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(24)
    :byproduct("water_clean", 12)
    :byproduct("juice_pulp", 12)
)

-- Acidic enough on their own that no canning_acid is needed
-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat.
content.add(content.Recipe {
    id = "oj_fresh_jarred_3l",
    result = "oj_fresh",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :component("orange", 48)
    :component("water_clean", 6)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :requirement("canning_low_heat", 6)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
    :byproduct("juice_pulp", 192)
)

-- Acidic enough on their own that no canning_acid is needed
-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat.
content.add(content.Recipe {
    id = "cranberry_juice_jarred",
    result = "cranberry_juice",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :component("cranberries", 6)
    :component("water_clean", 1)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :requirement("canning_low_heat", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
    :byproduct("juice_pulp", 4)
)

-- Acidic enough on their own that no canning_acid is needed
-- waterbath canning is measured in 0.5 liter quantities, so 1u of canning_low_heat.
content.add(content.Recipe {
    id = "apple_cider_jarred",
    result = "apple_cider",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "apple", count = 4 },
            { id = "crabapple", count = 20 }
        })
    :component("water_clean", 1)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :requirement("canning_low_heat", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
    :byproduct("juice_pulp", 4)
)

-- Acidic enough on their own that no canning_acid is needed
-- waterbath canning is measured in 0.5 liter quantities, so 1u of canning_low_heat.
content.add(content.Recipe {
    id = "apple_cider_jarred_3l",
    result = "apple_cider",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("jar_3l_glass_sealed", 1)
    :component_any({
            { id = "apple", count = 24 },
            { id = "crabapple", count = 120 }
        })
    :component_any({
            { id = "water", count = 16 },
            { id = "water_clean", count = 16 }
        })
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :requirement("canning_low_heat", 6)
    :requires_skill("mechanics", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(12)
    :byproduct("water_clean", 12)
    :byproduct("juice_pulp", 24)
)

-- Acidic enough on their own that no canning_acid is needed
-- waterbath canning is measured in 0.5 liter quantities, so 1u of canning_low_heat.
content.add(content.Recipe {
    id = "apple_canned_jarred",
    result = "apple_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("water_clean", 1)
    :component("jar_glass_sealed", 1)
    :component("sweet_fruit", 4, true)
    :component("sugar_standard", 2, true)
    :requirement("canning_low_heat", 1)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(4)
    :byproduct("water_clean", 2)
)

-- Acidic enough on their own that no canning_acid is needed
-- waterbath canning is measured in 0.5 liter quantities, so 6u of canning_low_heat.
content.add(content.Recipe {
    id = "apple_canned_jarred_3l",
    result = "apple_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_3l_glass_sealed",
    name = content.text("%s in large jar"),
}
    :component("water_clean", 6)
    :component("jar_3l_glass_sealed", 1)
    :component("sweet_fruit", 24, true)
    :component("sugar_standard", 12, true)
    :requirement("canning_low_heat", 6)
    :book("cookbook", 4)
    :book("manual_canning", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(24)
    :byproduct("water_clean", 12)
)

-- Acidic enough on their own that no canning_acid is needed
-- waterbath canning is measured in 0.5 liter quantities, so 1u of canning_low_heat.
content.add(content.Recipe {
    id = "oj_fresh_jarred",
    result = "oj_fresh",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "jar_glass_sealed",
    name = content.text("%s in jar"),
}
    :component("jar_glass_sealed", 1)
    :component("orange", 8)
    :component("water_clean", 1)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("STRAIN", 2, 1)
    :requirement("canning_low_heat", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(80, 4)
    :result_charges(2)
    :byproduct("water_clean", 2)
    :byproduct("juice_pulp", 32)
)

-- --------------------Tin can recipes begin here--------------------
-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "offal_canned_canned",
    result = "offal_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    contained = true,
    name = content.text("%s (0.5L)"),
}
    :component("water_clean", 1)
    :component("meat_offal", 2, true)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 4)
    :book("atomic_survival", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- 300g of flesh * double heat = 40u + 1u for the can
-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "offal_canned_canned_small",
    result = "offal_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_food",
    name = content.text("%s (0.25L)"),
}
    :component("water_clean", 1)
    :component("meat_offal", 1, true)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 4)
    :book("atomic_survival", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "offal_canned_canned_big",
    result = "offal_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_food_big",
    name = content.text("%s (3L)"),
}
    :component("water_clean", 6)
    :component("meat_offal", 12, true)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 4)
    :book("atomic_survival", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "dogfood_canned",
    result = "dogfood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "meat_nofish", count = 1, requirement = true },
            { id = "fish", count = 1 },
            { id = "lobster", count = 1 }
        })
    :component("veggy_green", 1, true)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "dogfood_canned_big",
    result = "dogfood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "meat_nofish", count = 6, requirement = true },
            { id = "fish", count = 6 },
            { id = "lobster", count = 6 }
        })
    :component("veggy_green", 6, true)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(6)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "catfood_canned",
    result = "catfood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "meat_nofish", count = 2, requirement = true },
            { id = "fish", count = 2 },
            { id = "lobster", count = 2 }
        })
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "catfood_canned_medium",
    result = "catfood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_medium",
}
    :component("water_clean", 1)
    :component_any({
            { id = "meat_nofish", count = 4, requirement = true },
            { id = "fish", count = 4 },
            { id = "lobster", count = 4 }
        })
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "catfood_canned_big",
    result = "catfood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :tool_charges("surface_heat", 60, true)
    :component("water_clean", 1)
    :component_any({
            { id = "meat_nofish", count = 24, requirement = true },
            { id = "fish", count = 24 },
            { id = "lobster", count = 24 }
        })
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "soup_mushroom_canned",
    result = "soup_mushroom",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 2)
    :requirement("mushroom_soup_ingredients", 2)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "soup_mushroom_canned_small",
    result = "soup_mushroom",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food",
    name = content.text("%s in small can (0.25L)"),
}
    :component("water_clean", 1)
    :requirement("mushroom_soup_ingredients", 1)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(1)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "soup_mushroom_canned_big",
    result = "soup_mushroom",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :component("water_clean", 6)
    :requirement("mushroom_soup_ingredients", 12)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "meat_canned",
    result = "meat_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    contained = true,
    name = content.text("%s (0.25L)"),
}
    :component("water_clean", 1)
    :component("meat_red_raw", 1, true)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "meat_canned_canned_medium",
    result = "meat_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_medium",
    name = content.text("%s (0.5L)"),
}
    :component("water_clean", 1)
    :component("meat_red_raw", 2, true)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "meat_canned_canned_big",
    result = "meat_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_food_big",
    name = content.text("%s (3L)"),
}
    :component("water_clean", 1)
    :component("meat_red_raw", 12, true)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "fish_canned",
    result = "fish_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    contained = true,
    name = content.text("%s (0.25L)"),
}
    :component("water_clean", 1)
    :component("fish", 1)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "fish_canned_canned_medium",
    result = "fish_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_medium",
    name = content.text("%s (0.5L)"),
}
    :component("water_clean", 1)
    :component("fish", 2)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "fish_canned_canned_big",
    result = "fish_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_food_big",
    name = content.text("%s (3L)"),
}
    :component("water_clean", 6)
    :component("fish", 12)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "lobster_canned",
    result = "lobster_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    contained = true,
    name = content.text("%s (0.25L)"),
}
    :component("water_clean", 1)
    :component("lobster", 1)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "lobster_canned_canned_medium",
    result = "lobster_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_medium",
    name = content.text("%s (0.5L)"),
}
    :component("water_clean", 1)
    :component("lobster", 2)
    :requirement("canning_metal", 1)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "lobster_canned_canned_big",
    result = "lobster_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_food_big",
    name = content.text("%s (3L)"),
}
    :component("water_clean", 6)
    :component("lobster", 12)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "veggy_canned",
    result = "veggy_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s (0.25L)"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "mushroom", count = 2 },
            { id = "veggy_any_uncooked", count = 1, requirement = true }
        })
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "veggy_canned_canned_medium",
    result = "veggy_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_medium",
    name = content.text("%s (0.5L)"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "mushroom", count = 4 },
            { id = "veggy_any_uncooked", count = 2, requirement = true }
        })
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "veggy_canned_canned_big",
    result = "veggy_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s (3L)"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "mushroom", count = 24 },
            { id = "veggy_any_uncooked", count = 12, requirement = true }
        })
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "apple_canned",
    result = "apple_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s (0.25L)"),
}
    :component("water_clean", 1)
    :component("sweet_fruit", 2, true)
    :component("sugar_standard", 1, true)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "apple_canned_canned_medium",
    result = "apple_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_medium",
    name = content.text("%s (0.5L)"),
}
    :component("water_clean", 1)
    :component("sweet_fruit", 4, true)
    :component("sugar_standard", 2, true)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(4)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "apple_canned_canned_big",
    result = "apple_canned",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s (3L)"),
}
    :component("water_clean", 1)
    :component("sweet_fruit", 24, true)
    :component("sugar_standard", 12, true)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(24)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "can_tomato",
    result = "can_tomato",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s (0.5L)"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "tomato", count = 2 },
            { id = "tomato_cut", count = 2 }
        })
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "can_tomato_canned_medium",
    result = "can_tomato",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_medium",
    name = content.text("%s (0.5L)"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "tomato", count = 4 },
            { id = "tomato_cut", count = 4 }
        })
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(4)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "can_tomato_canned_big",
    result = "can_tomato",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s (3L)"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "tomato", count = 24 },
            { id = "tomato_cut", count = 24 }
        })
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(24)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "can_beans",
    result = "can_beans",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s (0.5L)"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "beans_cooked", count = 2 },
            { id = "dry_beans", count = 2 },
            { id = "raw_beans", count = 2 }
        })
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "can_beans_canned_big",
    result = "can_beans",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s (3L)"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "beans_cooked", count = 12 },
            { id = "dry_beans", count = 12 },
            { id = "raw_beans", count = 12 }
        })
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "can_chicken",
    result = "can_chicken",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_food",
    contained = true,
    name = content.text("%s (0.25L)"),
}
    :component("water_clean", 1)
    :component("poultry_raw_any", 2, true)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "can_chicken_canned_medium",
    result = "can_chicken",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_medium",
    name = content.text("%s (0.5L)"),
}
    :component("water_clean", 1)
    :component("poultry_raw_any", 4, true)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "can_chicken_canned_big",
    result = "can_chicken",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_food_big",
    name = content.text("%s (3L)"),
}
    :component("water_clean", 1)
    :component("poultry_raw_any", 24, true)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "soup_woods_canned",
    result = "soup_woods",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 1)
    :requirement("woods_soup_ingredients", 1)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "soup_woods_canned_big",
    result = "soup_woods",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :component("water_clean", 6)
    :requirement("woods_soup_ingredients", 6)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "soup_veggy_canned",
    result = "soup_veggy",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 1)
    :requirement("veggy_soup_ingredients", 2)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "soup_veggy_canned_big",
    result = "soup_veggy",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :component("water_clean", 6)
    :requirement("veggy_soup_ingredients", 12)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "soup_meat_canned",
    result = "soup_meat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 1)
    :requirement("meat_soup_ingredients", 1)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "soup_meat_canned_big",
    result = "soup_meat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :component("water_clean", 6)
    :requirement("meat_soup_ingredients", 6)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "soup_fish_canned",
    result = "soup_fish",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 1)
    :requirement("fish_soup_ingredients", 1)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "soup_fish_canned_big",
    result = "soup_fish",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :component("water_clean", 6)
    :requirement("fish_soup_ingredients", 6)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "sauce_red_canned",
    result = "sauce_red",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s in can"),
}
    :component("any_tomato", 4, true)
    :component("water_clean", 5)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(8)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "sauce_red_canned_small",
    result = "sauce_red",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 192000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food",
    name = content.text("%s in small can (0.25L)"),
}
    :component("any_tomato", 2, true)
    :component("water_clean", 3)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(4)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "sauce_red_canned_big",
    result = "sauce_red",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 480000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :component("any_tomato", 24, true)
    :component("water_clean", 30)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(48)
    :byproduct("water_clean", 6)
)

-- 1032g of milk is dehydrated halfway before canning giving 52u of dehydrating
-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "con_milk_canned",
    result = "con_milk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
    contained = true,
    name = content.text("%s in can"),
}
    :tool_charges("dehydrating_heat", 52, true)
    :component("milk_standard_raw_fresh", 4, true)
    :component("sugar_standard", 6, true)
    :component("water_clean", 1)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :requires_skill("mechanics", 1)
    :book("cookbook_italian", 3)
    :book("family_cookbook", 3)
    :book("dairy_book", 2)
    :book("mag_cooking", 3)
    :book("manual_canning", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(20)
    :byproduct("water_clean", 1)
)

-- 516g of milk is dehydrated halfway before canning giving 26u of dehydrating
-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "con_milk_canned_small",
    result = "con_milk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 216000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
    container = "can_food",
    name = content.text("%s in small can (0.25L)"),
}
    :tool_charges("dehydrating_heat", 26, true)
    :component("milk_standard_raw_fresh", 2, true)
    :component("sugar_standard", 3, true)
    :component("water_clean", 1)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :requires_skill("mechanics", 1)
    :book("cookbook_italian", 3)
    :book("family_cookbook", 3)
    :book("dairy_book", 2)
    :book("mag_cooking", 3)
    :book("manual_canning", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(10)
    :byproduct("water_clean", 1)
)

-- 6192g of milk is dehydrated halfway before canning giving 310u of dehydrating
-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "con_milk_canned_big",
    result = "con_milk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :tool_charges("dehydrating_heat", 310, true)
    :component("milk_standard_raw_fresh", 24, true)
    :component("sugar_standard", 36, true)
    :component("water_clean", 6)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :requires_skill("mechanics", 1)
    :book("cookbook_italian", 3)
    :book("family_cookbook", 3)
    :book("dairy_book", 2)
    :book("mag_cooking", 3)
    :book("manual_canning", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(120)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "broth_canned",
    result = "broth",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 3)
    :requirement("broth_ingredients", 2)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "broth_canned_small",
    result = "broth",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food",
    name = content.text("%s in small can (0.25L)"),
}
    :component("water_clean", 2)
    :requirement("broth_ingredients", 1)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(1)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "broth_canned_big",
    result = "broth",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :component("water_clean", 13)
    :requirement("broth_ingredients", 12)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "broth_meat_canned",
    result = "broth_meat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 3)
    :requirement("broth_meat_ingredients", 2)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "broth_meat_canned_small",
    result = "broth_meat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food",
    name = content.text("%s in small can (0.25L)"),
}
    :component("water_clean", 2)
    :requirement("broth_meat_ingredients", 1)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(1)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "broth_meat_canned_big",
    result = "broth_meat",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :component("water_clean", 13)
    :requirement("broth_meat_ingredients", 12)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "broth_bone_canned",
    result = "broth_bone",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    contained = true,
    name = content.text("%s in can"),
}
    :component("bone_edible", 2, true)
    :component("water_clean", 3)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("gelatin_fresh", 2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "broth_bone_canned_small",
    result = "broth_bone",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food",
    name = content.text("%s in small can (0.25L)"),
}
    :component("bone_edible", 2, true)
    :component("water_clean", 2)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(1)
    :byproduct("gelatin_fresh", 1)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "broth_bone_canned_big",
    result = "broth_bone",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    name = content.text("%s in large can"),
}
    :component("bone_edible", 12, true)
    :component("water_clean", 16)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("manual_sealing", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("gelatin_fresh", 12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "apple_cider_canned",
    result = "apple_cider",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_medium",
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "apple", count = 4 },
            { id = "crabapple", count = 20 }
        })
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("juice_pulp", 4)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "apple_cider_canned_small",
    result = "apple_cider",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food",
    contained = true,
    name = content.text("%s in small can"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "apple", count = 2 },
            { id = "crabapple", count = 10 }
        })
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(1)
    :byproduct("juice_pulp", 2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "apple_cider_canned_big",
    result = "apple_cider",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    contained = true,
    name = content.text("%s in large can"),
}
    :component("water_clean", 6)
    :component_any({
            { id = "apple", count = 24 },
            { id = "crabapple", count = 120 }
        })
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("juice_pulp", 24)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "oj_fresh_canned",
    result = "oj_fresh",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_medium",
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 1)
    :component("orange", 8)
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("juice_pulp", 32)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "oj_fresh_canned_small",
    result = "oj_fresh",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food",
    contained = true,
    name = content.text("%s in small can"),
}
    :component("water_clean", 1)
    :component("orange", 4)
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(1)
    :byproduct("juice_pulp", 16)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "oj_fresh_canned_big",
    result = "oj_fresh",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    contained = true,
    name = content.text("%s in large can"),
}
    :component("water_clean", 6)
    :component("orange", 48)
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("juice_pulp", 192)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "juice_canned",
    result = "juice",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_medium",
    contained = true,
    name = content.text("%s in can"),
}
    :component("sweet_fruit", 2, true)
    :component("water_clean", 3)
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(4)
    :byproduct("juice_pulp", 2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "juice_canned_small",
    result = "juice",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food",
    contained = true,
    name = content.text("%s in small can"),
}
    :component("sweet_fruit", 1, true)
    :component("water_clean", 2)
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("juice_pulp", 1)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "juice_canned_big",
    result = "juice",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    contained = true,
    name = content.text("%s in large can"),
}
    :component("sweet_fruit", 12, true)
    :component("water_clean", 13)
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(24)
    :byproduct("juice_pulp", 12)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "canned_liver",
    result = "canned_liver",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_food",
    contained = true,
    name = content.text("%s (0.25L)"),
}
    :tool_charges("surface_heat", 5, true)
    :component("water_clean", 1)
    :component_any({
            { id = "liver", count = 5 },
            { id = "human_liver", count = 5 },
            { id = "demihuman_liver", count = 5 }
        })
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("cookbook", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(5)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "canned_liver_canned_medium",
    result = "canned_liver",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_medium",
    contained = true,
    name = content.text("%s (0.5L)"),
}
    :component("water_clean", 1)
    :component_any({
            { id = "liver", count = 10 },
            { id = "human_liver", count = 10 },
            { id = "demihuman_liver", count = 10 }
        })
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("cookbook", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(10)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "canned_liver_canned_big",
    result = "canned_liver",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
    container = "can_food_big",
    contained = true,
    name = content.text("%s (3L)"),
}
    :component("water_clean", 6)
    :component_any({
            { id = "liver", count = 60 },
            { id = "human_liver", count = 60 },
            { id = "demihuman_liver", count = 60 }
        })
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("cookbook", 6)
    :book("manual_canning", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(60)
    :byproduct("water_clean", 6)
)

-- tincan canning is measured in 0.25 liter quantities, so 2u of canning_metal.
content.add(content.Recipe {
    id = "cranberry_juice_canned",
    result = "cranberry_juice",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 144000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_medium",
    contained = true,
    name = content.text("%s in can"),
}
    :component("water_clean", 1)
    :component("cranberries", 6)
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 2)
    :requirement("tincan_medium", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(2)
    :byproduct("juice_pulp", 4)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 1u of canning_metal.
content.add(content.Recipe {
    id = "cranberry_juice_canned_small",
    result = "cranberry_juice",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food",
    contained = true,
    name = content.text("%s in small can"),
}
    :component("water_clean", 1)
    :component("cranberries", 3)
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 1)
    :requirement("tincan_small", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(1)
    :byproduct("juice_pulp", 2)
    :byproduct("water_clean", 1)
)

-- tincan canning is measured in 0.25 liter quantities, so 12u of canning_metal.
content.add(content.Recipe {
    id = "cranberry_juice_canned_big",
    result = "cranberry_juice",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
    container = "can_food_big",
    contained = true,
    name = content.text("%s in large can"),
}
    :component("water_clean", 6)
    :component("cranberries", 36)
    :quality("STRAIN", 2, 1)
    :requirement("canning_metal", 12)
    :requirement("tincan_large", 1)
    :book("preserving_juice", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_preservation")
    :proficiency("prof_food_canning")
    :batch_discount(83, 5)
    :result_charges(12)
    :byproduct("juice_pulp", 24)
    :byproduct("water_clean", 6)
)
