local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "arredondo_chute_benelli_sa",
    result = "arredondo_chute_benelli_sa",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :component("scrap", 4)
    :component("sheet_metal_small", 4)
    :quality("HAMMER_FINE", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("soldering_standard", 15)
    :requires_skill("gun", 2)
    :book("mag_guns", 4)
    :book("mag_pistol", 4)
    :book("mag_shotgun", 4)
    :book("mag_rifle", 4)
)

content.add(content.Recipe {
    id = "arredondo_chute_remington_870_breacher",
    result = "arredondo_chute_remington_870_breacher",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :component("scrap", 4)
    :component("sheet_metal_small", 4)
    :quality("HAMMER_FINE", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("soldering_standard", 15)
    :requires_skill("gun", 2)
    :book("mag_guns", 4)
    :book("mag_pistol", 4)
    :book("mag_shotgun", 4)
    :book("mag_rifle", 4)
)

content.add(content.Recipe {
    id = "arredondo_chute_remington_870",
    result = "arredondo_chute_remington_870",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :component("scrap", 4)
    :component("sheet_metal_small", 4)
    :quality("HAMMER_FINE", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("soldering_standard", 15)
    :requires_skill("gun", 2)
    :book("mag_guns", 4)
    :book("mag_pistol", 4)
    :book("mag_shotgun", 4)
    :book("mag_rifle", 4)
)

content.add(content.Recipe {
    id = "arredondo_chute_mossberg_500",
    result = "arredondo_chute_mossberg_500",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :component("scrap", 4)
    :component("sheet_metal_small", 4)
    :quality("HAMMER_FINE", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("soldering_standard", 15)
    :requires_skill("gun", 2)
    :book("mag_guns", 4)
    :book("mag_pistol", 4)
    :book("mag_shotgun", 4)
    :book("mag_rifle", 4)
)

content.add(content.Recipe {
    id = "arredondo_chute_mossberg_930",
    result = "arredondo_chute_mossberg_930",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :component("scrap", 4)
    :component("sheet_metal_small", 4)
    :quality("HAMMER_FINE", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("soldering_standard", 15)
    :requires_skill("gun", 2)
    :book("mag_guns", 4)
    :book("mag_pistol", 4)
    :book("mag_shotgun", 4)
    :book("mag_rifle", 4)
)

content.add(content.Recipe {
    id = "arredondo_chute_mossberg_590",
    result = "arredondo_chute_mossberg_590",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :component("scrap", 4)
    :component("sheet_metal_small", 4)
    :quality("HAMMER_FINE", 1, 1)
    :quality("DRILL", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("soldering_standard", 15)
    :requires_skill("gun", 2)
    :book("mag_guns", 4)
    :book("mag_pistol", 4)
    :book("mag_shotgun", 4)
    :book("mag_rifle", 4)
)

-- Remove these four simple recipes when obselete arredondo_chute.
content.add(content.Recipe {
    id = "arredondo_chute_benelli_sa_simple",
    result = "arredondo_chute_benelli_sa",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("arredondo_chute", 1)
    :requires_skill("gun", 2)
)

content.add(content.Recipe {
    id = "arredondo_chute_remington_870_breacher_simple",
    result = "arredondo_chute_remington_870_breacher",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("arredondo_chute", 1)
    :requires_skill("gun", 2)
)

content.add(content.Recipe {
    id = "arredondo_chute_remington_870_simple",
    result = "arredondo_chute_remington_870",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("arredondo_chute", 1)
    :requires_skill("gun", 2)
)

content.add(content.Recipe {
    id = "arredondo_chute_mossberg_500_simple",
    result = "arredondo_chute_mossberg_500",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("arredondo_chute", 1)
    :requires_skill("gun", 2)
)

content.add(content.Recipe {
    id = "arredondo_chute_mossberg_930_simple",
    result = "arredondo_chute_mossberg_930",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("arredondo_chute", 1)
    :requires_skill("gun", 2)
)

content.add(content.Recipe {
    id = "arredondo_chute_mossberg_590_simple",
    result = "arredondo_chute_mossberg_590",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("arredondo_chute", 1)
    :requires_skill("gun", 2)
)

content.add(content.Recipe {
    id = "bow_sight_pin",
    result = "bow_sight_pin",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("scrap", 1)
    :component("plastic_chunk", 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("soldering_standard", 8)
    :requires_skill("archery", 2)
    :book("manual_gun", 3)
    :book("mag_archery", 2)
    :book("manual_archery", 1)
)

content.add(content.Recipe {
    id = "bow_stabilizer_set",
    result = "bow_stabilizer_set",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :component("plastic_chunk", 2)
    :component("scrap", 4)
    :quality("CUT", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("archery", 3)
    :book("mag_archery", 3)
    :book("manual_archery", 2)
    :proficiency("prof_plasticworking")
)

-- a2 birdcage has a 22mm diameter = 69mm circumference, so ~7cm weld
content.add(content.Recipe {
    id = "filter_suppressor_welded_thread",
    result = "filter_suppressor",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 15600,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "compensator", count = 1 },
            { id = "muzzle_brake", count = 1 }
        })
    :component("filter_liquid", 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("welding_standard", 7)
    :requires_skill("mechanics", 2)
    :proficiency("prof_welding_basic")
)

-- a2 birdcage has a 22mm diameter = 69mm circumference, so ~14cm weld since the sheets are stacked
content.add(content.Recipe {
    id = "filter_suppressor",
    result = "filter_suppressor",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("filter_liquid", 1)
    :component("pipe", 1)
    :quality("DRILL", 3, 1)
    :quality("FILE", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("THREAD_TAP", 2, 1)
    :requirement("welding_standard", 14)
    :requires_skill("mechanics", 2)
)

content.add(content.Recipe {
    id = "bow_silencer",
    result = "bow_silencer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("chunk_rubber", 1)
    :component("glue_strong", 5)
    :quality("CUT", 2, 1)
    :requires_skill("archery", 2)
    :book("mag_archery", 1)
    :book("manual_archery", 1)
)

content.add(content.Recipe {
    id = "primitive_bow_silencer",
    result = "primitive_bow_silencer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("fur", 1)
    :component("glue_weak", 150)
    :quality("CUT", 2, 1)
    :requires_skill("archery", 2)
    :book("mag_archery", 1)
    :book("manual_archery", 1)
)

content.add(content.Recipe {
    id = "u_shotgun",
    result = "u_shotgun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 6,
}
    :component("pipe", 2)
    :component("duct_tape", 75)
    :component("nails", 2, true)
    :quality("SAW_M_FINE", 1, 1)
    :requires_skill("shotgun", 3)
    :book("manual_shotgun", 4)
    :book("mag_shotgun", 5)
)

content.add(content.Recipe {
    id = "shoulder_strap_simple",
    result = "shoulder_strap_simple",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "rope_natural_short", count = 1, requirement = true },
            { id = "cotton_patchwork", count = 3 },
            { id = "cordage", count = 6, requirement = true }
        })
    :quality("CUT", 1, 1)
)

-- This should be using plastic sliders, but we don't have any.
content.add(content.Recipe {
    id = "shoulder_strap",
    result = "shoulder_strap",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("scrap", 2)
    :component("plastic_chunk", 2)
    :quality("HAMMER", 2, 1)
    :requirement("tailoring_nylon_patchwork", 3)
)

content.add(content.Recipe {
    id = "pistol_bayonet",
    result = "pistol_bayonet",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("spike", 1)
    :requirement("cordage_short", 2)
)

content.add(content.Recipe {
    id = "brass_catcher",
    result = "brass_catcher",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 390000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("cotton_patchwork", 4)
    :requirement("sewing_standard", 4)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "big_brass_catcher",
    result = "big_brass_catcher",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("canvas_patch", 8)
    :requirement("sewing_standard", 8)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "compensator",
    result = "compensator",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 4,
}
    :component("pipe", 1)
    :quality("DRILL", 3, 1)
    :quality("FILE", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("THREAD_TAP", 2, 1)
    :requires_skill("gun", 3)
    :book("textbook_mechanics", 3)
    :book("manual_pistol", 4)
    :book("manual_shotgun", 4)
    :book("manual_smg", 4)
    :book("manual_rifle", 4)
)

-- 20cm weld
content.add(content.Recipe {
    id = "bipod",
    result = "bipod",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "scrap", count = 6 },
            { id = "pipe", count = 1 },
            { id = "steel_chunk_any", count = 2, requirement = true }
        })
    :component("plastic_chunk", 3)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("welding_standard", 20)
    :requires_skill("gun", 2)
    :book("manual_fabrication", 2)
    :book("manual_rifle", 3)
    :book("manual_launcher", 3)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.25, learning_time_multiplier = 0.1 })
)

content.add(content.Recipe {
    id = "grip",
    result = "grip",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 90000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("soldering_standard", 10, true)
    :component_any({
            { id = "scrap", count = 3 },
            { id = "steel_chunk_any", count = 1, requirement = true }
        })
    :component("plastic_chunk", 2)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("gun", 3)
    :book("manual_fabrication", 3)
    :book("manual_pistol", 3)
    :book("manual_shotgun", 4)
    :book("manual_smg", 4)
    :book("manual_rifle", 4)
    :book("manual_launcher", 4)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.25, learning_time_multiplier = 0.1 })
)

content.add(content.Recipe {
    id = "wooden_grip",
    result = "wooden_grip",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 300000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rolling_pin", 1)
    :component("nails", 2, true)
    :quality("HAMMER_FINE", 1, 1)
    :quality("CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :quality("FILE", 2, 1)
    :requires_skill("gun", 3)
    :book("manual_fabrication", 2)
    :book("manual_pistol", 3)
    :book("manual_shotgun", 4)
    :book("manual_smg", 4)
    :book("manual_rifle", 4)
    :book("manual_launcher", 4)
    :proficiency("prof_carving", { time_multiplier = 1.5 })
)

-- a2 birdcage has a 22mm diameter = 69mm circumference, so ~7cm weld
content.add(content.Recipe {
    id = "muzzle_brake_welded_thread",
    result = "muzzle_brake",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 4,
}
    :component("compensator", 1)
    :component("pipe", 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("welding_standard", 7)
    :requires_skill("gun", 4)
    :book("manual_shotgun", 5)
    :book("manual_rifle", 5)
    :proficiency("prof_welding_basic")
)

-- a2 birdcage has a 22mm diameter = 69mm circumference, so ~7cm weld
content.add(content.Recipe {
    id = "muzzle_brake",
    result = "muzzle_brake",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 6,
}
    :component("sheet_metal_small", 2)
    :component("pipe", 1)
    :quality("FILE", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("THREAD_TAP", 2, 1)
    :requirement("welding_standard", 7)
    :requires_skill("gun", 4)
    :book("manual_shotgun", 5)
    :book("manual_rifle", 5)
    :proficiency("prof_welding_basic")
)

content.add(content.Recipe {
    id = "rail_bayonet_lug",
    result = "rail_bayonet_lug",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "knife_combat", count = 1 },
            { id = "knife_combat_army", count = 1 },
            { id = "knife_combat_marine", count = 1 },
            { id = "sword_bayonet", count = 1 }
        })
    :component("nuts_bolts", 2)
    :component("scrap", 2)
    :quality("FILE", 2, 1)
    :quality("GRIND", 1, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 1)
    :requires_skill("gun", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
)

-- Pipe/sheet metal is to add trip to non M16-style carriers, since both types are in civilian AR's.
-- 30cm weld
content.add(content.Recipe {
    id = "dias",
    result = "dias",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 840000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "modular_ar15", count = 1 },
            { id = "modular_ar_pistol", count = 1 },
            { id = "modular_m27_assault_rifle", count = 1 },
            { id = "modular_m16_auto_rifle", count = 1 },
            { id = "modular_m4_carbine", count = 1 },
            { id = "modular_m16a4", count = 1 }
        })
    :component_any({
            { id = "steel_plate", count = 1 },
            { id = "steel_lump_any", count = 2, requirement = true }
        })
    :component_any({
            { id = "pipe", count = 1 },
            { id = "sheet_metal_small", count = 1 }
        })
    :component("scrap", 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("DRILL", 1, 1)
    :requirement("welding_standard", 30)
    :requires_skill("rifle", 3)
    :book("textbook_anarch", 5)
)

-- Simple to manufacture, hence it's not gonna be in published in too much detail in gun-mags.
-- source for it https://texasguntalk.com/attachments/ar15lightninglinkplans-pdf.228985/
content.add(content.Recipe {
    id = "llink",
    result = "llink",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "modular_ar15", count = 1 },
            { id = "modular_ar_pistol", count = 1 }
        })
    :tool_charges("dremel", 5)
    :component("sheet_metal_small", 2)
    :quality("DRILL", 3, 1)
    :quality("FILE", 2, 1)
    :requires_skill("rifle", 3)
    :book("manual_rifle", 6)
    :book("textbook_anarch", 3)
)

-- 5cm weld
content.add(content.Recipe {
    id = "glocksear",
    result = "glocksear",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 1950000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "glock_19", count = 1 },
            { id = "glock_17", count = 1 },
            { id = "glock_22", count = 1 },
            { id = "glock_31", count = 1 },
            { id = "glock_21", count = 1 },
            { id = "glock_20", count = 1 },
            { id = "glock_29", count = 1 }
        })
    :tool_any({
            { id = "small_repairkit", charges = 40 },
            { id = "large_repairkit", charges = 40 }
        })
    :component("steel_chunk_any", 1, true)
    :component("scrap", 4)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("DRILL", 1, 1)
    :requirement("welding_standard", 5)
    :requires_skill("pistol", 3)
    :book("manual_pistol", 5)
    :book("textbook_anarch", 5)
)

content.add(content.Recipe {
    id = "bow_stabilizer",
    result = "bow_stabilizer",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("plastic_chunk", 2)
    :quality("CUT", 2, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("archery", 3)
    :book("mag_archery", 3)
    :book("manual_archery", 2)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "arrowrest",
    result = "arrowrest",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("plastic_chunk", 1)
    :quality("CUT", 2, 1)
    :requirement("soldering_standard", 5)
    :requires_skill("archery", 1)
    :book("mag_archery", 2)
    :book("manual_archery", 1)
)

content.add(content.Recipe {
    id = "arrowrest_wood",
    result = "arrowrest_wood",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("splinter", 1)
    :component("cordage_short", 2, true)
    :quality("CUT", 2, 1)
    :requires_skill("archery", 1)
    :book("mag_archery", 2)
    :book("manual_archery", 1)
)

content.add(content.Recipe {
    id = "choke",
    result = "choke",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 8,
}
    :component("pipe", 1)
    :quality("FILE", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("THREAD_TAP", 2, 1)
    :quality("HAMMER_FINE", 1, 1)
    :requires_skill("gun", 1)
    :book("manual_shotgun", 4)
)

-- 20cm weld
content.add(content.Recipe {
    id = "m249semi",
    result = "m249semi",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 4,
}
    :tool("m249", 1)
    :tool_any({
            { id = "small_repairkit", charges = 40 },
            { id = "large_repairkit", charges = 40 }
        })
    :component("sheet_metal_small", 6)
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 20)
    :requires_skill("rifle", 4)
    :book("manual_rifle", 6)
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_basic")
)

-- 20cm weld
content.add(content.Recipe {
    id = "m240semi",
    result = "m240semi",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 4,
}
    :tool("m240", 1)
    :tool_any({
            { id = "small_repairkit", charges = 40 },
            { id = "large_repairkit", charges = 40 }
        })
    :component("sheet_metal_small", 5)
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 20)
    :requires_skill("rifle", 4)
    :book("manual_rifle", 6)
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_basic")
)

content.add(content.Recipe {
    id = "muzzle_weight",
    result = "muzzle_weight",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "forge", charges = 150 },
            { id = "oxy_torch", charges = 150 }
        })
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("material_aluminium_ingot", 1)
    :quality("ANVIL", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("pistol", 3)
    :requires_skill("gun", 1)
    :book("manual_pistol", 3)
    :book("text_gunsmith", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :byproduct("scrap_aluminum", 3)
)

content.add(content.Recipe {
    id = "muzzle_pistol_weight",
    result = "muzzle_pistol_weight",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "forge", charges = 150 },
            { id = "oxy_torch", charges = 150 }
        })
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("material_aluminium_ingot", 1)
    :quality("ANVIL", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("pistol", 3)
    :requires_skill("gun", 1)
    :book("manual_pistol", 3)
    :book("text_gunsmith", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :byproduct("scrap_aluminum", 3)
)
