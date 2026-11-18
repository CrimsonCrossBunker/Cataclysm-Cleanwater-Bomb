local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "spike",
    result = "spike",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 100,
    reversible = true,
    skill = "fabrication",
}
    :component("steel_chunk_any", 1, true)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "pilot_light",
    result = "pilot_light",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap", 3)
    :component("cable", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("mechanics", 2)
    :book("carpentry_book", 5)
)

content.add(content.Recipe {
    id = "clamp",
    result = "clamp",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :component("scrap", 4)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "spring",
    result = "spring",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

content.add(content.Recipe {
    id = "spring_medium",
    result = "spring_medium",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :requirement("spring_standard", 2)
    :book("reference_fabrication1", 2)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "spring_small",
    result = "spring_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :requirement("spring_standard", 1)
    :book("reference_fabrication1", 2)
    :proficiency("prof_metalworking")
)

-- The components require far more copper wire than the materials equal out to, this is to indicate the trial
-- and error process of finding the right frequency to make an antenna
content.add(content.Recipe {
    id = "antenna",
    result = "antenna",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 2,
}
    :tool_any({
            { id = "two_way_radio", charges = 25 },
            { id = "radiocontrol", charges = 25 }
        })
    :component("cable", 7)
    :quality("WRENCH", 1, 1)
    :book("radio_book", 1)
    :book("textbook_anarch", 1)
    :book("mag_electronics", 1)
)

content.add(content.Recipe {
    id = "directional_antenna",
    result = "directional_antenna",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component("amplifier", 1)
    :component("antenna", 1)
    :component("2x4", 2)
    :component("nails", 12, true)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :learn_by_disassembly("electronics", 3)
    :book("radio_book", 3)
    :book("textbook_anarch", 5)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "amplifier",
    result = "amplifier",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component("circuit", 1)
    :component("e_scrap", 3)
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 4)
    :learn_by_disassembly("electronics", 1)
    :book("radio_book", 3)
    :book("manual_electronics", 1)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "power_supply",
    result = "power_supply",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 39000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 1,
}
    :component("amplifier", 2)
    :component("cable", 7)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 3)
    :book("manual_electronics", 1)
    :book("textbook_electronics", 2)
    :book("advanced_electronics", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "crude_heating_element",
    result = "crude_heating_element",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :requires_skill("electronics", 1)
    :learn_automatically("electronics", 3)
    :book("manual_electronics", 1)
    :book("textbook_electronics", 1)
    :book("advanced_electronics", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "receiver",
    result = "receiver",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 72000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("circuit", 2)
    :component("e_scrap", 5)
    :component("cable", 1)
    :component("amplifier", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 4)
    :learn_by_disassembly("electronics", 2)
    :book("manual_electronics", 1)
    :book("radio_book", 1)
    :book("textbook_electronics", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "transponder",
    result = "transponder",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 84000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("circuit", 3)
    :component("e_scrap", 7)
    :component("cable", 1)
    :component("amplifier", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 7)
    :learn_by_disassembly("electronics", 3)
    :book("manual_electronics", 1)
    :book("textbook_electronics", 2)
    :book("textbook_anarch", 3)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "blade",
    result = "blade",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("swage", 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "chain",
    result = "chain",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 3120000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("hotcut_any", 1, true)
    :requirement("blacksmithing_standard", 32)
    :requirement("steel_standard", 8)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "blade_scythe",
    result = "blade_scythe",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("steel_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "stopcock",
    result = "stopcock",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :requirement("plastic_molding", 1)
    :book("plastics_book", 3)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "sheet_metal",
    result = "sheet_metal",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :requirement("blacksmithing_standard", 24)
    :requirement("lc_steel_standard", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

-- 5x5 grid of 20 cm square sheets combined into one big sheet = 800cm of weld. ouch!
content.add(content.Recipe {
    id = "sheet_metal_welding",
    result = "sheet_metal",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 810000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal_small", 25)
    :requirement("welding_standard", 800)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 60cm weld
content.add(content.Recipe {
    id = "xlframe",
    result = "xlframe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 72000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "material_aluminium_ingot", count = 7 },
            { id = "scrap_aluminum", count = 34 }
        })
    :requirement("welding_alloys", 60)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "motor_micro",
    result = "motor_micro",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 126000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("e_scrap", 1)
    :component("scrap", 1)
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 3)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "motor_tiny",
    result = "motor_tiny",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("cable", 10)
    :component("e_scrap", 3)
    :component("scrap", 1)
    :component("bearing", 4)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 5)
    :requirement("steel_chunk_any", 1)
    :requirement("welding_standard", 2)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 2)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "motor_small",
    result = "motor_small",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("e_scrap", 15)
    :component("cable", 173)
    :component("pipe", 1)
    :component("bearing", 10)
    :component("sheet_metal_small", 4)
    :quality("HAMMER", 1, 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requirement("steel_standard", 1)
    :requirement("welding_standard", 2)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 2)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "copper_rod",
    result = "copper_rod",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("swage", 1)
    :tool_any({
            { id = "forge", charges = 10 },
            { id = "oxy_torch", charges = 10 }
        })
    :component("copper_scrap_equivalent", 4, true)
    :quality("ANVIL", 1, 1)
    :quality("HAMMER", 2, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :result_charges(1)
)

-- Requires annealing 4 times from the copper rod.
content.add(content.Recipe {
    id = "copper_wire_draw_plate",
    result = "copper_wire",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 192000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_charges("hotcut_any", 1, true)
    :tool_any({
            { id = "forge", charges = 40 },
            { id = "oxy_torch", charges = 40 }
        })
    :tool("draw_plate", 1)
    :component("copper_rod", 1)
    :quality("ANVIL", 1, 1)
    :quality("HAMMER", 2, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_wiremaking")
    :result_charges(182)
)

-- Requires annealing 4 times from the copper rod.
content.add(content.Recipe {
    id = "copper_wire_wire_draw_machine",
    result = "copper_wire",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_charges("hotcut_any", 1, true)
    :tool_any({
            { id = "forge", charges = 40 },
            { id = "oxy_torch", charges = 40 }
        })
    :tool_charges("wire_draw_machine", 100)
    :component("copper_rod", 1)
    :quality("ANVIL", 1, 1)
    :quality("HAMMER", 2, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_wiremaking")
    :result_charges(182)
)

content.add(content.Recipe {
    id = "cable",
    result = "cable",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_COMPONENTS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("copper_wire", 2)
    :component("duct_tape", 1)
    :quality("CUT", 2, 1)
    :requires_skill("electronics", 2)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "remotevehcontrol",
    result = "remotevehcontrol",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 7,
}
    :component("e_scrap", 5)
    :component("amplifier", 1)
    :component("receiver", 1)
    :component("antenna", 1)
    :component("processor", 1)
    :component("RAM", 1)
    :component("small_lcd_screen", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 14)
    :requires_skill("computer", 2)
    :book("recipe_lab_elec", 5)
    :book("textbook_robots", 5)
    :proficiency("prof_elec_soldering")
)

-- 50cm weld to graft all the extra stuff to it
content.add(content.Recipe {
    id = "drive_by_wire_controls",
    result = "drive_by_wire_controls",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 8,
}
    :component("vehicle_controls", 1)
    :component("motor_tiny", 3)
    :component("receiver", 3)
    :component("processor", 3)
    :component("RAM", 3)
    :component("circuit", 3)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 30)
    :requirement("welding_standard", 50)
    :requires_skill("electronics", 4)
    :book("textbook_mechanics", 8)
    :book("textbook_robots", 7)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "electronics_controls",
    result = "electronics_controls",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("e_scrap", 5)
    :component("amplifier", 1)
    :component("cable", 2)
    :component("plastic_chunk", 5)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 40)
    :requires_skill("mechanics", 1)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "camera_control",
    result = "camera_control",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("small_lcd_screen", 10)
    :component("processor", 3)
    :component("RAM", 2)
    :component("cable", 7)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 150)
    :requires_skill("computer", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "omnicamera",
    result = "omnicamera",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 7,
}
    :component("lens", 4)
    :component("e_scrap", 10)
    :component("amplifier", 4)
    :component("cable", 7)
    :component("plastic_chunk", 5)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 50)
    :requirement("plastic_molding", 3)
    :requires_skill("computer", 3)
    :book("textbook_electronics", 6)
    :book("advanced_electronics", 6)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "omnicamera_from-cameras",
    result = "omnicamera",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 5,
}
    :component_any({
            { id = "camera", count = 2 },
            { id = "camera_pro", count = 2 },
            { id = "smart_phone", count = 2 }
        })
    :component("power_supply", 1)
    :component("cable", 2)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("computer", 1)
    :proficiency("prof_elec_soldering")
)

-- 20cm weld
content.add(content.Recipe {
    id = "omnicamera_reinforced",
    result = "omnicamera_reinforced",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 360000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("omnicamera", 1)
    :component_any({
            { id = "mc_wire", count = 4 },
            { id = "hc_wire", count = 4 },
            { id = "ch_wire", count = 4 },
            { id = "qt_wire", count = 4 }
        })
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 20)
    :requirement("glue_strong", 4)
    :book("textbook_fabrication", 3)
    :book("textbook_mechanics", 3)
    :book("welding_book", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "beeper",
    result = "beeper",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 66000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("amplifier", 1)
    :component("scrap_aluminum", 2)
    :component("cable", 2)
    :component("plastic_chunk", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 6)
    :learn_by_disassembly("electronics", 2)
    :book("mag_electronics", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "electrolysis_kit",
    result = "electrolysis_kit",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component_any({
            { id = "cable", count = 17 },
            { id = "jumper_cable", count = 1 }
        })
    :component("scrap", 2)
    :quality("CUT", 2, 1)
    :requirement("soldering_standard", 10)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "water_faucet",
    result = "water_faucet",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("pipe", 1)
    :component("scrap", 1)
    :component("plastic_chunk", 1)
    :component("pipe_fittings", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("mechanics", 1)
    :book("carpentry_book", 5)
    :book("101_carpentry", 4)
    :proficiency("prof_metalworking", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_plumbing", { required = false, time_multiplier = 3, skill_penalty = 0.5 })
)

-- 200cm weld total
content.add(content.Recipe {
    id = "cargo_rack",
    result = "cargo_rack",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("frame", 4)
    :component_any({
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 12 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("rope_natural", 4)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 20cm weld
content.add(content.Recipe {
    id = "muffler",
    result = "muffler",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 1,
}
    :component("pipe", 2)
    :component("sheet_metal_small", 5)
    :component("pipe_fittings", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 20)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 20cm weld
content.add(content.Recipe {
    id = "seat",
    result = "seat",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 120000,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 4)
    :component("spring_medium", 2)
    :component_any({
            { id = "nylon", count = 20 },
            { id = "sheet_nylon", count = 3 }
        })
    :component("pipe_fittings", 4)
    :requirement("sewing_standard", 50)
    :requirement("welding_standard", 20)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 20cm weld
content.add(content.Recipe {
    id = "seat_leather",
    result = "seat_leather",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 120000,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 4)
    :component("spring_medium", 2)
    :component_any({
            { id = "leather", count = 12 },
            { id = "fur", count = 12 },
            { id = "tanned_hide", count = 3 },
            { id = "tanned_pelt", count = 3 }
        })
    :component("pipe_fittings", 4)
    :component("nylon", 8)
    :requirement("sewing_standard", 50)
    :requirement("welding_standard", 20)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

-- 20cm weld
content.add(content.Recipe {
    id = "seat_bench",
    result = "seat_bench",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 120000,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 4)
    :component("spring_medium", 2)
    :component_any({
            { id = "nylon", count = 20 },
            { id = "sheet_nylon", count = 3 }
        })
    :component("pipe_fittings", 4)
    :requirement("sewing_standard", 50)
    :requirement("welding_standard", 20)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 20cm weld
content.add(content.Recipe {
    id = "seat_bench_leather",
    result = "seat_bench_leather",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 120000,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 4)
    :component("spring_medium", 2)
    :component_any({
            { id = "leather", count = 12 },
            { id = "fur", count = 12 },
            { id = "tanned_hide", count = 3 },
            { id = "tanned_pelt", count = 3 }
        })
    :component("pipe_fittings", 4)
    :component("nylon", 8)
    :requirement("sewing_standard", 50)
    :requirement("welding_standard", 20)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

-- 80cm weld
content.add(content.Recipe {
    id = "vehicle_controls",
    result = "vehicle_controls",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 3,
}
    :component("pipe", 6)
    :component_any({
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 12 }
        })
    :component("any_wire", 3, true)
    :component("cable", 4)
    :component("pipe_fittings", 4)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 80)
    :book("textbook_fabrication", 5)
    :book("textbook_mechanics", 3)
    :book("manual_mechanics", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "radio_repeater_mod",
    result = "radio_repeater_mod",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("processor", 1)
    :component("scrap", 2)
    :component("any_wire", 5, true)
    :component("power_supply", 2)
    :component("transponder", 1)
    :component("e_scrap", 2)
    :component("amplifier", 2)
    :component("cable", 1)
    :component("battery_car", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 15)
    :requires_skill("electronics", 5)
    :learn_by_disassembly("fabrication", 4)
    :book("repeater_mod_guide", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "radio_mod",
    result = "radio_mod",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component("antenna", 1)
    :component("pilot_light", 1)
    :component_any({
            { id = "light_minus_battery_cell", count = 1 },
            { id = "light_minus_disposable_cell", count = 1 },
            { id = "light_battery_cell", count = 1 }
        })
    :component("amplifier", 1)
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("fabrication", 2)
    :book("advanced_electronics", 3)
    :book("textbook_electronics", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "radio_car_wheel",
    result = "radio_car_wheel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("chunk_rubber", 8)
    :component("wheel_caster", 1)
    :quality("FILE", 1, 1)
    :quality("CUT", 2, 1)
    :quality("SAW_M", 1, 1)
    :requirement("surface_heat", 10)
    :requirement("glue_any", 1)
    :proficiency("prof_plasticworking", { time_multiplier = 1.25, skill_penalty = 0.125 })
    :byproduct("scrap", 2)
)

content.add(content.Recipe {
    id = "sharp_rock",
    result = "sharp_rock",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("rock_flaking", 1)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_knapping", { time_multiplier = 1.25, skill_penalty = 0.1 })
)

content.add(content.Recipe {
    id = "rock",
    result = "rock",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("field_stone", 1)
    :quality("HAMMER", 1, 1)
    :result_charges(3)
    :byproduct("pebble", 9)
)

content.add(content.Recipe {
    id = "nuts_bolts",
    result = "nuts_bolts",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 2, 1)
    :quality("THREAD_CUT", 2, 1)
    :quality("THREAD_TAP", 2, 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 2)
    :book("textbook_fabrication", 3)
    :book("manual_mechanics", 3)
    :book("manual_fabrication", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :batch_discount(25, 2)
    :result_charges(1)
)
