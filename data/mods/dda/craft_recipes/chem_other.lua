local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "glue_weak_from_bones",
    result = "glue_weak",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :tool_charges("surface_heat", 3, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component_any({
            { id = "bone_any", count = 10, requirement = true },
            { id = "skull_humanlike", count = 10, requirement = true },
            { id = "skull_medium", count = 10, requirement = true },
            { id = "skull_small", count = 40, requirement = true },
            { id = "skull_tiny", count = 80, requirement = true },
            { id = "skewer_bone", count = 500 },
            { id = "skull_rodent", count = 8000 }
        })
    :quality("COOK", 2, 1)
    :requires_skill("chemistry", 1)
    :book("recipe_arrows", 1)
    :book("textbook_survival", 1)
    :book("survival_book", 1)
    :batch_discount(70, 4)
    :result_charges(150)
)

content.add(content.Recipe {
    id = "glue_weak_as_rubber_cement",
    result = "glue_weak",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("ppe_gas", 1, true)
    :component_any({
            { id = "chem_acetone", count = 1 },
            { id = "chem_chloroform", count = 250 },
            { id = "ammonia_hydroxide", count = 1 },
            { id = "chem_toluene", count = 250 }
        })
    :component_any({
            { id = "chem_ethanol", count = 10 },
            { id = "denat_alcohol", count = 10 },
            { id = "methed_alcohol", count = 10 },
            { id = "chem_methanol", count = 10 }
        })
    :component_any({
            { id = "balloon", count = 3 },
            { id = "shredded_rubber", count = 20 },
            { id = "gloves_medical", count = 2 },
            { id = "latex", count = 2 },
            { id = "any_condom", count = 3, requirement = true }
        })
    :quality("CHEM", 1, 1)
    :quality("CUT", 1, 1)
    :book("textbook_fabrication", 3)
    :book("adv_chemistry", 3)
    :book("textbook_chemistry", 3)
    :book("textbook_tailor", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :result_charges(250)
)

content.add(content.Recipe {
    id = "rosin",
    result = "rosin",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component("pine_bough", 1)
    :quality("CHEM", 1, 1)
    :quality("DISTILL", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :batch_discount(70, 10)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "quill_ink_from_butternut",
    result = "quill_ink",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("filter_paper_quantitative", 1)
    :tool_charges("surface_heat", 30, true)
    :component("butternut_husk", 2)
    :component("water_clean", 3)
    :component("hard_liquor", 1, true)
    :quality("CHEM", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :batch_discount(70, 10)
)
