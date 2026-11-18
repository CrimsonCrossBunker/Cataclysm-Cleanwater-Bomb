local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "2byshin_guard",
    result = "2byshin_guard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 1)
    :component("cotton_patchwork", 4)
    :quality("CUT", 2, 1)
    :requirement("cordage", 2)
)

content.add(content.Recipe {
    id = "legguard_chitin",
    result = "legguard_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2640000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("armor_chitin", 35)
    :requirement("strap_large", 8)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_leatherworking")
    :byproduct("scrap_leather", 7)
)

content.add(content.Recipe {
    id = "xs_legguard_chitin",
    result = "xs_legguard_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("armor_chitin", 26)
    :requirement("strap_large", 8)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_leatherworking")
    :byproduct("scrap_leather", 4)
)

content.add(content.Recipe {
    id = "xl_legguard_chitin",
    result = "xl_legguard_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("armor_chitin", 45)
    :requirement("strap_large", 8)
    :requirement("tailoring_leather_patchwork", 3)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_leatherworking")
    :byproduct("scrap_leather", 4)
)

content.add(content.Recipe {
    id = "legguard_acidchitin",
    result = "legguard_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("armor_acidchitin", 6)
    :requirement("tailoring_leather_small", 4)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_leatherworking")
    :proficiency("prof_articulation")
    :byproduct("scrap_leather", 92)
)

content.add(content.Recipe {
    id = "xs_legguard_acidchitin",
    result = "xs_legguard_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("armor_acidchitin", 5)
    :requirement("tailoring_leather_small", 3)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_leatherworking")
    :proficiency("prof_articulation")
    :byproduct("scrap_leather", 4)
)

content.add(content.Recipe {
    id = "xl_legguard_acidchitin",
    result = "xl_legguard_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("armor_acidchitin", 7)
    :requirement("tailoring_leather_small", 5)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_leatherworking")
    :proficiency("prof_articulation")
    :byproduct("scrap_leather", 4)
)

content.add(content.Recipe {
    id = "bikini_bottom",
    result = "bikini_bottom",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_lycra_patchwork", 1)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :proficiency("prof_elastics", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :byproduct("scrap_lycra", 1)
)

content.add(content.Recipe {
    id = "chaps_leather",
    result = "chaps_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("button_plastic", 5)
    :requirement("tailoring_leather_patchwork", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures")
    :byproduct("leather", 6)
    :byproduct("scrap_leather", 1)
)

content.add(content.Recipe {
    id = "hot_pants",
    result = "hot_pants",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_lycra_patchwork", 1)
    :requirement("fastener_small", 1)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 3)
    :proficiency("prof_elastics")
    :proficiency("prof_closures")
    :byproduct("lycra_patch", 2)
    :byproduct("scrap_lycra", 2)
)

content.add(content.Recipe {
    id = "hot_pants_fur",
    result = "hot_pants_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_lycra_patchwork", 1)
    :requirement("tailoring_fur", 1)
    :requirement("fastener_small", 1)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 3)
    :proficiency("prof_elastics")
    :proficiency("prof_closures")
    :byproduct("fur", 1)
    :byproduct("scrap_fur", 3)
    :byproduct("scrap_lycra", 2)
)

content.add(content.Recipe {
    id = "hot_pants_leather",
    result = "hot_pants_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather", 1)
    :requirement("fastener_small", 1)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures")
    :byproduct("leather", 5)
)

content.add(content.Recipe {
    id = "jeans",
    result = "jeans",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_denim_patchwork", 8)
    :requirement("fastener_small", 1)
    :book("textbook_tailor", 3)
    :book("tailor_portfolio", 5)
    :book("manual_tailor", 3)
    :book("survival_book", 3)
    :proficiency("prof_closures")
    :byproduct("denim_patch", 6)
    :byproduct("scrap_denim", 15)
)

content.add(content.Recipe {
    id = "jeans_ripped",
    result = "jeans_ripped",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("jeans", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "jeans_mod",
    result = "jeans_mod",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("jeans", 1)
    :component("knee_pads", 1)
    :component("sheet_metal_small", 12)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requirement("sewing_standard", 60)
    :requires_skill("tailor", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "jeans_mod_ch",
    result = "jeans_mod_ch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2700000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("forge", 120)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("jeans", 1)
    :component("knee_pads", 1)
    :component("sheet_metal_small", 12)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requirement("sewing_standard", 60)
    :requirement("carbon", 6)
    :requires_skill("tailor", 3)
    :proficiency("prof_metalworking")
    :proficiency("prof_closures")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "skirt_leather",
    result = "skirt_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :quality("LEATHER_AWL", 1, 1)
    :requirement("fastener_small", 1)
    :requirement("sewing_standard", 15)
    :requirement("tailoring_leather_patchwork", 1)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 5)
    :book("manual_tailor", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 1)
)

content.add(content.Recipe {
    id = "kilt_leather",
    result = "kilt_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 180000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :quality("LEATHER_AWL", 1, 1)
    :requirement("tailoring_leather_patchwork", 7)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :book("scots_tailor", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "knee_pads",
    result = "knee_pads",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :requirement("plastic_molding", 4)
    :requirement("clasps", 2)
    :requirement("strap_small", 2)
    :book("plastics_book", 2)
    :proficiency("prof_plasticworking")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "leg_warmers_xlf",
    result = "leg_warmers_xlf",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_fur_patchwork", 2)
    :book("textbook_tailor", 2)
    :book("manual_tailor", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "legguard_hard",
    result = "legguard_hard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("strap_small", 2)
    :requirement("plastic_molding", 4)
    :requirement("tailoring_neoprene", 1)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 4)
    :book("plastics_book", 2)
    :proficiency("prof_plasticworking")
    :proficiency("prof_elastics")
)

content.add(content.Recipe {
    id = "carpet_legguards",
    result = "carpet_legguards",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "y_carpet", count = 1 },
            { id = "r_carpet", count = 1 },
            { id = "p_carpet", count = 1 },
            { id = "g_carpet", count = 1 }
        })
    :component_any({
            { id = "cordage", count = 4, requirement = true },
            { id = "duct_tape", count = 50 }
        })
    :quality("CUT", 2, 1)
    :byproduct("scrap_carpet", 8)
)

content.add(content.Recipe {
    id = "carpet_greaves",
    result = "carpet_greaves",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component_any({
            { id = "y_carpet", count = 1 },
            { id = "r_carpet", count = 1 },
            { id = "p_carpet", count = 1 },
            { id = "g_carpet", count = 1 }
        })
    :component_any({
            { id = "cordage", count = 2, requirement = true },
            { id = "duct_tape", count = 25 }
        })
    :quality("CUT", 2, 1)
    :byproduct("scrap_carpet", 10)
)

content.add(content.Recipe {
    id = "legguard_metal_sheets",
    result = "legguard_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 1)
    :component("cordage_6_leather", 8)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "xs_legguard_metal_sheets",
    result = "xs_legguard_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 1)
    :component("cordage_6_leather", 8)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "xl_legguard_metal_sheets",
    result = "xl_legguard_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 840000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 2)
    :component("cordage_36_leather", 4)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "ch_legguard_metal_sheets",
    result = "ch_legguard_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 64)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("legguard_metal_sheets", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "legguard_metal_sheets_greaves",
    result = "legguard_metal_sheets_greaves",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 480000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 1)
    :component("cordage_6_leather", 4)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
    :byproduct("sheet_metal_small", 12)
)

content.add(content.Recipe {
    id = "ch_legguard_metal_sheets_greaves",
    result = "ch_legguard_metal_sheets_greaves",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 64)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("legguard_metal_sheets_greaves", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "legguard_metal_sheets_knees",
    result = "legguard_metal_sheets_knees",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal_small", 2)
    :component("cordage_6_leather", 2)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "ch_legguard_metal_sheets_knees",
    result = "ch_legguard_metal_sheets_knees",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 16)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("legguard_metal_sheets_knees", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 1)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "legguard_metal_sheets_hip",
    result = "legguard_metal_sheets_hip",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal", 1)
    :component("leather_belt", 1)
    :component_any({
            { id = "nuts_bolts", count = 8 },
            { id = "nails", count = 8, requirement = true }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "ch_legguard_metal_sheets_hip",
    result = "ch_legguard_metal_sheets_hip",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 64)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("legguard_metal_sheets_hip", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "legguard_metal",
    result = "legguard_metal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :requirement("forging_standard", 6)
    :requirement("bronzesmithing_tools", 1)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :requirement("steel_chunk_any", 12)
    :requires_skill("tailor", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_legguard_metal",
    result = "xs_legguard_metal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :requirement("forging_standard", 4)
    :requirement("bronzesmithing_tools", 1)
    :requirement("strap_small", 3)
    :requirement("clasps", 3)
    :requirement("steel_chunk_any", 9)
    :requires_skill("tailor", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_legguard_metal",
    result = "xl_legguard_metal",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :requirement("forging_standard", 8)
    :requirement("bronzesmithing_tools", 1)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :requirement("steel_chunk_any", 16)
    :requires_skill("tailor", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "legguard_paper",
    result = "legguard_paper",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :requirement("armor_paper", 19)
)

content.add(content.Recipe {
    id = "improvised_legguard_tire",
    result = "improvised_legguard_tire",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :component("rubber_tire_chunk", 4)
    :requirement("adhesive_cordage", 2)
)

content.add(content.Recipe {
    id = "legguard_scrap",
    result = "legguard_scrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 120000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 6)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_legguard_scrap",
    result = "xs_legguard_scrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 120000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 4)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_legguard_scrap",
    result = "xl_legguard_scrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 120000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 8)
    :quality("HAMMER", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "loincloth",
    result = "loincloth",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :requirement("cordage_short", 1)
    :requirement("tailoring_cotton", 2)
)

content.add(content.Recipe {
    id = "loincloth_fur",
    result = "loincloth_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :requirement("cordage_short", 1)
    :requirement("tailoring_fur_patchwork_simple", 2)
)

content.add(content.Recipe {
    id = "loincloth_leather",
    result = "loincloth_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :requirement("cordage_short", 1)
    :requirement("tailoring_leather_patchwork_simple", 2)
)

content.add(content.Recipe {
    id = "loincloth_wool",
    result = "loincloth_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :requirement("cordage_short", 1)
    :requirement("tailoring_felt_patchwork_simple", 2)
)

content.add(content.Recipe {
    id = "armor_mercenary_bottom",
    result = "armor_mercenary_bottom",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("technician_pants_gray", 1)
    :component("sheet_kevlar_layered", 24)
    :requirement("sewing_standard", 90)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "leg_warmers_f",
    result = "leg_warmers_f",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_fur_patchwork", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "leg_warmers_xsf",
    result = "leg_warmers_xsf",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = false,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_fur_patchwork", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("fur", 4)
)

content.add(content.Recipe {
    id = "pants_fur",
    result = "pants_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_fur_patchwork", 4)
    :requirement("fastener_small", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("fur", 3)
)

content.add(content.Recipe {
    id = "pants_faux_fur",
    result = "pants_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_faux_fur_patchwork", 2)
    :requirement("tailoring_cotton", 14)
    :requirement("fastener_small", 1)
    :book("textbook_tailor", 3)
    :book("tailor_portfolio", 3)
    :book("recipe_fauxfur", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("faux_fur", 6)
    :byproduct("cotton_patchwork", 5)
    :byproduct("scrap_faux_fur", 3)
)

content.add(content.Recipe {
    id = "pants_leather",
    result = "pants_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_leather_patchwork", 4)
    :requirement("fastener_small", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 7)
    :byproduct("scrap_leather", 7)
)

content.add(content.Recipe {
    id = "shorts_denim",
    result = "shorts_denim",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("jeans", 1)
    :requirement("sewing_standard", 10)
    :byproduct("denim_patch", 4)
    :byproduct("scrap_denim", 8)
)

content.add(content.Recipe {
    id = "skirt_grass",
    result = "skirt_grass",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "straw_pile", count = 3 },
            { id = "withered", count = 3 }
        })
    :component("cordage_short", 2, true)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "stockings_tent_legs_from_stockings",
    result = "stockings_tent_legs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("stockings", 3)
    :component("cotton_patchwork", 6)
    :requirement("sewing_standard", 6)
)

content.add(content.Recipe {
    id = "lc_chainmail_legs",
    result = "lc_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 4)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_lc_chainmail_legs",
    result = "xs_lc_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 3)
    :requirement("strap_small", 3)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_legs",
    result = "xl_lc_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 6)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_legs",
    result = "mc_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 4)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_mc_chainmail_legs",
    result = "xs_mc_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 3)
    :requirement("strap_small", 3)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_legs",
    result = "xl_mc_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 6)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_legs",
    result = "hc_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 4)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_hc_chainmail_legs",
    result = "xs_hc_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 3)
    :requirement("strap_small", 3)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_legs",
    result = "xl_hc_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 6)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_legs",
    result = "ch_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 4)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_ch_chainmail_legs",
    result = "xs_ch_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 3)
    :requirement("strap_small", 3)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_legs",
    result = "xl_ch_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 6)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_legs",
    result = "qt_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 4)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_qt_chainmail_legs",
    result = "xs_qt_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 3)
    :requirement("strap_small", 3)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_legs",
    result = "xl_qt_chainmail_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 6)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "lc_chainmail_half_legs",
    result = "lc_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 3)
    :requirement("strap_small", 5)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_lc_chainmail_half_legs",
    result = "xs_lc_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 3)
    :requirement("strap_small", 4)
    :requirement("clasps", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_half_legs",
    result = "xl_lc_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1218000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 5)
    :requirement("strap_small", 5)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_half_legs",
    result = "mc_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 3)
    :requirement("strap_small", 5)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_mc_chainmail_half_legs",
    result = "xs_mc_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 3)
    :requirement("strap_small", 4)
    :requirement("clasps", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_half_legs",
    result = "xl_mc_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1218000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 5)
    :requirement("strap_small", 5)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_half_legs",
    result = "hc_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 3)
    :requirement("strap_small", 5)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_hc_chainmail_half_legs",
    result = "xs_hc_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 3)
    :requirement("strap_small", 4)
    :requirement("clasps", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_half_legs",
    result = "xl_hc_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1218000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 5)
    :requirement("strap_small", 5)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_half_legs",
    result = "ch_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 3)
    :requirement("strap_small", 5)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_ch_chainmail_half_legs",
    result = "xs_ch_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 3)
    :requirement("strap_small", 4)
    :requirement("clasps", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_half_legs",
    result = "xl_ch_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1218000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 5)
    :requirement("strap_small", 5)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_half_legs",
    result = "qt_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 3)
    :requirement("strap_small", 5)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_qt_chainmail_half_legs",
    result = "xs_qt_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 3)
    :requirement("strap_small", 4)
    :requirement("clasps", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_half_legs",
    result = "xl_qt_chainmail_half_legs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1218000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 5)
    :requirement("strap_small", 5)
    :requirement("clasps", 3)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "legguard_bronze",
    result = "legguard_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 12)
    :requirement("forging_standard", 6)
    :requirement("bronzesmithing_tools", 1)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("bronze_book", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_articulation", { required = true })
)

content.add(content.Recipe {
    id = "xs_legguard_bronze",
    result = "xs_legguard_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 9)
    :requirement("forging_standard", 4)
    :requirement("bronzesmithing_tools", 1)
    :requirement("strap_small", 3)
    :requirement("clasps", 3)
    :book("bronze_book", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_articulation", { required = true })
)

content.add(content.Recipe {
    id = "xl_legguard_bronze",
    result = "xl_legguard_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 16)
    :requirement("forging_standard", 8)
    :requirement("bronzesmithing_tools", 1)
    :requirement("strap_small", 4)
    :requirement("clasps", 4)
    :book("bronze_book", 4)
    :book("textbook_armwest", 4)
    :book("recipe_melee", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv")
    :proficiency("prof_articulation", { required = true })
)

content.add(content.Recipe {
    id = "armor_lc_light_leg_guard",
    result = "armor_lc_light_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 56160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_lc_light_leg_guard",
    result = "xl_armor_lc_light_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 63456000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_mc_light_leg_guard",
    result = "armor_mc_light_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 56160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_mc_light_leg_guard",
    result = "xl_armor_mc_light_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 63456000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_hc_light_leg_guard",
    result = "armor_hc_light_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 56160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_hc_light_leg_guard",
    result = "xl_armor_hc_light_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 63456000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_ch_light_leg_guard",
    result = "armor_ch_light_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 61776000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :requirement("armor_lc_chainmail_assembling", 1)
    :requirement("carbon", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_armor_ch_light_leg_guard",
    result = "xl_armor_ch_light_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 69804000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :requirement("carbon", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_qt_light_leg_guard",
    result = "armor_qt_light_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 64584000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_light_leg_guard",
    result = "xl_armor_qt_light_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 72978000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_lc_leg_guard",
    result = "armor_lc_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 61776000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_lc_leg_guard",
    result = "xl_armor_lc_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 69804000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_mc_leg_guard",
    result = "armor_mc_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 61776000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_mc_leg_guard",
    result = "xl_armor_mc_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 69804000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_hc_leg_guard",
    result = "armor_hc_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 61776000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_hc_leg_guard",
    result = "xl_armor_hc_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 69804000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_ch_leg_guard",
    result = "armor_ch_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 67950000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :requirement("armor_lc_chainmail_assembling", 1)
    :requirement("carbon", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_armor_ch_leg_guard",
    result = "xl_armor_ch_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 76794000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :requirement("carbon", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_qt_leg_guard",
    result = "armor_qt_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 70968000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_leg_guard",
    result = "xl_armor_qt_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 80274000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_lc_heavy_leg_guard",
    result = "armor_lc_heavy_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 67392000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_lc_heavy_leg_guard",
    result = "xl_armor_lc_heavy_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 76152000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 20)
    :requirement("lc_steel_standard", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_mc_heavy_leg_guard",
    result = "armor_mc_heavy_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 67392000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_mc_heavy_leg_guard",
    result = "xl_armor_mc_heavy_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 76152000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_hc_heavy_leg_guard",
    result = "armor_hc_heavy_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 67392000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_hc_heavy_leg_guard",
    result = "xl_armor_hc_heavy_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 76152000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 20)
    :requirement("hc_steel_standard", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_ch_heavy_leg_guard",
    result = "armor_ch_heavy_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 74130000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :requirement("armor_lc_chainmail_assembling", 1)
    :requirement("carbon", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_armor_ch_heavy_leg_guard",
    result = "xl_armor_ch_heavy_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 83766000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 20)
    :requirement("lc_steel_standard", 5)
    :requirement("carbon", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_qt_heavy_leg_guard",
    result = "armor_qt_heavy_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 77496000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_heavy_leg_guard",
    result = "xl_armor_qt_heavy_leg_guard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 87570000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 20)
    :requirement("mc_steel_standard", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "legguard_larmor",
    result = "legguard_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_patchwork", 5)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 2)
    :byproduct("scrap_leather", 5)
)

content.add(content.Recipe {
    id = "xs_legguard_larmor",
    result = "xs_legguard_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_patchwork", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 6)
    :byproduct("scrap_leather", 1)
)

content.add(content.Recipe {
    id = "xl_legguard_larmor",
    result = "xl_legguard_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_patchwork", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 2)
    :byproduct("scrap_leather", 1)
)

content.add(content.Recipe {
    id = "legguard_lc_brigandine",
    result = "legguard_lc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 4)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_legguard_lc_brigandine",
    result = "xl_legguard_lc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 5)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "legguard_lc_brigandine_xs",
    result = "legguard_lc_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "legguard_mc_brigandine",
    result = "legguard_mc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 4)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_legguard_mc_brigandine",
    result = "xl_legguard_mc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 5)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "legguard_mc_brigandine_xs",
    result = "legguard_mc_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "legguard_hc_brigandine",
    result = "legguard_hc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 4)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_legguard_hc_brigandine",
    result = "xl_legguard_hc_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 5)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "legguard_hc_brigandine_xs",
    result = "legguard_hc_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "legguard_ch_brigandine",
    result = "legguard_ch_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 4)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :requirement("carbon", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_legguard_ch_brigandine",
    result = "xl_legguard_ch_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7920000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 5)
    :requirement("blacksmithing_standard", 16)
    :requirement("lc_steel_standard", 4)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :requirement("carbon", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "legguard_ch_brigandine_xs",
    result = "legguard_ch_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :requirement("carbon", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "legguard_qt_brigandine",
    result = "legguard_qt_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 4)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_legguard_qt_brigandine",
    result = "xl_legguard_qt_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 11520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 5)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 4)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "legguard_qt_brigandine_xs",
    result = "legguard_qt_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "lc_knee_guards",
    result = "lc_knee_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_lc_knee_guards",
    result = "xl_lc_knee_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "lc_knee_guards_xs",
    result = "lc_knee_guards_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "mc_knee_guards",
    result = "mc_knee_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_mc_knee_guards",
    result = "xl_mc_knee_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "mc_knee_guards_xs",
    result = "mc_knee_guards_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "hc_knee_guards",
    result = "hc_knee_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_hc_knee_guards",
    result = "xl_hc_knee_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "hc_knee_guards_xs",
    result = "hc_knee_guards_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "ch_knee_guards",
    result = "ch_knee_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :requirement("carbon", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_knee_guards",
    result = "xl_ch_knee_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :requirement("carbon", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "ch_knee_guards_xs",
    result = "ch_knee_guards_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :requirement("carbon", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_knee_guards",
    result = "qt_knee_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_qt_knee_guards",
    result = "xl_qt_knee_guards",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "qt_knee_guards_xs",
    result = "qt_knee_guards_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("clasps", 2)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "lc_greaves_brigandine",
    result = "lc_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 2)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 4)
    :book("textbook_weparabic", 4)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_lc_greaves_brigandine",
    result = "xl_lc_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 4)
    :book("textbook_weparabic", 4)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xs_lc_greaves_brigandine",
    result = "xs_lc_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 2)
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 4)
    :book("textbook_weparabic", 4)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "mc_greaves_brigandine",
    result = "mc_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 2)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_mc_greaves_brigandine",
    result = "xl_mc_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xs_mc_greaves_brigandine",
    result = "xs_mc_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 2)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "hc_greaves_brigandine",
    result = "hc_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 2)
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_hc_greaves_brigandine",
    result = "xl_hc_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xs_hc_greaves_brigandine",
    result = "xs_hc_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("hc_steel_standard", 2)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :book("textbook_weparabic", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "ch_greaves_brigandine",
    result = "ch_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6480000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 2)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :requirement("carbon", 1)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_greaves_brigandine",
    result = "xl_ch_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6480000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("blacksmithing_standard", 12)
    :requirement("lc_steel_standard", 3)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :requirement("carbon", 2)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xs_ch_greaves_brigandine",
    result = "xs_ch_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6480000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 1)
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :requirement("carbon", 1)
    :book("textbook_armwest", 6)
    :book("textbook_weparabic", 6)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_greaves_brigandine",
    result = "qt_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 2)
    :requirement("blacksmithing_standard", 8)
    :requirement("mc_steel_standard", 2)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 7)
    :book("textbook_weparabic", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_qt_greaves_brigandine",
    result = "xl_qt_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("blacksmithing_standard", 12)
    :requirement("mc_steel_standard", 3)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 7)
    :book("textbook_weparabic", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xs_qt_greaves_brigandine",
    result = "xs_qt_greaves_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("CHISEL", 3, 1)
    :quality("DRILL", 3, 1)
    :requirement("tailoring_canvas_patchwork", 2)
    :requirement("blacksmithing_standard", 4)
    :requirement("mc_steel_standard", 1)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 7)
    :book("textbook_weparabic", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)
