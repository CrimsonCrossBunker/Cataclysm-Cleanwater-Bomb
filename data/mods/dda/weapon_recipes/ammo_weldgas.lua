local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "oxyacetylene",
    result = "oxyacetylene",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_any({
            { id = "oxygen_tank", charges = 24 },
            { id = "oxygen_cylinder", charges = 24 },
            { id = "smoxygen_tank", charges = 24 }
        })
    :component("acetylene", 96)
    :quality("PRESSURIZATION", 1, 1)
    :book("textbook_chemistry", 4)
    :book("textbook_gaswarfare", 4)
    :book("atomic_survival", 3)
    :batch_discount(80, 1)
    :result_charges(120)
)

local acetylene_byproducts = content.ItemGroup { id = "recipe_byproducts_acetylene", kind = "collection" }
acetylene_byproducts:entry { item = "chem_slaked_lime", count = { 50, 50 }, probability = 100 }
content.add(acetylene_byproducts)

content.add(content.Recipe {
    id = "acetylene",
    result = "acetylene",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool("acetylene_machine", 1)
    :component_any({
            { id = "water", count = 12 },
            { id = "water_clean", count = 12 }
        })
    :component("chem_carbide", 326)
    :book("textbook_chemistry", 4)
    :book("textbook_gaswarfare", 4)
    :book("atomic_survival", 3)
    :proficiency("prof_intro_chemistry")
    :batch_discount(80, 1)
    :result_charges(12)
    :byproducts_from_group("recipe_byproducts_acetylene")
)

content.add(content.Recipe {
    id = "tinyweldtank",
    result = "tinyweldtank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("tinyweldtank", 1)
    :component("oxyacetylene", 30)
    :quality("PRESSURIZATION", 1, 1)
    :book("welding_book", 2)
)

content.add(content.Recipe {
    id = "smallweldtank",
    result = "smallweldtank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("smallweldtank", 1)
    :component("oxyacetylene", 60)
    :quality("PRESSURIZATION", 1, 1)
    :book("welding_book", 2)
)

content.add(content.Recipe {
    id = "weldtank",
    result = "weldtank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("weldtank", 1)
    :component("oxyacetylene", 240)
    :quality("PRESSURIZATION", 1, 1)
    :book("welding_book", 2)
)

content.add(content.Recipe {
    id = "welding_rod_steel",
    result = "welding_rod_steel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 2,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 30)
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 10 }
        })
    :component("scrap", 1)
    :component_any({
            { id = "flour_any", count = 1, requirement = true },
            { id = "paper", count = 3 }
        })
    :component_any({
            { id = "material_limestone", count = 1 },
            { id = "chem_manganese_dioxide", count = 1 },
            { id = "light_battery_cell", count = 1 }
        })
    :component_any({
            { id = "rosin", count = 5 },
            { id = "glue_weak", count = 150 },
            { id = "sugar", count = 1 },
            { id = "plastic_chunk", count = 1 },
            { id = "wax_any", count = 1, requirement = true },
            { id = "candle", count = 1 }
        })
    :quality("HAMMER", 2, 1)
    :quality("ANVIL", 1, 1)
    :quality("SAW_M", 2, 1)
    :requires_skill("chemistry", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_intro_chemistry")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "welding_rod_alloy",
    result = "welding_rod_alloy",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 1260000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    result_multiplier = 50,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 350)
    :tool_any({
            { id = "rock_quern", count = 1 },
            { id = "mortar_pestle", count = 1 },
            { id = "food_processor", charges = 25 }
        })
    :component_any({
            { id = "material_aluminium_ingot", count = 3 },
            { id = "scrap_aluminum", count = 15 }
        })
    :component_any({
            { id = "chem_sulphuric_acid", count = 1 },
            { id = "chem_aluminium_sulphate", count = 6 },
            { id = "chem_sulphur", count = 50 }
        })
    :component_any({
            { id = "salt", count = 12 },
            { id = "chem_potassium_chloride", count = 65 },
            { id = "material_rocksalt", count = 1 }
        })
    :component_any({
            { id = "lye_powder", count = 20 },
            { id = "lye", count = 1 },
            { id = "chem_potassium_hydroxide", count = 40 }
        })
    :component("material_sand", 15)
    :quality("HAMMER", 1, 1)
    :quality("ANVIL", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("CHEM", 1, 1)
    :requires_skill("chemistry", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "welding_wire_steel",
    result = "welding_wire_steel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "forge", charges = 240 },
            { id = "oxy_torch", charges = 40 }
        })
    :tool_charges("wire_draw_machine", 100)
    :tool_charges("electrolysis_kit", 100)
    :tool_any({
            { id = "jar_glass_sealed", count = 1 },
            { id = "jar_3l_glass_sealed", count = 1 }
        })
    :component("any_wire", 4, true)
    :component("copper", 1)
    :component("any_strong_acid", 1, true)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :quality("HAMMER", 2, 1)
    :quality("ANVIL", 1, 1)
    :requires_skill("chemistry", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(180)
)

content.add(content.Recipe {
    id = "welding_wire_alloy",
    result = "welding_wire_alloy",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
    result_multiplier = 2,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "forge", charges = 250 },
            { id = "oxy_torch", charges = 50 }
        })
    :tool_charges("wire_draw_machine", 120)
    :component_any({
            { id = "material_aluminium_ingot", count = 3 },
            { id = "scrap_aluminum", count = 11 }
        })
    :quality("HAMMER", 1, 1)
    :quality("ANVIL", 1, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_wiremaking")
    :result_charges(180)
)

content.add(content.Recipe {
    id = "brazing_rod_bronze",
    result = "brazing_rod_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 7,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 50)
    :component("scrap_bronze", 1)
    :quality("HAMMER", 1, 1)
    :quality("ANVIL", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("flux", 10)
    :requires_skill("chemistry", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_intro_chemistry")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "brazing_rod_alloy",
    result = "brazing_rod_alloy",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 990000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    result_multiplier = 38,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 200)
    :component_any({
            { id = "material_aluminium_ingot", count = 3 },
            { id = "scrap_aluminum", count = 13 }
        })
    :quality("HAMMER", 1, 1)
    :quality("ANVIL", 1, 1)
    :quality("SAW_M", 1, 1)
    :proficiency("prof_metalworking")
    :result_charges(10)
)

content.add(content.Recipe {
    id = "oxygen_tank",
    result = "oxygen_tank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 270000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    flags = { "FULL_MAGAZINE" },
}
    :tool_charges("pseudo_app_oxygen_concentrator", 1620)
    :tool_charges("pseudo_app_hd_compressor_unit", 1350)
    :component("oxygen_tank", 1)
)

content.add(content.Recipe {
    id = "oxygen_cylinder",
    result = "oxygen_cylinder",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 3390000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    flags = { "FULL_MAGAZINE" },
}
    :tool_charges("pseudo_app_oxygen_concentrator", 20250)
    :tool_charges("pseudo_app_hd_compressor_unit", 16875)
    :component("oxygen_cylinder", 1)
)

content.add(content.Recipe {
    id = "smoxygen_tank",
    result = "smoxygen_tank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 150000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    flags = { "FULL_MAGAZINE" },
}
    :tool_charges("pseudo_app_oxygen_concentrator", 810)
    :tool_charges("pseudo_app_hd_compressor_unit", 675)
    :component("smoxygen_tank", 1)
)
