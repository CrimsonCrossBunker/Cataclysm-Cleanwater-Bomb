local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "fcl_mealgrub_medium_simple",
    result = "fcl_mealgrub_medium",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
    flags = { "BLIND_HARD", "ALLOW_ROTTEN", "NUTRIENT_OVERRIDE" },
}
    :tool_charges("surface_heat", 10, true)
    :component_any({
            { id = "water", count = 6 },
            { id = "water_clean", count = 6 }
        })
    :component_any({
            { id = "meal_bone", count = 2 },
            { id = "meal_chitin_piece", count = 1 }
        })
    :component_any({
            { id = "fertilizer_liquid", count = 1 },
            { id = "fertilizer_commercial", count = 1 }
        })
    :component("any_fat", 2, true)
    :quality("BOIL", 1, 1)
    :quality("CHEM", 2, 1)
    :quality("CUT", 2, 1)
    :book("fcl_bugbrew_book", 1)
    :batch_discount(80, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "brew_fcl_mealgrub_broth_simple",
    result = "brew_fcl_mealgrub_broth",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 0,
    flags = { "BLIND_HARD" },
}
    :component("fcl_mealgrub_spores", 1)
    :component("fcl_mealgrub_medium", 5)
    :book("fcl_bugbrew_book", 1)
    :batch_discount(80, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "fcl_mealgrubs_simple",
    result = "fcl_mealgrubs",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_CHEMICALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 0,
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "water", count = 6 },
            { id = "water_clean", count = 6 }
        })
    :component("fcl_mealgrub_jelly", 5)
    :book("fcl_bugbrew_book", 1)
    :batch_discount(80, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "fcl_hydroponics_core",
    result = "fcl_hydroponics_core",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 8,
}
    :component("power_supply", 1)
    :component("processor", 1)
    :component("circuit", 2)
    :component("small_storage_battery", 1)
    :component("plut_cell", 1)
    :component("lightstrip_inactive", 1)
    :component("plastic_chunk", 5)
    :component("cable", 4)
    :component("diamond", 1)
    :component("gold_small", 1)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("fabrication", 4)
    :requires_skill("mechanics", 4)
    :book("fcl_helixwirl_hydroponics_manual", 1)
    :proficiency("prof_carving")
    :proficiency("prof_elec_integrated_circuits")
)

