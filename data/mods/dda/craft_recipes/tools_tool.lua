local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "wearable_camera",
    result = "wearable_camera",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("camera", 1)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "leather", count = 2 },
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 10 },
            { id = "medical_tape", count = 20 }
        })
    :quality("CUT", 2, 1)
    :book("textbook_fabrication", 0)
    :book("manual_fabrication", 0)
    :book("mag_electronics", 0)
)

content.add(content.Recipe {
    id = "wearable_camera_pro",
    result = "wearable_camera_pro",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("camera_pro", 1)
    :component_any({
            { id = "cotton_patchwork", count = 2 },
            { id = "leather", count = 2 },
            { id = "cordage", count = 1, requirement = true },
            { id = "duct_tape", count = 10 },
            { id = "medical_tape", count = 20 }
        })
    :quality("CUT", 2, 1)
    :book("textbook_fabrication", 0)
    :book("manual_fabrication", 0)
    :book("mag_electronics", 0)
)

content.add(content.Recipe {
    id = "g_shovel",
    result = "g_shovel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

-- 30cm weld
content.add(content.Recipe {
    id = "hand_pump",
    result = "hand_pump",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("pipe", 2)
    :component("hose", 1)
    :component("scrap", 10)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 30)
    :requires_skill("mechanics", 2)
    :book("textbook_fabrication", 4)
    :book("welding_book", 5)
    :book("manual_mechanics", 4)
)

content.add(content.Recipe {
    id = "loom_frame",
    result = "loom_frame",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "2x4", count = 4 },
            { id = "stick", count = 4 }
        })
    :component("cordage_short", 4, true)
    :quality("CUT", 1, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "punch_bone",
    result = "punch_bone",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("bone_sturdy", 1, true)
    :component("any_water", 1, true)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "punch_nail",
    result = "punch_nail",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("nails", 1, true)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "shed_stick",
    result = "shed_stick",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 },
            { id = "splinter", count = 1 }
        })
    :quality("CUT", 1, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "butchering_kit",
    result = "butchering_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("knife_huge", 1)
    :component("knife_large", 1)
    :component("knife_cleaver", 1)
    :component_any({
            { id = "leather", count = 2 },
            { id = "cotton_patchwork", count = 2 }
        })
    :component("cordage_short", 2, true)
)

content.add(content.Recipe {
    id = "crude_picklock",
    result = "crude_picklock",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "traps",
}
    :component("scrap", 1)
    :quality_any({
            { id = "HAMMER_FINE", level = 1, count = 1 },
            { id = "WRENCH", level = 1, count = 1 }
        })
    :quality("SAW_M", 1, 1)
    :proficiency("prof_lockpicking", { required = false, time_multiplier = 2, learning_time_multiplier = 0, skill_penalty = 0.5 })
)

content.add(content.Recipe {
    id = "crude_picklock_from emergency",
    result = "crude_picklock",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "traps",
}
    :component("emergency_lockpick", 1)
    :quality_any({
            { id = "HAMMER_FINE", level = 1, count = 1 },
            { id = "WRENCH", level = 1, count = 1 }
        })
    :proficiency("prof_lockpicking", { required = false, time_multiplier = 2, learning_time_multiplier = 0, skill_penalty = 0.5 })
)

-- First item in the components list is serving as a torsion wrench. Many small flat items can be jammed in
-- and turned to apply torsion.  Second item in the list is the pick itself which has to be a small, bent bit
-- of wire or pin.
content.add(content.Recipe {
    id = "emergency_lockpick",
    result = "emergency_lockpick",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "traps",
}
    :component_any({
            { id = "hairpin", count = 1 },
            { id = "fc_hairpin", count = 1 },
            { id = "copper_hairpin", count = 1 },
            { id = "platinum_hairpin", count = 1 },
            { id = "gold_hairpin", count = 1 },
            { id = "silver_hairpin", count = 1 },
            { id = "knife_small", count = 1 },
            { id = "knife_butter", count = 1 },
            { id = "fork", count = 1 },
            { id = "any_wire", count = 1, requirement = true }
        })
    :component_any({
            { id = "hairpin", count = 1 },
            { id = "cable", count = 1 },
            { id = "any_wire", count = 1, requirement = true }
        })
    :proficiency("prof_lockpicking", { required = false, time_multiplier = 2, learning_time_multiplier = 0, skill_penalty = 0.5 })
)

