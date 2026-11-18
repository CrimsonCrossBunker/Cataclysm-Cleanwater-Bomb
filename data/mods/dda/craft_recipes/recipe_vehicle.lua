local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

-- 1000cm weld
content.add(content.Recipe {
    id = "steam_watts_small",
    result = "steam_watts_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("pipe", 16)
    :component_any({
            { id = "scrap", count = 90 },
            { id = "steel_chunk_any", count = 30, requirement = true },
            { id = "steel_lump_any", count = 10, requirement = true }
        })
    :component("chain", 4)
    :component("spring_medium", 4)
    :component("30gal_drum", 3)
    :component_any({
            { id = "filter_air", count = 1 },
            { id = "filter_air_makeshift", count = 1 }
        })
    :component("well_pump", 2)
    :component("cable", 14)
    :component("frame", 1)
    :component("steel_plate", 8)
    :component_any({
            { id = "water", count = 150 },
            { id = "water_clean", count = 150 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 1000)
    :book("textbook_fabrication", 5)
    :book("welding_book", 6)
    :book("textbook_carpentry", 5)
    :proficiency("prof_basic_engines")
    :proficiency("prof_welding_basic")
)

-- 400cm weld
content.add(content.Recipe {
    id = "fuel_bunker",
    result = "fuel_bunker",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 780000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("sheet_metal", 3)
    :quality("HAMMER", 2, 1)
    :requirement("welding_standard", 400)
)

content.add(content.Recipe {
    id = "wheel",
    result = "wheel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
}
    :component("deflated_wheel", 1)
    :quality("PRESSURIZATION", 1, 1)
)

content.add(content.Recipe {
    id = "wheel_slick",
    result = "wheel_slick",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
}
    :component("deflated_wheel_slick", 1)
    :quality("PRESSURIZATION", 1, 1)
)

content.add(content.Recipe {
    id = "wheel_motorbike",
    result = "wheel_motorbike",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
}
    :component("deflated_wheel_motorbike", 1)
    :quality("PRESSURIZATION", 1, 1)
)

content.add(content.Recipe {
    id = "wheel_motorbike_or",
    result = "wheel_motorbike_or",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
}
    :component("deflated_wheel_motorbike_or", 1)
    :quality("PRESSURIZATION", 1, 1)
)

content.add(content.Recipe {
    id = "wheel_wide",
    result = "wheel_wide",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
}
    :component("deflated_wheel_wide", 1)
    :quality("PRESSURIZATION", 1, 1)
)

content.add(content.Recipe {
    id = "wheel_wide_or",
    result = "wheel_wide_or",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
}
    :component("deflated_wheel_wide_or", 1)
    :quality("PRESSURIZATION", 1, 1)
)

content.add(content.Recipe {
    id = "wheel_bicycle",
    result = "wheel_bicycle",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
}
    :component("deflated_wheel_bicycle", 1)
    :quality("PRESSURIZATION", 1, 1)
)

content.add(content.Recipe {
    id = "wheel_bicycle_or",
    result = "wheel_bicycle_or",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
}
    :component("deflated_wheel_bicycle_or", 1)
    :quality("PRESSURIZATION", 1, 1)
)

content.add(content.Recipe {
    id = "deflated_wheel",
    result = "deflated_wheel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
}
    :tool("fake_tire_changer", 1)
    :component("tire_medium", 1)
    :component("wheel_rim_medium", 1)
)

content.add(content.Recipe {
    id = "deflated_wheel_slick",
    result = "deflated_wheel_slick",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
}
    :tool("fake_tire_changer", 1)
    :component("tire_medium_slick", 1)
    :component("wheel_rim_medium", 1)
)

content.add(content.Recipe {
    id = "deflated_wheel_motorbike",
    result = "deflated_wheel_motorbike",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
}
    :tool("fake_tire_changer", 1)
    :component("tire_motorbike", 1)
    :component("wheel_rim_motorbike", 1)
)

content.add(content.Recipe {
    id = "deflated_wheel_motorbike_or",
    result = "deflated_wheel_motorbike_or",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
}
    :tool("fake_tire_changer", 1)
    :component("tire_motorbike_or", 1)
    :component("wheel_rim_motorbike", 1)
)

content.add(content.Recipe {
    id = "deflated_wheel_wide",
    result = "deflated_wheel_wide",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
}
    :tool("fake_tire_changer", 1)
    :component("tire_wide", 1)
    :component("wheel_rim_wide", 1)
)

content.add(content.Recipe {
    id = "deflated_wheel_wide_or",
    result = "deflated_wheel_wide_or",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
}
    :tool("fake_tire_changer", 1)
    :component("tire_wide_or", 1)
    :component("wheel_rim_wide", 1)
)

content.add(content.Recipe {
    id = "deflated_wheel_bicycle",
    result = "deflated_wheel_bicycle",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
}
    :component("tire_bicycle", 1)
    :component("wheel_rim_bicycle", 1)
    :quality("PRY", 1, 1)
)

content.add(content.Recipe {
    id = "deflated_wheel_bicycle_or",
    result = "deflated_wheel_bicycle_or",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
}
    :component("tire_bicycle_or", 1)
    :component("wheel_rim_bicycle", 1)
    :quality("PRY", 1, 1)
)

content.add(content.Recipe {
    id = "reins_tackle",
    result = "reins_tackle",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "leather", count = 16 },
            { id = "tanned_hide", count = 2 },
            { id = "fur", count = 16 },
            { id = "tanned_pelt", count = 2 }
        })
    :component("cordage_superior", 2, true)
    :requirement("sewing_standard", 100)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "yoke_harness",
    result = "yoke_harness",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "leather", count = 8 },
            { id = "tanned_hide", count = 1 },
            { id = "fur", count = 8 },
            { id = "tanned_pelt", count = 1 }
        })
    :component("2x4", 4)
    :component("rope_superior_short", 2, true)
    :quality("HAMMER", 1, 1)
    :requirement("sewing_standard", 100)
    :book("textbook_fabrication", 5)
    :book("textbook_carpentry", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "yoke_harness_heavyduty",
    result = "yoke_harness_heavyduty",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 300000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("yoke_harness", 1)
    :component("frame", 1)
    :component_any({
            { id = "scrap", count = 35 },
            { id = "steel_chunk_any", count = 11, requirement = true },
            { id = "steel_lump_any", count = 5, requirement = true }
        })
    :component("pipe", 6)
    :component_any({
            { id = "chain", count = 2 },
            { id = "hd_tow_cable", count = 1 }
        })
    :component_any({
            { id = "spring", count = 2 },
            { id = "tanned_hide", count = 2 }
        })
    :component("nuts_bolts", 6)
    :component_any({
            { id = "rope_superior_short", count = 2, requirement = true },
            { id = "sheet_canvas", count = 4 },
            { id = "sheet_canvas_patchwork", count = 4 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("GLARE", 1, 1)
    :requirement("welding_standard", 25)
    :requirement("steel_standard", 2)
    :book("textbook_fabrication", 5)
    :proficiency("prof_welding_basic")
)

-- 90cm weld
content.add(content.Recipe {
    id = "hd_tow_cable",
    result = "hd_tow_cable",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 2880000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("duct_tape", 50)
    :component("grip_hook", 1)
    :component("chain", 8)
    :component("cable", 4)
    :quality("HAMMER", 1, 1)
    :requirement("welding_standard", 90)
)

-- 50cm weld
content.add(content.Recipe {
    id = "bike_rack",
    result = "bike_rack",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("pipe", 4)
    :component("pipe_fittings", 4)
    :component_any({
            { id = "scrap", count = 9 },
            { id = "steel_chunk_any", count = 3, requirement = true },
            { id = "steel_lump_any", count = 1, requirement = true }
        })
    :component("rope_natural_short", 2, true)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 50)
    :book("textbook_fabrication", 5)
    :book("welding_book", 6)
    :book("textbook_carpentry", 5)
)

-- sawing it down doesn't teach anything useful
-- 60cm weld
content.add(content.Recipe {
    id = "rebar_plate",
    result = "rebar_plate",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("rebar", 4)
    :component("scrap", 3)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 60)
)

-- 75cm weld
content.add(content.Recipe {
    id = "spring_plate",
    result = "spring_plate",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("steel_plate", 1)
    :component("spring", 4)
    :requirement("welding_standard", 75)
)

-- 300cm weld
content.add(content.Recipe {
    id = "tearer",
    result = "tearer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "scrap", count = 18 },
            { id = "steel_chunk_any", count = 6, requirement = true },
            { id = "steel_lump_any", count = 2, requirement = true }
        })
    :component("hdframe", 1)
    :component_any({
            { id = "rebar", count = 8 },
            { id = "pipe", count = 16 }
        })
    :component("chain", 2)
    :component("blade", 9)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 300)
)

-- 400cm weld
content.add(content.Recipe {
    id = "minifreezer",
    result = "minifreezer",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("sheet_metal", 10)
    :component("condensor_coil", 1)
    :component("evaporator_coil", 1)
    :component("thermostat", 1)
    :component("motor_micro", 1)
    :component("refrigerant_tank", 1)
    :component("plastic_chunk", 10)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 400)
    :requires_skill("fabrication", 5)
    :book("textbook_mechanics", 5)
    :book("manual_mechanics", 5)
    :book("textbook_fabrication", 5)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.1, learning_time_multiplier = 0.1 })
    :proficiency("prof_appliance_repair")
)

content.add(content.Recipe {
    id = "programmable_autopilot",
    result = "programmable_autopilot",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "computer",
    difficulty = 5,
}
    :component("sheet_metal", 2)
    :component("motor_tiny", 3)
    :component("plastic_chunk", 10)
    :component("power_supply", 1)
    :component("scrap", 4)
    :component("cable", 4)
    :component("antenna", 1)
    :component("e_scrap", 5)
    :component("amplifier", 1)
    :component("any_wire", 6, true)
    :component("circuit", 2)
    :component("processor", 1)
    :component("RAM", 1)
    :component("small_lcd_screen", 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("electronics", 4)
    :book("manual_electronics", 3)
    :book("textbook_electronics", 3)
    :book("advanced_electronics", 3)
    :book("recipe_lab_elec", 3)
    :book("textbook_anarch", 3)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "minifridge",
    result = "minifridge",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("sheet_metal", 10)
    :component("condensor_coil", 1)
    :component("evaporator_coil", 1)
    :component("thermostat", 1)
    :component("motor_micro", 1)
    :component("refrigerant_tank", 1)
    :component("plastic_chunk", 8)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 400)
    :requires_skill("fabrication", 4)
    :book("textbook_mechanics", 5)
    :book("manual_mechanics", 5)
    :book("textbook_fabrication", 5)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.1, learning_time_multiplier = 0.1 })
    :proficiency("prof_appliance_repair")
)

