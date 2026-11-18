local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "2byarm_guard",
    result = "2byarm_guard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("2x4", 1)
    :component("cotton_patchwork", 2)
    :quality("CUT", 2, 1)
    :requirement("cordage_short", 2)
)

-- Time has gotten shorter but is double requirement time due to making a pair
content.add(content.Recipe {
    id = "arm_warmers",
    result = "arm_warmers",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 1)
    :byproduct("scrap_cotton", 3)
)

content.add(content.Recipe {
    id = "xs_arm_warmers",
    result = "xs_arm_warmers",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 1)
    :byproduct("scrap_cotton", 11)
)

content.add(content.Recipe {
    id = "xl_arm_warmers",
    result = "xl_arm_warmers",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 420000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 2)
    :byproduct("scrap_cotton", 21)
)

content.add(content.Recipe {
    id = "armguard_chitin",
    result = "armguard_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1500000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("armor_chitin", 14)
    :requirement("strap_large", 8)
    :requirement("tailoring_leather_patchwork", 1)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_leatherworking")
    :byproduct("scrap_leather", 4)
)

content.add(content.Recipe {
    id = "xs_armguard_chitin",
    result = "xs_armguard_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("armor_chitin", 11)
    :requirement("strap_large", 8)
    :requirement("tailoring_leather_patchwork", 1)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_leatherworking")
    :byproduct("scrap_leather", 4)
)

content.add(content.Recipe {
    id = "xl_armguard_chitin",
    result = "xl_armguard_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("armor_chitin", 18)
    :requirement("strap_large", 8)
    :requirement("tailoring_leather_patchwork", 1)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_leatherworking")
    :byproduct("scrap_leather", 4)
)

content.add(content.Recipe {
    id = "armguard_acidchitin",
    result = "armguard_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("armor_acidchitin", 3)
    :requirement("tailoring_leather_small", 2)
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
    id = "xs_armguard_acidchitin",
    result = "xs_armguard_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("armor_acidchitin", 2)
    :requirement("tailoring_leather_small", 1)
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
    id = "xl_armguard_acidchitin",
    result = "xl_armguard_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2640000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("armor_acidchitin", 4)
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
    id = "armguard_hard",
    result = "armguard_hard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1560000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :requirement("plastic_molding", 2)
    :requirement("tailoring_neoprene_patchwork", 2)
    :requires_skill("tailor", 2)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 4)
    :book("tailor_portfolio", 3)
    :proficiency("prof_polymerworking")
    :proficiency("prof_plasticworking")
    :byproduct("scrap_neoprene", 4)
)

content.add(content.Recipe {
    id = "xs_armguard_hard",
    result = "xs_armguard_hard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1560000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :requirement("plastic_molding", 1)
    :requirement("tailoring_neoprene_patchwork", 1)
    :requires_skill("tailor", 2)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 4)
    :book("tailor_portfolio", 3)
    :proficiency("prof_polymerworking")
    :proficiency("prof_plasticworking")
    :byproduct("scrap_neoprene", 2)
)

content.add(content.Recipe {
    id = "xl_armguard_hard",
    result = "xl_armguard_hard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1740000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :requirement("plastic_molding", 3)
    :requirement("tailoring_neoprene_patchwork", 3)
    :requires_skill("tailor", 2)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 4)
    :book("tailor_portfolio", 3)
    :proficiency("prof_polymerworking")
    :proficiency("prof_plasticworking")
    :byproduct("scrap_neoprene", 6)
)

content.add(content.Recipe {
    id = "armguard_larmor",
    result = "armguard_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_patchwork", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 2)
    :byproduct("scrap_leather", 5)
)

content.add(content.Recipe {
    id = "xs_armguard_larmor",
    result = "xs_armguard_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_patchwork", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 6)
    :byproduct("scrap_leather", 1)
)

content.add(content.Recipe {
    id = "xl_armguard_larmor",
    result = "xl_armguard_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
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
    :byproduct("scrap_leather", 1)
)

content.add(content.Recipe {
    id = "carpet_armguards",
    result = "carpet_armguards",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
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
    :byproduct("scrap_carpet", 10)
)

content.add(content.Recipe {
    id = "carpet_bracers",
    result = "carpet_bracers",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
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
    :byproduct("scrap_carpet", 12)
)

content.add(content.Recipe {
    id = "armguard_metal",
    result = "armguard_metal",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
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
    id = "ch_armguard_metal",
    result = "ch_armguard_metal",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 64)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("armguard_metal", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xs_armguard_metal",
    result = "xs_armguard_metal",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
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
    id = "xl_armguard_metal",
    result = "xl_armguard_metal",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
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
    id = "armguard_metal_sheets_bracer",
    result = "armguard_metal_sheets_bracer",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
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
    id = "ch_armguard_metal_sheets_bracer",
    result = "ch_armguard_metal_sheets_bracer",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 64)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("armguard_metal_sheets_bracer", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 3)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armguard_metal_sheets_elbows",
    result = "armguard_metal_sheets_elbows",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
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
    id = "ch_armguard_metal_sheets_elbows",
    result = "ch_armguard_metal_sheets_elbows",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 16)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("armguard_metal_sheets_elbows", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 2)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armguard_metal_sheets_shoulders",
    result = "armguard_metal_sheets_shoulders",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal_small", 4)
    :component_any({
            { id = "cordage_6_leather", count = 6 },
            { id = "cordage_36_leather", count = 1 }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "ch_armguard_metal_sheets_shoulders",
    result = "ch_armguard_metal_sheets_shoulders",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 16)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("armguard_metal_sheets_shoulders", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 1)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armguard_paper",
    result = "armguard_paper",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 228000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    flags = { "BLIND_HARD" },
}
    :requirement("armor_paper", 19)
)

content.add(content.Recipe {
    id = "improvised_armguard_tire",
    result = "improvised_armguard_tire",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
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
    id = "armguard_scrap",
    result = "armguard_scrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 6)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_armguard_scrap",
    result = "xs_armguard_scrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 4)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("cordage", 1)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armguard_scrap",
    result = "xl_armguard_scrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 210000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 8)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("cordage", 2)
    :requirement("mixed_steel", 1)
    :book("recipe_melee", 2)
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armguard_soft",
    result = "armguard_soft",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1680000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 4)
    :requirement("tailoring_neoprene_patchwork", 3)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 4)
    :book("tailor_portfolio", 3)
    :proficiency("prof_polymerworking")
    :byproduct("scrap_cotton", 11)
    :byproduct("scrap_neoprene", 3)
)

content.add(content.Recipe {
    id = "xs_armguard_soft",
    result = "xs_armguard_soft",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1680000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 3)
    :requirement("tailoring_neoprene_patchwork", 3)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 4)
    :book("tailor_portfolio", 3)
    :proficiency("prof_polymerworking")
    :byproduct("scrap_cotton", 8)
    :byproduct("scrap_neoprene", 5)
)

content.add(content.Recipe {
    id = "xl_armguard_soft",
    result = "xl_armguard_soft",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1890000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 5)
    :requirement("tailoring_neoprene_patchwork", 4)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 4)
    :book("tailor_portfolio", 3)
    :proficiency("prof_polymerworking")
    :byproduct("scrap_cotton", 10)
    :byproduct("scrap_neoprene", 1)
    :byproduct("neoprene", 2)
)

content.add(content.Recipe {
    id = "elbow_pads",
    result = "elbow_pads",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :requirement("plastic_molding", 1)
    :requirement("tailoring_cotton_patchwork", 2)
    :requires_skill("tailor", 1)
    :proficiency("prof_plasticworking")
    :byproduct("scrap_cotton", 5)
    :byproduct("cotton_patchwork", 2)
)

content.add(content.Recipe {
    id = "stockings_tent_arms",
    result = "stockings_tent_arms",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1980000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 11)
    :byproduct("scrap_cotton", 25)
)

content.add(content.Recipe {
    id = "stockings_tent_arms_from_stockings",
    result = "stockings_tent_arms",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("stockings", 4)
    :requirement("sewing_standard", 8)
)

content.add(content.Recipe {
    id = "vambrace_larmor",
    result = "vambrace_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather_patchwork", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("leather", 2)
    :byproduct("scrap_leather", 2)
)

content.add(content.Recipe {
    id = "xs_vambrace_larmor",
    result = "xs_vambrace_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("scrap_leather", 1)
)

content.add(content.Recipe {
    id = "xl_vambrace_larmor",
    result = "xl_vambrace_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("scrap_leather", 2)
)

content.add(content.Recipe {
    id = "lc_chainmail_arms",
    result = "lc_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 3)
    :requirement("tailoring_cotton_patchwork", 8)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 1)
    :byproduct("scrap_cotton", 66)
)

content.add(content.Recipe {
    id = "xs_lc_chainmail_arms",
    result = "xs_lc_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 2)
    :requirement("tailoring_cotton_patchwork", 6)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 1)
    :byproduct("scrap_cotton", 49)
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_arms",
    result = "xl_lc_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5670000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 4)
    :requirement("tailoring_cotton_patchwork", 11)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 3)
    :byproduct("scrap_cotton", 86)
)

content.add(content.Recipe {
    id = "mc_chainmail_arms",
    result = "mc_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 3)
    :requirement("tailoring_cotton_patchwork", 8)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 1)
    :byproduct("scrap_cotton", 66)
)

content.add(content.Recipe {
    id = "xs_mc_chainmail_arms",
    result = "xs_mc_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 2)
    :requirement("tailoring_cotton_patchwork", 6)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 1)
    :byproduct("scrap_cotton", 49)
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_arms",
    result = "xl_mc_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5670000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 4)
    :requirement("tailoring_cotton_patchwork", 11)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 3)
    :byproduct("scrap_cotton", 86)
)

content.add(content.Recipe {
    id = "hc_chainmail_arms",
    result = "hc_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 3)
    :requirement("tailoring_cotton_patchwork", 8)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 1)
    :byproduct("scrap_cotton", 66)
)

content.add(content.Recipe {
    id = "xs_hc_chainmail_arms",
    result = "xs_hc_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 2)
    :requirement("tailoring_cotton_patchwork", 6)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 1)
    :byproduct("scrap_cotton", 49)
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_arms",
    result = "xl_hc_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5670000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 4)
    :requirement("tailoring_cotton_patchwork", 11)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 3)
    :byproduct("scrap_cotton", 86)
)

content.add(content.Recipe {
    id = "ch_chainmail_arms",
    result = "ch_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 3)
    :requirement("tailoring_cotton_patchwork", 8)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 1)
    :byproduct("scrap_cotton", 66)
)

content.add(content.Recipe {
    id = "xs_ch_chainmail_arms",
    result = "xs_ch_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 2)
    :requirement("tailoring_cotton_patchwork", 6)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 1)
    :byproduct("scrap_cotton", 49)
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_arms",
    result = "xl_ch_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5670000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 4)
    :requirement("tailoring_cotton_patchwork", 11)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 3)
    :byproduct("scrap_cotton", 86)
)

content.add(content.Recipe {
    id = "qt_chainmail_arms",
    result = "qt_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 3)
    :requirement("tailoring_cotton_patchwork", 8)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 1)
    :byproduct("scrap_cotton", 66)
)

content.add(content.Recipe {
    id = "xs_qt_chainmail_arms",
    result = "xs_qt_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 2)
    :requirement("tailoring_cotton_patchwork", 6)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 1)
    :byproduct("scrap_cotton", 49)
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_arms",
    result = "xl_qt_chainmail_arms",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5670000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 4)
    :requirement("tailoring_cotton_patchwork", 11)
    :requires_skill("tailor", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour", { required = false, time_multiplier = 3 })
    :proficiency("prof_articulation", { required = false, time_multiplier = 2, skill_penalty = 0.15 })
    :byproduct("cotton_patchwork", 3)
    :byproduct("scrap_cotton", 86)
)

content.add(content.Recipe {
    id = "armguard_bronze",
    result = "armguard_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2700000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 10)
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
    id = "xs_armguard_bronze",
    result = "xs_armguard_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2700000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 7)
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
    id = "xl_armguard_bronze",
    result = "xl_armguard_bronze",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3060000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("scrap_bronze", 14)
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
    id = "armor_lc_lightarmguard",
    result = "armor_lc_lightarmguard",
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
    :requirement("armor_lc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_lc_lightarmguard",
    result = "xl_armor_lc_lightarmguard",
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
    :requirement("armor_lc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_mc_lightarmguard",
    result = "armor_mc_lightarmguard",
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
    :requirement("armor_mc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_mc_lightarmguard",
    result = "xl_armor_mc_lightarmguard",
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
    :requirement("armor_mc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_hc_lightarmguard",
    result = "armor_hc_lightarmguard",
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
    :requirement("armor_hc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_hc_lightarmguard",
    result = "xl_armor_hc_lightarmguard",
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
    :requirement("armor_hc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_ch_lightarmguard",
    result = "armor_ch_lightarmguard",
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
    :requirement("blacksmithing_standard", 8)
    :requirement("lc_steel_standard", 2)
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
    id = "xl_armor_ch_lightarmguard",
    result = "xl_armor_ch_lightarmguard",
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
    :requirement("armor_lc_chainmail_assembling", 2)
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
    id = "armor_qt_lightarmguard",
    result = "armor_qt_lightarmguard",
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
    :requirement("armor_mc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_lightarmguard",
    result = "xl_armor_qt_lightarmguard",
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
    :requirement("armor_mc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_lc_armguard",
    result = "armor_lc_armguard",
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
    :requirement("armor_lc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_lc_armguard",
    result = "xl_armor_lc_armguard",
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
    :requirement("armor_lc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_mc_armguard",
    result = "armor_mc_armguard",
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
    :requirement("armor_mc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_mc_armguard",
    result = "xl_armor_mc_armguard",
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
    :requirement("armor_mc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_hc_armguard",
    result = "armor_hc_armguard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 61776000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("hc_steel_standard", 3)
    :requirement("armor_hc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_hc_armguard",
    result = "xl_armor_hc_armguard",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 69804000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("fabric_leather_fur_hide", 2)
    :requirement("blacksmithing_standard", 16)
    :requirement("hc_steel_standard", 4)
    :requirement("armor_hc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_ch_armguard",
    result = "armor_ch_armguard",
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
    id = "xl_armor_ch_armguard",
    result = "xl_armor_ch_armguard",
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
    :requirement("armor_lc_chainmail_assembling", 2)
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
    id = "armor_qt_armguard",
    result = "armor_qt_armguard",
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
    :requirement("armor_mc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_armguard",
    result = "xl_armor_qt_armguard",
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
    :requirement("armor_mc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_lc_heavyarmguard",
    result = "armor_lc_heavyarmguard",
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
    :requirement("armor_lc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_lc_heavyarmguard",
    result = "xl_armor_lc_heavyarmguard",
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
    :requirement("armor_lc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_mc_heavyarmguard",
    result = "armor_mc_heavyarmguard",
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
    :requirement("armor_mc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_mc_heavyarmguard",
    result = "xl_armor_mc_heavyarmguard",
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
    :requirement("armor_mc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_hc_heavyarmguard",
    result = "armor_hc_heavyarmguard",
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
    :requirement("armor_hc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_armor_hc_heavyarmguard",
    result = "xl_armor_hc_heavyarmguard",
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
    :requirement("armor_hc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "armor_ch_heavyarmguard",
    result = "armor_ch_heavyarmguard",
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
    id = "xl_armor_ch_heavyarmguard",
    result = "xl_armor_ch_heavyarmguard",
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
    :requirement("armor_lc_chainmail_assembling", 2)
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
    id = "armor_qt_heavyarmguard",
    result = "armor_qt_heavyarmguard",
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
    :requirement("armor_mc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_heavyarmguard",
    result = "xl_armor_qt_heavyarmguard",
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
    :requirement("armor_mc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armguard_lc_brigandine",
    result = "armguard_lc_brigandine",
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
    id = "xl_armguard_lc_brigandine",
    result = "xl_armguard_lc_brigandine",
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
    id = "armguard_lc_brigandine_xs",
    result = "armguard_lc_brigandine_xs",
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
    :requirement("tailoring_canvas_patchwork", 2)
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
    id = "armguard_mc_brigandine",
    result = "armguard_mc_brigandine",
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
    id = "xl_armguard_mc_brigandine",
    result = "xl_armguard_mc_brigandine",
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
    id = "armguard_mc_brigandine_xs",
    result = "armguard_mc_brigandine_xs",
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
    :requirement("tailoring_canvas_patchwork", 2)
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
    id = "armguard_hc_brigandine",
    result = "armguard_hc_brigandine",
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
    id = "xl_armguard_hc_brigandine",
    result = "xl_armguard_hc_brigandine",
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
    id = "armguard_hc_brigandine_xs",
    result = "armguard_hc_brigandine_xs",
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
    :requirement("tailoring_canvas_patchwork", 2)
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
    id = "armguard_ch_brigandine",
    result = "armguard_ch_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
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
    id = "xl_armguard_ch_brigandine",
    result = "xl_armguard_ch_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7920000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
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
    :requirement("carbon", 3)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armguard_ch_brigandine_xs",
    result = "armguard_ch_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
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
    id = "armguard_qt_brigandine",
    result = "armguard_qt_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10080000,
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
    id = "xl_armguard_qt_brigandine",
    result = "xl_armguard_qt_brigandine",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 11520000,
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
    id = "armguard_qt_brigandine_xs",
    result = "armguard_qt_brigandine_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10080000,
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
    id = "lc_elbow_guards",
    result = "lc_elbow_guards",
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
    id = "xl_lc_elbow_guards",
    result = "xl_lc_elbow_guards",
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
    id = "lc_elbow_guards_xs",
    result = "lc_elbow_guards_xs",
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
    id = "mc_elbow_guards",
    result = "mc_elbow_guards",
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
    id = "xl_mc_elbow_guards",
    result = "xl_mc_elbow_guards",
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
    id = "mc_elbow_guards_xs",
    result = "mc_elbow_guards_xs",
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
    id = "hc_elbow_guards",
    result = "hc_elbow_guards",
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
    id = "xl_hc_elbow_guards",
    result = "xl_hc_elbow_guards",
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
    id = "hc_elbow_guards_xs",
    result = "hc_elbow_guards_xs",
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
    id = "ch_elbow_guards",
    result = "ch_elbow_guards",
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
    id = "xl_ch_elbow_guards",
    result = "xl_ch_elbow_guards",
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
    id = "ch_elbow_guards_xs",
    result = "ch_elbow_guards_xs",
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
    id = "qt_elbow_guards",
    result = "qt_elbow_guards",
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
    id = "xl_qt_elbow_guards",
    result = "xl_qt_elbow_guards",
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
    id = "qt_elbow_guards_xs",
    result = "qt_elbow_guards_xs",
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
    id = "lc_vambrace_brigandine",
    result = "lc_vambrace_brigandine",
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
    id = "xl_lc_vambrace_brigandine",
    result = "xl_lc_vambrace_brigandine",
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
    id = "xs_lc_vambrace_brigandine",
    result = "xs_lc_vambrace_brigandine",
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
    :requirement("tailoring_canvas_patchwork", 1)
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
    id = "mc_vambrace_brigandine",
    result = "mc_vambrace_brigandine",
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
    id = "xl_mc_vambrace_brigandine",
    result = "xl_mc_vambrace_brigandine",
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
    id = "xs_mc_vambrace_brigandine",
    result = "xs_mc_vambrace_brigandine",
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
    id = "hc_vambrace_brigandine",
    result = "hc_vambrace_brigandine",
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
    :requirement("hc_steel_standard", 1)
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
    id = "xl_hc_vambrace_brigandine",
    result = "xl_hc_vambrace_brigandine",
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
    id = "xs_hc_vambrace_brigandine",
    result = "xs_hc_vambrace_brigandine",
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
    :requirement("blacksmithing_standard", 4)
    :requirement("hc_steel_standard", 1)
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
    id = "ch_vambrace_brigandine",
    result = "ch_vambrace_brigandine",
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
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
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
    id = "xl_ch_vambrace_brigandine",
    result = "xl_ch_vambrace_brigandine",
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
    id = "xs_ch_vambrace_brigandine",
    result = "xs_ch_vambrace_brigandine",
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
    :requirement("blacksmithing_standard", 4)
    :requirement("lc_steel_standard", 1)
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
    id = "qt_vambrace_brigandine",
    result = "qt_vambrace_brigandine",
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

content.add(content.Recipe {
    id = "xl_qt_vambrace_brigandine",
    result = "xl_qt_vambrace_brigandine",
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
    id = "xs_qt_vambrace_brigandine",
    result = "xs_qt_vambrace_brigandine",
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
    :requirement("tailoring_canvas_patchwork", 1)
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
