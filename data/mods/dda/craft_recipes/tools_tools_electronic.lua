local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "crude_firestarter",
    result = "crude_firestarter",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component_any({
            { id = "any_wire", count = 3, requirement = true },
            { id = "cable", count = 30 }
        })
    :component("scrap", 2)
    :quality("HAMMER", 1, 1)
)

content.add(content.Recipe {
    id = "welder_crude",
    result = "welder_crude",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("power_supply", 4)
    :component("scrap", 2)
    :component("cable", 9)
    :component("plastic_chunk", 1)
    :component("duct_tape", 60)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :learn_by_disassembly("electronics", 2)
    :learn_automatically("mechanics", 3)
    :learn_automatically("electronics", 2)
    :book("manual_mechanics", 3)
    :book("textbook_mechanics", 2)
    :book("welding_book", 1)
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding", { time_multiplier = 1.1, learning_time_multiplier = 0.25, skill_penalty = 0.1 })
)

content.add(content.Recipe {
    id = "food_processor",
    result = "food_processor",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("scrap", 4)
    :component("cable", 1)
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 }
        })
    :component("motor_tiny", 1)
    :component("e_scrap", 1)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 3, 1)
    :requirement("soldering_standard", 20)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "noise_emitter_radio-mod",
    result = "noise_emitter",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 1,
}
    :component_any({
            { id = "radio", count = 1 },
            { id = "two_way_radio", count = 1 },
            { id = "talking_doll", count = 1 },
            { id = "creepy_doll", count = 1 },
            { id = "stereo", count = 1 },
            { id = "chimes", count = 1 },
            { id = "beeper", count = 1 }
        })
    :component("amplifier", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :book("radio_book", 1)
    :book("textbook_anarch", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "noise_emitter",
    result = "noise_emitter",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("amplifier", 2)
    :component("antenna", 1)
    :component("scrap_aluminum", 5)
    :component("cable", 3)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :book("textbook_anarch", 2)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "radio",
    result = "radio",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("receiver", 1)
    :component("antenna", 1)
    :component("scrap_aluminum", 5)
    :component("cable", 3)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :book("radio_book", 2)
    :book("textbook_anarch", 3)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "water_purifier",
    result = "water_purifier",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 3,
}
    :component_any({
            { id = "element", count = 8 },
            { id = "crude_heating_element", count = 8 }
        })
    :component_any({
            { id = "bottle_glass", count = 2 },
            { id = "plastic_bottles_4l", count = 2, requirement = true }
        })
    :component_any({
            { id = "hose", count = 1 },
            { id = "makeshift_hose", count = 1 }
        })
    :component("scrap", 3)
    :component("cable", 2)
    :quality("SCREW", 1, 1)
    :requires_skill("electronics", 1)
    :learn_by_disassembly("mechanics", 2)
    :book("advanced_electronics", 3)
    :book("manual_electronics", 2)
)

content.add(content.Recipe {
    id = "two_way_radio",
    result = "two_way_radio",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 4,
}
    :component("amplifier", 1)
    :component("transponder", 1)
    :component("receiver", 1)
    :component("antenna", 1)
    :component("scrap_aluminum", 5)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 14)
    :learn_by_disassembly("electronics", 4)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "electrohack",
    result = "electrohack",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 210000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :tool("laptop", 1)
    :component("processor", 1)
    :component("RAM", 1)
    :component("scrap_aluminum", 4)
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 4)
    :book("textbook_anarch", 3)
    :book("advanced_electronics", 5)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_integrated_circuits")
)

