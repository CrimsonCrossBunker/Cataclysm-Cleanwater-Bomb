local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "bandages",
    result = "bandages",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
    result_multiplier = 3,
}
    :component_any({
            { id = "cotton_patchwork", count = 3 },
            { id = "medical_gauze", count = 1 }
        })
    :component_any({
            { id = "duct_tape", count = 20 },
            { id = "medical_tape", count = 5 }
        })
    :component_any({
            { id = "disinfectant", count = 5 },
            { id = "thyme_oil", count = 1 },
            { id = "chem_ethanol", count = 250 },
            { id = "denat_alcohol", count = 250 },
            { id = "methed_alcohol", count = 250 }
        })
)

content.add(content.Recipe {
    id = "bandages_makeshift_with_tool",
    result = "bandages_makeshift",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200,
    activity_level = NO_EXERCISE,
    autolearn = true,
    flags = { "BLIND_EASY" },
    result_multiplier = 3,
}
    :component_any({
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_cotton_patchwork", count = 1 }
        })
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "bandages_makeshift_bleached",
    result = "bandages_makeshift_bleached",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
    result_multiplier = 9,
}
    :component("bandages_makeshift", 9)
    :component("bleach", 125)
    :component_any({
            { id = "water_clean", count = 3 },
            { id = "water", count = 3 }
        })
    :batch_discount(95, 4)
)

-- 3 units of water + 114g of cotton, bandages will soak up some of the water but the rest should be returned
content.add(content.Recipe {
    id = "bandages_makeshift_boiled",
    result = "bandages_makeshift_boiled",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
    result_multiplier = 9,
}
    :tool_charges("water_boiling_heat", 4, true)
    :component("bandages_makeshift", 9)
    :component("water_clean", 3)
    :quality("BOIL", 1, 1)
    :batch_discount(95, 4)
    :byproduct("water", 2)
)

content.add(content.Recipe {
    id = "adhesive_bandages",
    result = "adhesive_bandages",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
    result_multiplier = 30,
}
    :component("medical_gauze", 1)
    :component_any({
            { id = "duct_tape", count = 8 },
            { id = "medical_tape", count = 10 }
        })
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "tourniquet_upper",
    result = "tourniquet_upper",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "hose", count = 1 },
            { id = "rope_any_short", count = 1, requirement = true },
            { id = "cordage_short", count = 1, requirement = true },
            { id = "towel", count = 1 },
            { id = "blanket", count = 1 },
            { id = "down_blanket", count = 1 },
            { id = "fur_blanket", count = 1 },
            { id = "electric_blanket", count = 1 },
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 },
            { id = "sheet", count = 1 },
            { id = "bandana", count = 1 },
            { id = "cable", count = 1 },
            { id = "tie_skinny", count = 1 }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "cu_pipe", count = 1 }
        })
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "disinfectant_makeshift",
    result = "disinfectant_makeshift",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
}
    :component_any({
            { id = "chem_ethanol", count = 250 },
            { id = "denat_alcohol", count = 250 },
            { id = "methed_alcohol", count = 250 }
        })
    :book("isherwood_herbal_remedies", 1)
    :proficiency("prof_intro_chemistry")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "wintergreen_oil",
    result = "wintergreen_oil",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "cooking_oil", count = 2 },
            { id = "edible_tallow", count = 2, requirement = true }
        })
    :component("wintergreen_leaves", 2)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :requires_skill("survival", 5)
    :book("isherwood_herbal_remedies", 3)
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "mugwort_oil",
    result = "mugwort_oil",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "cooking_oil", count = 2 },
            { id = "edible_tallow", count = 2, requirement = true }
        })
    :component("mugwort", 2)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :requires_skill("survival", 4)
    :book("isherwood_herbal_remedies", 3)
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "thyme_oil",
    result = "thyme_oil",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "cooking_oil", count = 2 },
            { id = "edible_tallow", count = 2, requirement = true }
        })
    :component("thyme", 2)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :requires_skill("survival", 4)
    :book("isherwood_herbal_remedies", 3)
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "cattail_jelly",
    result = "cattail_jelly",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "survival",
    difficulty = 1,
}
    :component("cattail_stalk", 4)
    :quality("CUT", 2, 1)
    :book("emergency_book", 1)
    :book("mag_survival", 1)
    :book("textbook_survival", 1)
    :book("survival_book", 1)
    :book("pocket_survival", 1)
    :book("isherwood_herbal_remedies", 1)
    :result_charges(7)
    :byproduct("plant_fibre", 1)
)

content.add(content.Recipe {
    id = "disinrag",
    result = "disinrag",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
    flags = { "BLIND_EASY" },
    result_multiplier = 2,
}
    :component("cotton_patchwork", 2)
    :component("disinfectant", 1)
)

content.add(content.Recipe {
    id = "disincotton_ball",
    result = "disincotton_ball",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
    flags = { "BLIND_EASY" },
    result_multiplier = 4,
}
    :component("cotton_ball", 4)
    :component("disinfectant", 1)
)

