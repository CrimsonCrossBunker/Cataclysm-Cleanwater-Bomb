local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.replace(content.Recipe {
    id = "chem_black_powder",
    result = "chem_black_powder",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_COMPONENTS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 4,
}
    :component("chem_saltpetre", 10)
    :component("chem_sulphur", 23)
    :component("charcoal", 1)
    :quality("CONTAIN", 1, 1)
    :result_charges(470)
)

content.add(content.Recipe {
    id = "chem_black_powder_generic",
    result = "chem_black_powder",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_COMPONENTS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "hotplate", charges = 50 },
            { id = "integrated_welder", charges = 50 }
        })
    :component("oxy_powder", 200)
    :component_any({
            { id = "ammonia_liquid", count = 2 },
            { id = "lye_powder", count = 200 }
        })
    :component("charcoal", 25)
    :quality("CHEM", 2, 1)
    :requires_skill("chemistry", 3)
)

content.replace(content.Recipe {
    id = "sword_xiphos",
    result = "sword_xiphos",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("casting_mold", 1)
    :component_any({
            { id = "cotton_patchwork", count = 1 },
            { id = "felt_patch", count = 1 },
            { id = "leather", count = 1 },
            { id = "fur", count = 1 },
            { id = "duct_tape", count = 50 },
            { id = "cordage_short", count = 2, requirement = true },
            { id = "filament", count = 100, requirement = true }
        })
    :component("scrap_bronze", 4)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 2)
    :requirement("bronzesmithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
)

content.replace(content.Recipe {
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
    :component("stick", 1)
    :component("nails", 2, true)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :quality("CUT_FINE", 1, 1)
    :quality("FILE", 1, 1)
    :requires_skill("gun", 3)
    :book("manual_fabrication", 2)
    :book("manual_pistol", 3)
    :book("manual_shotgun", 4)
    :book("manual_smg", 4)
    :book("manual_rifle", 4)
    :book("manual_launcher", 4)
    :proficiency("prof_carving", { time_multiplier = 1.5 })
)

content.replace(content.Recipe {
    id = "spear_dory",
    result = "spear_dory",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("casting_mold", 1)
    :component("scrap_bronze", 2)
    :component("stick_long", 1)
    :quality("CUT", 2, 1)
    :quality("GRIND", 2, 1)
    :requirement("forging_standard", 1)
    :requirement("bronzesmithing_tools", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_carving", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "soaking_spear_shaft_using_stone_tools",
    result = "soaking_spear_shaft",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 1800000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("stick_long", 1)
    :component("wood_sealant_any", 1, true)
    :quality("CUT", 2, 1)
    :quality("SAW_W", 1, 1)
    :quality("FILE", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.25 })
    :byproduct("splinter", 12)
)

content.replace(content.Recipe {
    id = "rifle_flintlock",
    result = "rifle_flintlock",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :component("2x4", 2)
    :component("pipe", 1)
    :component("sharp_rock", 1)
    :quality("ANVIL", 3, 1)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 3, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("forging_standard", 4)
    :requirement("steel_standard", 3)
    :requires_skill("traps", 2)
    :requires_skill("rifle", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.replace(content.Recipe {
    id = "longrifle_flintlock",
    result = "longrifle_flintlock",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 9,
}
    :tool("metalworking_tongs", 1)
    :tool("hotcut", 1)
    :component("2x4", 2)
    :component("pipe", 1)
    :component("sharp_rock", 1)
    :quality("ANVIL", 3, 1)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 3, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("forging_standard", 6)
    :requirement("steel_standard", 3)
    :requires_skill("traps", 2)
    :requires_skill("rifle", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.replace(content.Recipe {
    id = "carbine_flintlock",
    result = "carbine_flintlock",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("metalworking_tongs", 1)
    :tool("hotcut", 1)
    :component("2x4", 2)
    :component("pipe", 1)
    :component("sharp_rock", 1)
    :quality("ANVIL", 3, 1)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 3, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("forging_standard", 3)
    :requirement("steel_standard", 3)
    :requires_skill("traps", 2)
    :requires_skill("rifle", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.replace(content.Recipe {
    id = "pistol_flintlock",
    result = "pistol_flintlock",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("metalworking_tongs", 1)
    :tool("hotcut", 1)
    :component("2x4", 1)
    :component("pipe", 1)
    :component("sharp_rock", 1)
    :quality("ANVIL", 3, 1)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 3, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("forging_standard", 2)
    :requirement("steel_standard", 3)
    :requires_skill("traps", 2)
    :requires_skill("pistol", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.replace(content.Recipe {
    id = "carbine_flintlock_double",
    result = "carbine_flintlock_double",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("2x4", 2)
    :component("pipe", 2)
    :component("sharp_rock", 2)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW", 1, 1)
    :requirement("forging_standard", 2)
    :requirement("steel_standard", 1)
    :requires_skill("traps", 2)
    :requires_skill("rifle", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
    :proficiency("prof_carving", { time_multiplier = 1.5, skill_penalty = 0.15 })
)

content.replace(content.Recipe {
    id = "carbine_flintlock_double_from_antiques",
    result = "carbine_flintlock_double",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
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
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
)

content.replace(content.Recipe {
    id = "hand_crossbow",
    result = "hand_crossbow",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 3 }
        })
    :component("cordage_superior_short", 1, true)
    :component("spring", 1)
    :component("scrap", 4)
    :component("nails", 10, true)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 2, 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requires_skill("traps", 1)
    :requires_skill("archery", 2)
    :learn_by_disassembly("fabrication", 3)
    :proficiency("prof_bowyery", { time_multiplier = 1.5, skill_penalty = 0.15 })
    :proficiency("prof_gunsmithing_spring")
)

content.replace(content.Recipe {
    id = "crossbow",
    result = "crossbow",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
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
    :proficiency("prof_bowyery", { time_multiplier = 1.5, skill_penalty = 0.15 })
    :proficiency("prof_gunsmithing_spring")
)

content.replace(content.Recipe {
    id = "compositecrossbow",
    result = "compositecrossbow",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 3600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
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
    :proficiency("prof_bowyery", { time_multiplier = 1.5, skill_penalty = 0.15 })
    :proficiency("prof_gunsmithing_spring")
    :proficiency("prof_carving", { time_multiplier = 1.5 })
)

content.replace(content.Recipe {
    id = "bullet_crossbow",
    result = "bullet_crossbow",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
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
    :proficiency("prof_bowyery", { time_multiplier = 1.5, skill_penalty = 0.15 })
    :proficiency("prof_gunsmithing_spring")
)

content.add(content.Recipe {
    id = "cannon_3in_ordnance",
    result = "cannon_3in_ordnance",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 14400000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :quality("ANVIL", 3, 1)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 3, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("CHISEL", 3, 1)
    :requirement("forging_standard", 40)
    :requirement("steel_standard", 410)
    :requires_skill("traps", 2)
    :requires_skill("rifle", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_gunsmithing_basic")
    :proficiency("prof_gunsmithing_antique")
)