content.add(content.Recipe {
    id = "soldering_iron",
    result = "soldering_iron",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 1,
}
    :component_any({
            { id = "e_scrap", count = 2 },
            { id = "glowplug", count = 1 }
        })
    :component_any({
            { id = "copper", count = 1 },
            { id = "nails", count = 1, requirement = true },
            { id = "any_wire", count = 1, requirement = true }
        })
    :component("scrap", 1)
    :component("duct_tape", 10)
    :component("cable", 2)
    :quality("CUT", 2, 1)
    :quality("SCREW", 1, 1)
    :learn_by_disassembly("electronics", 0)
    :learn_automatically("electronics", 2)
    :book("manual_electronics", 1)
    :book("advanced_electronics", 2)
    :book("textbook_anarch", 2)
    :proficiency("prof_elec_soldering", { skill_penalty = 0.125 })
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "soldering_iron_portable",
    result = "soldering_iron_portable",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 72000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("soldering_iron", 1)
    :component("e_scrap", 1)
    :component("scrap", 1)
    :component("cable", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :learn_by_disassembly("electronics", 0)
    :learn_automatically("electronics", 2)
    :book("manual_electronics", 1)
    :book("advanced_electronics", 1)
    :book("textbook_anarch", 1)
    :proficiency("prof_elec_soldering", { skill_penalty = 0.125 })
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "hotplate",
    result = "hotplate",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component_any({
            { id = "element", count = 4 },
            { id = "crude_heating_element", count = 4 }
        })
    :component("amplifier", 1)
    :component_any({
            { id = "scrap_aluminum", count = 2 },
            { id = "pan", count = 1 },
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "knife_huge", count = 2 },
            { id = "knife_small", count = 6 },
            { id = "knife_butter", count = 6 },
            { id = "muffler", count = 1 }
        })
    :component("cable", 4)
    :quality("SCREW", 1, 1)
    :learn_by_disassembly("electronics", 2)
    :book("advanced_electronics", 1)
    :book("mag_electronics", 3)
    :book("manual_electronics", 2)
    :proficiency("prof_plasticworking", { time_multiplier = 1.5 })
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "coffeemaker",
    result = "coffeemaker",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component_any({
            { id = "element", count = 4 },
            { id = "crude_heating_element", count = 4 }
        })
    :component("amplifier", 1)
    :component_any({
            { id = "wire_mesh", count = 1 },
            { id = "cotton_patchwork", count = 1 }
        })
    :component_any({
            { id = "scrap", count = 2 },
            { id = "pan", count = 1 },
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "knife_huge", count = 2 },
            { id = "knife_small", count = 6 },
            { id = "knife_butter", count = 6 },
            { id = "muffler", count = 1 }
        })
    :component("cable", 5)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :learn_by_disassembly("electronics", 2)
    :book("advanced_electronics", 1)
    :book("mag_electronics", 3)
    :book("manual_electronics", 2)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "dehydrator",
    result = "dehydrator",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component_any({
            { id = "element", count = 2 },
            { id = "crude_heating_element", count = 2 }
        })
    :component("amplifier", 2)
    :component("power_supply", 1)
    :component("cable", 4)
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 }
        })
    :component("plastic_chunk", 18)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 20)
    :learn_by_disassembly("electronics", 4)
    :book("textbook_electronics", 3)
    :book("advanced_electronics", 3)
    :book("textbook_chemistry", 5)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "vibrator",
    result = "vibrator",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("scrap", 1)
    :component("plastic_chunk", 3)
    :component("cable", 2)
    :component("motor_micro", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 5)
    :requirement("plastic_molding", 2)
    :requirement("glue_waterproof", 4)
    :requires_skill("electronics", 1)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "makeshift_sealer",
    result = "makeshift_sealer",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component("scrap_aluminum", 4)
    :component("plastic_chunk", 2)
    :component("motor_micro", 1)
    :component_any({
            { id = "element", count = 2 },
            { id = "crude_heating_element", count = 2 }
        })
    :component("hose", 1)
    :component("power_supply", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("glue_any", 2)
    :requires_skill("mechanics", 2)
    :book("advanced_electronics", 4)
    :book("mag_electronics", 6)
    :book("manual_electronics", 5)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "makeshift_vacuum_mold",
    result = "makeshift_vacuum_mold",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 4,
}
    :component("2x4", 4)
    :component("plastic_chunk", 2)
    :component("motor_micro", 1)
    :component("nails", 16, true)
    :component("wood_panel", 1)
    :component("hose", 1)
    :component("power_supply", 1)
    :quality("VISE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_W", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("electronics", 2)
    :book("theater_props", 3)
    :book("manual_mechanics", 5)
    :book("manual_electronics", 5)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_soldering")
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "elec_hairtrimmer",
    result = "elec_hairtrimmer",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("razor_blade", 1)
    :component("motor_micro", 1)
    :component("power_supply", 1)
    :component("plastic_chunk", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("plastic_molding", 1)
    :requires_skill("electronics", 1)
    :book("advanced_electronics", 4)
    :book("textbook_electronics", 3)
    :book("textbook_fabrication", 3)
    :book("manual_fabrication", 4)
    :proficiency("prof_plasticworking", { time_multiplier = 1.5 })
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "electric_spinwheel",
    result = "electric_spinwheel",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("plastic_chunk", 10)
    :component("scrap", 1)
    :component_any({
            { id = "glue_strong", count = 5 },
            { id = "duct_tape", count = 10 }
        })
    :component("string_36", 4)
    :component("motor_micro", 1)
    :component("e_scrap", 1)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 3, 1)
    :requirement("soldering_standard", 20)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
)

