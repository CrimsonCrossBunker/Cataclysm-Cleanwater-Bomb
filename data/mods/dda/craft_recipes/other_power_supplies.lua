local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

-- 60cm weld
content.add(content.Recipe {
    id = "reinforced_solar_panel",
    result = "reinforced_solar_panel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("solar_panel", 1)
    :component("reinforced_glass_pane", 1)
    :component("scrap", 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 60)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 60cm weld
content.add(content.Recipe {
    id = "reinforced_solar_panel_v2",
    result = "reinforced_solar_panel_v2",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("solar_panel_v2", 1)
    :component("reinforced_glass_pane", 1)
    :component("scrap", 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 60)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 20cm weld
content.add(content.Recipe {
    id = "it_battery_mount",
    result = "it_battery_mount",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 1)
    :component("scrap", 2)
    :component("circuit", 1)
    :quality("HAMMER", 2, 1)
    :quality("GLARE", 1, 1)
    :requirement("welding_standard", 20)
    :requirement("soldering_standard", 10)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "it_handheld_battery_mount",
    result = "it_handheld_battery_mount",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("power_supply", 1)
    :component("scrap", 4)
    :component("cable", 4)
    :component("circuit", 1)
    :component_any({
            { id = "rope_6", count = 1 },
            { id = "rope_makeshift_6", count = 1 }
        })
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "UPS_OFF",
    result = "UPS_OFF",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 5,
}
    :component("power_supply", 4)
    :component("amplifier", 3)
    :component("scrap_aluminum", 4)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 24)
    :learn_by_disassembly("electronics", 4)
    :book("advanced_electronics", 4)
    :book("recipe_lab_elec", 4)
    :book("textbook_anarch", 4)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "recharge_station",
    result = "recharge_station",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("power_supply", 2)
    :component("processor", 2)
    :component("scrap", 5)
    :component("cable", 3)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 35)
    :learn_by_disassembly("electronics", 6)
    :book("textbook_mechanics", 7)
    :book("textbook_electronics", 6)
    :book("advanced_electronics", 6)
    :book("textbook_robots", 5)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "battery_charger",
    result = "battery_charger",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component("amplifier", 1)
    :component_any({
            { id = "plastic_chunk", count = 1 },
            { id = "duct_tape", count = 10 }
        })
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :learn_by_disassembly("electronics", 0)
    :learn_automatically("electronics", 2)
    :book("manual_electronics", 0)
    :book("mag_electronics", 1)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

-- 50cm weld
content.add(content.Recipe {
    id = "solarpack",
    result = "solarpack",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 300000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("power_supply", 2)
    :component("amplifier", 2)
    :component("solar_panel", 1)
    :component("cable", 7)
    :component("sheet_metal", 2)
    :component("rope_natural_short", 1, true)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("soldering_standard", 35)
    :requirement("welding_standard", 50)
    :requires_skill("fabrication", 2)
    :requires_skill("mechanics", 2)
    :learn_by_disassembly("electronics", 5)
    :book("manual_electronics", 7)
    :book("textbook_electronics", 6)
    :book("advanced_electronics", 6)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
    :byproduct("sheet_metal_small", 8)
    :byproduct("scrap", 8)
)

content.add(content.Recipe {
    id = "solar_panel",
    result = "solar_panel",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("power_supply", 2)
    :component("amplifier", 2)
    :component("solar_cell", 12)
    :component("cable", 7)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 35)
    :learn_by_disassembly("electronics", 5)
    :book("manual_electronics", 7)
    :book("textbook_electronics", 6)
    :book("advanced_electronics", 6)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "ground_solar_panel",
    result = "ground_solar_panel",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("solar_panel", 4)
    :component("cable", 7)
)

content.add(content.Recipe {
    id = "ground_solar_panel_v2",
    result = "ground_solar_panel_v2",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("solar_panel_v2", 4)
    :component("cable", 7)
)

content.add(content.Recipe {
    id = "wind_turbine",
    result = "wind_turbine",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "motor_small", count = 1 },
            { id = "alternator_bicycle", count = 1 },
            { id = "alternator_motorbike", count = 1 }
        })
    :component_any({
            { id = "2x4", count = 5 },
            { id = "frame_wood", count = 1 }
        })
    :component("sheet_metal_small", 3)
    :component("nails", 20, true)
    :component("pipe", 4)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("soldering_standard", 35)
    :requires_skill("electronics", 3)
    :learn_by_disassembly("fabrication", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

-- 100cm weld
content.add(content.Recipe {
    id = "xl_wind_turbine",
    result = "xl_wind_turbine",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "2x4", count = 30 },
            { id = "frame_wood", count = 4 }
        })
    :component("sheet_metal_small", 12)
    :component_any({
            { id = "motor_small", count = 4 },
            { id = "alternator_bicycle", count = 4 },
            { id = "alternator_motorbike", count = 4 },
            { id = "alternator_car", count = 2 },
            { id = "alternator_truck", count = 1 },
            { id = "motor", count = 2 },
            { id = "motor_large", count = 1 }
        })
    :component("nails", 120, true)
    :component("pipe", 20)
    :component("nuts_bolts", 50)
    :component("pipe_fittings", 10)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("WRENCH", 2, 1)
    :requirement("welding_standard", 100)
    :requirement("soldering_standard", 35)
    :requires_skill("electronics", 5)
    :learn_by_disassembly("fabrication", 2)
    :book("manual_electronics", 4)
    :book("textbook_electronics", 4)
    :book("advanced_electronics", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "water_wheel",
    result = "water_wheel",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "motor_small", count = 1 },
            { id = "alternator_bicycle", count = 1 },
            { id = "alternator_motorbike", count = 1 }
        })
    :component_any({
            { id = "2x4", count = 20 },
            { id = "frame_wood", count = 3 }
        })
    :component("sheet_metal_small", 6)
    :component("nails", 80, true)
    :component("pipe", 8)
    :component("wheel_wood_b", 2)
    :component("nuts_bolts", 20)
    :component("pipe_fittings", 3)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_W", 2, 1)
    :quality("WRENCH", 2, 1)
    :requirement("soldering_standard", 35)
    :requires_skill("electronics", 4)
    :learn_by_disassembly("fabrication", 3)
    :book("manual_electronics", 7)
    :book("textbook_electronics", 6)
    :book("advanced_electronics", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "water_wheel_with_power_saw",
    result = "water_wheel",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "motor_small", count = 1 },
            { id = "alternator_bicycle", count = 1 },
            { id = "alternator_motorbike", count = 1 }
        })
    :component_any({
            { id = "2x4", count = 20 },
            { id = "frame_wood", count = 3 }
        })
    :component("sheet_metal_small", 6)
    :component("nails", 80, true)
    :component("pipe", 8)
    :component("wheel_wood_b", 2)
    :component("nuts_bolts", 20)
    :component("pipe_fittings", 3)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("WRENCH", 2, 1)
    :requirement("soldering_standard", 35)
    :requirement("power_saw_short", 20)
    :requires_skill("electronics", 4)
    :learn_by_disassembly("fabrication", 3)
    :book("manual_electronics", 7)
    :book("textbook_electronics", 6)
    :book("advanced_electronics", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "xl_water_wheel",
    result = "xl_water_wheel",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "2x4", count = 50 },
            { id = "frame_wood", count = 9 }
        })
    :component("sheet_metal_small", 18)
    :component_any({
            { id = "motor_small", count = 3 },
            { id = "alternator_bicycle", count = 3 },
            { id = "alternator_motorbike", count = 3 },
            { id = "alternator_car", count = 2 },
            { id = "alternator_truck", count = 1 },
            { id = "motor", count = 2 },
            { id = "motor_large", count = 1 }
        })
    :component("nails", 240, true)
    :component("pipe", 24)
    :component("wheel_wood_b", 6)
    :component("nuts_bolts", 42)
    :component("pipe_fittings", 10)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_W", 2, 1)
    :requirement("soldering_standard", 85)
    :requires_skill("electronics", 6)
    :learn_by_disassembly("fabrication", 3)
    :book("manual_electronics", 7)
    :book("textbook_electronics", 6)
    :book("advanced_electronics", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "xl_water_wheel_with_power_saw",
    result = "xl_water_wheel",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "2x4", count = 50 },
            { id = "frame_wood", count = 9 }
        })
    :component("sheet_metal_small", 18)
    :component_any({
            { id = "motor_small", count = 3 },
            { id = "alternator_bicycle", count = 3 },
            { id = "alternator_motorbike", count = 3 },
            { id = "alternator_car", count = 2 },
            { id = "alternator_truck", count = 1 },
            { id = "motor", count = 2 },
            { id = "motor_large", count = 1 }
        })
    :component("nails", 240, true)
    :component("pipe", 24)
    :component("wheel_wood_b", 6)
    :component("nuts_bolts", 42)
    :component("pipe_fittings", 10)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("WRENCH", 2, 1)
    :requirement("soldering_standard", 85)
    :requirement("power_saw_short", 50)
    :requires_skill("electronics", 6)
    :learn_by_disassembly("fabrication", 3)
    :book("manual_electronics", 7)
    :book("textbook_electronics", 6)
    :book("advanced_electronics", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "solar_panel_v2",
    result = "solar_panel_v2",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 9,
}
    :component("power_supply", 2)
    :component("amplifier", 2)
    :component("solar_cell_v2", 12)
    :component("cable", 7)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 35)
    :learn_by_disassembly("electronics", 5)
    :book("manual_electronics", 7)
    :book("textbook_electronics", 6)
    :book("advanced_electronics", 6)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "large_storage_battery",
    result = "large_storage_battery",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("storage_battery", 2)
    :component("e_scrap", 4)
    :component("scrap", 8)
    :component("cable", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("fabrication", 4)
    :learn_by_disassembly("electronics", 3)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 3)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "medium_storage_battery",
    result = "medium_storage_battery",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 3,
}
    :component("small_storage_battery", 10)
    :component("e_scrap", 4)
    :component("scrap", 8)
    :component("cable", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("fabrication", 2)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 3)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "storage_battery_from_medium",
    result = "storage_battery",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 3,
}
    :component("medium_storage_battery", 5)
    :component("e_scrap", 4)
    :component("scrap", 8)
    :component("cable", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("fabrication", 3)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 3)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "storage_battery",
    result = "storage_battery",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 3,
}
    :component("small_storage_battery", 50)
    :component("e_scrap", 16)
    :component("scrap", 32)
    :component("cable", 7)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 80)
    :requires_skill("fabrication", 3)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 3)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "hand_crank_charger",
    result = "hand_crank_charger",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 5)
    :component("power_supply", 1)
    :component("e_scrap", 3)
    :component("scrap", 3)
    :component("motor_micro", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("surface_heat", 10)
    :requirement("glue_strong", 5)
    :requires_skill("electronics", 3)
    :learn_by_disassembly("fabrication", 3)
    :book("textbook_robots", 4)
    :book("mag_electronics", 3)
    :book("mag_mechanics", 3)
    :book("textbook_electronics", 3)
    :book("textbook_fabrication", 3)
    :book("manual_fabrication", 4)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "condensor_coil",
    result = "condensor_coil",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 4,
}
    :component("compressor", 1)
    :component("cu_pipe", 3)
    :component("motor_micro", 1)
    :component("sheet_metal_small", 5)
    :component_any({
            { id = "scrap", count = 12 },
            { id = "steel_chunk_any", count = 4, requirement = true }
        })
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 2, 1)
    :requirement("soldering_standard", 10)
    :book("textbook_mechanics", 5)
)