-- 15cm weld
content.add(content.Recipe {
    id = "mountable_heater",
    result = "mountable_heater",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("large_space_heater", 1)
    :component("any_wire", 2, true)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 15)
    :requires_skill("mechanics", 2)
)

-- 15cm weld
content.add(content.Recipe {
    id = "mountable_heater_small",
    result = "mountable_heater_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("small_space_heater", 1)
    :component("any_wire", 2, true)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 15)
    :requires_skill("mechanics", 2)
)

-- 200cm weld
content.add(content.Recipe {
    id = "mountable_cooler",
    result = "mountable_cooler",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("sheet_metal", 2)
    :component("condensor_coil", 2)
    :component("evaporator_coil", 2)
    :component("thermostat", 1)
    :component("motor_tiny", 2)
    :component("refrigerant_tank", 1)
    :component("plastic_chunk", 11)
    :component("any_wire", 4, true)
    :component("scrap", 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 200)
    :book("textbook_mechanics", 5)
    :book("manual_mechanics", 5)
    :book("textbook_fabrication", 5)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.1, learning_time_multiplier = 0.1 })
)

content.add(content.Recipe {
    id = "vh_autoclave",
    result = "vh_autoclave",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("autoclave", 1)
    :component("cable", 1)
    :component("power_supply", 2)
    :requirement("soldering_standard", 5)
    :requires_skill("electronics", 4)
    :proficiency("prof_elec_soldering")
)

-- 360cm weld
content.add(content.Recipe {
    id = "washing_machine",
    result = "washing_machine",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 1020000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("sheet_metal", 3)
    :component("any_wire", 6, true)
    :component_any({
            { id = "hose", count = 1 },
            { id = "makeshift_hose", count = 1 }
        })
    :component("e_scrap", 3)
    :component("circuit", 1)
    :component("scrap", 4)
    :component("steel_chunk_any", 2, true)
    :component("metal_tank", 1)
    :component("motor_tiny", 1)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 2, 1)
    :requirement("welding_standard", 350)
    :requires_skill("mechanics", 5)
    :book("textbook_fabrication", 6)
    :book("textbook_mechanics", 5)
    :proficiency("prof_basic_engines")
    :proficiency("prof_welding_basic")
    :byproduct("scrap", 6)
)

-- 350cm weld
content.add(content.Recipe {
    id = "dishwasher",
    result = "dishwasher",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 1020000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("sheet_metal", 3)
    :component("any_wire", 6, true)
    :component_any({
            { id = "hose", count = 1 },
            { id = "makeshift_hose", count = 1 }
        })
    :component("e_scrap", 3)
    :component("circuit", 1)
    :component("scrap", 4)
    :component("steel_chunk_any", 2, true)
    :component("metal_tank", 1)
    :component("motor_tiny", 1)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 2, 1)
    :requirement("welding_standard", 350)
    :requires_skill("mechanics", 5)
    :book("textbook_fabrication", 6)
    :book("textbook_mechanics", 5)
    :proficiency("prof_basic_engines")
    :proficiency("prof_welding_basic")
    :byproduct("scrap", 6)
)

-- 20cm weld
content.add(content.Recipe {
    id = "wheel_caster",
    result = "wheel_caster",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("plastic_chunk", 4)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("welding_standard", 20)
    :requirement("steel_chunk_any", 4)
    :requirement("plastic_molding", 3)
    :proficiency("prof_plasticworking")
)

-- 22cm weld
content.add(content.Recipe {
    id = "wheel_caster_large",
    result = "wheel_caster_large",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("plastic_chunk", 12)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("welding_standard", 22)
    :requirement("steel_chunk_any", 5)
    :requirement("plastic_molding", 6)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "mounted_spare_tire",
    result = "mounted_spare_tire",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "mechanics",
    difficulty = 1,
}
    :component_any({
            { id = "wheel_wide_or", count = 1 },
            { id = "wheel_wide", count = 1 },
            { id = "wheel", count = 1 },
            { id = "wheel_slick", count = 1 },
            { id = "wheel_armor", count = 1 }
        })
    :component("spare_tire_carrier", 1)
    :quality("WRENCH", 2, 1)
)

content.add(content.Recipe {
    id = "boat_board",
    result = "boat_board",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 5)
    :component("nails", 30, true)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "raft_board",
    result = "raft_board",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("log", 4)
    :component("rope_natural", 3, true)
)

content.add(content.Recipe {
    id = "plastic_boat_hull",
    result = "plastic_boat_hull",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 18)
    :requirement("plastic_molding", 21)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "sail",
    result = "sail",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("sheet", 2)
    :component_any({
            { id = "2x4", count = 4 },
            { id = "stick", count = 4 }
        })
    :component("nails", 20, true)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
    :requirement("sewing_standard", 100)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "hand_paddles",
    result = "hand_paddles",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 4)
    :component("nails", 10, true)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "hand_paddles_blade_from_log",
    result = "hand_paddles",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("log", 1)
    :component_any({
            { id = "nails", count = 2, requirement = true },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true },
            { id = "duct_tape", count = 40 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
    :quality("CUT", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 3, skill_penalty = 0 })
)

-- 200cm weld
content.add(content.Recipe {
    id = "cargo_aisle",
    result = "cargo_aisle",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 3)
    :component("hinge", 2)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 1)
)

content.add(content.Recipe {
    id = "towel_hanger",
    result = "towel_hanger",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("nails", 4, true)
    :component("2x4", 2)
    :component_any({
            { id = "stick", count = 2 },
            { id = "2x4", count = 2 }
        })
    :component("towel", 3)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "wheel_mount_wood",
    result = "wheel_mount_wood",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component("nails", 12, true)
    :component("2x4", 2)
    :component("any_wire", 1, true)
    :quality("DRILL", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :requires_skill("fabrication", 4)
    :proficiency("prof_carpentry_basic")
)

-- 10cm weld
content.add(content.Recipe {
    id = "wheel_mount_light",
    result = "wheel_mount_light",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 1,
}
    :component("scrap", 2)
    :quality("DRILL", 3, 1)
    :requirement("welding_standard", 10)
)

-- 40cm weld
content.add(content.Recipe {
    id = "turret_mount",
    result = "turret_mount",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 3,
}
    :component("pipe", 3)
    :component("motor_tiny", 2)
    :component("spring_medium", 1)
    :component("cable", 4)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("SCREW", 1, 1)
    :requirement("welding_standard", 40)
    :requirement("steel_standard", 2)
    :requirement("soldering_standard", 10)
    :requires_skill("electronics", 1)
    :book("arduino_experiments", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "turret_controls",
    result = "turret_controls",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 5,
}
    :tool("laptop", 1)
    :component("targeting_module", 1)
    :component("ai_module", 1)
    :component("gun_module", 1)
    :component("identification_module", 1)
    :component("cable", 4)
    :component_any({
            { id = "camera", count = 1 },
            { id = "camera_pro", count = 1 },
            { id = "omnicamera", count = 1 },
            { id = "sensor_module", count = 1 }
        })
    :component("robot_controls", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("computer", 5)
    :requires_skill("mechanics", 3)
    :book("arduino_experiments", 4)
    :proficiency("prof_elec_soldering")
)

-- 40cm weld
content.add(content.Recipe {
    id = "basket",
    result = "basket",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("lc_wire", 40)
    :requirement("welding_standard", 40)
    :requirement("cutting_wire_standard", 1)
)

-- 45cm weld
content.add(content.Recipe {
    id = "folding_basket",
    result = "folding_basket",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "lc_wire", count = 40 },
            { id = "basket", count = 1 }
        })
    :component("scrap", 8)
    :requirement("welding_standard", 45)
    :requirement("cutting_wire_standard", 1)
)

-- 10cm weld
content.add(content.Recipe {
    id = "bike_basket",
    result = "bike_basket",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("lc_wire", 8)
    :requirement("welding_standard", 10)
    :requirement("cutting_wire_standard", 1)
)

-- 20cm weld
content.add(content.Recipe {
    id = "foldframe",
    result = "foldframe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 4)
    :component("pipe_fittings", 4)
    :requirement("welding_standard", 20)
)

content.add(content.Recipe {
    id = "foldwoodframe",
    result = "foldwoodframe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("2x4", 5)
    :component("stick", 2)
    :component("nails", 20, true)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_carving")
)

-- 15cm weld
content.add(content.Recipe {
    id = "wheel_wheelchair",
    result = "wheel_wheelchair",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 150000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("pipe", 2)
    :component("wheel_bicycle", 2)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 15)
)

content.add(content.Recipe {
    id = "wheel_rail_small_pair",
    result = "wheel_rail_small_pair",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 300000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("pipe", 1)
    :quality("SAW_M", 1, 1)
    :requirement("blacksmithing_standard", 48)
    :requirement("steel_standard", 12)
    :requires_skill("mechanics", 1)
)

content.add(content.Recipe {
    id = "wheel_rail",
    result = "wheel_rail",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("CHISEL", 3, 1)
    :quality("SAW_M", 2, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("steel_standard", 5)
    :requires_skill("mechanics", 3)
    :proficiency("prof_blacksmithing", { time_multiplier = 10 })
)

-- 15cm weld
content.add(content.Recipe {
    id = "hand_rims",
    result = "hand_rims",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 2)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 15)
)

content.add(content.Recipe {
    id = "frame",
    result = "frame",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
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
    :quality("GLARE", 1, 1)
    :requirement("lc_steel_standard", 20)
    :proficiency("prof_blacksmithing", { time_multiplier = 10 })
)

content.add(content.Recipe {
    id = "hdframe",
    result = "hdframe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
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
    :quality("GLARE", 1, 1)
    :requirement("lc_steel_standard", 100)
    :proficiency("prof_blacksmithing", { time_multiplier = 10 })
)

content.add(content.Recipe {
    id = "frame_wood",
    result = "frame_wood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 5)
    :component("nails", 20, true)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "frame_wood_light",
    result = "frame_wood_light",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component_any({
            { id = "2x4", count = 3 },
            { id = "stick", count = 6 }
        })
    :requirement("rope_natural_short", 3)
)

content.add(content.Recipe {
    id = "wheel_wood",
    result = "wheel_wood",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("2x4", 5)
    :component("nails", 20, true)
    :quality("HAMMER", 1, 1)
    :quality("SAW_W", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "wheel_wood_b",
    result = "wheel_wood_b",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("2x4", 5)
    :component("nails", 30, true)
    :component("scrap", 5)
    :quality("HAMMER", 1, 1)
    :quality("SAW_W", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "wood_plate",
    result = "wood_plate",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("2x4", 6)
    :requirement("rope_natural_short", 2)
)

content.add(content.Recipe {
    id = "wheel_metal",
    result = "wheel_metal",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :requirement("blacksmithing_standard", 20)
    :requirement("steel_standard", 5)
)

-- sawing it down doesn't teach anything useful
content.add(content.Recipe {
    id = "steel_plate",
    result = "steel_plate",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 3600000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "welder", charges = 100 },
            { id = "welding_kit", charges = 100 },
            { id = "welder_crude", charges = 150 },
            { id = "integrated_welder", charges = 150 },
            { id = "forge", charges = 100 },
            { id = "oxy_torch", charges = 20 }
        })
    :component("lc_steel_lump", 8)
    :quality("GLARE", 1, 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

-- sawing it down doesn't teach anything useful
content.add(content.Recipe {
    id = "steel_armor",
    result = "steel_armor",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 3240000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "welder", charges = 50 },
            { id = "welding_kit", charges = 50 },
            { id = "welder_crude", charges = 75 },
            { id = "integrated_welder", charges = 75 },
            { id = "forge", charges = 50 },
            { id = "oxy_torch", charges = 10 }
        })
    :component("steel_lump_any", 4, true)
    :quality("GLARE", 1, 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "spiked_plate",
    result = "spiked_plate",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 3600000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "welder", charges = 100 },
            { id = "welding_kit", charges = 100 },
            { id = "welder_crude", charges = 150 },
            { id = "integrated_welder", charges = 150 },
            { id = "forge", charges = 100 },
            { id = "oxy_torch", charges = 20 }
        })
    :component_any({
            { id = "steel_lump_any", count = 8, requirement = true },
            { id = "steel_plate", count = 1 }
        })
    :component_any({
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 12 },
            { id = "spike", count = 4 }
        })
    :quality("GLARE", 1, 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :requires_skill("fabrication", 6)
    :book("textbook_fabrication", 3)
    :book("welding_book", 3)
    :book("textbook_mechanics", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

-- hardened metal can be achieved with a simple forge setup. Ask Atsume#2311 on discord if you want to
-- change.
content.add(content.Recipe {
    id = "hard_plate",
    result = "hard_plate",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 4320000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_any({
            { id = "welder", charges = 100 },
            { id = "welding_kit", charges = 100 },
            { id = "welder_crude", charges = 150 },
            { id = "integrated_welder", charges = 150 },
            { id = "forge", charges = 200 },
            { id = "oxy_torch", charges = 20 }
        })
    :component("steel_lump_any", 24, true)
    :quality("GLARE", 1, 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :book("textbook_fabrication", 5)
    :book("adv_chemistry", 6)
    :book("welding_book", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "alloy_plate",
    result = "alloy_plate",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 3600000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    reversible = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_any({
            { id = "welder", charges = 100 },
            { id = "welding_kit", charges = 100 },
            { id = "welder_crude", charges = 150 },
            { id = "integrated_welder", charges = 150 },
            { id = "forge", charges = 200 },
            { id = "oxy_torch", charges = 20 }
        })
    :component("alloy_sheet", 12)
    :quality("GLARE", 1, 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 3, 1)
    :book("textbook_fabrication", 5)
    :book("adv_chemistry", 6)
    :book("welding_book", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "fridgetank",
    result = "fridgetank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("metal_tank", 1)
    :component("condensor_coil", 1)
    :component("evaporator_coil", 1)
    :component("thermostat", 1)
    :component("motor_tiny", 1)
    :component("refrigerant_tank", 1)
    :component("plastic_chunk", 8)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 400)
    :requires_skill("fabrication", 4)
    :book("textbook_mechanics", 5)
    :book("manual_mechanics", 5)
    :book("textbook_fabrication", 5)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.1, learning_time_multiplier = 0.1 })
    :proficiency("prof_appliance_repair")
)

content.add(content.Recipe {
    id = "fridgetank_large",
    result = "fridgetank_large",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("30gal_drum", 1)
    :component("condensor_coil", 1)
    :component("evaporator_coil", 1)
    :component("thermostat", 1)
    :component("motor_tiny", 1)
    :component("refrigerant_tank", 1)
    :component("plastic_chunk", 8)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 400)
    :requires_skill("fabrication", 4)
    :book("textbook_mechanics", 5)
    :book("manual_mechanics", 5)
    :book("textbook_fabrication", 5)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.1, learning_time_multiplier = 0.1 })
    :proficiency("prof_appliance_repair")
)

content.add(content.Recipe {
    id = "heattank",
    result = "heattank",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("metal_tank", 1)
    :component_any({
            { id = "element", count = 6 },
            { id = "crude_heating_element", count = 9 }
        })
    :component("thermostat", 1)
    :component("plastic_chunk", 8)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("welding_standard", 400)
    :requires_skill("fabrication", 4)
    :book("textbook_mechanics", 5)
    :book("manual_mechanics", 5)
    :book("textbook_fabrication", 5)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.1, learning_time_multiplier = 0.1 })
    :proficiency("prof_appliance_repair")
)

content.add(content.Recipe {
    id = "alternator_bicycle",
    result = "alternator_bicycle",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("cable", 2)
    :component("e_scrap", 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 4)
    :requirement("steel_chunk_any", 1)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 2)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "alternator_motorbike",
    result = "alternator_motorbike",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("e_scrap", 4)
    :component("cable", 10)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 8)
    :requirement("steel_standard", 1)
    :requires_skill("fabrication", 1)
    :learn_by_disassembly("electronics", 2)
    :book("manual_electronics", 2)
    :book("mag_electronics", 2)
    :book("manual_mechanics", 2)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "five-point_harness",
    result = "five-point_harness",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("seatbelt", 5)
    :component("nuts_bolts", 1)
    :quality("WRENCH", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requires_skill("mechanics", 2)
)

content.add(content.Recipe {
    id = "aluminum_boat_hull",
    result = "aluminum_boat_hull",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 270000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
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
    :component_any({
            { id = "scrap_aluminum", count = 45 },
            { id = "material_aluminium_ingot", count = 9 }
        })
    :quality("GLARE", 1, 1)
)

content.add(content.Recipe {
    id = "foldxlframe",
    result = "foldxlframe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "material_aluminium_ingot", count = 7 },
            { id = "scrap_aluminum", count = 34 }
        })
    :requirement("welding_alloys", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

content.add(content.Recipe {
    id = "pedal_extenders_makeshift",
    result = "pedal_extenders_makeshift",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("wood_block", 2)
)

content.add(content.Recipe {
    id = "pedal_extenders",
    result = "pedal_extenders",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "BLIND_EASY" },
}
    :component_any({
            { id = "rubber_tire_chunk", count = 4 },
            { id = "clamp", count = 2 }
        })
)

content.add(content.Recipe {
    id = "hand_controls",
    result = "hand_controls",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 210000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "pipe_fittings", count = 2 },
            { id = "pipe", count = 2 },
            { id = "clamp", count = 2 }
        })
    :requirement("welding_standard", 25)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_welding")
)
