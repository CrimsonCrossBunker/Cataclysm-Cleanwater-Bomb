local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "afs_foamcrete",
    result = "afs_foamcrete",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("surface_heat", 20, true)
    :component("oxy_powder", 20)
    :component("afs_biomaterial_1", 4)
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :component_any({
            { id = "concrete", count = 10 },
            { id = "chitin_piece", count = 6 }
        })
    :quality("CHEM", 1, 1)
    :book("recipe_unusual_ammos", 3)
    :result_charges(30)
)

content.add(content.Recipe {
    id = "xray_laser_barrel",
    result = "xray_laser_barrel",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("oxy_powder", 20)
    :component("afs_material_2", 4)
    :component("afs_material_3", 1)
    :component("afs_energy_storage_2", 1)
    :quality("CHEM", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("HAMMER_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("surface_heat", 50)
    :book("recipe_unusual_ammos", 3)
    :book("recipe_lab_elec", 8)
)

content.add(content.Recipe {
    id = "arrow_nano",
    result = "arrow_nano",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("afs_material_2", 4)
    :component("afs_material_3", 3)
    :quality("CHEM", 1, 1)
    :quality("NANO_FORGE", 1, 1)
    :quality("HAMMER_FINE", 1, 1)
    :requirement("nanosmithing_standard", 5)
    :book("recipe_unusual_ammos", 3)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "rebar_rail",
    result = "rebar_rail",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("rebar", 2)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "steel_rail",
    result = "steel_rail",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 600000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :requirement("blacksmithing_standard", 16)
    :requirement("steel_standard", 4)
    :result_charges(10)
)

-- 3000 mg gunpowder rounded to 30 100 mg 'pieces'
content.add(content.Recipe {
    id = "afs_reloaded_5x50dart",
    result = "afs_reloaded_5x50dart",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("afs_5x50_hull", 1)
    :component("smrifle_primer", 1)
    :component_any({
            { id = "gunpowder", count = 30 },
            { id = "gunpowder_magnum_pistol", count = 30 }
        })
    :component("combatnail", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 5)
    :book("recipe_caseless", 4)
    :proficiency("prof_plasticworking")
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "afs_electroshock_grenade_1",
    result = "afs_electroshock_grenade_1",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("afs_energy_storage_2", 1)
    :component("afs_material_1", 3)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 10)
)

content.add(content.Recipe {
    id = "grenade_cryo",
    result = "grenade_cryo",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 7,
}
    :component("afs_energy_storage_3", 1)
    :component("afs_material_1", 3)
    :component("afs_energy_storage_2", 2)
    :quality("DIAMONDPRESS", 1, 1)
    :requirement("soldering_standard", 10)
)

content.add(content.Recipe {
    id = "afs_oxygen_bomb",
    result = "afs_oxygen_bomb",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :component("afs_oxygen_candle", 1)
    :component_any({
            { id = "duct_tape", count = 10 },
            { id = "medical_tape", count = 20 }
        })
    :component_any({
            { id = "afs_heat_2", count = 1 },
            { id = "motor_oil", count = 1 }
        })
    :quality("SCREW_FINE", 1, 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("fabrication", 2)
)

content.add(content.Recipe {
    id = "afs_plasma_torch_gun",
    result = "afs_plasma_torch_gun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 4,
}
    :component("afs_plasma_torch", 1)
    :component("cable", 7)
    :component("afs_energy_storage_3", 1)
    :component("afs_material_1", 2)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("electric_probing", 1)
    :learn_automatically("electronics", 6)
    :book("advanced_electronics", 3)
    :book("textbook_electronics", 3)
    :byproduct("afs_energy_storage_2", 1)
)

content.add(content.Recipe {
    id = "afs_makeshift_fusion_gun",
    result = "afs_makeshift_fusion_gun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 7,
}
    :component("afs_plasma_torch", 1)
    :component("afs_fusion_engine_core", 1)
    :component("cable", 7)
    :component("afs_material_1", 5)
    :component("afs_heat_1", 1)
    :component("afs_energy_storage_3", 1)
    :component("afs_magnet_4", 1)
    :component("afs_heat_2", 2)
    :component("afs_heat_3", 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("electric_probing", 1)
    :learn_automatically("electronics", 6)
)

content.add(content.Recipe {
    id = "afs_shotgun_gauss",
    result = "afs_shotgun_gauss",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("cable", 7)
    :component("afs_energy_storage_4", 1)
    :component("afs_material_2", 2)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("electric_probing", 1)
    :learn_automatically("electronics", 6)
    :book("advanced_electronics", 3)
    :book("textbook_electronics", 3)
)

content.add(content.Recipe {
    id = "afs_magnetic_choke",
    result = "afs_magnetic_choke",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("afs_magnet_4", 1)
    :component("afs_material_2", 2)
    :quality("SCREW_FINE", 1, 1)
    :requirement("nanosmithing_standard", 3)
    :requirement("electric_probing", 1)
    :learn_automatically("electronics", 6)
    :book("advanced_electronics", 3)
    :book("textbook_electronics", 3)
)

content.add(content.Recipe {
    id = "firmware_subsonic",
    result = "firmware_subsonic",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "computer",
    difficulty = 5,
    flags = { "BLIND_EASY" },
}
    :tool_any({
            { id = "laptop", charges = 100 },
            { id = "afs_bio_deck_jack", charges = 100 },
            { id = "afs_wrist_computer", charges = 45 }
        })
    :tool_charges("cable", 1)
    :component("afs_circuitry_1", 1)
    :requires_skill("gun", 4)
    :learn_automatically("computer", 5)
)

content.add(content.Recipe {
    id = "firmware_overpressure",
    result = "firmware_overpressure",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "computer",
    difficulty = 5,
    flags = { "BLIND_EASY" },
}
    :tool_any({
            { id = "laptop", charges = 100 },
            { id = "afs_bio_deck_jack", charges = 100 },
            { id = "afs_wrist_computer", charges = 45 }
        })
    :tool_charges("cable", 1)
    :component("afs_circuitry_1", 1)
    :requires_skill("gun", 4)
    :learn_automatically("computer", 5)
)

content.add(content.Recipe {
    id = "firmware_incendiary",
    result = "firmware_incendiary",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "computer",
    difficulty = 5,
    flags = { "BLIND_EASY" },
}
    :tool_any({
            { id = "laptop", charges = 100 },
            { id = "afs_bio_deck_jack", charges = 100 },
            { id = "afs_wrist_computer", charges = 45 }
        })
    :tool_charges("cable", 1)
    :component("afs_circuitry_1", 1)
    :requires_skill("gun", 4)
    :learn_automatically("computer", 5)
)

content.add(content.Recipe {
    id = "mininuke",
    result = "mininuke",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_EXPLOSIVE",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 10,
}
    :component("canister_empty", 1)
    :component_any({
            { id = "grenade", count = 1 },
            { id = "40x46mm_m433", count = 2 }
        })
    :component("plut_cell", 6)
    :component("amplifier", 3)
    :component("power_supply", 1)
    :component("clockworks", 1)
    :component("cable", 5)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("electronics", 5)
    :learn_by_disassembly("mechanics", 10)
    :book("textbook_atomic_lab", 5)
)

content.add(content.Recipe {
    id = "afs_murdersaw",
    result = "afs_murdersaw",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 4,
}
    :component("afs_power_cutter", 1)
    :component_any({
            { id = "steel_chunk_any", count = 3, requirement = true },
            { id = "scrap", count = 6 }
        })
    :quality("SAW_M", 1, 1)
    :quality("CUT", 2, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("melee", 2)
    :byproduct("plastic_chunk", 1)
    :byproduct("plastic_chunk", 1)
)

content.add(content.Recipe {
    id = "laser_rifle_cheap",
    result = "laser_rifle_cheap",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "electronics",
    difficulty = 5,
}
    :tool_any({
            { id = "soldering_iron", charges = 200 },
            { id = "soldering_iron_portable", charges = 200 },
            { id = "integrated_welder", charges = 200 }
        })
    :component("afs_circuitry_2", 1)
    :component("cable", 34)
    :component("afs_energy_storage_2", 2)
    :component("afs_optics_3", 1)
    :component("afs_material_1", 6)
    :quality("SCREW_FINE", 1, 1)
    :learn_automatically("electronics", 4)
    :book("advanced_electronics", 3)
    :book("textbook_electronics", 3)
)

content.add(content.Recipe {
    id = "afs_rebar_rifle",
    result = "afs_rebar_rifle",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 2160000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 9,
}
    :tool_any({
            { id = "oxy_torch", charges = 60 },
            { id = "welder", charges = 300 },
            { id = "welder_crude", charges = 450 },
            { id = "integrated_welder", charges = 450 }
        })
    :component("cable", 27)
    :component("afs_circuitry_1", 1)
    :component("2x4", 1)
    :component("afs_energy_storage_3", 4)
    :component("afs_material_1", 6)
    :component("pipe", 3)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :quality("GLARE", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("SAW_W", 1, 1)
    :requires_skill("mechanics", 6)
)

content.add(content.Recipe {
    id = "scrapbow",
    result = "scrapbow",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("afs_material_1", 8)
    :component("afs_circuitry_2", 1)
    :component("afs_energy_storage_1", 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("welding_standard", 3)
    :requires_skill("archery", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
)

content.add(content.Recipe {
    id = "scrapcrossbow",
    result = "scrapcrossbow",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("afs_material_1", 6)
    :component("afs_circuitry_2", 3)
    :component("afs_energy_storage_1", 2)
    :component("afs_magnet_1", 4)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :requirement("welding_standard", 3)
    :requires_skill("rifle", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
)
