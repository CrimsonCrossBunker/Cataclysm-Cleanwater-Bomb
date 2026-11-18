local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
content.add(content.Recipe {
    id = "salt_water",
    result = "salt_water",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "water", count = 1 }
        })
    :component("salt", 10)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "soapy_water",
    result = "soapy_water",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "water", count = 1 }
        })
    :component_any({
            { id = "soap", count = 1 },
            { id = "soap_flakes", count = 15 },
            { id = "detergent", count = 1 },
            { id = "liquid_soap", count = 1 }
        })
    :result_charges(1)
)

-- Cold mixing a 1:1:1 recipe for detergent using 25 ml each of soap, borax, and washing soda, produces ~75ml
-- of detergent.
content.add(content.Recipe {
    id = "detergent",
    result = "detergent",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    flags = { "BLIND_HARD" },
}
    :component("soap_flakes", 2)
    :component("chem_borax", 10)
    :component("chem_washing_soda", 25)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "saline",
    result = "saline",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 2,
}
    :tool_charges("surface_heat", 3, true)
    :component("water_clean", 1)
    :component("salt", 10)
    :quality("BOIL", 1, 1)
    :requires_skill("chemistry", 2)
    :book("textbook_firstaid", 2)
    :book("pocket_firstaid", 2)
    :book("manual_first_aid", 2)
    :book("atomic_survival", 4)
    :book("textbook_chemistry", 5)
    :book("adv_chemistry", 4)
    :book("emergency_book", 3)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "tallow_tainted",
    result = "tallow_tainted",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("water_boiling_heat", 20, true)
    :component_any({
            { id = "fat_tainted", count = 4 },
            { id = "fat_tainted_human", count = 4 }
        })
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :batch_discount(75, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "handrolled_cig",
    result = "handrolled_cig",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :component("rolling_paper", 1)
    :component_any({
            { id = "tobacco", count = 1 },
            { id = "cig_butt", count = 5 },
            { id = "cigar_butt", count = 5 }
        })
)