content.add(content.Recipe {
    id = "evaporator_coil",
    result = "evaporator_coil",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 4,
}
    :component("cu_pipe", 4)
    :component("sheet_metal_small", 8)
    :component("sheet_metal", 2)
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 2, 1)
    :requirement("soldering_standard", 50)
    :book("textbook_mechanics", 5)
)

content.add(content.Recipe {
    id = "light_minus_disposable_cell",
    result = "light_minus_disposable_cell",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("chem_manganese_dioxide", 29)
    :component("zinc_metal", 8)
    :component_any({
            { id = "chem_potassium_hydroxide", count = 7 },
            { id = "lye_powder", count = 2 }
        })
    :component("duct_tape", 1)
    :component("water_clean", 1)
    :component_any({
            { id = "steel_chunk_any", count = 1, requirement = true },
            { id = "scrap", count = 2 }
        })
    :requirement("blacksmithing_standard", 1)
    :requires_skill("electronics", 5)
    :book("adv_chemistry", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
)

content.add(content.Recipe {
    id = "5l_methanol_tank",
    result = "5l_methanol_tank",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "mechanics",
}
    :tool("syringe", 1)
    :component("5l_methanol_tank", 1)
    :component("chem_methanol", 5000)
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "10l_methanol_tank",
    result = "10l_methanol_tank",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1920000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "mechanics",
}
    :tool("syringe", 1)
    :component("10l_methanol_tank", 1)
    :component("chem_methanol", 10000)
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "28l_methanol_tank",
    result = "28l_methanol_tank",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5376000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "mechanics",
}
    :tool("syringe", 1)
    :component("28l_methanol_tank", 1)
    :component("chem_methanol", 28000)
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "60l_methanol_tank",
    result = "60l_methanol_tank",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 11520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "mechanics",
}
    :tool("syringe", 1)
    :component("60l_methanol_tank", 1)
    :component("chem_methanol", 60000)
    :proficiency("prof_intro_chemistry")
)

content.add(content.Recipe {
    id = "carbon_electrode",
    result = "carbon_electrode",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("tongs", 1)
    :tool_charges("surface_heat", 10, true)
    :tool_any({
            { id = "paper", count = 1 },
            { id = "aluminum_foil", count = 1 }
        })
    :component("water_clean", 1)
    :component("sugar", 2)
    :component("charcoal", 3)
    :quality("BOIL", 2, 1)
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :requires_skill("chemistry", 2)
    :proficiency("prof_intro_chemistry")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "cathod_mix",
    result = "cathod_mix",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
}
    :component("chem_muriatic_acid", 1)
    :component("chem_zinc_powder", 200)
    :component("chem_manganese_dioxide", 262)
    :quality("CONTAIN", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(1000)
)
