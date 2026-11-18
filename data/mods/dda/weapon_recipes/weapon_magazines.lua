local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "3006_clip",
    result = "3006_clip",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :requirement("3006_casehead", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 3)
)

content.add(content.Recipe {
    id = "762x39_clip",
    result = "762x39_clip",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :requirement("762_casehead", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 3)
)

content.add(content.Recipe {
    id = "762R_clip",
    result = "762R_clip",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :requirement("762R_casehead", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 3)
)

content.add(content.Recipe {
    id = "clip9mm_10rd",
    result = "clip9mm_10rd",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :requirement("9mm_casehead", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 2)
    :book("mag_pistol", 3)
)

content.add(content.Recipe {
    id = "garandclip",
    result = "garandclip",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("garand", 1)
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :requirement("3006_casehead", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 3)
)

content.add(content.Recipe {
    id = "marlin_tubeloader",
    result = "marlin_tubeloader",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component_any({
            { id = "pipe", count = 1 },
            { id = "scrap", count = 1 }
        })
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 3)
)

content.add(content.Recipe {
    id = "pressurized_tank_chem",
    result = "pressurized_tank_chem",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("metal_tank_little", 1)
    :quality("HAMMER", 2, 1)
    :requirement("welding_standard", 2)
    :requires_skill("mechanics", 3)
)

content.add(content.Recipe {
    id = "survivor223mag",
    result = "survivor223mag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "modular_m27_assault_rifle", count = 1 },
            { id = "modular_m16_auto_rifle", count = 1 },
            { id = "modular_m4_carbine", count = 1 },
            { id = "modular_ar15", count = 1 },
            { id = "m249", count = 1 },
            { id = "modular_m16a4", count = 1 }
        })
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("223_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "ruger_makeshiftmag",
    result = "ruger_makeshiftmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("ruger_mini", 1)
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("223_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "m14_makeshiftmag",
    result = "m14_makeshiftmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "m14ebr", count = 1 },
            { id = "m1a", count = 1 },
            { id = "M24", count = 1 }
        })
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("308_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "hk417_makeshiftmag",
    result = "hk417_makeshiftmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "hk417_13", count = 1 },
            { id = "m110a1", count = 1 }
        })
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("308_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "ar10_makeshiftmag",
    result = "ar10_makeshiftmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("ar10", 1)
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("308_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "steyr_scout_mag_makeshift",
    result = "steyr_scout_mag_makeshift",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("steyr_scout", 1)
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("308_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "g3_makeshiftmag",
    result = "g3_makeshiftmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "hk_g3", count = 1 },
            { id = "m1a", count = 1 }
        })
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("308_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "fal_makeshiftmag",
    result = "fal_makeshiftmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("fn_fal_semi", 1)
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("308_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "scarh_makeshiftmag",
    result = "scarh_makeshiftmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("scar_h", 1)
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("308_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "scarh_makeshiftmag_conversion",
    result = "scarh_makeshiftmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("fal_makeshiftmag", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("DRILL", 1, 1)
)

content.add(content.Recipe {
    id = "scarhmag",
    result = "scarhmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("falmag", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("DRILL", 1, 1)
)

content.add(content.Recipe {
    id = "scarhmag_30rd",
    result = "scarhmag_30rd",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("falbigmag", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("DRILL", 1, 1)
)

content.add(content.Recipe {
    id = "shotbelt_20",
    result = "shotbelt_20",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("cotton_patchwork", 2)
    :requirement("sewing_standard", 40)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "smg_40_mag",
    result = "smg_40_mag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("smg_40", 1)
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("40_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "smg_45_mag",
    result = "smg_45_mag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "mac_10", count = 1 },
            { id = "smg_45", count = 1 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("45_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "ump45_makeshiftmag",
    result = "ump45_makeshiftmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("modular_ump", 1)
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("45_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "thompson_makeshiftmag",
    result = "thompson_makeshiftmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("tommygun", 1)
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("45_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "survivor9mm_mag",
    result = "survivor9mm_mag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "smg_9mm", count = 1 },
            { id = "sten", count = 1 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("duct_tape", 40)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("9mm_casehead", 1)
    :requires_skill("gun", 1)
)

content.add(content.Recipe {
    id = "nailmag",
    result = "nailmag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 48000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("coilgun", 1)
    :tool_any({
            { id = "nail", count = 1 },
            { id = "combatnail", count = 1 }
        })
    :component("sheet_metal_small", 1)
    :component("spring_medium", 1)
    :component("scrap", 1)
    :component("duct_tape", 20)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
)

content.add(content.Recipe {
    id = "stanag20_beowulf",
    result = "stanag20_beowulf",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "modular_ar15", count = 1 },
            { id = "modular_m4_carbine", count = 1 },
            { id = "modular_m27_assault_rifle", count = 1 },
            { id = "modular_m16a4", count = 1 },
            { id = "modular_m16_auto_rifle", count = 1 }
        })
    :tool_any({
            { id = "retool_ar15_50beowulf", count = 1 },
            { id = "retool_ar15_50beowulf_medium", count = 1 },
            { id = "retool_ar15_50beowulf_short", count = 1 }
        })
    :component("stanag20", 1)
    :quality("FILE", 2, 1)
    :quality("GRIND", 1, 1)
    :requirement("50beowulf_casehead", 1)
    :requires_skill("rifle", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 2)
)

content.add(content.Recipe {
    id = "stanag30_beowulf",
    result = "stanag30_beowulf",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "modular_ar15", count = 1 },
            { id = "modular_m4_carbine", count = 1 },
            { id = "modular_m27_assault_rifle", count = 1 },
            { id = "modular_m16a4", count = 1 },
            { id = "modular_m16_auto_rifle", count = 1 }
        })
    :tool_any({
            { id = "retool_ar15_50beowulf", count = 1 },
            { id = "retool_ar15_50beowulf_medium", count = 1 },
            { id = "retool_ar15_50beowulf_short", count = 1 }
        })
    :component("stanag30", 1)
    :quality("FILE", 2, 1)
    :quality("GRIND", 1, 1)
    :requirement("50beowulf_casehead", 1)
    :requires_skill("rifle", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 2)
)

content.add(content.Recipe {
    id = "stanag20ranger_beowulf",
    result = "stanag20ranger_beowulf",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "modular_ar15", count = 1 },
            { id = "modular_m4_carbine", count = 1 },
            { id = "modular_m27_assault_rifle", count = 1 },
            { id = "modular_m16a4", count = 1 },
            { id = "modular_m16_auto_rifle", count = 1 }
        })
    :tool_any({
            { id = "retool_ar15_50beowulf", count = 1 },
            { id = "retool_ar15_50beowulf_medium", count = 1 },
            { id = "retool_ar15_50beowulf_short", count = 1 }
        })
    :component("stanag20ranger", 1)
    :quality("FILE", 2, 1)
    :quality("GRIND", 1, 1)
    :requirement("50beowulf_casehead", 1)
    :requires_skill("rifle", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 2)
)

content.add(content.Recipe {
    id = "stanag30ranger_beowulf",
    result = "stanag30ranger_beowulf",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "modular_ar15", count = 1 },
            { id = "modular_m4_carbine", count = 1 },
            { id = "modular_m27_assault_rifle", count = 1 },
            { id = "modular_m16a4", count = 1 },
            { id = "modular_m16_auto_rifle", count = 1 }
        })
    :tool_any({
            { id = "retool_ar15_50beowulf", count = 1 },
            { id = "retool_ar15_50beowulf_medium", count = 1 },
            { id = "retool_ar15_50beowulf_short", count = 1 }
        })
    :component("stanag30ranger", 1)
    :quality("FILE", 2, 1)
    :quality("GRIND", 1, 1)
    :requirement("50beowulf_casehead", 1)
    :requires_skill("rifle", 1)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 2)
)