content.add(content.Recipe {
    id = "shears",
    result = "shears",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("hotcut_any", 1, true)
    :component("plastic_chunk", 2)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("plastic_molding", 1)
    :requirement("steel_standard", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.25, learning_time_multiplier = 0.1 })
)

content.add(content.Recipe {
    id = "forged_shears",
    result = "forged_shears",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "bronze_shears",
    result = "bronze_shears",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("casting_mold", 1)
    :component("scrap_bronze", 5)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "steel_pan",
    result = "steel_pan",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "awl_bone",
    result = "awl_bone",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("bone_sturdy", 1, true)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "awl_steel",
    result = "awl_steel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("hotcut_any", 1, true)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "awl_steel_using_file",
    result = "awl_steel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 300000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("screwdriver", 1)
    :quality("FILE", 1, 1)
)

content.add(content.Recipe {
    id = "sewing_kit",
    result = "sewing_kit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component("scrap", 2)
    :component("plastic_chunk", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_scrap", 2)
    :requirement("plastic_molding", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "fishing_rod_basic",
    result = "fishing_rod_basic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
}
    :component("stick", 1)
    :component_any({
            { id = "fishing_hook_bone", count = 1 },
            { id = "fishing_hook_basic", count = 1 }
        })
    :requirement("cordage_fishing", 1)
)

content.add(content.Recipe {
    id = "hoboreel",
    result = "hoboreel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "wood_block", count = 1 }
        })
    :component_any({
            { id = "fishing_hook_bone", count = 1 },
            { id = "fishing_hook_basic", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requirement("cordage_fishing", 1)
    :requires_skill("survival", 4)
    :book("mag_survival", 4)
    :book("manual_survival", 4)
    :book("textbook_survival", 4)
)

content.add(content.Recipe {
    id = "churn",
    result = "churn",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 18)
    :component("nails", 14, true)
    :component("sheet_metal", 1)
    :component_any({
            { id = "simple_crank", count = 1 },
            { id = "foot_crank", count = 1 }
        })
    :component("sheet_metal_small", 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("cooking", 4)
    :book("family_cookbook", 4)
    :book("textbook_survival", 4)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "horse_bridle",
    result = "horse_bridle",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("leather", 8)
    :component("any_wire", 1, true)
    :requirement("sewing_standard", 40)
    :book("book_horse_tack", 2)
)

content.add(content.Recipe {
    id = "horse_tack",
    result = "horse_tack",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather", count = 30 },
            { id = "tanned_hide", count = 5 },
            { id = "fur", count = 30 },
            { id = "tanned_pelt", count = 5 }
        })
    :component("any_wire", 2, true)
    :requirement("sewing_standard", 100)
    :requirement("cordage", 2)
    :requires_skill("fabrication", 1)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :book("book_horse_tack", 4)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "jack_makeshift",
    result = "jack_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("pipe", 4)
    :component("scrap", 2)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("mechanics", 1)
    :book("manual_mechanics", 1)
    :book("manual_fabrication", 2)
    :book("textbook_fabrication", 2)
)

-- 50cm weld
content.add(content.Recipe {
    id = "jack_small",
    result = "jack_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("pipe", 4)
    :component("scrap", 2)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 50)
    :requires_skill("mechanics", 2)
    :book("manual_mechanics", 2)
    :book("manual_fabrication", 3)
    :book("textbook_fabrication", 3)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "press",
    result = "press",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("GRIND", 2, 1)
    :quality("WRENCH", 1, 1)
    :requirement("blacksmithing_standard", 28)
    :requirement("steel_standard", 7)
    :book("manual_shotgun", 2)
    :book("manual_rifle", 2)
    :book("manual_smg", 2)
    :book("manual_pistol", 3)
    :book("recipe_bullets", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "still",
    result = "still",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1200000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    disassembly_moves = 3000,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("material_sand", 1)
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 }
        })
    :component("cu_pipe", 1)
    :component("duct_tape", 10)
    :quality("DRILL", 2, 1)
    :quality("HAMMER", 2, 1)
    :requirement("glue_waterproof", 15)
    :requires_skill("chemistry", 3)
    :book("textbook_chemistry", 4)
    :book("distilling_cookbook", 3)
    :proficiency("prof_metalworking")
)

-- 150cm weld
content.add(content.Recipe {
    id = "electrolyzer_makeshift",
    result = "electrolyzer_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("pipe", 2)
    :component("sheet_metal_small", 12)
    :component("jar_3l_glass_sealed", 8)
    :component("lye", 16)
    :component("sheet_metal", 1)
    :component("cable", 134)
    :component("scrap", 16)
    :component("power_supply", 1)
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("welding_standard", 150)
    :requirement("soldering_standard", 5)
    :requires_skill("mechanics", 2)
    :requires_skill("electronics", 2)
    :book("adv_chemistry", 5)
    :book("recipe_labchem", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
    :proficiency("prof_plumbing")
    :proficiency("prof_appliance_repair")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_intro_chemistry")
)

-- 220cm weld
content.add(content.Recipe {
    id = "ammonia_machine_reactor",
    result = "ammonia_machine_reactor",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 7200000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 9,
}
    :component("large_pressure_vessel", 1)
    :component("pyrometer", 1)
    :component("hd_valve", 3)
    :component("pressure_gauge", 3)
    :component("sheet_metal_small", 4)
    :component("steel_grille", 16)
    :component_any({
            { id = "element", count = 16 },
            { id = "crude_heating_element", count = 24 }
        })
    :component("cable", 17)
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("welding_standard", 220)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 8)
    :requires_skill("chemistry", 6)
    :requires_skill("electronics", 3)
    :book("adv_chemistry", 7)
    :book("recipe_labchem", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
    :proficiency("prof_plumbing")
    :proficiency("prof_basic_engines")
    :proficiency("prof_appliance_repair")
    :proficiency("prof_high_pressure_systems")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :proficiency("prof_chemical_engineering")
)

-- 200cm weld
content.add(content.Recipe {
    id = "ammonia_machine_pipework",
    result = "ammonia_machine_pipework",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 7200000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 9,
}
    :component("hd_pipe", 18)
    :component("pipe", 4)
    :component("hd_pipe_fittings", 6)
    :component("hd_valve", 1)
    :component("pressure_gauge", 1)
    :component("pipe_fittings", 2)
    :component("metal_tank_little", 1)
    :component("small_pressure_vessel", 1)
    :component("sheet_metal_small", 6)
    :component("cable", 100)
    :component("hd_compressor", 3)
    :component_any({
            { id = "water", count = 12 },
            { id = "water_clean", count = 12 }
        })
    :component("power_supply", 1)
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("welding_standard", 200)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 8)
    :requires_skill("chemistry", 6)
    :requires_skill("electronics", 3)
    :book("adv_chemistry", 7)
    :book("recipe_labchem", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
    :proficiency("prof_plumbing")
    :proficiency("prof_basic_engines")
    :proficiency("prof_appliance_repair")
    :proficiency("prof_high_pressure_systems")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_intro_chem_synth")
    :proficiency("prof_chem_synth")
    :proficiency("prof_chemical_engineering")
)

-- 150cm weld
content.add(content.Recipe {
    id = "nitrogen_generator",
    result = "nitrogen_generator",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("pipe", 2)
    :component("hd_pipe", 2)
    :component("sheet_metal_small", 2)
    :component("cotton_patchwork", 2)
    :component("metal_tank", 1)
    :component("nitrogen_membrane_filter", 1)
    :component("cable", 4)
    :component("salt", 4000)
    :component("hd_compressor", 1)
    :component_any({
            { id = "filter_air", count = 1 },
            { id = "filter_air_makeshift", count = 1 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("welding_standard", 150)
    :requirement("soldering_standard", 5)
    :requires_skill("mechanics", 2)
    :requires_skill("electronics", 2)
    :book("adv_chemistry", 5)
    :book("recipe_labchem", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
    :proficiency("prof_plumbing")
    :proficiency("prof_basic_engines")
    :proficiency("prof_appliance_repair")
    :proficiency("prof_high_pressure_systems")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

-- Item disassembly based on reversible craft and manually defined uncraft integration. Read
-- ITEM_CRAFT_AND_DISASSEMBLY.md for more info.
-- 50cm weld
content.add(content.Recipe {
    id = "can_sealer",
    result = "can_sealer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "simple_crank", count = 1 },
            { id = "foot_crank", count = 1 }
        })
    :component("scrap", 8)
    :component("steel_chunk_any", 4, true)
    :component("steel_lump_any", 2, true)
    :quality("GRIND", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("welding_standard", 50)
    :requirement("blacksmithing_standard", 14)
    :requires_skill("mechanics", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "mortar_pestle",
    result = "mortar_pestle",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("rock", 2)
    :component("any_water", 1, true)
    :component_any({
            { id = "material_sand", count = 1 },
            { id = "material_gravel", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :quality("ANVIL", 1, 1)
    :requires_skill("survival", 2)
    :book("atomic_survival", 0)
    :book("textbook_survival", 0)
    :proficiency("prof_knapping")
)

content.add(content.Recipe {
    id = "chicken_cage",
    result = "chicken_cage",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("lc_wire", 4)
    :quality("SAW_M_FINE", 1, 1)
)

content.add(content.Recipe {
    id = "hobo_stove",
    result = "hobo_stove",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "survival",
    difficulty = 3,
}
    :component("can_medium", 1)
    :component("scrap", 3)
    :quality("SAW_M", 1, 1)
    :quality_any({
            { id = "DRILL", level = 1, count = 1 },
            { id = "LEATHER_AWL", level = 2, count = 1 }
        })
    :requires_skill("fabrication", 2)
    :book("mag_survival", 2)
    :book("textbook_survival", 1)
    :book("cookbook", 2)
)

-- 20cm weld
content.add(content.Recipe {
    id = "esbit_stove",
    result = "esbit_stove",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("scrap_aluminum", 5)
    :quality("SAW_M", 1, 1)
    :requirement("welding_alloys", 20)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "makeshift_axe",
    result = "makeshift_axe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    difficulty = 3,
}
    :quality("HAMMER", 1, 1)
    :requirement("steel_chunk_any", 1)
    :requires_skill("fabrication", 1)
)

content.add(content.Recipe {
    id = "tinderbox",
    result = "tinderbox",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component_any({
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
            { id = "canister_empty", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requires_skill("fabrication", 2)
    :book("mag_survival", 1)
    :book("textbook_survival", 1)
)

content.add(content.Recipe {
    id = "pot_makeshift",
    result = "pot_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("sheet_metal", 1)
    :quality("HAMMER", 2, 1)
)

content.add(content.Recipe {
    id = "pot_makeshift_copper",
    result = "pot_makeshift_copper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "surface_heat", charges = 10, requirement = true },
            { id = "forge", charges = 10 },
            { id = "oxy_torch", charges = 2 }
        })
    :component("copper_scrap_equivalent", 2, true)
    :quality("HAMMER", 2, 1)
)

content.add(content.Recipe {
    id = "ny_hook",
    result = "ny_hook",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :book("textbook_fireman", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "makeshift_crowbar",
    result = "makeshift_crowbar",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("pipe", 1)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "torch",
    result = "torch",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_cotton_patchwork", count = 1 }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 },
            { id = "torch_done", count = 1 }
        })
    :requirement("flammable_liquid", 100)
)

content.add(content.Recipe {
    id = "torch_pine",
    result = "torch",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :tool_charges("surface_heat", 7, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 },
            { id = "torch_done", count = 1 }
        })
    :component("pine_bough", 2)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :batch_discount(50, 5)
)

content.add(content.Recipe {
    id = "sieve_steel_makeshift",
    result = "sieve_steel_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("wire_mesh", 1)
    :component("lc_wire", 1)
)

content.add(content.Recipe {
    id = "sieve_primitive",
    result = "sieve_primitive",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "straw_pile", count = 3 },
            { id = "birchbark", count = 5 }
        })
    :requires_skill("survival", 1)
    :requires_skill("tailor", 2)
    :proficiency("prof_basketweaving")
)

-- 90cm weld
content.add(content.Recipe {
    id = "closed_loop_extractor_small",
    result = "closed_loop_extractor_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 5760000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_any({
            { id = "butane_tank", charges = 30 },
            { id = "butane_can", charges = 30 }
        })
    :component_any({
            { id = "jerrycan_big", count = 1 },
            { id = "metal_tank_little", count = 1 }
        })
    :component("pipe", 1)
    :component("hose", 3)
    :component("motor_micro", 1)
    :component("recovery_pump", 1)
    :component("metal_funnel", 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M", 2, 1)
    :quality("WRENCH", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("FILE", 2, 1)
    :requirement("welding_standard", 90)
    :requirement("blacksmithing_standard", 20)
    :requirement("steel_standard", 5)
    :requires_skill("mechanics", 3)
    :book("textbook_extraction", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

-- 110cm weld
content.add(content.Recipe {
    id = "closed_loop_extractor_large",
    result = "closed_loop_extractor_large",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_any({
            { id = "butane_tank", charges = 30 },
            { id = "butane_can", charges = 30 }
        })
    :component_any({
            { id = "30gal_drum", count = 1 },
            { id = "metal_tank", count = 1 }
        })
    :component("pipe", 3)
    :component("hose", 10)
    :component("motor_micro", 1)
    :component("recovery_pump", 1)
    :component("metal_funnel", 3)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M", 2, 1)
    :quality("WRENCH", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("FILE", 2, 1)
    :requirement("welding_standard", 110)
    :requirement("blacksmithing_standard", 40)
    :requirement("steel_standard", 10)
    :requires_skill("mechanics", 4)
    :book("textbook_extraction", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "oil_extractor_crude",
    result = "oil_extractor_crude",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("55gal_drum", 1)
    :component_any({
            { id = "pipe", count = 1 },
            { id = "stick_long", count = 1 },
            { id = "pointy_stick", count = 1 }
        })
    :component("water_faucet", 1)
    :component_any({
            { id = "duct_tape", count = 10 },
            { id = "gasket_plastic", count = 1 }
        })
    :quality("SAW_M", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("DRILL", 2, 1)
    :requires_skill("mechanics", 2)
    :book("textbook_extraction", 3)
)

-- 100cm weld
content.add(content.Recipe {
    id = "recovery_pump",
    result = "recovery_pump",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 4320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("pipe", 4)
    :component("hose", 2)
    :component("gasket_plastic", 2)
    :component("well_pump", 1)
    :quality("HAMMER", 3, 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M", 2, 1)
    :quality("WRENCH", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("FILE", 2, 1)
    :requirement("welding_standard", 100)
    :requirement("blacksmithing_standard", 5)
    :requires_skill("mechanics", 2)
    :book("textbook_extraction", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

-- Specifically avoids blacksmithing requirement groups so that it's craftable without itself - substitutes
-- metal fileset for metalworking chisel.
content.add(content.Recipe {
    id = "metal_file",
    result = "metal_file",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("scrap", 2)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("CHISEL", 3, 1)
    :requirement("forging_scrap", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

-- Specifically avoids blacksmithing requirement groups so that it's craftable without itself - substitutes
-- metal fileset for metalworking chisel.
content.add(content.Recipe {
    id = "bronze_file",
    result = "bronze_file",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("scrap_bronze", 2)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("CHISEL", 2, 1)
    :requirement("forging_scrap", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "gasket_plastic",
    result = "gasket_plastic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_charges("surface_heat", 5, true)
    :component("plastic_chunk", 1)
    :quality("CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("ANVIL", 1, 1)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "gasket_plastic_set",
    result = "gasket_plastic_set",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "fabrication",
}
    :component("gasket_plastic", 3)
    :book("textbook_extraction", 2)
)

content.add(content.Recipe {
    id = "dog_whistle_wood",
    result = "dog_whistle_wood",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :requires_skill("survival", 2)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "pipe_tobacco",
    result = "pipe_tobacco",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :component("cordage_short", 1, true)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "makeshift_hose_DIY_hose_from_leather",
    result = "makeshift_hose",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("leather", 2)
    :component("filament", 40, true)
    :quality("CUT", 2, 1)
    :quality("SEW", 2, 1)
    :requirement("glue_waterproof", 12)
    :requires_skill("survival", 3)
    :requires_skill("tailor", 4)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "kevlar_shears",
    result = "kevlar_shears",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "hotcut_any", charges = 1, requirement = true },
            { id = "metal_file_any", charges = 1, requirement = true }
        })
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_bladesmith", { required = false, time_multiplier = 2 })
)

content.add(content.Recipe {
    id = "magnifying_glass",
    result = "magnifying_glass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("plastic_chunk", 4)
    :component("lens", 1)
    :component("any_wire", 1, true)
    :requirement("soldering_standard", 10)
    :requirement("plastic_molding", 3)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "lens_crude",
    result = "lens_crude",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 5)
    :component_any({
            { id = "glass_shard", count = 1 },
            { id = "flask_glass", count = 1 },
            { id = "marble", count = 25 }
        })
    :quality("CHISEL", 3, 1)
    :book("glassblowing_book", 5)
    :proficiency("prof_glassblowing")
)

content.add(content.Recipe {
    id = "fire_piston",
    result = "fire_piston",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "forge", charges = 150 },
            { id = "oxy_torch", charges = 30 }
        })
    :component("2x4", 1)
    :component("cordage_short", 1, true)
    :component_any({
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
            { id = "canister_empty", count = 1 },
            { id = "clay_canister", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("DRILL", 1, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "improvised_oven",
    result = "improvised_oven",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("stock_pot", 1)
    :component("heavy_wire_rack", 1)
    :component_any({
            { id = "tin_plate", count = 1 },
            { id = "ceramic_plate", count = 1 },
            { id = "mess_tray", count = 1 }
        })
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "clay_dutch_oven",
    result = "clay_dutch_oven",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pot_canning_clay", 1)
    :component("clay_pot", 1)
    :component("fire_brick", 2)
    :component("clay_lump", 3)
    :proficiency("prof_pottery")
)

content.add(content.Recipe {
    id = "scissors",
    result = "scissors",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("hotcut_any", 1, true)
    :component("scrap", 1)
    :component("plastic_chunk", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_scrap", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_toolsmithing", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_bladesmith", { required = false, time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "makeshift_welding_blanket",
    result = "makeshift_welding_blanket",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("rock_wool_bat", 22)
    :requirement("sewing_aramids", 50)
    :requirement("adhesive", 4)
    :learn_automatically("tailor", 3)
    :book("welding_book", 1)
    :proficiency("prof_polymerworking", { required = false, time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "hair_dye_kit",
    result = "hair_dye_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("hairbrush", 1)
    :component("box_small", 1)
    :component("comb_pocket", 1)
    :component("gloves_medical", 1)
)

content.add(content.Recipe {
    id = "monkey_tool",
    result = "monkey_tool",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("lc_steel_lump", 1)
    :quality("DRILL", 3, 1)
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "nail_header",
    result = "nail_header",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "mc_steel_chunk", count = 1 },
            { id = "hc_steel_chunk", count = 1 }
        })
    :requirement("blacksmithing_standard", 1)
    :requirement("metal_punch", 1)
    :proficiency("prof_toolsmithing", { time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "nail_header_bronze",
    result = "nail_header_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "casting_mold_large", count = 1 },
            { id = "casting_mold_long", count = 1 }
        })
    :component("bronze_tiny", 2, true)
    :requirement("forging_standard", 1)
    :requirement("bronzesmithing_tools", 1)
    :requirement("bronze_punch", 1)
    :proficiency("prof_redsmithing")
)
