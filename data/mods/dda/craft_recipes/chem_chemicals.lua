local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "chem_saltpetre_from_feces_bird",
    result = "chem_saltpetre",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("water_boiling_heat", 3, true)
    :component("feces_bird", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :quality("STRAIN", 2, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(99, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "formic_acid_from_oxalic_acid",
    result = "formic_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 5, true)
    :tool("thermometer", 1)
    :component("splinter", 3)
    :component_any({
            { id = "lye_powder", count = 30 },
            { id = "lye", count = 1 },
            { id = "chem_potassium_hydroxide", count = 150 },
            { id = "lye_potassium", count = 1 }
        })
    :component("chem_sulphuric_acid", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("chem_glycerol", 20)
    :quality("CHEM", 2, 1)
    :quality("CUT", 2, 1)
    :quality("FINE_DISTILL", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_distilling")
    :batch_discount(80, 2)
    :result_charges(75)
    :byproduct("chem_glycerol", 20)
)

content.add(content.Recipe {
    id = "chem_acetone",
    result = "chem_acetone",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 30, true)
    :component("chem_acetic_acid", 3)
    :component_any({
            { id = "material_limestone", count = 54 },
            { id = "material_quicklime", count = 24 },
            { id = "chem_slaked_lime", count = 240 }
        })
    :quality("CHEM", 2, 1)
    :quality("DISTILL", 1, 1)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 5)
    :book("recipe_labchem", 4)
    :book("atomic_survival", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_distilling")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(80, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "chem_toluene",
    result = "chem_toluene",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 5, true)
    :tool("chem_citric_acid", 1)
    :component("chem_benzene", 90)
    :component("chem_methanol", 32)
    :quality("CHEM", 2, 1)
    :book("adv_chemistry", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_organic_chemistry")
    :batch_discount(99, 1)
    :result_charges(105)
)

-- 14 mol(1037g) slaked lime + 14 mol(616g) co2 ~= 14 mol(1400g) caco3 + 14mol(250g) h2o
-- assumption just over 3g of co2 per ml of coal or 205 g per 150g wood splinter, which is fed into the
-- slaked lime to produce caco3
content.add(content.Recipe {
    id = "chem_caco3",
    result = "chem_caco3",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 270000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :component_any({
            { id = "splinter", count = 3 },
            { id = "coal_lump", count = 200 }
        })
    :component("chem_slaked_lime", 470)
    :quality("CHEM", 2, 1)
    :quality("DISTILL", 1, 1)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 3)
    :book("recipe_labchem", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(25, 2)
    :result_charges(516)
    :byproduct("water_clean", 1)
)

-- 1 mol(106g) calcchloride + 1 mol(111g) washingsoda ~= 1 mol(100g) caco3 + 2mol(116g) salt
do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_chem_caco3_from_washing_soda", kind = "collection" }
    byproducts:entry { item = "salt", probability = 100, count = { 33, 33 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "chem_caco3_from_washing_soda",
    result = "chem_caco3",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 1,
}
    :component("chem_washing_soda", 49)
    :component("chem_calcium_chloride", 48)
    :component("water_clean", 1)
    :quality("CHEM", 1, 1)
    :book("adv_chemistry", 1)
    :book("textbook_chemistry", 1)
    :book("basic_chemistry", 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(15, 2)
    :result_charges(37)
    :byproducts_from_group("recipe_byproducts_chem_caco3_from_washing_soda")
)

content.add(content.Recipe {
    id = "chem_chloroform",
    result = "chem_chloroform",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :component("chem_acetone", 1)
    :component("bleach", 750)
    :quality("CHEM", 2, 1)
    :quality("SEPARATE", 1, 1)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 5)
    :book("recipe_labchem", 4)
    :book("atomic_survival", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_organic_chemistry")
    :batch_discount(80, 2)
    :result_charges(276)
)

content.add(content.Recipe {
    id = "chem_citric_acid",
    result = "chem_citric_acid",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 50, true)
    :component_any({
            { id = "lemon", count = 8 },
            { id = "orange", count = 8 },
            { id = "grapefruit", count = 8 }
        })
    :component("lye_powder", 4)
    :component("chem_sulphuric_acid", 1)
    :component("paper", 10)
    :component("chem_calcium_chloride", 14)
    :component("water_clean", 16)
    :quality("CHEM", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("SEPARATE", 1, 1)
    :quality("STRAIN", 2, 1)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 5)
    :book("recipe_labchem", 4)
    :book("atomic_survival", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(99, 2)
    :result_charges(18)
    :byproduct("juice_pulp", 8)
)

content.add(content.Recipe {
    id = "chem_ferric_chloride",
    result = "chem_ferric_chloride",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("electrolysis_kit", 50)
    :component("scrap", 1)
    :component("salt_water", 4)
    :quality("CHEM", 2, 1)
    :quality("SAW_M", 1, 1)
    :book("adv_chemistry", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(49)
)

content.add(content.Recipe {
    id = "chem_calcium_chloride",
    result = "chem_calcium_chloride",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :component("chem_muriatic_acid", 1)
    :component_any({
            { id = "material_limestone", count = 45 },
            { id = "material_quicklime", count = 24 }
        })
    :quality("CHEM", 2, 1)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 5)
    :book("recipe_labchem", 4)
    :book("atomic_survival", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(80, 2)
    :result_charges(51)
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_chem_washing_soda", kind = "collection" }
    byproducts:entry { item = "ammonia_liquid", probability = 100, charges = { 4, 4 } }
    byproducts:entry { item = "chem_calcium_chloride", probability = 100, count = { 51, 51 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "chem_washing_soda",
    result = "chem_washing_soda",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
}
    :tool_charges("surface_heat", 25, true)
    :component("salt_water", 3)
    :component("material_limestone", 8)
    :component("ammonia_liquid", 4)
    :quality("CHEM", 2, 1)
    :book("adv_chemistry", 5)
    :book("textbook_chemistry", 6)
    :book("recipe_labchem", 5)
    :book("atomic_survival", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(80, 2)
    :result_charges(41)
    :byproducts_from_group("recipe_byproducts_chem_washing_soda")
)

content.add(content.Recipe {
    id = "chem_washing_soda_from_baking_soda",
    result = "chem_washing_soda",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 25, true)
    :component("chem_baking_soda", 76)
    :quality("BOIL", 2, 1)
    :book("adv_chemistry", 4)
    :book("textbook_chemistry", 5)
    :book("recipe_labchem", 4)
    :book("atomic_survival", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(80, 2)
    :result_charges(41)
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_chem_baking_soda", kind = "collection" }
    byproducts:entry { item = "material_quicklime", probability = 100, count = { 8, 8 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "chem_baking_soda",
    result = "chem_baking_soda",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("surface_heat", 25, true)
    :tool_any({
            { id = "forge", charges = 25 },
            { id = "oxy_torch", charges = 5 }
        })
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("chem_washing_soda", 41)
    :component("material_limestone", 8)
    :component("water_clean", 1)
    :quality("CHEM", 2, 1)
    :book("adv_chemistry", 5)
    :book("textbook_chemistry", 6)
    :book("recipe_labchem", 5)
    :book("atomic_survival", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(80, 2)
    :result_charges(76)
    :byproducts_from_group("recipe_byproducts_chem_baking_soda")
)

content.add(content.Recipe {
    id = "acetic_anhydride",
    result = "acetic_anhydride",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 8,
}
    :tool_charges("surface_heat", 25, true)
    :tool_charges("ketene_lamp", 50)
    :component("chem_acetic_acid", 1)
    :component("chem_acetone", 1)
    :quality("CHEM", 2, 1)
    :quality("FINE_DISTILL", 1, 1)
    :book("adv_chemistry", 5)
    :book("textbook_chemistry", 6)
    :book("recipe_labchem", 5)
    :book("atomic_survival", 5)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_distilling")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :batch_discount(80, 2)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "chem_mercury_fulminate",
    result = "chem_mercury_fulminate",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    result_multiplier = 958,
}
    :tool_charges("surface_heat", 10, true)
    :component("mercury", 22)
    :component("chem_nitric_acid", 1)
    :component("chem_ethanol", 206)
    :quality("CHEM", 2, 1)
    :book("adv_chemistry", 7)
    :book("recipe_labchem", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :proficiency("prof_organic_chemistry")
    :batch_discount(99, 2)
)

content.add(content.Recipe {
    id = "chem_lead_azide",
    result = "chem_lead_azide",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 540000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 6,
    result_multiplier = 1168,
}
    :tool_charges("surface_heat", 30, true)
    :component("chem_sodium", 142)
    :component("ammonia_liquid", 1)
    :component("chem_ammonium_nitrate", 238)
    :component("lead", 62)
    :component("chem_nitric_acid", 1)
    :quality("CHEM", 2, 1)
    :book("adv_chemistry", 7)
    :book("recipe_labchem", 7)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(99, 2)
)

content.add(content.Recipe {
    id = "ammonia_liquid",
    result = "ammonia_liquid",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 5,
}
    :tool_charges("electrolyzer_makeshift", 10500)
    :tool_charges("ammonia_machine_reactor", 50000)
    :tool_charges("ammonia_machine_pipework", 5000)
    :tool_charges("nitrogen_generator", 150)
    :component("salt", 10)
    :component("water_clean", 2)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(2)
    :byproduct("salt_water", 1)
)