content.add(content.Recipe {
    id = "fcl_light_minus_atomic_battery_cell",
    result = "fcl_light_minus_atomic_battery_cell",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 6,
}
    :component("scrap", 6)
    :component("cable", 4)
    :component("plut_cell", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("fabrication", 6)
    :learn_by_disassembly("electronics", 4)
    :book("recipe_atomic_battery", 6)
)

content.add(content.Recipe {
    id = "fcl_light_atomic_battery_cell",
    result = "fcl_light_atomic_battery_cell",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 6,
}
    :component("scrap", 6)
    :component("cable", 4)
    :component("plut_cell", 2)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("fabrication", 6)
    :learn_by_disassembly("electronics", 4)
    :book("recipe_atomic_battery", 6)
)

content.add(content.Recipe {
    id = "fcl_medium_atomic_battery_cell",
    result = "fcl_medium_atomic_battery_cell",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 6,
}
    :component("scrap", 6)
    :component("cable", 4)
    :component("plut_cell", 10)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("fabrication", 6)
    :learn_by_disassembly("electronics", 4)
    :book("recipe_atomic_battery", 6)
)

content.replace(content.Recipe {
    id = "heavy_atomic_battery_cell",
    result = "heavy_atomic_battery_cell",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 6,
}
    :component("scrap", 6)
    :component("cable", 4)
    :component("plut_cell", 20)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("fabrication", 6)
    :learn_by_disassembly("electronics", 4)
    :book("recipe_atomic_battery", 6)
)

-- 50cm weld
content.add(content.Recipe {
    id = "fcl_bot_eyebot",
    result = "fcl_bot_eyebot",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 4,
}
    :component("ai_module", 1)
    :component("identification_module", 1)
    :component("pathfinding_module", 1)
    :component("sensor_module", 1)
    :component("small_storage_battery", 1)
    :component("RAM", 1)
    :component("processor", 1)
    :component("scrap", 1)
    :component("quad_rotors", 1)
    :component("lens", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 3)
    :requirement("welding_standard", 50)
    :requires_skill("mechanics", 4)
    :requires_skill("computer", 4)
    :learn_by_disassembly("electronics", 5)
    :book("fcl_schematics_eyebot", 7)
)

-- 200cm weld
content.add(content.Recipe {
    id = "fcl_bot_copbot",
    result = "fcl_bot_copbot",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 780000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("omni_wheel", 1)
    :component("copbot_chassis", 1)
    :component("android_arms", 1)
    :component("power_supply", 4)
    :component("solar_cell", 2)
    :component("tazer", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 5)
    :requires_skill("computer", 6)
    :learn_by_disassembly("electronics", 8)
    :book("fcl_schematics_copbot", 7)
)

content.add(content.Recipe {
    id = "fcl_bot_molebot",
    result = "fcl_bot_molebot",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("medium_storage_battery", 1)
    :component("robot_controls", 1)
    :component("steel_chunk", 20)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("welding_standard", 6)
    :requires_skill("mechanics", 6)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 5)
    :book("fcl_schematics_molebot", 7)
)

-- 200cm weld
content.add(content.Recipe {
    id = "fcl_bot_riotbot",
    result = "fcl_bot_riotbot",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("omni_wheel", 1)
    :component("copbot_chassis", 1)
    :component("android_arms", 1)
    :component("power_supply", 4)
    :component("solar_cell", 2)
    :component("canister_empty", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 7)
    :requires_skill("computer", 6)
    :learn_by_disassembly("electronics", 8)
    :book("fcl_schematics_riotbot", 7)
)

content.add(content.Recipe {
    id = "bot_tripod",
    result = "bot_tripod",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_OTHER",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 9,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("spidery_legs_big", 1)
    :component("tripod_chassis", 1)
    :component("targeting_module", 1)
    :component("gun_module", 1)
    :component("power_supply", 12)
    :component("storage_battery", 1)
    :component("flamethrower", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("welding_standard", 10)
    :requires_skill("mechanics", 9)
    :requires_skill("computer", 8)
    :learn_by_disassembly("electronics", 8)
    :book("schematics_tripod", 9)
)

content.add(content.Recipe {
    id = "fcl_smart_omnicamera",
    result = "fcl_smart_omnicamera",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("omnicamera", 1)
    :component_any({
            { id = "fcl_bot_eyebot", count = 1 },
            { id = "broken_fcl_eyebot", count = 2 }
        })
    :component("power_supply", 1)
    :component("cable", 2)
    :quality("SCREW", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("soldering_standard", 50)
    :requirement("plastic_molding", 3)
    :requires_skill("computer", 4)
    :book("textbook_electronics", 8)
    :book("advanced_electronics", 8)
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_soldering")
)

-- 20cm weld
content.add(content.Recipe {
    id = "fcl_smart_omnicamera_reinforced",
    result = "fcl_smart_omnicamera_reinforced",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 360000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("fcl_smart_omnicamera", 1)
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
    id = "solar_panel_v3",
    result = "solar_panel_v3",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 10,
}
    :component("power_supply", 2)
    :component("amplifier", 2)
    :component("solar_cell_v3", 12)
    :component("cable", 7)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 35)
    :learn_by_disassembly("electronics", 7)
    :book("manual_electronics", 9)
    :book("textbook_electronics", 8)
    :book("advanced_electronics", 8)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_elec_circuits")
    :proficiency("prof_elec_semiconductors")
)

content.add(content.Recipe {
    id = "ground_solar_panel_v3",
    result = "ground_solar_panel_v3",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("solar_panel_v3", 4)
    :component("cable", 7)
    :book("advanced_electronics", 9)
    :book("textbook_electronics", 10)
)

-- 60cm weld
content.add(content.Recipe {
    id = "reinforced_solar_panel_v3",
    result = "reinforced_solar_panel_v3",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :component("solar_panel_v3", 1)
    :component("reinforced_glass_pane", 1)
    :component("scrap", 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 60)
    :requires_skill("electronics", 5)
    :book("textbook_fabrication", 8)
    :book("textbook_mechanics", 8)
    :book("welding_book", 9)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 240cm weld
content.add(content.Recipe {
    id = "reinforced_ground_solar_panel_v3",
    result = "reinforced_ground_solar_panel_v3",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 2880000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :component("ground_solar_panel_v3", 1)
    :component("reinforced_glass_pane", 4)
    :component("scrap", 4)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 240)
    :requires_skill("electronics", 5)
    :book("textbook_fabrication", 8)
    :book("textbook_mechanics", 8)
    :book("welding_book", 9)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "fcl_superalloy_frame",
    result = "fcl_superalloy_frame",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 540000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "welder", charges = 50 },
            { id = "welding_kit", charges = 50 },
            { id = "welder_crude", charges = 75 },
            { id = "integrated_welder", charges = 75 },
            { id = "forge", charges = 50 },
            { id = "oxy_torch", charges = 10 }
        })
    :component("alloy_plate", 2)
    :component("alloy_sheet", 8)
    :component("steel_lump_any", 8, true)
    :quality("GLARE", 1, 1)
    :book("textbook_fabrication", 5)
    :book("adv_chemistry", 6)
    :book("welding_book", 5)
    :proficiency("prof_blacksmithing", { time_multiplier = 10 })
)

content.add(content.Recipe {
    id = "atomic_light",
    result = "atomic_light",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("plastic_chunk", 1)
    :component("superglue", 1)
    :component("power_supply", 1)
    :component("cable", 1)
    :component_any({
            { id = "light_bulb", count = 1 },
            { id = "e_scrap", count = 1 }
        })
    :component("betavoltaic", 1)
    :quality("SCREW", 1, 1)
    :book("textbook_electronics", 3)
    :book("advanced_electronics", 3)
    :book("recipe_caseless", 2)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "fcl_atomic_lamp",
    result = "fcl_atomic_lamp",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("plastic_chunk", 2)
    :component("superglue", 1)
    :component("power_supply", 1)
    :component("cable", 2)
    :component("betavoltaic", 4)
    :quality("SCREW", 1, 1)
    :book("textbook_electronics", 4)
    :book("advanced_electronics", 4)
    :book("recipe_caseless", 3)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "fcl_atomic_headlamp",
    result = "fcl_atomic_headlamp",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 2,
}
    :component("betavoltaic", 4)
    :component("power_supply", 1)
    :component("scrap", 2)
    :component("wire", 2)
    :component_any({
            { id = "lens", count = 1 },
            { id = "lens_small", count = 1 }
        })
    :component_any({
            { id = "cotton_patchwork", count = 4 },
            { id = "leather", count = 4 },
            { id = "duct_tape", count = 20 },
            { id = "medical_tape", count = 40 },
            { id = "cordage", count = 1, requirement = true }
        })
    :quality("CUT", 2, 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("survival", 3)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "fcl_atomic_headlamp_from_lamp",
    result = "fcl_atomic_headlamp",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_LIGHTING",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component_any({
            { id = "fcl_atomic_lamp", count = 1 },
            { id = "fcl_atomic_lamp_off", count = 1 }
        })
    :component("glue_strong", 1)
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :requirement("tailoring_nylon_patchwork", 2)
)

content.add(content.Recipe {
    id = "fcl_atomic_coffeemaker",
    result = "fcl_atomic_coffeemaker",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("plastic_chunk", 5)
    :component("superglue", 1)
    :component("power_supply", 2)
    :component_any({
            { id = "wire_mesh", count = 1 },
            { id = "cotton_patchwork", count = 1 }
        })
    :component("thermos", 2)
    :component_any({
            { id = "element", count = 1 },
            { id = "crude_heating_element", count = 1 }
        })
    :component("scrap_aluminum", 2)
    :component("betavoltaic", 2)
    :component("RTG_coffee", 1)
    :quality("SCREW", 1, 1)
    :book("recipe_caseless", 8)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elec_semiconductors")
)

-- Conversion of a normal smartphone into an atomic one by replacing the power supply.
content.add(content.Recipe {
    id = "fcl_atomic_smartphone",
    result = "fcl_atomic_smartphone",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_TOOLS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 5,
}
    :component("plastic_chunk", 1)
    :component("processor", 1)
    :component("smart_phone", 1)
    :component("plut_cell", 1)
    :quality("SCREW", 1, 1)
    :book("recipe_caseless", 5)
    :book("textbook_atomic_lab", 4)
)
