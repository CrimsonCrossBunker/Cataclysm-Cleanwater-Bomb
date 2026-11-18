local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "caffeine",
    result = "caffeine",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 3600000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
}
    :tool_charges("surface_heat", 60, true)
    :component("feces_bird", 17)
    :component("formic_acid", 23)
    :component("ammonia_liquid", 1)
    :component("chem_sulphuric_acid", 2)
    :component("chem_methanol", 97)
    :component_any({
            { id = "water", count = 5 },
            { id = "water_clean", count = 5 }
        })
    :component_any({
            { id = "lye_powder", count = 2 },
            { id = "chem_potassium_hydroxide", count = 10 },
            { id = "lye", count = 1 },
            { id = "lye_potassium", count = 1 }
        })
    :component("chem_muriatic_acid", 1)
    :component("paper", 2)
    :quality("CHEM", 2, 1)
    :quality("SEPARATE", 1, 1)
    :quality("ANALYSIS", 1, 1)
    :quality("STRAIN", 2, 1)
    :book("adv_chemistry", 7)
    :book("recipe_labchem", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_pharmaceutical")
    :batch_discount(99, 2)
    :result_charges(1941)
)

content.add(content.Recipe {
    id = "chaw",
    result = "chaw",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 5, true)
    :component("tobacco", 20)
    :component_any({
            { id = "sugar_standard", count = 1, requirement = true },
            { id = "artificial_sweetener", count = 14 }
        })
    :component_any({
            { id = "sweet_juice", count = 1, requirement = true },
            { id = "sweet_water", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 2, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "pure_meth_from_phosporous_iodine",
    result = "pure_meth",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 2160000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
}
    :component("dayquil", 15)
    :component("iodine_crystal", 15)
    :component_any({
            { id = "red_phosphorous", count = 3 },
            { id = "red_phosphorous_small", count = 270 }
        })
    :component("chem_acetone", 1)
    :component("chem_methanol", 3)
    :component_any({
            { id = "lye_powder", count = 5 },
            { id = "chem_potassium_hydroxide", count = 25 },
            { id = "lye", count = 1 },
            { id = "lye_potassium", count = 1 }
        })
    :quality("CHEM", 3, 1)
    :quality("SEPARATE", 1, 1)
    :book("recipe_labchem", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_pharmaceutical")
    :batch_discount(30, 5)
    :result_charges(180)
)