content.add(content.Recipe {
    id = "radiocontrol",
    result = "radiocontrol",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 5,
}
    :component("e_scrap", 5)
    :component("amplifier", 1)
    :component("antenna", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :book("recipe_lab_elec", 5)
    :book("textbook_robots", 5)
)

content.add(content.Recipe {
    id = "radio_car",
    result = "radio_car",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 3150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 6,
}
    :component("antenna", 1)
    :component("motor_micro", 2)
    :component("amplifier", 2)
    :component("receiver", 1)
    :component("plastic_chunk", 12)
    :component("scrap_aluminum", 4)
    :component("e_scrap", 2)
    :component("cable", 3)
    :component("spring_small", 2)
    :component("radio_car_wheel", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("CUT", 2, 1)
    :requirement("soldering_standard", 10)
    :requirement("plastic_molding", 8)
    :requirement("glue_any", 1)
    :requires_skill("mechanics", 4)
    :requires_skill("fabrication", 6)
    :learn_by_disassembly("electronics", 5)
    :book("textbook_electronics", 7)
    :book("textbook_robots", 6)
    :proficiency("prof_plasticworking", { time_multiplier = 1.5 })
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "ketene_lamp",
    result = "ketene_lamp",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("pipe", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_charges("forge", 150)
    :component("glass_shard", 8)
    :component("plastic_chunk", 10)
    :component_any({
            { id = "element", count = 1 },
            { id = "crude_heating_element", count = 1 }
        })
    :component("cable", 4)
    :quality("CHISEL", 3, 1)
    :requirement("plastic_molding", 7)
    :requirement("soldering_standard", 5)
    :requires_skill("chemistry", 5)
    :requires_skill("electronics", 2)
    :book("adv_chemistry", 5)
    :book("textbook_chemistry", 6)
    :book("recipe_labchem", 5)
    :book("atomic_survival", 5)
    :proficiency("prof_glassblowing")
    :proficiency("prof_plasticworking")
)

-- 30cm weld
content.add(content.Recipe {
    id = "wire_draw_machine",
    result = "wire_draw_machine",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("motor_small", 1)
    :component("jerrycan", 1)
    :component("sheet_metal_small", 4)
    :component("scrap", 5)
    :component("draw_plate", 1)
    :component("cable", 4)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 30)
    :requires_skill("mechanics", 2)
    :requires_skill("electronics", 1)
    :proficiency("prof_welding_basic")
)

content.add(content.Recipe {
    id = "noise_emitter_super",
    result = "noise_emitter_super",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 3,
}
    :component_any({
            { id = "noise_emitter", count = 1 },
            { id = "horn_big", count = 1 }
        })
    :component("amplifier", 4)
    :component("power_supply", 2)
    :component("e_scrap", 5)
    :component("amplifier_head", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 15)
    :book("radio_book", 2)
    :book("textbook_anarch", 3)
    :proficiency("prof_elec_soldering")
)