content.add(content.Recipe {
    id = "quikclot",
    result = "quikclot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 18, true)
    :component("meal_chitin_piece", 6)
    :component_any({
            { id = "lye_powder", count = 100 },
            { id = "lye", count = 3 }
        })
    :quality("CHEM", 1, 1)
    :requires_skill("firstaid", 1)
    :book("textbook_firstaid", 3)
    :book("adv_chemistry", 4)
    :book("emergency_book", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(6)
)

content.add(content.Recipe {
    id = "quikclot_from_alder",
    result = "quikclot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 18, true)
    :component("alder_bark", 6)
    :component("water_clean", 10)
    :quality("CHEM", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :requires_skill("firstaid", 1)
    :proficiency("prof_intro_chemistry")
    :result_charges(6)
)

content.add(content.Recipe {
    id = "makeshift_stethoscope",
    result = "makeshift_stethoscope",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "duct_tape", count = 30 },
            { id = "medical_tape", count = 30 }
        })
    :component_any({
            { id = "bottle_plastic_small", count = 2 },
            { id = "funnel", count = 2 },
            { id = "makeshift_funnel", count = 2 },
            { id = "birchbark_funnel", count = 2 },
            { id = "leather_funnel", count = 2 },
            { id = "metal_funnel", count = 2 }
        })
    :component("hose", 1)
    :component_any({
            { id = "any_condom", count = 1, requirement = true },
            { id = "balloon", count = 1 }
        })
    :quality("CUT", 2, 1)
    :book("mag_fabrication", 1)
    :book("manual_fabrication", 1)
    :book("textbook_fabrication", 1)
    :book("manual_first_aid", 1)
    :book("pocket_firstaid", 1)
)

-- This is just a container, a tube pushed into your mouth, and knowing how to get a good flow rate without
-- killing yourself or waking up in the middle of your chest surgery. Suitable only for inhalative
-- anesthetics. See https://github.com/CleverRaven/Cataclysm-DDA/pull/44899
content.add(content.Recipe {
    id = "anesthetic_kit",
    result = "anesthetic_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 15000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "firstaid",
    difficulty = 3,
}
    :component("jar_3l_glass_sealed", 1)
    :component_any({
            { id = "hose", count = 1 },
            { id = "makeshift_hose", count = 1 }
        })
    :component("cotton_patchwork", 2)
    :quality("SEW", 1, 1)
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_cotton_ball_by hand", kind = "collection" }
    byproducts:entry { item = "seed_cotton_boll", probability = 100, count = { 2, 2 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "cotton_ball_by hand",
    result = "cotton_ball",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 324000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    result_multiplier = 10,
}
    :component("cotton_boll", 1)
    :byproducts_from_group("recipe_byproducts_cotton_ball_by hand")
)

content.add(content.Recipe {
    id = "arm_xlsplint",
    result = "arm_xlsplint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 10 },
            { id = "medical_gauze", count = 4 }
        })
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 100 },
            { id = "medical_tape", count = 50 }
        })
    :component_any({
            { id = "stick", count = 2 },
            { id = "broom", count = 2 },
            { id = "2x4", count = 2 },
            { id = "pool_cue", count = 2 },
            { id = "mop", count = 2 }
        })
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "arm_splint",
    result = "arm_splint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 5 },
            { id = "medical_gauze", count = 2 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 50 },
            { id = "medical_tape", count = 25 }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 },
            { id = "mop", count = 1 }
        })
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "arm_xs_splint",
    result = "arm_xs_splint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "medical_gauze", count = 1 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 25 },
            { id = "medical_tape", count = 10 }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 }
        })
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "leg_splint",
    result = "leg_splint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 10 },
            { id = "medical_gauze", count = 4 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 100 },
            { id = "medical_tape", count = 50 }
        })
    :component_any({
            { id = "stick", count = 2 },
            { id = "broom", count = 2 },
            { id = "2x4", count = 2 },
            { id = "pool_cue", count = 2 },
            { id = "mop", count = 2 }
        })
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "leg_xlsplint",
    result = "leg_xlsplint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 10 },
            { id = "medical_gauze", count = 4 }
        })
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 100 },
            { id = "medical_tape", count = 50 }
        })
    :component_any({
            { id = "stick", count = 4 },
            { id = "broom", count = 4 },
            { id = "2x4", count = 4 },
            { id = "pool_cue", count = 4 },
            { id = "mop", count = 4 }
        })
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "leg_xs_splint",
    result = "leg_xs_splint",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "cotton_patchwork", count = 5 },
            { id = "medical_gauze", count = 2 }
        })
    :component_any({
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 100 },
            { id = "medical_tape", count = 50 }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 }
        })
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "makeshift_cane",
    result = "makeshift_cane",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "makeshift_crutches",
    result = "makeshift_crutches",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "cotton_patchwork", count = 10 },
            { id = "medical_gauze", count = 4 }
        })
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 100 },
            { id = "medical_tape", count = 50 }
        })
    :component_any({
            { id = "stick", count = 2 },
            { id = "broom", count = 2 },
            { id = "2x4", count = 2 },
            { id = "pool_cue", count = 2 }
        })
    :quality("SAW_W", 1, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "vitc_fragment_by hand",
    result = "vitc_fragment",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
    result_multiplier = 6,
}
    :component("vitc_tablet", 1)
    :quality("CUT_FINE", 2, 1)
)

-- Tearing a sheet by hand requires brute force.
content.add(content.Recipe {
    id = "bandages_makeshift",
    result = "bandages_makeshift",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    result_multiplier = 2,
    flags = { "BLIND_EASY" },
}:requires_stat("strength", 5)
    :component_any({
        { id = "sheet_cotton", count = 1 },
        { id = "sheet_cotton_patchwork", count = 1 },
    }))
