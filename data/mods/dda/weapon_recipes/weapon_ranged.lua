local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

-- 50cm weld
content.add(content.Recipe {
    id = "chemical_thrower",
    result = "chemical_thrower",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("pipe", 2)
    :component_any({
            { id = "hose", count = 2 },
            { id = "makeshift_hose", count = 2 }
        })
    :component_any({
            { id = "steel_lump_any", count = 1, requirement = true },
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 12 }
        })
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("HAMMER", 2, 1)
    :requirement("welding_standard", 50)
    :requires_skill("mechanics", 2)
    :requires_skill("launcher", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "staff_sling",
    result = "staff_sling",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("stick_long", 1)
    :component("sling", 1)
    :quality("SAW_W", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("throw", 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "rifle_38",
    result = "rifle_38",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("pipe", 1)
    :component("2x4", 1)
    :component("scrap", 2)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "rifle_44",
    result = "rifle_44",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("pipe", 1)
    :component("2x4", 1)
    :component("scrap", 2)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "rifle_flintlock",
    result = "rifle_flintlock",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :component("2x4", 2)
    :component("pipe", 1)
    :component("hc_steel_chunk", 1)
    :component("flint", 1)
    :quality("CUT", 2, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 13)
    :requirement("steel_standard", 3)
    :requires_skill("traps", 2)
    :requires_skill("rifle", 4)
    :book("manual_rifle", 5)
    :book("mag_rifle", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "longrifle_flintlock",
    result = "longrifle_flintlock",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :component("2x4", 2)
    :component("pipe", 1)
    :component("hc_steel_chunk", 1)
    :component("flint", 1)
    :quality("CUT", 2, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 13)
    :requirement("steel_standard", 3)
    :requires_skill("traps", 2)
    :requires_skill("rifle", 4)
    :book("manual_rifle", 5)
    :book("mag_rifle", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "carbine_flintlock",
    result = "carbine_flintlock",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :component("2x4", 2)
    :component("pipe", 1)
    :component("hc_steel_chunk", 1)
    :component("flint", 1)
    :quality("CUT", 2, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 13)
    :requirement("steel_standard", 3)
    :requires_skill("traps", 2)
    :requires_skill("rifle", 4)
    :book("manual_rifle", 5)
    :book("mag_rifle", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "pistol_flintlock",
    result = "pistol_flintlock",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :component("2x4", 1)
    :component("pipe", 1)
    :component("hc_steel_chunk", 1)
    :component("flint", 1)
    :quality("CUT", 2, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 13)
    :requirement("steel_standard", 3)
    :requires_skill("traps", 2)
    :requires_skill("pistol", 4)
    :book("manual_pistol", 5)
    :book("mag_pistol", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "carbine_flintlock_double",
    result = "carbine_flintlock_double",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component("2x4", 2)
    :component("pipe", 2)
    :component("hc_steel_chunk", 2)
    :component("flint", 2)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :requirement("blacksmithing_standard", 6)
    :requirement("steel_standard", 1)
    :requires_skill("traps", 2)
    :requires_skill("rifle", 3)
    :book("manual_rifle", 3)
    :book("mag_rifle", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "carbine_flintlock_double_from_antiques",
    result = "carbine_flintlock_double",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "rifle_flintlock", count = 2 },
            { id = "carbine_flintlock", count = 2 }
        })
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("rifle", 1)
    :book("manual_rifle", 2)
    :book("mag_rifle", 3)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
)

content.add(content.Recipe {
    id = "speargun",
    result = "speargun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 2 }
        })
    :component("hose", 4)
    :component("scrap", 4)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("archery", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_spring")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "doublespeargun",
    result = "doublespeargun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "2x4", count = 3 },
            { id = "stick", count = 3 }
        })
    :component("hose", 8)
    :component("scrap", 6)
    :quality("SAW_M", 1, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("archery", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_spring")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

-- 40cm weld
content.add(content.Recipe {
    id = "slamfire_shotgun",
    result = "slamfire_shotgun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "shot_00", count = 1 },
            { id = "shot_bird", count = 1 },
            { id = "shot_dragon", count = 1 },
            { id = "shot_flechette", count = 1 },
            { id = "shot_slug", count = 1 },
            { id = "shot_scrap", count = 1 },
            { id = "shot_beanbag", count = 1 },
            { id = "reloaded_shot_00", count = 1 },
            { id = "reloaded_shot_bird", count = 1 },
            { id = "reloaded_shot_dragon", count = 1 },
            { id = "reloaded_shot_flechette", count = 1 },
            { id = "reloaded_shot_slug", count = 1 },
            { id = "bp_shot_00", count = 1 },
            { id = "bp_shot_bird", count = 1 },
            { id = "bp_shot_dragon", count = 1 },
            { id = "bp_shot_flechette", count = 1 },
            { id = "bp_shot_slug", count = 1 },
            { id = "bp_shot_scrap", count = 1 },
            { id = "shot_hull", count = 1 }
        })
    :component("pipe", 2)
    :component("nails", 1, true)
    :component("scrap", 3)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 1, 1)
    :requirement("welding_standard", 40)
    :requires_skill("gun", 1)
    :book("manual_shotgun", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "slamfire_shotgun_without_welding",
    result = "slamfire_shotgun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "shot_00", count = 1 },
            { id = "shot_bird", count = 1 },
            { id = "shot_dragon", count = 1 },
            { id = "shot_flechette", count = 1 },
            { id = "shot_slug", count = 1 },
            { id = "shot_scrap", count = 1 },
            { id = "shot_beanbag", count = 1 },
            { id = "reloaded_shot_00", count = 1 },
            { id = "reloaded_shot_bird", count = 1 },
            { id = "reloaded_shot_dragon", count = 1 },
            { id = "reloaded_shot_flechette", count = 1 },
            { id = "reloaded_shot_slug", count = 1 },
            { id = "bp_shot_00", count = 1 },
            { id = "bp_shot_bird", count = 1 },
            { id = "bp_shot_dragon", count = 1 },
            { id = "bp_shot_flechette", count = 1 },
            { id = "bp_shot_slug", count = 1 },
            { id = "bp_shot_scrap", count = 1 },
            { id = "shot_hull", count = 1 }
        })
    :component("pipe", 2)
    :component("nails", 1, true)
    :component("pipe_fittings", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("DRILL", 2, 1)
    :requires_skill("traps", 1)
    :requires_skill("gun", 1)
    :book("manual_shotgun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "slamfire_shotgun_d_with_tape",
    result = "slamfire_shotgun_d",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
}
    :component("slamfire_shotgun", 2)
    :component("duct_tape", 100)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_improv")
)

-- 80cm weld
content.add(content.Recipe {
    id = "slamfire_shotgun_d",
    result = "slamfire_shotgun_d",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "shot_00", count = 1 },
            { id = "shot_bird", count = 1 },
            { id = "shot_dragon", count = 1 },
            { id = "shot_flechette", count = 1 },
            { id = "shot_slug", count = 1 },
            { id = "shot_scrap", count = 1 },
            { id = "shot_beanbag", count = 1 },
            { id = "reloaded_shot_00", count = 1 },
            { id = "reloaded_shot_bird", count = 1 },
            { id = "reloaded_shot_dragon", count = 1 },
            { id = "reloaded_shot_flechette", count = 1 },
            { id = "reloaded_shot_slug", count = 1 },
            { id = "bp_shot_00", count = 1 },
            { id = "bp_shot_bird", count = 1 },
            { id = "bp_shot_dragon", count = 1 },
            { id = "bp_shot_flechette", count = 1 },
            { id = "bp_shot_slug", count = 1 },
            { id = "bp_shot_scrap", count = 1 },
            { id = "shot_hull", count = 1 }
        })
    :component("pipe", 4)
    :component("nails", 2, true)
    :component("scrap", 6)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 1, 1)
    :requirement("welding_standard", 80)
    :requires_skill("gun", 1)
    :book("manual_shotgun", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_improv")
)

-- 20cm weld
content.add(content.Recipe {
    id = "slamfire_shotgun_d_welded_together",
    result = "slamfire_shotgun_d",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("slamfire_shotgun", 2)
    :component("scrap", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 1, 1)
    :requirement("welding_standard", 20)
    :requires_skill("gun", 1)
    :book("manual_shotgun", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_improv")
)

-- 80cm weld
content.add(content.Recipe {
    id = "slamfire_shotgun_d_bolted_and_welded",
    result = "slamfire_shotgun_d",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
}
    :tool_any({
            { id = "shot_00", count = 1 },
            { id = "shot_bird", count = 1 },
            { id = "shot_dragon", count = 1 },
            { id = "shot_flechette", count = 1 },
            { id = "shot_slug", count = 1 },
            { id = "shot_scrap", count = 1 },
            { id = "shot_beanbag", count = 1 },
            { id = "reloaded_shot_00", count = 1 },
            { id = "reloaded_shot_bird", count = 1 },
            { id = "reloaded_shot_dragon", count = 1 },
            { id = "reloaded_shot_flechette", count = 1 },
            { id = "reloaded_shot_slug", count = 1 },
            { id = "bp_shot_00", count = 1 },
            { id = "bp_shot_bird", count = 1 },
            { id = "bp_shot_dragon", count = 1 },
            { id = "bp_shot_flechette", count = 1 },
            { id = "bp_shot_slug", count = 1 },
            { id = "bp_shot_scrap", count = 1 },
            { id = "shot_hull", count = 1 }
        })
    :component("pipe", 4)
    :component("nails", 2, true)
    :component("pipe_fittings", 2)
    :component("scrap", 3)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("DRILL", 2, 1)
    :requirement("welding_standard", 80)
    :requires_skill("gun", 1)
    :book("manual_shotgun", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "smg_9mm",
    result = "smg_9mm",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 5760000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("metal_file", 1)
    :tool_charges("angle_grinder", 100)
    :tool_charges("belt_grinder", 100)
    :tool("pin_reamer", 1)
    :tool("bench_vise", 1)
    :component("pipe", 2)
    :component("sheet_metal", 5)
    :component("nuts_bolts", 15)
    :component("scrap", 33)
    :component("qt_wire", 1)
    :component("spring_medium", 1)
    :quality("DRILL", 3, 1)
    :quality("SAW_M", 2, 1)
    :quality("HAMMER", 3, 1)
    :requires_skill("gun", 2)
    :book("text_gunsmith", 3)
    :book("textbook_anarch", 4)
    :book("manual_smg", 4)
    :proficiency("prof_gunsmithing_improv")
    :proficiency("prof_gunsmithing_basic")
)

content.add(content.Recipe {
    id = "smg_40",
    result = "smg_40",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 5760000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("metal_file", 1)
    :tool_charges("angle_grinder", 100)
    :tool_charges("belt_grinder", 100)
    :tool("pin_reamer", 1)
    :tool("bench_vise", 1)
    :component("pipe", 2)
    :component("sheet_metal", 5)
    :component("nuts_bolts", 15)
    :component("scrap", 33)
    :component("qt_wire", 1)
    :component("spring_medium", 1)
    :quality("DRILL", 3, 1)
    :quality("SAW_M", 2, 1)
    :quality("HAMMER", 3, 1)
    :requires_skill("gun", 2)
    :book("text_gunsmith", 3)
    :book("textbook_anarch", 4)
    :book("manual_smg", 4)
    :proficiency("prof_gunsmithing_improv")
    :proficiency("prof_gunsmithing_basic")
)

content.add(content.Recipe {
    id = "smg_45",
    result = "smg_45",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 5760000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("metal_file", 1)
    :tool_charges("angle_grinder", 100)
    :tool_charges("belt_grinder", 100)
    :tool("pin_reamer", 1)
    :tool("bench_vise", 1)
    :component("pipe", 2)
    :component("sheet_metal", 5)
    :component("nuts_bolts", 15)
    :component("scrap", 33)
    :component("qt_wire", 1)
    :component("spring_medium", 1)
    :quality("DRILL", 3, 1)
    :quality("SAW_M", 2, 1)
    :quality("HAMMER", 3, 1)
    :requires_skill("gun", 2)
    :book("text_gunsmith", 3)
    :book("textbook_anarch", 4)
    :book("manual_smg", 4)
    :proficiency("prof_gunsmithing_improv")
    :proficiency("prof_gunsmithing_basic")
)

content.add(content.Recipe {
    id = "briefcase_smg",
    result = "briefcase_smg",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
}
    :component("hk_mp5k", 1)
    :component("hk_briefcase", 1)
)

content.add(content.Recipe {
    id = "throwing_stick",
    result = "throwing_stick",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("CUT", 1, 1)
    :requires_skill("fabrication", 1)
    :proficiency("prof_carving", { time_multiplier = 4, skill_penalty = 0.5 })
)

content.add(content.Recipe {
    id = "bolas",
    result = "bolas",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("rope_natural_short", 3, true)
    :component("rock", 3)
    :quality("CUT", 1, 1)
    :requires_skill("fabrication", 2)
)

content.add(content.Recipe {
    id = "net",
    result = "net",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 420000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component("cordage", 32, true)
    :component("rock", 8)
    :quality("CUT", 2, 1)
    :requirement("sewing_standard", 40)
    :requires_skill("tailor", 2)
    :proficiency("prof_fibers", { time_multiplier = 4, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "sling",
    result = "sling",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("filament", 20, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("SEW", 1, 1)
    :requires_skill("throw", 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "sling_cord",
    result = "sling",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :requirement("cordage", 3)
    :requires_skill("throw", 1)
    :proficiency("prof_fibers", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "sling_long_cord",
    result = "sling_long",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :requirement("cordage", 6)
    :requires_skill("throw", 1)
    :proficiency("prof_fibers", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "sling_long",
    result = "sling_long",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("filament", 40, true)
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("SEW", 1, 1)
    :requires_skill("throw", 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "slingshot",
    result = "slingshot",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("hose", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "bullwhip",
    result = "bullwhip",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("leather", 20)
    :component("rope_superior_short", 2, true)
    :quality("CUT", 2, 1)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "longbow",
    result = "longbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "stick_long", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("cordage_superior", 2, true)
    :quality("CUT", 2, 1)
    :requires_skill("archery", 3)
    :learn_by_disassembly("fabrication", 1)
    :book("manual_archery", 4)
    :book("recipe_bows", 3)
    :book("book_archery", 4)
    :proficiency("prof_bowyery")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "woodgreatbow",
    result = "woodgreatbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 8,
}
    :component_any({
            { id = "stick_long", count = 4 },
            { id = "2x4", count = 4 }
        })
    :component("cordage_superior", 6, true)
    :quality("CUT", 2, 1)
    :requires_skill("archery", 3)
    :learn_by_disassembly("fabrication", 1)
    :book("manual_archery", 6)
    :book("recipe_bows", 5)
    :book("book_archery", 7)
    :proficiency("prof_bowyery")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "selfbow",
    result = "selfbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("cordage", 2, true)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_bowyery")
)

content.add(content.Recipe {
    id = "shortbow",
    result = "shortbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("cordage_superior", 2, true)
    :quality("CUT", 2, 1)
    :requires_skill("archery", 1)
    :learn_by_disassembly("fabrication", 1)
    :book("recipe_bows", 1)
    :book("manual_archery", 2)
    :book("book_archery", 2)
    :proficiency("prof_bowyery")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "reflexbow",
    result = "reflexbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "stick", count = 3 },
            { id = "2x4", count = 2 }
        })
    :component("bone_sturdy", 3, true)
    :component("cordage_superior", 2, true)
    :quality("CUT", 2, 1)
    :requirement("adhesive", 3)
    :requires_skill("archery", 2)
    :book("recipe_bows", 4)
    :book("manual_archery", 5)
    :proficiency("prof_bowyery")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "compositebow",
    result = "compositebow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "stick", count = 3 },
            { id = "2x4", count = 2 }
        })
    :component("bone_sturdy", 3, true)
    :component("cordage_superior", 2, true)
    :quality("CUT", 2, 1)
    :requirement("adhesive", 3)
    :requires_skill("archery", 2)
    :book("recipe_bows", 4)
    :book("manual_archery", 5)
    :proficiency("prof_bowyery")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "compgreatbow",
    result = "compgreatbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool_charges("hotcut_any", 1, true)
    :component("steel_standard", 2, true)
    :component("plastic_chunk", 10)
    :component("sheet_metal_small", 8)
    :component("cordage_superior", 18, true)
    :quality("CUT", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("HAMMER_FINE", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("adhesive", 5)
    :requires_skill("archery", 5)
    :book("recipe_bows", 9)
    :book("welding_book", 8)
    :book("textbook_mechanics", 8)
    :proficiency("prof_bowyery")
    :proficiency("prof_carving")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_plasticworking", { time_multiplier = 1.5, learning_time_multiplier = 0.25 })
)

-- 80cm weld
content.add(content.Recipe {
    id = "revolver_shotgun",
    result = "revolver_shotgun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "shotgun_s", count = 1 },
            { id = "pipe_shotgun", count = 1 }
        })
    :component("pipe", 3)
    :component("spring_medium", 2)
    :component_any({
            { id = "steel_chunk_any", count = 3, requirement = true },
            { id = "scrap", count = 9 }
        })
    :quality("SAW_M_FINE", 1, 1)
    :requirement("welding_standard", 80)
    :requires_skill("traps", 2)
    :requires_skill("gun", 3)
    :book("manual_shotgun", 2)
    :book("manual_pistol", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_revolver")
)

content.add(content.Recipe {
    id = "atlatl",
    result = "atlatl",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :quality("CUT", 2, 1)
    :requires_skill("throw", 2)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "hand_crossbow",
    result = "hand_crossbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 3 }
        })
    :component("cordage_superior_short", 1, true)
    :component("spring_small", 1)
    :component("scrap", 4)
    :component("nails", 10, true)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("archery", 2)
    :learn_by_disassembly("fabrication", 3)
    :book("recipe_bows", 3)
    :book("manual_archery", 5)
    :book("book_archery", 4)
    :proficiency("prof_bowyery", { time_multiplier = 1.5, skill_penalty = 0.15 })
    :proficiency("prof_gunsmithing_spring")
)

content.add(content.Recipe {
    id = "crossbow",
    result = "crossbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :component("scrap", 1)
    :component("cordage_superior", 3, true)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("archery", 2)
    :learn_by_disassembly("fabrication", 2)
    :book("recipe_bows", 2)
    :book("manual_archery", 4)
    :book("book_archery", 3)
    :book("textbook_armschina", 5)
    :proficiency("prof_bowyery", { time_multiplier = 1.5, skill_penalty = 0.15 })
    :proficiency("prof_gunsmithing_spring")
)

content.add(content.Recipe {
    id = "compositecrossbow",
    result = "compositecrossbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "stick", count = 5 },
            { id = "2x4", count = 3 }
        })
    :component("bone_sturdy", 3, true)
    :component("cordage_superior", 1, true)
    :quality("CUT", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("adhesive", 3)
    :requires_skill("traps", 2)
    :requires_skill("archery", 2)
    :book("recipe_bows", 5)
    :book("manual_archery", 6)
    :book("book_archery", 6)
    :book("textbook_armschina", 6)
    :proficiency("prof_bowyery", { time_multiplier = 1.5, skill_penalty = 0.15 })
    :proficiency("prof_gunsmithing_spring")
    :proficiency("prof_carving", { time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "bullet_crossbow",
    result = "bullet_crossbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :component("scrap", 1)
    :component("cordage_superior", 3, true)
    :component("leather", 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("archery", 1)
    :learn_by_disassembly("fabrication", 2)
    :book("recipe_bows", 1)
    :book("manual_archery", 3)
    :book("book_archery", 2)
    :proficiency("prof_bowyery", { time_multiplier = 1.5, skill_penalty = 0.15 })
    :proficiency("prof_gunsmithing_spring")
)

content.add(content.Recipe {
    id = "2_shot_special",
    result = "2_shot_special",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("pipe", 1)
    :component("scrap", 1)
    :component("duct_tape", 50)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "rifle_22",
    result = "rifle_22",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("pipe", 1)
    :component("2x4", 1)
    :component("scrap", 2)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "rifle_45_410",
    result = "rifle_45_410",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("pipe", 1)
    :component("2x4", 1)
    :component("scrap", 2)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "blunderbuss",
    result = "blunderbuss",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("pipe", 1)
    :component("2x4", 1)
    :component("scrap", 2)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "pipe_shotgun",
    result = "pipe_shotgun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("pipe", 1)
    :component("scrap", 2)
    :component("2x4", 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "pipe_double_shotgun",
    result = "pipe_double_shotgun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 900000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 150000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("pipe", 2)
    :component("scrap", 3)
    :component("2x4", 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "m320",
    result = "m320",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "launcher",
}
    :component_any({
            { id = "m320_mod", count = 1 },
            { id = "m320_mod_mod", count = 1 }
        })
    :component("ugl_buttstock", 1)
    :learn_by_disassembly("launcher", 0)
)

content.add(content.Recipe {
    id = "m26_mass_standalone",
    result = "m26_mass_standalone",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "shotgun",
}
    :component("m26_mass", 1)
    :component("m26_mass_stock", 1)
    :learn_by_disassembly("shotgun", 0)
)

-- 160cm weld
content.add(content.Recipe {
    id = "bigun",
    result = "bigun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 4320000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("xlframe", 1)
    :component_any({
            { id = "simple_crank", count = 1 },
            { id = "foot_crank", count = 1 }
        })
    :component("sheet_metal_small", 12)
    :component("pipe", 6)
    :component("chain", 1)
    :component("motor_tiny", 1)
    :component("power_supply", 2)
    :component("cable", 2)
    :component("spring", 7)
    :component("scrap", 2)
    :quality("SAW_M", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("welding_standard", 160)
    :requires_skill("traps", 2)
    :requires_skill("mechanics", 5)
    :requires_skill("gun", 2)
    :book("manual_shotgun", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

-- 50cm weld
content.add(content.Recipe {
    id = "ashot",
    result = "ashot",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 3,
}
    :component("pipe", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :component("scrap", 2)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("welding_standard", 50)
    :requires_skill("gun", 2)
    :book("manual_shotgun", 2)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "ashot_from_gun",
    result = "ashot",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 1,
    name = content.text("%s from shotgun"),
}
    :component("shotgun_s", 1)
    :quality("SAW_M", 2, 1)
    :quality("FILE", 1, 1)
    :requires_skill("gun", 2)
)

content.add(content.Recipe {
    id = "throwing_knife",
    result = "throwing_knife",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :requires_skill("throw", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "throwing_axe",
    result = "throwing_axe",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 3)
    :requirement("steel_chunk_any", 3)
    :requires_skill("throw", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
)

content.add(content.Recipe {
    id = "lawn_dart",
    result = "lawn_dart",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("plastic_chunk", 2)
    :component("scrap", 1)
    :quality("HAMMER", 1, 1)
    :requirement("plastic_molding", 2)
    :requires_skill("throw", 1)
    :proficiency("prof_plasticworking", { time_multiplier = 3 })
)

content.add(content.Recipe {
    id = "ballista",
    result = "ballista",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 5400000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("2x4", 14)
    :component("rope_superior_short", 2, true)
    :component("nails", 60, true)
    :component("nuts_bolts", 60)
    :component_any({
            { id = "simple_crank", count = 1 },
            { id = "foot_crank", count = 1 }
        })
    :component("spring", 4)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("SAW_W", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("steel_standard", 4)
    :requires_skill("mechanics", 3)
    :requires_skill("archery", 1)
    :requires_skill("traps", 2)
    :book("ballista_book", 4)
    :proficiency("prof_carving", { time_multiplier = 2 })
    :proficiency("prof_carpentry_basic", { time_multiplier = 2 })
    :proficiency("prof_gunsmithing_spring")
    :proficiency("prof_metalworking", { time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "huge_crossbow",
    result = "huge_crossbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "2x4", count = 8 },
            { id = "stick", count = 16 }
        })
    :component("rope_superior_short", 2, true)
    :component_any({
            { id = "simple_crank", count = 1 },
            { id = "foot_crank", count = 1 }
        })
    :component("spring_medium", 4)
    :component_any({
            { id = "steel_chunk_any", count = 4, requirement = true },
            { id = "scrap", count = 12 }
        })
    :component("nails", 60, true)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("SAW_W", 1, 1)
    :requires_skill("traps", 2)
    :requires_skill("mechanics", 1)
    :requires_skill("archery", 1)
    :learn_by_disassembly("fabrication", 5)
    :book("recipe_bows", 6)
    :book("textbook_weapwest", 6)
    :proficiency("prof_bowyery", { time_multiplier = 1.5, skill_penalty = 0.15 })
    :proficiency("prof_gunsmithing_spring")
    :proficiency("prof_carving", { time_multiplier = 1.5 })
)

content.add(content.Recipe {
    id = "rep_crossbow",
    result = "rep_crossbow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 4 },
            { id = "stick", count = 8 }
        })
    :component("spring_medium", 1)
    :component("cordage_superior", 1, true)
    :component("nails", 20, true)
    :quality("CUT", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("traps", 2)
    :requires_skill("mechanics", 1)
    :requires_skill("archery", 1)
    :learn_by_disassembly("fabrication", 4)
    :book("recipe_bows", 4)
    :book("textbook_weapeast", 6)
    :proficiency("prof_bowyery", { time_multiplier = 1.5, skill_penalty = 0.15 })
    :proficiency("prof_gunsmithing_spring")
    :proficiency("prof_carving", { time_multiplier = 1.5 })
)

-- 200cm weld
content.add(content.Recipe {
    id = "surv_rocket_launcher",
    result = "surv_rocket_launcher",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1260000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("sheet_metal", 2)
    :component("pilot_light", 2)
    :component("light_battery_cell", 2)
    :component("processor", 2)
    :quality("HAMMER", 3, 1)
    :quality("SAW_M", 1, 1)
    :requirement("welding_standard", 200)
    :requires_skill("traps", 1)
    :requires_skill("launcher", 4)
    :book("manual_launcher", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
    :proficiency("prof_gunsmithing_improv")
)

content.add(content.Recipe {
    id = "bullwhip_razor",
    result = "bullwhip_razor",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component_any({
            { id = "leather", count = 30 },
            { id = "rope_superior_short", count = 2, requirement = true }
        })
    :component_any({
            { id = "scrap", count = 9 },
            { id = "razor_blade", count = 9 }
        })
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "coilgun",
    result = "coilgun",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 5,
}
    :tool("laptop", 1)
    :component("plastic_chunk", 10)
    :component("processor", 1)
    :component("circuit", 2)
    :component("power_supply", 2)
    :component("amplifier", 1)
    :component("e_scrap", 30)
    :component("scrap", 10)
    :component("cable", 34)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("plastic_molding", 7)
    :requirement("glue_any", 1)
    :requires_skill("computer", 3)
    :requires_skill("fabrication", 3)
    :book("advanced_electronics", 5)
    :book("textbook_electronics", 5)
    :book("textbook_anarch", 6)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_electromagnetics")
    :proficiency("prof_gunsmithing_improv")
    :proficiency("prof_plasticworking", { time_multiplier = 1.25, learning_time_multiplier = 0.1 })
)

-- 20cm weld
content.add(content.Recipe {
    id = "pamd68mountable",
    result = "pamd68mountable",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("scrap", 3)
    :component("pamd68", 1)
    :quality("HAMMER", 2, 1)
    :requirement("welding_standard", 20)
    :requirement("metal_punch", 1)
    :requires_skill("mechanics", 2)
    :requires_skill("rifle", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic")
)

content.add(content.Recipe {
    id = "weighted_dart",
    result = "weighted_dart",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component("steel_chunk_any", 1, true)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("fletching", 2, true)
    :component("lead", 4)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :quality("ANVIL", 3, 1)
    :requires_skill("throw", 1)
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "javelin_fletched",
    result = "javelin_fletched",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("fletching", 2, true)
    :quality("CUT", 2, 1)
    :requirement("blacksmithing_standard", 2)
    :requirement("steel_chunk_any", 2)
    :requires_skill("throw", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "javelin_fletched_bronze",
    result = "javelin_fletched_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component_any({
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :component("scrap_bronze", 2)
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("fletching", 2, true)
    :quality("CUT", 2, 1)
    :quality("GRIND", 2, 1)
    :requirement("bronzesmithing_tools", 3)
    :requires_skill("throw", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_fletching")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "air_launcher",
    result = "air_launcher",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 6,
}
    :component("pipe", 2)
    :component_any({
            { id = "hose", count = 1 },
            { id = "makeshift_hose", count = 1 }
        })
    :component("metal_tank_little", 1)
    :component("gasket_plastic", 1)
    :component("plastic_chunk", 2)
    :quality("SAW_M_FINE", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :quality("HAMMER", 2, 1)
    :requirement("plastic_molding", 2)
    :requires_skill("fabrication", 5)
    :book("book_pneumatics", 5)
    :proficiency("prof_pneumatics")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "ruger_1022_auto",
    result = "ruger_1022_auto",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "gun",
    difficulty = 2,
}
    :tool("bench_vise", 1)
    :component("ruger_1022", 1)
    :component("qt_wire", 1)
    :component("sheet_metal_small", 2)
    :component("glue_strong", 5)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 3, 1)
    :quality("HAMMER", 2, 1)
    :quality("FILE", 2, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("traps", 2)
    :requires_skill("fabrication", 3)
    :book("textbook_anarch", 2)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "crude_40mm",
    result = "crude_40mm",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "gun",
    difficulty = 2,
}
    :component_any({
            { id = "m320_mod", count = 1 },
            { id = "m320_mod_mod", count = 1 },
            { id = "m203", count = 1 },
            { id = "m203_mod", count = 1 }
        })
    :component("sheet_metal_small", 2)
    :component("glue_strong", 5)
    :component("2x4", 1)
    :component("nuts_bolts", 10)
    :quality("SAW_W", 2, 1)
    :quality("SAW_M_FINE", 2, 1)
    :quality("DRILL", 2, 1)
    :quality("FILE", 2, 1)
    :quality("SCREW", 1, 1)
    :requires_skill("fabrication", 1)
    :proficiency("prof_gunsmithing_improv")
)