content.add(content.Recipe {
    id = "tobacco",
    result = "tobacco",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_any({
            { id = "dehydrator", charges = 25 },
            { id = "char_smoker", charges = 25 }
        })
    :component("tobacco_raw", 1)
    :batch_discount(67, 5)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "joint",
    result = "joint",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :component("rolling_paper", 1)
    :component_any({
            { id = "weed", count = 1 },
            { id = "joint_roach", count = 5 }
        })
)

content.add(content.Recipe {
    id = "crack",
    result = "crack",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
}
    :tool_charges("surface_heat", 8, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("coke", 12)
    :component("chem_baking_soda", 20)
    :quality("BOIL", 2, 1)
    :learn_automatically("chemistry", 2)
    :book("textbook_chemistry", 1)
    :book("adv_chemistry", 1)
    :book("recipe_labchem", 1)
    :proficiency("prof_intro_chemistry")
    :result_charges(4)
)

content.add(content.Recipe {
    id = "poppy_sleep",
    result = "poppy_sleep",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :tool_charges("surface_heat", 2, true)
    :component("poppy_bud", 2)
    :quality("CHEM", 2, 1)
    :requires_skill("survival", 1)
    :book("textbook_chemistry", 2)
    :book("adv_chemistry", 2)
    :book("pocket_survival", 3)
    :book("atomic_survival", 2)
    :book("textbook_survival", 2)
    :book("survival_book", 3)
    :book("isherwood_herbal_remedies", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_pharmaceutical")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "bonemeal_tablet",
    result = "bonemeal_tablet",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 8, true)
    :component("meal_bone", 1)
    :component("water_clean", 1)
    :requires_skill("survival", 2)
    :book("pocket_survival", 3)
    :book("atomic_survival", 2)
    :book("textbook_survival", 2)
    :book("survival_book", 3)
    :book("isherwood_herbal_remedies", 1)
    :result_charges(40)
)

content.add(content.Recipe {
    id = "flavored_bonemeal_tablet",
    result = "flavored_bonemeal_tablet",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 8, true)
    :component("meal_bone", 1)
    :component_any({
            { id = "dry_fruit", count = 1 },
            { id = "sugar", count = 45 },
            { id = "artificial_sweetener", count = 45 }
        })
    :component("water_clean", 1)
    :requires_skill("survival", 2)
    :book("pocket_survival", 3)
    :book("atomic_survival", 2)
    :book("textbook_survival", 2)
    :book("survival_book", 3)
    :book("isherwood_herbal_remedies", 2)
    :result_charges(42)
)

content.add(content.Recipe {
    id = "tums",
    result = "tums",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 8, true)
    :component("chem_caco3", 30)
    :component("water_clean", 2)
    :component_any({
            { id = "chem_citric_acid", count = 3 },
            { id = "dry_fruit", count = 1 },
            { id = "sugar", count = 20 },
            { id = "artificial_sweetener", count = 20 }
        })
    :component_any({
            { id = "gelatin_powder", count = 1 },
            { id = "gelatin_fresh", count = 1 },
            { id = "honeydew", count = 2 },
            { id = "honey_bottled", count = 2 },
            { id = "syrup", count = 2 },
            { id = "syrup_simple", count = 2 },
            { id = "syrup_corn", count = 2 },
            { id = "wax", count = 1 }
        })
    :requires_skill("survival", 2)
    :book("pocket_survival", 3)
    :book("atomic_survival", 2)
    :book("textbook_survival", 2)
    :book("survival_book", 3)
    :book("isherwood_herbal_remedies", 1)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "poppy_pain",
    result = "poppy_pain",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :tool_charges("surface_heat", 2, true)
    :component("poppy_bud", 2)
    :quality("CHEM", 2, 1)
    :requires_skill("survival", 1)
    :book("textbook_chemistry", 2)
    :book("adv_chemistry", 2)
    :book("pocket_survival", 3)
    :book("atomic_survival", 2)
    :book("textbook_survival", 2)
    :book("survival_book", 3)
    :book("isherwood_herbal_remedies", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_pharmaceutical")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "fungicide_from_normal_chemicals",
    result = "fungicide",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
    flags = { "SECRET" },
    name = content.text("%s from normal chemicals"),
}
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "disinfectant", count = 20 },
            { id = "oxy_powder", count = 100 }
        })
    :component("bleach", 625)
    :quality("CHEM", 2, 1)
    :requires_skill("survival", 1)
    :book("textbook_chemistry", 2)
    :book("adv_chemistry", 2)
    :book("pocket_survival", 2)
    :book("atomic_survival", 2)
    :book("textbook_survival", 1)
    :book("survival_book", 3)
    :book("recipe_labchem", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :result_charges(400)
)

content.add(content.Recipe {
    id = "fungicide_from_triffids",
    result = "fungicide",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 7,
    name = content.text("%s from triffids"),
}
    :tool_charges("surface_heat", 10, true)
    :component("triffid_fungicide", 1)
    :component("charcoal", 5)
    :component("bleach", 125)
    :quality("CHEM", 3, 1)
    :requires_skill("survival", 6)
    :requires_skill("firstaid", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(90, 2)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "antifungal",
    result = "antifungal",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 20, true)
    :component("fungicide", 10)
    :component_any({
            { id = "ammonia_liquid", count = 2 },
            { id = "lye_powder", count = 200 }
        })
    :component("salt", 10)
    :quality("CHEM", 3, 1)
    :book("textbook_chemistry", 5)
    :book("adv_chemistry", 4)
    :book("pocket_survival", 5)
    :book("atomic_survival", 5)
    :book("textbook_survival", 5)
    :book("survival_book", 5)
    :book("recipe_labchem", 4)
    :book("isherwood_herbal_remedies", 3)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_pharmaceutical")
    :result_charges(5)
)

content.add(content.Recipe {
    id = "insecticide",
    result = "insecticide",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    result_multiplier = 8,
}
    :tool_charges("surface_heat", 50, true)
    :tool_charges("electrolysis_kit", 200)
    :tool("chem_sulphuric_acid", 1)
    :tool("chem_muriatic_acid", 1)
    :tool("chem_antimony_trichloride", 1)
    :tool("chem_ferric_chloride", 1)
    :tool("silver_small", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("chem_ethanol", 46)
    :component("salt_water", 4)
    :component("chem_benzene", 90)
    :quality("CHEM", 2, 1)
    :book("textbook_chemistry", 4)
    :book("adv_chemistry", 4)
    :book("recipe_labchem", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 1)
)

content.add(content.Recipe {
    id = "insecticide_nicotine",
    result = "insecticide",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("%s from nicotine"),
}
    :component_any({
            { id = "tobacco", count = 50 },
            { id = "cig", count = 50 },
            { id = "cig_butt", count = 500 },
            { id = "cigar", count = 10 },
            { id = "tobacco_raw", count = 50 },
            { id = "nicotine_liquid", count = 70 }
        })
    :component_any({
            { id = "lamp_oil", count = 1 },
            { id = "chem_sulphuric_acid", count = 1 }
        })
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "water", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :book("textbook_chemistry", 4)
    :book("adv_chemistry", 4)
    :book("recipe_labchem", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
)

-- Na2​B4​O7​⋅10H2​O+2HA→4HBO2​+2NaA+5H2​O Boric acid precipitates. 4 moles of boric acid is produced(and 2
-- moles of some salt mostly remains in solution) when reacted completely with a strong acid.
-- For the strong acids, they seem to be very pure as an item for some reason. sulfuric acid is 4.5 moles as
-- an item, compared to nitric at 6 moles! 4 moles of Sulfuric acid was used as a base rate.
-- Insecticide yield is purely based on ~80% yield boric acid precipitate. Trace salts have no effect on
-- insecticide performance and negligible(2%) effect on precipitate mass.
content.add(content.Recipe {
    id = "insecticide_boric",
    result = "insecticide",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    result_multiplier = 20,
    name = content.text("%s from boric acid"),
}
    :tool_charges("surface_heat", 10, true)
    :component("chem_borax", 500)
    :component("water_clean", 40)
    :quality("CHEM", 1, 1)
    :requirement("any_strong_acid", 1)
    :book("textbook_chemistry", 3)
    :book("adv_chemistry", 3)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
)

content.add(content.Recipe {
    id = "adrenaline_injector",
    result = "adrenaline_injector",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
}
    :tool_charges("surface_heat", 10, true)
    :component("syringe", 1)
    :component("chem_ethanol", 100)
    :component("conc_venom", 4)
    :component_any({
            { id = "salt_water", count = 1 },
            { id = "saline", count = 5 }
        })
    :quality("CHEM", 3, 1)
    :quality("ANALYSIS", 1, 1)
    :quality("SEPARATE", 1, 1)
    :requires_skill("firstaid", 6)
    :book("textbook_chemistry", 8)
    :book("textbook_toxicology", 7)
    :book("recipe_labchem", 8)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_pharmaceutical")
)

content.add(content.Recipe {
    id = "heroin",
    result = "heroin",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
}
    :tool_charges("surface_heat", 3, true)
    :component("acetic_anhydride", 2)
    :component("morphine", 3)
    :quality("CHEM", 1, 1)
    :book("textbook_chemistry", 7)
    :book("adv_chemistry", 7)
    :book("atomic_survival", 6)
    :book("recipe_labchem", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :proficiency("prof_pharmaceutical")
    :batch_discount(40, 6)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "oxycodone",
    result = "oxycodone",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("electrolysis_kit", 50)
    :tool_any({
            { id = "lye", count = 1 },
            { id = "lye_potassium", count = 1 }
        })
    :tool("platinum_grille", 1)
    :component("codeine", 10)
    :component("water_clean", 1)
    :quality("CHEM", 2, 1)
    :book("textbook_chemistry", 6)
    :book("adv_chemistry", 6)
    :book("atomic_survival", 5)
    :book("recipe_labchem", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :proficiency("prof_pharmaceutical")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "diazepam",
    result = "diazepam",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 4320000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 9,
}
    :tool_charges("surface_heat", 200, true)
    :tool_charges("electrolysis_kit", 500)
    :tool_charges("ketene_lamp", 50)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool("chem_ferric_chloride", 1)
    :component("chem_toluene", 105)
    :component("chem_benzene", 90)
    :component("water_clean", 1)
    :component("salt_water", 12)
    :component("chem_sodium", 33)
    :component("chem_nitric_acid", 1)
    :component("chem_muriatic_acid", 1)
    :component("chem_sulphuric_acid", 2)
    :component("chem_acetone", 1)
    :component("chem_methanol", 32)
    :component("lye_powder", 15)
    :component("chem_sulphur", 100)
    :component("scrap", 2)
    :component("chem_nickel_powder", 7)
    :component("chem_aluminium_powder", 16)
    :quality("CHEM", 2, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("ANALYSIS", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :requires_skill("firstaid", 5)
    :book("textbook_chemistry", 7)
    :book("adv_chemistry", 7)
    :book("atomic_survival", 6)
    :book("recipe_labchem", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :proficiency("prof_pharmaceutical")
    :batch_discount(80, 1)
    :result_charges(200)
)

content.add(content.Recipe {
    id = "pepto",
    result = "pepto",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
}
    :tool_charges("surface_heat", 20, true)
    :tool_charges("electrolysis_kit", 20)
    :component("aspirin", 18)
    :component("salt_water", 1)
    :component("water_clean", 1)
    :component("bismuth", 10)
    :component("lye_powder", 2)
    :quality("CHEM", 2, 1)
    :requires_skill("firstaid", 1)
    :book("emergency_book", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_pharmaceutical")
    :batch_discount(80, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "iodine",
    result = "iodine",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 25, true)
    :component("iodine_crystal", 2)
    :component("chem_potassium_hydroxide", 5)
    :component("formic_acid", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CHEM", 2, 1)
    :requires_skill("firstaid", 1)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :book("recipe_labchem", 4)
    :book("atomic_survival", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_pharmaceutical")
    :result_charges(9)
)

content.add(content.Recipe {
    id = "iodine_crystal",
    result = "iodine_crystal",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 25, true)
    :component_any({
            { id = "kombu", count = 150 },
            { id = "iodine", count = 450 }
        })
    :component("ether", 80)
    :component("chem_washing_soda", 30)
    :component("chem_muriatic_acid", 1)
    :component("chem_hydrogen_peroxide", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CHEM", 2, 1)
    :book("adv_chemistry", 3)
    :book("textbook_chemistry", 3)
    :book("recipe_labchem", 3)
    :book("atomic_survival", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_pharmaceutical")
    :result_charges(100)
)

content.add(content.Recipe {
    id = "prussian_blue",
    result = "prussian_blue",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 216000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_muriatic_acid", 1)
    :component("scrap", 6)
    :component("chem_hydrogen_peroxide", 10)
    :component_any({
            { id = "any_blood", count = 2, requirement = true },
            { id = "scrap_leather", count = 500 },
            { id = "leather", count = 5 }
        })
    :component("paper", 5)
    :quality("CHEM", 2, 1)
    :quality("BOIL", 2, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("firstaid", 1)
    :book("adv_chemistry", 5)
    :book("textbook_chemistry", 6)
    :book("recipe_labchem", 5)
    :book("atomic_survival", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_pharmaceutical")
    :batch_discount(80, 2)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "aspirin",
    result = "aspirin",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :tool_charges("surface_heat", 25, true)
    :component("water_clean", 1)
    :component("acetic_anhydride", 1)
    :component("willowbark", 10)
    :quality("CHEM", 2, 1)
    :requires_skill("firstaid", 1)
    :book("adv_chemistry", 2)
    :book("textbook_chemistry", 2)
    :book("recipe_labchem", 2)
    :book("atomic_survival", 3)
    :book("isherwood_herbal_remedies", 2)
    :book("basic_chemistry", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_pharmaceutical")
    :result_charges(20)
)

content.add(content.Recipe {
    id = "pur_tablets",
    result = "pur_tablets",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 25, true)
    :component("iodine", 10)
    :component("aspirin", 10)
    :component_any({
            { id = "bleach", count = 125 },
            { id = "oxy_powder", count = 50 }
        })
    :quality("CHEM", 2, 1)
    :book("adv_chemistry", 5)
    :book("textbook_chemistry", 5)
    :book("recipe_labchem", 4)
    :book("atomic_survival", 4)
    :book("textbook_survival", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
)

-- another variation of chloralkali process, now used to produce bleach (sodium hypochlorite - or rather
-- rough, technical grade hypochlorite/hydroxide/chloride mix), note we will not be heating anything and that
-- the (mostly) electrochemical reaction easily scales in size, some hydrogen gas could be recoverable
-- (optional byproduct)
content.add(content.Recipe {
    id = "bleach",
    result = "bleach",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("electrolysis_kit", 250)
    :component_any({
            { id = "salt_water", count = 2 },
            { id = "saline", count = 10 }
        })
    :quality("CHEM", 2, 1)
    :requires_skill("electronics", 2)
    :book("adv_chemistry", 3)
    :book("textbook_chemistry", 3)
    :book("recipe_labchem", 3)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(90, 4)
    :result_charges(250)
)

-- abstracting using chloralkali process (hot solution, unpartitioned cell) to produce sodium chlorate, then
-- perchlorate by anodic oxidation on platinum, then ammonia perchlorate by double decomposition from sodium
-- perchlorate and ammonium chloride; while we can't directly use bleach here but we do end up recovering
-- some brine
content.add(content.Recipe {
    id = "oxy_powder",
    result = "oxy_powder",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("electrolysis_kit", 750)
    :tool_charges("surface_heat", 25, true)
    :tool("platinum_small", 1)
    :component_any({
            { id = "salt_water", count = 4 },
            { id = "saline", count = 20 }
        })
    :component("ammonia_liquid", 1)
    :component("chem_muriatic_acid", 1)
    :quality("CHEM", 2, 1)
    :quality("BOIL", 1, 1)
    :requires_skill("electronics", 2)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :book("recipe_labchem", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(60, 4)
    :result_charges(200)
    :byproduct("salt_water", 2)
)

content.add(content.Recipe {
    id = "lye_powder_from_lye",
    result = "lye_powder",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
    name = content.text("%s from lye"),
}
    :tool_charges("water_boiling_heat", 120, true)
    :component("lye", 6)
    :quality("BOIL", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 4)
    :result_charges(200)
)

-- reversal of the recipe above
content.add(content.Recipe {
    id = "lye_from_lye_powder",
    result = "lye",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
    name = content.text("%s from lye powder"),
}
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component("lye_powder", 100)
    :batch_discount(90, 4)
    :result_charges(3)
)

-- One battery charge is one kJ, one unit of surface_heat is 25 charges, 1129 lye powder is 30 grams, 25 kJ
-- is needed to melt 30 grams of lye.
-- kerosene is used here because sodium metal needs to be suspended in a mineral oil to prevent it from
-- reacting to air. It's half of the resulting sodium because the item itself is 50/50.
content.add(content.Recipe {
    id = "chem_sodium",
    result = "chem_sodium",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("electrolysis_kit", 1500)
    :tool_charges("surface_heat", 1, true)
    :tool("syringe", 1)
    :component("lye_powder", 1129)
    :component("lamp_oil", 350)
    :quality("CHEM", 2, 1)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(60, 4)
    :result_charges(700)
)

-- kerosene is used here because potassium metal needs to be suspended in a mineral oil to prevent it from
-- reacting with air.
content.add(content.Recipe {
    id = "chem_potassium",
    result = "chem_potassium",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("electrolysis_kit", 1500)
    :tool_charges("surface_heat", 1, true)
    :tool("syringe", 1)
    :component("chem_potassium_hydroxide", 800)
    :component("lamp_oil", 200)
    :quality("CHEM", 2, 1)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(60, 4)
    :result_charges(350)
)

content.add(content.Recipe {
    id = "heatpack",
    result = "heatpack",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 2, true)
    :component_any({
            { id = "bag_plastic", count = 1 },
            { id = "bag_plastic_small", count = 1 },
            { id = "heatpack_used", count = 1 }
        })
    :component("oxy_powder", 5)
    :component("scrap", 1)
    :quality("CHEM", 2, 1)
    :requirement("sewing_standard", 1)
    :book("adv_chemistry", 3)
    :book("textbook_chemistry", 3)
    :book("atomic_survival", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
)

content.add(content.Recipe {
    id = "fermentable_liquid_mixture",
    result = "fermentable_liquid_mixture",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "BLIND_EASY", "ALLOW_ROTTEN" },
}
    :tool("fake_digester_tank", 1)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :requirement("organic_waste", 1)
    :batch_discount(90, 4)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "fermentable_liquid_mixture_hard",
    result = "fermentable_liquid_mixture",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "BLIND_HARD", "ALLOW_ROTTEN" },
}
    :tool("fake_digester_tank", 1)
    :component("ruined_chunks", 20)
    :component_any({
            { id = "water", count = 5 },
            { id = "water_clean", count = 5 }
        })
    :proficiency("prof_intro_chemistry")
    :batch_discount(70, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "fermentable_fish_mixture_active",
    result = "fermentable_fish_mixture_active",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "BLIND_EASY", "ALLOW_ROTTEN" },
}
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component_any({
            { id = "fish", count = 5 },
            { id = "lobster", count = 5 },
            { id = "fish_scrap", count = 75 }
        })
    :requirement("sugar_standard", 1)
    :batch_discount(90, 4)
    :result_charges(3)
)

-- Simply heating fermented fertilizer liquid.
content.add(content.Recipe {
    id = "fertilizer_liquid_simple",
    result = "fertilizer_liquid",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
    flags = { "BLIND_HARD", "ALLOW_ROTTEN" },
    name = content.text("simple %s"),
}
    :tool_charges("surface_heat", 10, true)
    :component("fermented_fertilizer_liquid", 1)
    :quality("CONTAIN", 1, 1)
    :quality("BOIL", 1, 1)
    :proficiency("prof_intro_chemistry")
    :batch_discount(80, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "fertilizer_commercial_simple",
    result = "fertilizer_commercial",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    flags = { "BLIND_EASY" },
    name = content.text("simple %s"),
}
    :component("chem_ammonium_nitrate_pellets", 27)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "fertilizer_liquid",
    result = "fertilizer_liquid",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
    flags = { "ALLOW_ROTTEN" },
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :component_any({
            { id = "meal_bone", count = 2 },
            { id = "meal_bone_tainted", count = 4 }
        })
    :component("meal_chitin_piece", 1)
    :component_any({
            { id = "ammonia_liquid", count = 1 },
            { id = "lye_powder", count = 100 },
            { id = "chem_saltpetre", count = 50 }
        })
    :quality("CHEM", 2, 1)
    :requires_skill("survival", 2)
    :book("adv_chemistry", 2)
    :book("textbook_chemistry", 2)
    :book("recipe_labchem", 3)
    :book("atomic_survival", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(4)
)

content.add(content.Recipe {
    id = "flask_yeast_active",
    result = "flask_yeast_active",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 7, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("jar_glass_sealed", 1)
    :component("yeast", 1)
    :component_any({
            { id = "sugar", count = 10 },
            { id = "honey_bottled", count = 1 }
        })
)

content.add(content.Recipe {
    id = "soap",
    result = "soap",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :tool_charges("surface_heat", 18, true)
    :component_any({
            { id = "edible_tallow", count = 10, requirement = true },
            { id = "cooking_oil", count = 14 },
            { id = "edible_tallow", count = 7, requirement = true }
        })
    :component_any({
            { id = "lye", count = 1 },
            { id = "lye_powder", count = 11 }
        })
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 },
            { id = "salt_water", count = 2 }
        })
    :quality("CHEM", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(10)
    :byproduct("chem_glycerol", 1)
)

content.add(content.Recipe {
    id = "soap_from_potassium_hydroxide",
    result = "soap",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
    name = content.text("%s from potassium hydroxide"),
}
    :tool_charges("surface_heat", 18, true)
    :component_any({
            { id = "edible_tallow", count = 10, requirement = true },
            { id = "cooking_oil", count = 14 },
            { id = "edible_tallow", count = 7, requirement = true }
        })
    :component_any({
            { id = "lye_potassium", count = 1 },
            { id = "chem_potassium_hydroxide", count = 55 }
        })
    :component("salt_water", 2)
    :quality("CHEM", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(10)
    :byproduct("chem_glycerol", 1)
)

content.add(content.Recipe {
    id = "liquid_soap",
    result = "liquid_soap",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
    flags = { "ALLOW_ROTTEN" },
}
    :tool_charges("surface_heat", 18, true)
    :component_any({
            { id = "edible_tallow", count = 10, requirement = true },
            { id = "cooking_oil", count = 14 },
            { id = "edible_tallow", count = 7, requirement = true }
        })
    :component_any({
            { id = "lye_potassium", count = 1 },
            { id = "chem_potassium_hydroxide", count = 55 }
        })
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("CHEM", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(10)
    :byproduct("chem_glycerol", 1)
)

-- Too simple to learn any chemistry.
content.add(content.Recipe {
    id = "soap_flakes",
    result = "soap_flakes",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
}
    :component("soap", 1)
    :quality("CUT", 1, 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "poppysyrup",
    result = "poppysyrup",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 2, true)
    :component("poppy_bud", 2)
    :quality("CHEM", 1, 1)
    :requires_skill("survival", 1)
    :book("textbook_chemistry", 2)
    :book("adv_chemistry", 2)
    :book("pocket_survival", 3)
    :book("atomic_survival", 2)
    :book("textbook_survival", 2)
    :book("survival_book", 3)
    :book("isherwood_herbal_remedies", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_pharmaceutical")
    :result_charges(5)
)

content.add(content.Recipe {
    id = "skunk_spray_neutralizing_solution",
    result = "skunk_spray_neutralizing_solution",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 1,
}
    :component("chem_hydrogen_peroxide", 4)
    :component_any({
            { id = "chem_baking_soda", count = 83 },
            { id = "liquid_soap", count = 2 }
        })
    :quality("CHEM", 1, 1)
    :requires_skill("survival", 1)
    :book("pocket_survival", 3)
    :book("survival_book", 3)
    :book("isherwood_herbal_remedies", 2)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "chem_hydrogen_peroxide_conc",
    result = "chem_hydrogen_peroxide_conc",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_hydrogen_peroxide", 50)
    :quality("BOIL", 2, 1)
    :book("recipe_labchem", 4)
    :book("textbook_chemistry", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
)

-- A reverse recipe. Not adding chemical proficiencies.
content.add(content.Recipe {
    id = "chem_hydrogen_peroxide",
    result = "chem_hydrogen_peroxide",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 10, true)
    :component("chem_hydrogen_peroxide_conc", 1)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :quality("BOIL", 2, 1)
    :quality("CHEM", 1, 1)
    :requires_skill("firstaid", 3)
    :book("recipe_labchem", 3)
    :book("textbook_chemistry", 3)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "chem_muriatic_acid",
    result = "chem_muriatic_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("%s from sulphuric acid"),
}
    :tool_charges("surface_heat", 10, true)
    :component("salt", 210)
    :component("chem_sulphuric_acid", 1)
    :component("water_clean", 1)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :book("recipe_labchem", 3)
    :book("textbook_chemistry", 3)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :result_charges(1)
)

-- abstracted chloralkali process, followed by 'burning' resulting chlorine and hydrogen with electric arc as
-- uv source and crucible serving as reaction furnace, then dissolving resulting hydrogen chloride gas in
-- water
content.add(content.Recipe {
    id = "chem_muriatic_acid_by_electrolysis",
    result = "chem_muriatic_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    name = content.text("%s by electrolysis"),
}
    :tool_charges("electrolysis_kit", 500)
    :tool_any({
            { id = "welder", charges = 100 },
            { id = "welding_kit", charges = 100 },
            { id = "welder_crude", charges = 150 }
        })
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("salt_water", 4)
    :component("water_clean", 1)
    :quality("CHEM", 2, 1)
    :requires_skill("electronics", 2)
    :requires_skill("mechanics", 2)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(50, 5)
    :byproduct("lye", 2)
)

content.add(content.Recipe {
    id = "chem_sulphuric_acid",
    result = "chem_sulphuric_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    name = content.text("%s with hydrogen peroxide"),
}
    :tool_charges("surface_heat", 10, true)
    :component("chem_hydrogen_peroxide_conc", 1)
    :component("chem_sulphur", 375)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :result_charges(1)
)

-- burning sulfur with platinum catalyst to create SO3, dissolving in water to create H2SO4
content.add(content.Recipe {
    id = "chem_sulphuric_acid_with platinum",
    result = "chem_sulphuric_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
    name = content.text("%s with platinum"),
}
    :tool_charges("surface_heat", 10, true)
    :tool("platinum_small", 1)
    :component("water_clean", 1)
    :component("chem_sulphur", 375)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
)

content.add(content.Recipe {
    id = "chem_nitric_acid_from_sulphuric",
    result = "chem_nitric_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("%s from sulphuric acid"),
}
    :tool_charges("surface_heat", 50, true)
    :component("chem_sulphuric_acid", 1)
    :component("chem_saltpetre", 25)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
)

content.add(content.Recipe {
    id = "chem_nitric_acid_from ammonia",
    result = "chem_nitric_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    name = content.text("%s from ammonia"),
}
    :tool_charges("surface_heat", 25, true)
    :tool("pressure_cooker", 1)
    :tool("platinum_grille", 1)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component("ammonia_liquid", 1)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :quality("DISTILL", 1, 1)
    :book("adv_chemistry", 5)
    :book("textbook_chemistry", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "chem_nitric_acid_from_muriatic",
    result = "chem_nitric_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("%s from muriatic acid"),
}
    :tool_charges("surface_heat", 50, true)
    :component("chem_muriatic_acid", 1)
    :component("chem_saltpetre", 25)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :byproduct("chem_potassium_chloride", 1)
)

content.add(content.Recipe {
    id = "chem_aluminium_sulphate",
    result = "chem_aluminium_sulphate",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 15000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_sulphuric_acid", 1)
    :component("chem_hydrogen_peroxide", 10)
    :component("chem_aluminium_powder", 25)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :result_charges(50)
)

content.add(content.Recipe {
    id = "chem_ammonium_nitrate",
    result = "chem_ammonium_nitrate",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_nitric_acid", 5)
    :component("ammonia_liquid", 5)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :result_charges(500)
    :byproduct("water", 1)
)

content.add(content.Recipe {
    id = "chem_ammonium_nitrate_from_pellets",
    result = "chem_ammonium_nitrate",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    name = content.text("%s from pellets"),
}
    :component("chem_ammonium_nitrate_pellets", 100)
    :quality("FINE_GRIND", 1, 1)
    :quality("SIEVE", 1, 1)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "chem_ammonium_nitrate_pellets",
    result = "chem_ammonium_nitrate_pellets",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :component("fertilizer_commercial", 1)
    :result_charges(27)
)

content.add(content.Recipe {
    id = "chem_potassium_hydroxide",
    result = "chem_potassium_hydroxide",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("electrolysis_kit", 100)
    :tool("platinum_small", 1)
    :tool("silver_small", 1)
    :tool("salt", 1)
    :component("water_clean", 3)
    :component("chem_potassium_chloride", 25)
    :quality("CHEM", 2, 1)
    :book("textbook_chemistry", 4)
    :book("adv_chemistry", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :result_charges(680)
    :byproduct("water", 1)
)

content.add(content.Recipe {
    id = "chem_potassium_hydroxide_from_lye",
    result = "chem_potassium_hydroxide",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
    name = content.text("%s from lye"),
}
    :tool_charges("water_boiling_heat", 120, true)
    :component("lye_potassium", 6)
    :quality("BOIL", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 4)
    :result_charges(100)
)

-- A reverse recipe. Not adding chemical proficiencies,
content.add(content.Recipe {
    id = "lye_potassium_from_lye_powder",
    result = "lye_potassium",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
    name = content.text("%s from lye powder"),
}
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component("chem_potassium_hydroxide", 125)
    :batch_discount(90, 4)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "chem_saltpetre",
    result = "chem_saltpetre",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("%s from ammonium nitrate"),
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_ammonium_nitrate", 225)
    :component("lye_powder", 150)
    :component_any({
            { id = "water_clean", count = 3 },
            { id = "water", count = 3 }
        })
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :book("textbook_anarch", 7)
    :book("recipe_labchem", 4)
    :book("textbook_chemistry", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :result_charges(50)
    :byproduct("ammonia_liquid", 1)
)

content.add(content.Recipe {
    id = "chem_saltpetre_niter",
    result = "chem_saltpetre",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
    result_multiplier = 5,
    name = content.text("%s from niter"),
}
    :tool_charges("surface_heat", 25, true)
    :component("material_niter", 1)
    :component_any({
            { id = "water_clean", count = 3 },
            { id = "water", count = 3 }
        })
    :quality("BOIL", 2, 1)
    :quality("CONTAIN", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 4)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "red_phosphorous_with_white_phosphorous",
    result = "red_phosphorous",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
    name = content.text("%s from white phosphorous"),
}
    :tool_charges("vac_oven_small", 1000)
    :component("white_phosphorous", 4)
    :book("textbook_gaswarfare", 2)
    :book("textbook_chemistry", 3)
    :book("adv_chemistry", 3)
    :book("textbook_anarch", 3)
    :batch_discount(95, 1)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "red_phosphorous",
    result = "red_phosphorous",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "chemistry",
}
    :component("red_phosphorous_small", 100)
    :result_charges(1)
)

-- calculation based on https://www.youtube.com/watch?v=5ZrfNAHDjWU; 1 matchbox contains 30 mg phosphorus and
-- 1 unit of phosphor is 100 mg
content.add(content.Recipe {
    id = "red_phosphorous_small",
    result = "red_phosphorous_small",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "survival_match", count = 1 },
            { id = "ref_matches", count = 3 },
            { id = "matches", count = 5 }
        })
    :quality("FINE_GRIND", 1, 1)
    :quality("CUT", 1, 1)
    :quality("SIEVE", 1, 1)
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "white_phosphorous_with_red_phosphorous",
    result = "white_phosphorous",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
    name = content.text("%s from red phosphorous"),
}
    :tool_charges("vac_oven_small", 100)
    :component("red_phosphorous", 3)
    :book("textbook_gaswarfare", 2)
    :book("textbook_chemistry", 3)
    :book("adv_chemistry", 3)
    :book("textbook_anarch", 3)
    :batch_discount(95, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "chem_anfo",
    result = "chem_anfo",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
}
    :component_any({
            { id = "chem_ammonium_nitrate", count = 94 },
            { id = "chem_ammonium_nitrate_pellets", count = 94 }
        })
    :quality("CONTAIN", 1, 1)
    :requirement("fuel_liquid", 6)
    :book("textbook_anarch", 0)
    :book("recipe_labchem", 5)
    :book("textbook_chemistry", 7)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "chem_acetic_acid",
    result = "chem_acetic_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 10, true)
    :component("vinegar", 320)
    :quality("FINE_DISTILL", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
)

content.add(content.Recipe {
    id = "chem_hexamine",
    result = "chem_hexamine",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :component("ammonia_liquid", 4)
    :component("chem_formaldehyde", 6)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 3, 1)
    :book("recipe_labchem", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(67, 5)
    :result_charges(1620)
)

content.add(content.Recipe {
    id = "chem_formaldehyde",
    result = "chem_formaldehyde",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 50, true)
    :component("chem_methanol", 50)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :book("textbook_chemistry", 5)
    :book("adv_chemistry", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 4)
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_chem_methanol", kind = "collection" }
    byproducts:entry { item = "chem_ethanol", probability = 100, charges = { 500, 500 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "chem_methanol",
    result = "chem_methanol",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("water_boiling_heat", 25, true)
    :component("methed_alcohol", 1000)
    :quality("BOIL", 2, 1)
    :quality("DISTILL", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 4)
    :result_charges(250)
    :byproducts_from_group("recipe_byproducts_chem_methanol")
)

-- Heated to 78.3 degress C, water doesn't boil. 5x40 surface heat to bring the mixture to temp, +5x ish to
-- keep it there for requisite time hour+.
-- 6 kg wood to produce 500 ml of methanol at an material efficiency of about 8%, 25,000 kj per recipe or ~14
-- kwh per kg of methanol.
-- net energy efficiency of about 30% (it takes 10 joules to consolidate the wood into a 3 joules of higher
-- energy density)
content.add(content.Recipe {
    id = "chem_methanol_from wood",
    result = "chem_methanol",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("%s from wood"),
}
    :tool_charges("surface_heat", 1000, true)
    :tool("thermometer", 1)
    :tool_charges("ppe_gas", 2, true)
    :tool_any({
            { id = "water", charges = 40 },
            { id = "water_clean", charges = 40 }
        })
    :component("splinter", 40)
    :quality("DISTILL", 2, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :proficiency("prof_intro_chem_synth")
    :result_charges(500)
)

content.add(content.Recipe {
    id = "chem_rdx",
    result = "chem_rdx",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 450000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 20, true)
    :component("chem_hexamine", 624)
    :component("chem_nitric_acid", 5)
    :component("chem_sulphuric_acid", 2)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 3, 1)
    :book("recipe_labchem", 8)
    :book("textbook_anarch", 10)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :result_charges(500)
)

content.add(content.Recipe {
    id = "chem_thermite",
    result = "chem_thermite",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :component("chem_aluminium_powder", 50)
    :component("chem_chromium_oxide", 430)
    :quality("BOIL", 2, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(50)
)

content.add(content.Recipe {
    id = "chem_hmtd_from_acetic",
    result = "chem_hmtd",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 330000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    name = content.text("%s from acetic acid"),
}
    :component("chem_hexamine", 312)
    :component("chem_hydrogen_peroxide_conc", 5)
    :component("chem_acetic_acid", 2)
    :quality("BOIL", 2, 1)
    :book("recipe_labchem", 8)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :result_charges(200)
)

content.add(content.Recipe {
    id = "chem_hmtd_from_citric",
    result = "chem_hmtd",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 330000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
    name = content.text("%s from citric acid"),
}
    :component("chem_hexamine", 312)
    :component("chem_hydrogen_peroxide_conc", 5)
    :component("chem_citric_acid", 2)
    :quality("BOIL", 2, 1)
    :book("recipe_labchem", 8)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :result_charges(2)
)

content.add(content.Recipe {
    id = "chem_apex",
    result = "chem_apex",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 450000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :component("chem_acetone", 5)
    :component("chem_hydrogen_peroxide_conc", 5)
    :component("chem_muriatic_acid", 2)
    :quality("BOIL", 2, 1)
    :book("recipe_labchem", 8)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :result_charges(200)
)

content.add(content.Recipe {
    id = "chem_rocket_fuel",
    result = "chem_rocket_fuel",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :component("chem_zinc_powder", 645)
    :component("chem_sulphur", 750)
    :quality("BOIL", 2, 1)
    :book("textbook_anarch", 5)
    :book("recipe_labchem", 4)
    :book("textbook_chemistry", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "tool_rocket_candy",
    result = "tool_rocket_candy",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_any({
            { id = "hotplate", charges = 50 },
            { id = "integrated_welder", charges = 50 }
        })
    :component("chem_saltpetre", 50)
    :component("sugar", 50)
    :quality("BOIL", 2, 1)
    :book("textbook_anarch", 4)
    :book("recipe_labchem", 3)
    :book("textbook_chemistry", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
)

content.add(content.Recipe {
    id = "lye",
    result = "lye",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("chem_slaked_lime", 34)
    :component("chem_washing_soda", 42)
    :quality("CHEM", 1, 1)
    :book("adv_chemistry", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(99, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "lye_potassium",
    result = "lye_potassium",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("ash", 50)
    :quality("CHEM", 1, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(99, 1)
    :result_charges(1)
)

-- chloralkali process, same as with bleach except we wont be washing gases
content.add(content.Recipe {
    id = "lye_by_electrolysis",
    result = "lye",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("%s by electrolysis"),
}
    :tool_charges("electrolysis_kit", 250)
    :component_any({
            { id = "salt_water", count = 2 },
            { id = "saline", count = 10 }
        })
    :quality("CHEM", 2, 1)
    :requires_skill("electronics", 2)
    :book("adv_chemistry", 3)
    :book("textbook_chemistry", 3)
    :book("recipe_labchem", 3)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 4)
)

-- This makes 5 charges for an average-sized survivor, morphine assumed as 1 ch=5mg, heroin as 50% pure.
content.add(content.Recipe {
    id = "anesthetic",
    result = "anesthetic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MEDICAL",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 6,
}
    :tool_charges("surface_heat", 30, true)
    :tool("syringe", 1)
    :component("ether", 420)
    :component_any({
            { id = "heroin", count = 20 },
            { id = "morphine", count = 10 }
        })
    :component("datura_seed", 5)
    :component_any({
            { id = "conc_venom", count = 5 },
            { id = "stimpack_ammo", count = 5 }
        })
    :component_any({
            { id = "conc_paralytic", count = 5 },
            { id = "rocuronium", count = 5 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("CHEM", 3, 1)
    :quality("SEPARATE", 1, 1)
    :requires_skill("chemistry", 5)
    :book("textbook_firstaid", 6)
    :book("textbook_toxicology", 6)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_pharmaceutical")
    :batch_discount(75, 1)
    :result_charges(420)
)

content.add(content.Recipe {
    id = "ether",
    result = "ether",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool("chem_sulphuric_acid", 1)
    :tool_charges("surface_heat", 20, true)
    :component("chem_ethanol", 250)
    :quality("CHEM", 2, 1)
    :quality("CONTAIN", 1, 1)
    :book("textbook_chemistry", 4)
    :book("adv_chemistry", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_intro_chem_synth")
    :result_charges(250)
    :byproduct("water_clean", 1)
)

-- Some combination of: CO2 + C -> 2CO; ZnO + C -> Zn + CO; ZnO + CO -> Zn + CO2
-- 1412g zincite ~ 15.8140 mol ZnO (1287.354g) + 1.7571 mol MnO (124.644g) | in theory require 7.907 mol C
-- under perfect conditions
-- 125×931mg anthracite coal @ ~90% carbon ~ 8.7201 mol C | input excess carbon to account for wastage e.g.
-- CO lost to atmosphere
-- output 375×1.785g zinc metal = 10.2382 mol Zn | byproduct 5 mol ZnO residue (imperfect process) |
-- remainder wasted e.g. zinc vapor lost to atmosphere
-- carbon content of wood charcoal varies drastically (50~95%); picked ~80.56% so that 1040mg charcoal equiv.
-- to 931mg coal
do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_zinc_metal", kind = "collection" }
    byproducts:entry { item = "chem_zinc_oxide", probability = 100, count = { 500, 500 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "zinc_metal",
    result = "zinc_metal",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("material_zincite", 1)
    :component_any({
            { id = "coal_lump", count = 125 },
            { id = "charcoal", count = 125 }
        })
    :quality("CHISEL", 2, 1)
    :quality("HAMMER", 2, 1)
    :requirement("forging_standard", 6)
    :proficiency("prof_metallurgy")
    :result_charges(375)
    :byproducts_from_group("recipe_byproducts_zinc_metal")
)

-- unlike smelting zinc_metal from material_zincite above, we want to guarantee complete reduction here
-- ZnO + C -> Zn + CO | being extremely conservative; basically doubled carbon input + allow excess for
-- wastage
-- 80×931mg anthracite coal @ ~90% carbon ~ 5.5809 mol C
-- carbon content of wood charcoal varies drastically (50~95%); picked ~80.56% so that 1040mg charcoal equiv.
-- to 931mg coal
content.add(content.Recipe {
    id = "chem_zinc_powder_with_carbon",
    result = "chem_zinc_powder",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("chem_zinc_oxide", 500)
    :component_any({
            { id = "coal_lump", count = 80 },
            { id = "charcoal", count = 80 }
        })
    :requirement("forging_standard", 2)
    :proficiency("prof_metallurgy")
    :result_charges(500)
)

-- rhodonite has up to 42% manganese.  915g/869mg*40%=421
content.add(content.Recipe {
    id = "chem_manganese_dioxide",
    result = "chem_manganese_dioxide",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("material_rhodonite", 1)
    :quality("CHISEL", 2, 1)
    :quality("HAMMER", 2, 1)
    :result_charges(400)
)

-- Extraction only. No chemical reactions = no proficiencies.
content.add(content.Recipe {
    id = "hi_q_wax",
    result = "hi_q_wax",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1350000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_any({
            { id = "pointy_stick", count = 1 },
            { id = "pipe", count = 1 }
        })
    :tool_charges("surface_heat", 5, true)
    :tool_charges("closed_loop_extractor_small", 50)
    :tool_charges("filter_paper_qualitative", 1)
    :tool_charges("filter_paper_quantitative", 1)
    :tool_charges("gasket_plastic_set", 1)
    :component("weed", 7)
    :quality("CONTAIN", 1, 1)
    :quality("BOIL", 1, 1)
    :book("textbook_extraction", 4)
    :proficiency("prof_intro_chemistry")
    :batch_discount(100, 1)
    :result_charges(4)
)

-- Extraction only. No chemical reactions = no proficiencies.
content.add(content.Recipe {
    id = "hi_q_wax_improvised_extraction",
    result = "hi_q_wax",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
    name = content.text("improvised %s"),
}
    :tool("pipe", 1)
    :tool_charges("surface_heat", 5, true)
    :tool_any({
            { id = "butane_tank", charges = 1 },
            { id = "butane_can", charges = 1 }
        })
    :tool_charges("filter_paper_qualitative", 1)
    :tool_charges("filter_paper_quantitative", 1)
    :component("weed", 8)
    :quality("CONTAIN", 1, 1)
    :quality("BOIL", 1, 1)
    :book("textbook_extraction", 4)
    :proficiency("prof_intro_chemistry")
    :batch_discount(100, 1)
    :result_charges(4)
)

-- Extraction only. No chemical reactions = no proficiencies.
content.add(content.Recipe {
    id = "hi_q_shatter",
    result = "hi_q_shatter",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 27360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("closed_loop_extractor_small", 50)
    :tool_charges("vac_oven_small", 200)
    :tool_charges("filter_paper_qualitative", 2)
    :tool_charges("filter_paper_quantitative", 2)
    :tool_charges("gasket_plastic_set", 2)
    :component("weed", 7)
    :book("textbook_extraction", 4)
    :proficiency("prof_intro_chemistry")
    :batch_discount(100, 1)
    :result_charges(5)
)

-- Extraction only. No chemical reactions = no proficiencies.
content.add(content.Recipe {
    id = "hi_q_shatter_improvised_extraction",
    result = "hi_q_shatter",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 26640000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("improvised %s"),
}
    :tool("pipe", 1)
    :tool_any({
            { id = "butane_tank", charges = 1 },
            { id = "butane_can", charges = 1 }
        })
    :tool_charges("vac_oven_small", 200)
    :tool_charges("filter_paper_qualitative", 2)
    :tool_charges("filter_paper_quantitative", 2)
    :tool_charges("gasket_plastic_set", 1)
    :component("weed", 8)
    :book("textbook_extraction", 4)
    :proficiency("prof_intro_chemistry")
    :batch_discount(100, 1)
    :result_charges(5)
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_hi_q_distillate", kind = "collection" }
    byproducts:entry { item = "chem_ethanol", probability = 100, charges = { 250, 250 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "hi_q_distillate",
    result = "hi_q_distillate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5760000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_any({
            { id = "pointy_stick", count = 1 },
            { id = "pipe", count = 1 }
        })
    :tool("flask_glass", 1)
    :tool_charges("surface_heat", 5, true)
    :tool_charges("closed_loop_extractor_small", 50)
    :tool_charges("vac_pump", 300)
    :tool_charges("filter_paper_qualitative", 2)
    :tool_charges("filter_paper_quantitative", 2)
    :tool_charges("gasket_plastic_set", 1)
    :component("weed", 7)
    :component("chem_ethanol", 2250)
    :quality("CONTAIN", 1, 1)
    :quality("BOIL", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("STRAIN", 2, 1)
    :book("textbook_extraction", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :batch_discount(90, 1)
    :result_charges(15)
    :byproducts_from_group("recipe_byproducts_hi_q_distillate")
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_hi_q_distillate_improvised_extraction", kind = "collection" }
    byproducts:entry { item = "chem_ethanol", probability = 100, charges = { 250, 250 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "hi_q_distillate_improvised_extraction",
    result = "hi_q_distillate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4680000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("improvised %s"),
}
    :tool("pipe", 1)
    :tool("flask_glass", 1)
    :tool_charges("surface_heat", 5, true)
    :tool_any({
            { id = "butane_tank", charges = 1 },
            { id = "butane_can", charges = 1 }
        })
    :tool_charges("vac_pump", 300)
    :tool_charges("filter_paper_qualitative", 2)
    :tool_charges("filter_paper_quantitative", 2)
    :component("weed", 8)
    :component("chem_ethanol", 2250)
    :quality("CONTAIN", 1, 1)
    :quality("BOIL", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("STRAIN", 2, 1)
    :book("textbook_extraction", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :batch_discount(90, 1)
    :result_charges(15)
    :byproducts_from_group("recipe_byproducts_hi_q_distillate_improvised_extraction")
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_hi_q_distillate_large_extraction", kind = "collection" }
    byproducts:entry { item = "chem_ethanol", probability = 100, charges = { 250, 250 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "hi_q_distillate_large_extraction",
    result = "hi_q_distillate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("large %s"),
}
    :tool_any({
            { id = "pointy_stick", count = 1 },
            { id = "pipe", count = 1 }
        })
    :tool("flask_glass", 1)
    :tool_charges("surface_heat", 5, true)
    :tool_charges("closed_loop_extractor_large", 100)
    :tool_charges("vac_pump", 300)
    :tool_charges("filter_paper_qualitative", 2)
    :tool_charges("filter_paper_quantitative", 2)
    :tool_charges("gasket_plastic_set", 1)
    :component("weed", 10)
    :component("chem_ethanol", 2250)
    :quality("CONTAIN", 1, 1)
    :quality("BOIL", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("STRAIN", 2, 1)
    :book("textbook_extraction", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :batch_discount(99, 1)
    :result_charges(12)
    :byproducts_from_group("recipe_byproducts_hi_q_distillate_large_extraction")
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_hi_q_distillate_crude_extraction", kind = "collection" }
    byproducts:entry { item = "chem_ethanol", probability = 100, charges = { 250, 250 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "hi_q_distillate_crude_extraction",
    result = "hi_q_distillate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("crude %s"),
}
    :tool_any({
            { id = "pointy_stick", count = 1 },
            { id = "pipe", count = 1 }
        })
    :tool("oil_extractor_crude", 1)
    :tool_any({
            { id = "funnel", count = 1 },
            { id = "makeshift_funnel", count = 1 },
            { id = "birchbark_funnel", count = 1 },
            { id = "leather_funnel", count = 1 },
            { id = "metal_funnel", count = 1 }
        })
    :tool("flask_glass", 1)
    :tool_charges("surface_heat", 5, true)
    :tool_any({
            { id = "butane_tank", charges = 1 },
            { id = "butane_can", charges = 1 }
        })
    :tool_charges("vac_pump", 300)
    :tool_charges("filter_paper_qualitative", 2)
    :tool_charges("filter_paper_quantitative", 2)
    :component("weed", 10)
    :component("chem_ethanol", 5000)
    :quality("CONTAIN", 1, 1)
    :quality("BOIL", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :quality("STRAIN", 2, 1)
    :book("textbook_extraction", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :batch_discount(90, 1)
    :result_charges(12)
    :byproducts_from_group("recipe_byproducts_hi_q_distillate_crude_extraction")
)

-- Biochemistry is added because one needs to know where to look.
-- Should likely come from an entomology text, or something similar, in the future; but still relatively
-- basic.
content.add(content.Recipe {
    id = "formic_acid",
    result = "formic_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
}
    :tool("funnel", 1)
    :component_any({
            { id = "wasp_sting", count = 1 },
            { id = "bee_sting", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
)

content.add(content.Recipe {
    id = "latex",
    result = "latex",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :component("spurge", 20)
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :proficiency("prof_intro_chemistry")
)

-- This is not actually accurate; producing rubber from formic acid and latex generally takes around 12
-- hours. However, it will be better if we simply create some kind of curing rubber, and let it naturally
-- evolve into rubber chunks from there. Nobody has twelve hours to watch rubber form in a zombie apocalypse.
content.add(content.Recipe {
    id = "chunk_rubber",
    result = "chunk_rubber",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :component("latex", 5)
    :component("formic_acid", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
)

content.add(content.Recipe {
    id = "cocaine_topical",
    result = "cocaine_topical",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 2,
}
    :tool("syringe", 1)
    :tool_charges("surface_heat", 1, true)
    :component("chem_citric_acid", 9)
    :component("coke", 20)
    :component("water_clean", 1)
    :quality("CONTAIN", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :quality("CHEM", 2, 1)
    :book("reference_cooking", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_pharmaceutical")
    :batch_discount(80, 1)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "conc_venom",
    result = "conc_venom",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool("syringe", 1)
    :tool_charges("surface_heat", 30, true)
    :component_any({
            { id = "venom_wasp", count = 1 },
            { id = "venom_bee", count = 1 }
        })
    :quality("CHEM", 3, 1)
    :quality("SEPARATE", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :requires_skill("firstaid", 3)
    :book("textbook_toxicology", 5)
    :book("textbook_arthropod", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(50, 3)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "conc_paralytic",
    result = "conc_paralytic",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool("syringe", 1)
    :tool_charges("surface_heat", 30, true)
    :component("venom_paralytic", 1)
    :quality("CHEM", 3, 1)
    :quality("SEPARATE", 1, 1)
    :quality("CONCENTRATE", 1, 1)
    :requires_skill("firstaid", 3)
    :book("textbook_toxicology", 5)
    :book("textbook_botany", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :batch_discount(50, 3)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "chem_turpentine",
    result = "chem_turpentine",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
}
    :tool_charges("surface_heat", 25, true)
    :component("pine_resin", 12)
    :component_any({
            { id = "water", count = 12 },
            { id = "water_clean", count = 12 }
        })
    :quality("CHEM", 1, 1)
    :quality("DISTILL", 1, 1)
    :quality("STRAIN", 1, 1)
    :requires_skill("survival", 3)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_distilling")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(80, 4)
    :result_charges(200)
    :byproduct("rosin", 1)
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_chem_muriatic_acid_with_blood", kind = "collection" }
    byproducts:entry { item = "salt", probability = 100, count = { 80, 100 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "chem_muriatic_acid_with_blood",
    result = "chem_muriatic_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
    name = content.text("%s with blood"),
}
    :tool_charges("water_boiling_heat", 2, true)
    :tool_charges("ppe_gas", 5, true)
    :tool_charges("ppe_gloves", 1, true)
    :tool_charges("ppe_skin", 1, true)
    :component_any({
            { id = "chem_ethanol", count = 250 },
            { id = "denat_alcohol", count = 250 },
            { id = "mixed_alcohol_strong", count = 14 }
        })
    :component("blood_acid", 2)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 1, 1)
    :book("textbook_chemistry", 2)
    :book("adv_chemistry", 2)
    :book("atomic_survival", 1)
    :book("recipe_labchem", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(40, 2)
    :byproducts_from_group("recipe_byproducts_chem_muriatic_acid_with_blood")
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_chem_muriatic_acid_with_blood_distill", kind = "collection" }
    byproducts:entry { item = "salt", probability = 100, count = { 80, 100 } }
    byproducts:entry { item = "water_clean", probability = 100, charges = { 1, 1 } }
    byproducts:entry { item = "chem_ethanol", probability = 100, charges = { 200, 250 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "chem_muriatic_acid_with_blood_distill",
    result = "chem_muriatic_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    name = content.text("distill %s with blood"),
}
    :tool_charges("water_boiling_heat", 2, true)
    :tool_charges("ppe_gas", 6, true)
    :tool_charges("ppe_gloves", 1, true)
    :tool_charges("ppe_skin", 1, true)
    :component_any({
            { id = "chem_ethanol", count = 250 },
            { id = "denat_alcohol", count = 250 },
            { id = "mixed_alcohol_strong", count = 14 }
        })
    :component("blood_acid", 2)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :quality("DISTILL", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :book("textbook_chemistry", 6)
    :book("adv_chemistry", 6)
    :book("atomic_survival", 5)
    :book("recipe_labchem", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_distilling")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(30, 2)
    :byproducts_from_group("recipe_byproducts_chem_muriatic_acid_with_blood_distill")
)

content.add(content.Recipe {
    id = "formic_acid_with_blood",
    result = "formic_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
    name = content.text("%s with blood"),
}
    :tool_charges("water_boiling_heat", 2, true)
    :tool_charges("ppe_gas", 3, true)
    :tool_charges("ppe_gloves", 1, true)
    :tool_charges("ppe_skin", 1, true)
    :component_any({
            { id = "chem_ethanol", count = 250 },
            { id = "denat_alcohol", count = 250 },
            { id = "mixed_alcohol_strong", count = 14 }
        })
    :component("blood_acid_insect", 2)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 1, 1)
    :book("textbook_chemistry", 2)
    :book("adv_chemistry", 2)
    :book("atomic_survival", 1)
    :book("recipe_labchem", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(40, 2)
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_formic_acid_with_blood_distill", kind = "collection" }
    byproducts:entry { item = "water_clean", probability = 100, charges = { 1, 1 } }
    byproducts:entry { item = "chem_ethanol", probability = 100, charges = { 200, 250 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "formic_acid_with_blood_distill",
    result = "formic_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    name = content.text("distill %s with blood"),
}
    :tool_charges("water_boiling_heat", 2, true)
    :tool_charges("ppe_gas", 4, true)
    :tool_charges("ppe_gloves", 1, true)
    :tool_charges("ppe_skin", 1, true)
    :component_any({
            { id = "chem_ethanol", count = 250 },
            { id = "denat_alcohol", count = 250 },
            { id = "mixed_alcohol_strong", count = 14 }
        })
    :component("blood_acid_insect", 2)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :quality("DISTILL", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :book("textbook_chemistry", 6)
    :book("adv_chemistry", 6)
    :book("atomic_survival", 5)
    :book("recipe_labchem", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_distilling")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(30, 2)
    :byproducts_from_group("recipe_byproducts_formic_acid_with_blood_distill")
)

content.add(content.Recipe {
    id = "chem_acetic_acid_with_blood",
    result = "chem_acetic_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
    name = content.text("%s with blood"),
}
    :tool_charges("water_boiling_heat", 2, true)
    :tool_charges("ppe_gas", 2, true)
    :tool_charges("ppe_gloves", 1, true)
    :tool_charges("ppe_skin", 1, true)
    :component_any({
            { id = "chem_ethanol", count = 250 },
            { id = "denat_alcohol", count = 250 },
            { id = "mixed_alcohol_strong", count = 14 }
        })
    :component("blood_acid_plant", 2)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 1, 1)
    :book("textbook_chemistry", 2)
    :book("adv_chemistry", 2)
    :book("atomic_survival", 1)
    :book("recipe_labchem", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(40, 2)
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_chem_acetic_acid_with_blood_distill", kind = "collection" }
    byproducts:entry { item = "water_clean", probability = 100, charges = { 1, 1 } }
    byproducts:entry { item = "chem_ethanol", probability = 100, charges = { 200, 250 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "chem_acetic_acid_with_blood_distill",
    result = "chem_acetic_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    name = content.text("distill %s with blood"),
}
    :tool_charges("water_boiling_heat", 2, true)
    :tool_charges("ppe_gas", 3, true)
    :tool_charges("ppe_gloves", 1, true)
    :tool_charges("ppe_skin", 1, true)
    :component_any({
            { id = "chem_ethanol", count = 250 },
            { id = "denat_alcohol", count = 250 },
            { id = "mixed_alcohol_strong", count = 14 }
        })
    :component("blood_acid_plant", 2)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 2, 1)
    :quality("DISTILL", 1, 1)
    :quality("FINE_DISTILL", 1, 1)
    :book("textbook_chemistry", 6)
    :book("adv_chemistry", 6)
    :book("atomic_survival", 5)
    :book("recipe_labchem", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_distilling")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(30, 2)
    :byproducts_from_group("recipe_byproducts_chem_acetic_acid_with_blood_distill")
)

content.add(content.Recipe {
    id = "chem_sulphuric_acid_with_blood",
    result = "chem_sulphuric_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
    name = content.text("%s with blood"),
}
    :tool_charges("water_boiling_heat", 3, true)
    :tool_charges("ppe_gas", 10, true)
    :tool_charges("ppe_gloves", 1, true)
    :tool_charges("ppe_skin", 1, true)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("blood_acid_underground", 2)
    :quality("BOIL", 2, 1)
    :quality("CHEM", 1, 1)
    :book("textbook_chemistry", 2)
    :book("adv_chemistry", 2)
    :book("atomic_survival", 1)
    :book("recipe_labchem", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_biochemistry")
    :proficiency("prof_intro_chem_synth")
    :batch_discount(50, 2)
)

-- It is just a blend; no chemical reactions.
content.add(content.Recipe {
    id = "camphine",
    result = "camphine",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :component("chem_turpentine", 50)
    :component("chem_ethanol", 150)
    :quality("CHEM", 1, 1)
    :book("pocket_survival", 1)
    :book("survival_book", 1)
    :book("textbook_survival", 1)
    :book("manual_survival", 1)
    :proficiency("prof_intro_chemistry")
    :batch_discount(80, 4)
    :result_charges(200)
)

-- At least some knowledge on chemicals handling is required.
-- Ultimately, cac2powder premix feeds into CaO + 3 C -> CaC2 + CO
-- 7×15g quicklime = 1.8724 moles of CaO
-- 80×931mg anthracite coal @ ~90% carbon = 5.5809 moles C (5.5809/3 = 1.8603)
-- If no losses, this mix is equivalent to 1.86 moles of CaC2; but make this grinding process a bit lossy
content.add(content.Recipe {
    id = "cac2powder",
    result = "cac2powder",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "coal_lump", count = 80 },
            { id = "charcoal", count = 80 }
        })
    :component("material_quicklime", 7)
    :quality("FINE_GRIND", 1, 1)
    :proficiency("prof_intro_chemistry")
    :result_charges(175)
)

-- industrial arc furnace smelting, cooling, then grinding
-- multiple batches worth can be smelted and cooled at once, but grinding time dominates
-- some loss/waste, e.g. imperfect smelting; powder escaping
-- Lower limit is based on a guesstimate about how much charge you need in the furnace for it to operate
-- At least some knowledge on chemicals handling is required.
-- 460kJ per mole @ 70% energy efficiency
content.add(content.Recipe {
    id = "chem_carbide",
    result = "chem_carbide",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_charges("fake_arc_furnace", 6500)
    :component("cac2powder", 1000)
    :quality("FINE_GRIND", 1, 1)
    :book("textbook_chemistry", 4)
    :book("textbook_gaswarfare", 4)
    :book("atomic_survival", 3)
    :proficiency("prof_intro_chemistry")
    :batch_discount(25, 2)
    :result_charges(950)
)

-- basically burning potassium chlorate to form KCl in the ratio 1.6:1, i.e 20 matches produce 71 mg of KCl.
-- A survial match burns for 15-20 seconds and have a thicker coating of Potassium Chlorate to make it
-- windproof.
content.add(content.Recipe {
    id = "chem_potassium_chloride",
    result = "chem_potassium_chloride",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :tool_charges("water_boiling_heat", 1, true)
    :component_any({
            { id = "survival_match", count = 1 },
            { id = "match", count = 28 }
        })
    :quality("CUT", 1, 1)
    :batch_discount(99, 1)
    :result_charges(1)
)
