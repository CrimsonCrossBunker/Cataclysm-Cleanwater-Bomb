local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "armor_blarmor",
    result = "armor_blarmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("surface_heat", 20, true)
    :component_any({
            { id = "water", count = 10 },
            { id = "water_clean", count = 10 }
        })
    :component_any({
            { id = "wax_any", count = 2, requirement = true },
            { id = "any_tallow", count = 20, requirement = true },
            { id = "vinegar", count = 10 },
            { id = "pine_bough", count = 20 }
        })
    :component("salt", 50)
    :component("armor_larmor", 1)
    :quality("COOK", 3, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 4)
    :requires_skill("tailor", 3)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 5)
    :book("textbook_survival", 3)
    :book("trappers_companion", 3)
    :book("survival_book", 3)
    :book("textbook_armwest", 6)
    :book("textbook_armschina", 6)
    :proficiency("prof_articulation")
    :proficiency("prof_tanning_basic")
    :proficiency("prof_tanning")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "armor_chitin",
    result = "armor_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "police_belt", count = 1 },
            { id = "fireman_belt", count = 1 }
        })
    :requirement("armor_chitin", 86)
    :requirement("strap_large", 16)
    :requirement("tailoring_leather_patchwork", 7)
    :requires_skill("fabrication", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_arthropod", 6)
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("scrap_leather", 18)
)

content.add(content.Recipe {
    id = "armor_chitin_xs",
    result = "armor_chitin_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4680000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "police_belt", count = 1 },
            { id = "fireman_belt", count = 1 }
        })
    :requirement("armor_chitin", 65)
    :requirement("strap_large", 16)
    :requirement("tailoring_leather_patchwork", 6)
    :requires_skill("fabrication", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_arthropod", 6)
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("scrap_leather", 18)
)

content.add(content.Recipe {
    id = "xl_armor_chitin",
    result = "xl_armor_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "police_belt", count = 1 },
            { id = "fireman_belt", count = 1 }
        })
    :requirement("armor_chitin", 112)
    :requirement("strap_large", 18)
    :requirement("tailoring_leather_patchwork", 9)
    :requires_skill("fabrication", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_arthropod", 6)
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :byproduct("scrap_leather", 18)
)

content.add(content.Recipe {
    id = "armor_acidchitin",
    result = "armor_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :component("acidchitin_piece", 72)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 2)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 7)
    :proficiency("prof_articulation")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "armor_acidchitin_xs",
    result = "armor_acidchitin_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :component("acidchitin_piece", 54)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 1)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 7)
    :proficiency("prof_articulation")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "xl_armor_acidchitin",
    result = "xl_armor_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 8,
}
    :component("acidchitin_piece", 96)
    :quality("CUT_FINE", 1, 1)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 3)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 7)
    :proficiency("prof_articulation")
    :proficiency("prof_chitinworking")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "armor_farmor",
    result = "armor_farmor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_fur_patchwork", 14)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("fur", 2)
)

content.add(content.Recipe {
    id = "armor_farmor_xs",
    result = "armor_farmor_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_fur_patchwork", 11)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("fur", 5)
)

content.add(content.Recipe {
    id = "xl_armor_farmor",
    result = "xl_armor_farmor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_fur_patchwork", 16)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("fur", 6)
)

content.add(content.Recipe {
    id = "armor_larmor",
    result = "armor_larmor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("armor_larmor_chest", 1)
    :component("armguard_larmor", 1)
    :component("legguard_larmor", 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 2)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "armor_larmor_xs",
    result = "armor_larmor_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("armor_larmor_chest_xs", 1)
    :component("xs_armguard_larmor", 1)
    :component("xs_legguard_larmor", 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 2)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "xl_armor_larmor",
    result = "xl_armor_larmor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("xl_armor_larmor_chest", 1)
    :component("xl_armguard_larmor", 1)
    :component("xl_legguard_larmor", 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("cordage", 3)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "armor_lorica",
    result = "armor_lorica",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2688000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("steel_standard", 5)
    :requirement("tailoring_leather_patchwork", 2)
    :book("textbook_armwest", 8)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_armor_lorica",
    result = "xs_armor_lorica",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2688000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 12)
    :requirement("steel_standard", 3)
    :requirement("tailoring_leather_patchwork", 1)
    :book("textbook_armwest", 8)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armor_lorica",
    result = "xl_armor_lorica",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 3060000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 28)
    :requirement("steel_standard", 7)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 8)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_plarmor",
    result = "armor_plarmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "steel_chunk_any", count = 6, requirement = true },
            { id = "scrap", count = 18 }
        })
    :component("armor_larmor", 1)
    :quality("HAMMER", 3, 1)
    :requirement("sewing_standard", 26)
    :requires_skill("tailor", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_armwest", 4)
    :book("textbook_armschina", 4)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_plarmor_xs",
    result = "armor_plarmor_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "steel_chunk_any", count = 5, requirement = true },
            { id = "scrap", count = 14 }
        })
    :component("armor_larmor_xs", 1)
    :quality("HAMMER", 3, 1)
    :requirement("sewing_standard", 19)
    :requires_skill("tailor", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_armwest", 4)
    :book("textbook_armschina", 4)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armor_plarmor",
    result = "xl_armor_plarmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 810000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "steel_chunk_any", count = 8, requirement = true },
            { id = "scrap", count = 24 }
        })
    :component("xl_armor_larmor", 1)
    :quality("HAMMER", 3, 1)
    :requirement("sewing_standard", 38)
    :requires_skill("tailor", 3)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :book("textbook_armwest", 4)
    :book("textbook_armschina", 4)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_samurai",
    result = "armor_samurai",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 3360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 64)
    :requirement("steel_standard", 16)
    :requirement("fabric_standard_nostretch", 10)
    :requirement("tailoring_leather_patchwork", 6)
    :book("textbook_armeast", 8)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_scrapsuit",
    result = "armor_scrapsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 20)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("cordage", 6)
    :requirement("mixed_steel", 3)
    :book("recipe_melee", 2)
    :proficiency("prof_armorsmithing", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_scrapsuit_assembly",
    result = "armor_scrapsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cuirass_scrap", 1)
    :component("armguard_scrap", 1)
    :component("legguard_scrap", 1)
    :requirement("cordage", 2)
    :book("recipe_melee", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_xl_scrapsuit",
    result = "armor_xl_scrapsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 23)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("cordage", 8)
    :requirement("mixed_steel", 5)
    :book("recipe_melee", 2)
    :proficiency("prof_armorsmithing", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_xl_scrapsuit_assembly",
    result = "armor_xl_scrapsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("xl_cuirass_scrap", 1)
    :component("xl_armguard_scrap", 1)
    :component("xl_legguard_scrap", 1)
    :requirement("cordage", 3)
    :book("recipe_melee", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_xs_scrapsuit",
    result = "armor_xs_scrapsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cotton_patchwork", 18)
    :quality("CUT", 2, 1)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :requirement("cordage", 5)
    :requirement("mixed_steel", 3)
    :book("recipe_melee", 2)
    :proficiency("prof_armorsmithing", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_xs_scrapsuit_assembly",
    result = "armor_xs_scrapsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("xs_cuirass_scrap", 1)
    :component("xs_armguard_scrap", 1)
    :component("xl_legguard_scrap", 1)
    :requirement("cordage", 2)
    :book("recipe_melee", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_metal_sheets_assembly",
    result = "armor_metal_sheets",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("chestguard_metal_sheets", 1)
    :component("armguard_metal", 1)
    :component("armguard_metal_sheets_shoulders", 1)
    :component("armguard_metal_sheets_elbows", 1)
    :component("legguard_metal_sheets", 1)
    :component("legguard_metal_sheets_hip", 1)
    :component("legguard_metal_sheets_knees", 1)
)

content.add(content.Recipe {
    id = "armor_ch_metal_sheets_assembly",
    result = "armor_ch_metal_sheets",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("ch_chestguard_metal_sheets", 1)
    :component("ch_armguard_metal", 1)
    :component("ch_armguard_metal_sheets_shoulders", 1)
    :component("ch_armguard_metal_sheets_elbows", 1)
    :component("ch_legguard_metal_sheets", 1)
    :component("ch_legguard_metal_sheets_hip", 1)
    :component("ch_legguard_metal_sheets_knees", 1)
)

content.add(content.Recipe {
    id = "armor_ch_metal_sheets",
    result = "armor_ch_metal_sheets",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 256)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("armor_metal_sheets", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 10)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_metal_sheets_heavy_assembly",
    result = "armor_metal_sheets_heavy",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("chestguard_metal_sheets_heavy", 1)
    :component("armguard_metal", 1)
    :component("armguard_metal_sheets_shoulders", 1)
    :component("armguard_metal_sheets_elbows", 1)
    :component("legguard_metal_sheets", 1)
    :component("legguard_metal_sheets_hip", 1)
    :component("legguard_metal_sheets_knees", 1)
)

content.add(content.Recipe {
    id = "armor_ch_metal_sheets_heavy_assembly",
    result = "armor_ch_metal_sheets_heavy",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("ch_chestguard_metal_sheets_heavy", 1)
    :component("ch_armguard_metal", 1)
    :component("ch_armguard_metal_sheets_shoulders", 1)
    :component("ch_armguard_metal_sheets_elbows", 1)
    :component("ch_legguard_metal_sheets", 1)
    :component("ch_legguard_metal_sheets_hip", 1)
    :component("ch_legguard_metal_sheets_knees", 1)
)

content.add(content.Recipe {
    id = "armor_ch_metal_sheets_heavy",
    result = "armor_ch_metal_sheets_heavy",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 312)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("armor_metal_sheets_heavy", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 8)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "armor_metal_sheets_chain_assembly",
    result = "armor_metal_sheets_chain",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("armor_metal_sheets", 1)
    :component("lc_link_sheet", 2)
    :component("nuts_bolts", 48)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 2, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "armor_metal_sheets_chain_heavy_assembly",
    result = "armor_metal_sheets_chain_heavy",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("armor_metal_sheets_heavy", 1)
    :component("lc_link_sheet", 2)
    :component("nuts_bolts", 48)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 2, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "armor_ch_metal_sheets_chain_assembly",
    result = "armor_ch_metal_sheets_chain",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("armor_ch_metal_sheets", 1)
    :component("ch_link_sheet", 2)
    :component("nuts_bolts", 48)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 2, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "armor_ch_metal_sheets_chain_heavy_assembly",
    result = "armor_ch_metal_sheets_chain_heavy",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("armor_ch_metal_sheets_heavy", 1)
    :component("ch_link_sheet", 2)
    :component("nuts_bolts", 48)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 2, 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "armor_ch_metal_sheets_chain",
    result = "armor_ch_metal_sheets_chain",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5760000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 256)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("armor_metal_sheets_chain", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 10)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_ch_metal_sheets_chain_heavy",
    result = "armor_ch_metal_sheets_chain_heavy",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5760000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 312)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("armor_metal_sheets_chain_heavy", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 8)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "armor_tiresuit_assembly",
    result = "armor_tiresuit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cuirass_tire", 1)
    :component("armguard_tire", 1)
    :component("legguard_tire", 1)
    :requirement("cordage", 1)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_tiresuit",
    result = "armor_tiresuit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("rubber_tire_chunk", 24)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("cordage", 8)
    :book("dieselpunk_tailor", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "lc_chainmail_hauberk",
    result = "lc_chainmail_hauberk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("lc_chainmail_vest", 1)
    :component("lc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "lc_chainmail_hauberk_xs",
    result = "lc_chainmail_hauberk_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("xs_lc_chainmail_vest", 1)
    :component("xs_lc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_hauberk",
    result = "xl_lc_chainmail_hauberk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("xl_lc_chainmail_vest", 1)
    :component("xl_lc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_hauberk",
    result = "mc_chainmail_hauberk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("mc_chainmail_vest", 1)
    :component("mc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_hauberk_xs",
    result = "mc_chainmail_hauberk_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("xs_mc_chainmail_vest", 1)
    :component("xs_mc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_hauberk",
    result = "xl_mc_chainmail_hauberk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("xl_mc_chainmail_vest", 1)
    :component("xl_mc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_hauberk",
    result = "hc_chainmail_hauberk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("hc_chainmail_vest", 1)
    :component("hc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_hauberk_xs",
    result = "hc_chainmail_hauberk_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("xs_hc_chainmail_vest", 1)
    :component("xs_hc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_hauberk",
    result = "xl_hc_chainmail_hauberk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("xl_hc_chainmail_vest", 1)
    :component("xl_hc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_hauberk",
    result = "ch_chainmail_hauberk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("ch_chainmail_vest", 1)
    :component("ch_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_hauberk_xs",
    result = "ch_chainmail_hauberk_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("xs_ch_chainmail_vest", 1)
    :component("xs_ch_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_hauberk",
    result = "xl_ch_chainmail_hauberk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("xl_ch_chainmail_vest", 1)
    :component("xl_ch_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_hauberk",
    result = "qt_chainmail_hauberk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("qt_chainmail_vest", 1)
    :component("qt_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_hauberk_xs",
    result = "qt_chainmail_hauberk_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("xs_qt_chainmail_vest", 1)
    :component("xs_qt_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_hauberk",
    result = "xl_qt_chainmail_hauberk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
    flags = { "NO_RESIZE" },
}
    :component("xl_qt_chainmail_vest", 1)
    :component("xl_qt_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "lc_chainmail_sjumpsuit",
    result = "lc_chainmail_sjumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("lc_chainmail_vest", 1)
    :component("lc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "lc_chainmail_sjumpsuit_xs",
    result = "lc_chainmail_sjumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xs_lc_chainmail_vest", 1)
    :component("xs_lc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_sjumpsuit",
    result = "xl_lc_chainmail_sjumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_lc_chainmail_vest", 1)
    :component("xl_lc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_sjumpsuit",
    result = "mc_chainmail_sjumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("mc_chainmail_vest", 1)
    :component("mc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_sjumpsuit_xs",
    result = "mc_chainmail_sjumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xs_mc_chainmail_vest", 1)
    :component("xs_mc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_sjumpsuit",
    result = "xl_mc_chainmail_sjumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_mc_chainmail_vest", 1)
    :component("xl_mc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_sjumpsuit",
    result = "hc_chainmail_sjumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("hc_chainmail_vest", 1)
    :component("hc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_sjumpsuit_xs",
    result = "hc_chainmail_sjumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xs_hc_chainmail_vest", 1)
    :component("xs_hc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_sjumpsuit",
    result = "xl_hc_chainmail_sjumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_hc_chainmail_vest", 1)
    :component("xl_hc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_sjumpsuit",
    result = "ch_chainmail_sjumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("ch_chainmail_vest", 1)
    :component("ch_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_sjumpsuit_xs",
    result = "ch_chainmail_sjumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xs_ch_chainmail_vest", 1)
    :component("xs_ch_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_sjumpsuit",
    result = "xl_ch_chainmail_sjumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_ch_chainmail_vest", 1)
    :component("xl_ch_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_sjumpsuit",
    result = "qt_chainmail_sjumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("qt_chainmail_vest", 1)
    :component("qt_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_sjumpsuit_xs",
    result = "qt_chainmail_sjumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xs_qt_chainmail_vest", 1)
    :component("xs_qt_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_sjumpsuit",
    result = "xl_qt_chainmail_sjumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_qt_chainmail_vest", 1)
    :component("xl_qt_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "lc_chainmail_jumpsuit",
    result = "lc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("lc_chainmail_sjumpsuit", 1)
    :component("lc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "lc_chainmail_jumpsuit_xs",
    result = "lc_chainmail_jumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("lc_chainmail_sjumpsuit_xs", 1)
    :component("xs_lc_chainmail_arms", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_jumpsuit",
    result = "xl_lc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_lc_chainmail_sjumpsuit", 1)
    :component("xl_lc_chainmail_arms", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "lc_chainmail_jumpsuit_hauberk",
    result = "lc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("lc_chainmail_hauberk", 1)
    :component("lc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "lc_chainmail_jumpsuit_xs_hauberk",
    result = "lc_chainmail_jumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("lc_chainmail_hauberk_xs", 1)
    :component("xs_lc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_jumpsuit_hauberk",
    result = "xl_lc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_lc_chainmail_hauberk", 1)
    :component("xl_lc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_jumpsuit",
    result = "mc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("mc_chainmail_sjumpsuit", 1)
    :component("mc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_jumpsuit_xs",
    result = "mc_chainmail_jumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("mc_chainmail_sjumpsuit_xs", 1)
    :component("xs_mc_chainmail_arms", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_jumpsuit",
    result = "xl_mc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_mc_chainmail_sjumpsuit", 1)
    :component("xl_mc_chainmail_arms", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "mc_chainmail_jumpsuit_hauberk",
    result = "mc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("mc_chainmail_hauberk", 1)
    :component("mc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_jumpsuit_xs_hauberk",
    result = "mc_chainmail_jumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("mc_chainmail_hauberk_xs", 1)
    :component("xs_mc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_jumpsuit_hauberk",
    result = "xl_mc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_mc_chainmail_hauberk", 1)
    :component("xl_mc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_jumpsuit",
    result = "hc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("hc_chainmail_sjumpsuit", 1)
    :component("hc_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_jumpsuit_xs",
    result = "hc_chainmail_jumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("hc_chainmail_sjumpsuit_xs", 1)
    :component("xs_hc_chainmail_arms", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_jumpsuit",
    result = "xl_hc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_hc_chainmail_sjumpsuit", 1)
    :component("xl_hc_chainmail_arms", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "hc_chainmail_jumpsuit_hauberk",
    result = "hc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("hc_chainmail_hauberk", 1)
    :component("hc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_jumpsuit_xs_hauberk",
    result = "hc_chainmail_jumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("hc_chainmail_hauberk_xs", 1)
    :component("xs_hc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_jumpsuit_hauberk",
    result = "xl_hc_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_hc_chainmail_hauberk", 1)
    :component("xl_hc_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_jumpsuit",
    result = "ch_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("ch_chainmail_sjumpsuit", 1)
    :component("ch_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_jumpsuit_xs",
    result = "ch_chainmail_jumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("ch_chainmail_sjumpsuit_xs", 1)
    :component("xs_ch_chainmail_arms", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_jumpsuit",
    result = "xl_ch_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_ch_chainmail_sjumpsuit", 1)
    :component("xl_ch_chainmail_arms", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "ch_chainmail_jumpsuit_hauberk",
    result = "ch_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("ch_chainmail_hauberk", 1)
    :component("ch_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_jumpsuit_xs_hauberk",
    result = "ch_chainmail_jumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("ch_chainmail_hauberk_xs", 1)
    :component("xs_ch_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_jumpsuit_hauberk",
    result = "xl_ch_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_ch_chainmail_hauberk", 1)
    :component("xl_ch_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_jumpsuit",
    result = "qt_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("qt_chainmail_sjumpsuit", 1)
    :component("qt_chainmail_arms", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_jumpsuit_xs",
    result = "qt_chainmail_jumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("qt_chainmail_sjumpsuit_xs", 1)
    :component("xs_qt_chainmail_arms", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_jumpsuit",
    result = "xl_qt_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_qt_chainmail_sjumpsuit", 1)
    :component("xl_qt_chainmail_arms", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "qt_chainmail_jumpsuit_hauberk",
    result = "qt_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("qt_chainmail_hauberk", 1)
    :component("qt_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_jumpsuit_xs_hauberk",
    result = "qt_chainmail_jumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("qt_chainmail_hauberk_xs", 1)
    :component("xs_qt_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_jumpsuit_hauberk",
    result = "xl_qt_chainmail_jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_qt_chainmail_hauberk", 1)
    :component("xl_qt_chainmail_legs", 1)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "lc_chainmail_suit",
    result = "lc_chainmail_suit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("lc_chainmail_hood", 1)
    :component("lc_chainmail_jumpsuit", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_suit",
    result = "xl_lc_chainmail_suit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_lc_chainmail_hood", 1)
    :component("xl_lc_chainmail_jumpsuit", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "lc_chainmail_suit_xs",
    result = "lc_chainmail_suit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xs_lc_chainmail_hood", 1)
    :component("lc_chainmail_jumpsuit_xs", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "mc_chainmail_suit",
    result = "mc_chainmail_suit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("mc_chainmail_hood", 1)
    :component("mc_chainmail_jumpsuit", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_suit",
    result = "xl_mc_chainmail_suit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_mc_chainmail_hood", 1)
    :component("xl_mc_chainmail_jumpsuit", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "mc_chainmail_suit_xs",
    result = "mc_chainmail_suit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xs_mc_chainmail_hood", 1)
    :component("mc_chainmail_jumpsuit_xs", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "hc_chainmail_suit",
    result = "hc_chainmail_suit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("hc_chainmail_hood", 1)
    :component("hc_chainmail_jumpsuit", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_suit",
    result = "xl_hc_chainmail_suit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_hc_chainmail_hood", 1)
    :component("xl_hc_chainmail_jumpsuit", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "hc_chainmail_suit_xs",
    result = "hc_chainmail_suit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xs_hc_chainmail_hood", 1)
    :component("hc_chainmail_jumpsuit_xs", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "ch_chainmail_suit",
    result = "ch_chainmail_suit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("ch_chainmail_hood", 1)
    :component("ch_chainmail_jumpsuit", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_suit",
    result = "xl_ch_chainmail_suit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_ch_chainmail_hood", 1)
    :component("xl_ch_chainmail_jumpsuit", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "ch_chainmail_suit_xs",
    result = "ch_chainmail_suit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xs_ch_chainmail_hood", 1)
    :component("ch_chainmail_jumpsuit_xs", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "qt_chainmail_suit",
    result = "qt_chainmail_suit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("qt_chainmail_hood", 1)
    :component("qt_chainmail_jumpsuit", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_suit",
    result = "xl_qt_chainmail_suit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_qt_chainmail_hood", 1)
    :component("xl_qt_chainmail_jumpsuit", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "qt_chainmail_suit_xs",
    result = "qt_chainmail_suit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xs_qt_chainmail_hood", 1)
    :component("qt_chainmail_jumpsuit_xs", 1)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_chain_armour", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "chainmail_suit_faraday",
    result = "chainmail_suit_faraday",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("qt_chainmail_hood", 1)
    :component("qt_chainmail_vest", 1)
    :component("qt_chainmail_arms", 1)
    :component("qt_chainmail_legs", 1)
    :component("qt_chainmail_hands", 1)
    :component_any({
            { id = "qt_link_sheet", count = 2 },
            { id = "qt_chainmail_feet", count = 1 }
        })
    :component("qt_chain_link", 500)
    :component("cable", 84)
    :component("qt_wire", 5)
    :requirement("chainmail_standard", 20)
    :requirement("fabric_standard_nostretch", 26)
    :requires_skill("electronics", 3)
    :book("textbook_fabrication", 6)
    :book("advanced_electronics", 6)
    :book("textbook_electronics", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
    :proficiency("prof_shock_weapons")
)

content.add(content.Recipe {
    id = "chainmail_suit_faraday_xs",
    result = "chainmail_suit_faraday_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("xs_qt_chainmail_hood", 1)
    :component("xs_qt_chainmail_vest", 1)
    :component("xs_qt_chainmail_arms", 1)
    :component("xs_qt_chainmail_legs", 1)
    :component("xs_qt_chainmail_hands", 1)
    :component_any({
            { id = "qt_link_sheet", count = 2 },
            { id = "xs_qt_chainmail_feet", count = 1 }
        })
    :component("qt_chain_link", 375)
    :component("cable", 67)
    :component("qt_wire", 3)
    :requirement("chainmail_standard", 15)
    :requirement("fabric_standard_nostretch", 19)
    :requires_skill("electronics", 3)
    :book("textbook_fabrication", 6)
    :book("advanced_electronics", 6)
    :book("textbook_electronics", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
    :proficiency("prof_shock_weapons")
)

content.add(content.Recipe {
    id = "xl_chainmail_suit_faraday",
    result = "xl_chainmail_suit_faraday",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("xl_qt_chainmail_hood", 1)
    :component("xl_qt_chainmail_vest", 1)
    :component("xl_qt_chainmail_arms", 1)
    :component("xl_qt_chainmail_legs", 1)
    :component("xl_qt_chainmail_hands", 1)
    :component_any({
            { id = "qt_link_sheet", count = 4 },
            { id = "xl_qt_chainmail_feet", count = 1 }
        })
    :component("qt_chain_link", 750)
    :component("cable", 100)
    :component("qt_wire", 5)
    :requirement("chainmail_standard", 20)
    :requirement("fabric_standard_nostretch", 30)
    :requires_skill("electronics", 3)
    :book("textbook_fabrication", 6)
    :book("advanced_electronics", 6)
    :book("textbook_electronics", 6)
    :proficiency("prof_closures")
    :proficiency("prof_chain_armour")
    :proficiency("prof_shock_weapons")
)

content.add(content.Recipe {
    id = "grass_cloak",
    result = "grass_cloak",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("grass_yarn", 7)
    :requirement("sewing_simple", 15)
)

content.add(content.Recipe {
    id = "cloak",
    result = "cloak",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork_simple", 34)
)

content.add(content.Recipe {
    id = "cloak_denim",
    result = "cloak_denim",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_denim_patchwork", 24)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "cloak_fur",
    result = "cloak_fur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :quality("LEATHER_AWL", 1, 1)
    :requirement("tailoring_fur_patchwork_simple", 7)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :book("survival_book", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "cloak_leather",
    result = "cloak_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 270000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :quality("LEATHER_AWL", 1, 1)
    :requirement("tailoring_leather_patchwork_simple", 8)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "cloak_wool",
    result = "cloak_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_felt_patchwork_simple", 36)
)

content.add(content.Recipe {
    id = "denim_overalls",
    result = "denim_overalls",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 7920000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :quality("FABRIC_CUT", 2, 1)
    :requirement("tailoring_denim_patchwork", 16)
    :requirement("strap_large", 2)
    :proficiency("prof_closures")
    :byproduct("scrap_denim", 20)
)

content.add(content.Recipe {
    id = "entry_suit",
    result = "entry_suit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("sheet_kevlar_layered", 8)
    :component_any({
            { id = "kevlar", count = 1 },
            { id = "ballistic_vest_light", count = 1 },
            { id = "ballistic_vest_esapi", count = 1 },
            { id = "sheet_kevlar_layered", count = 24 }
        })
    :quality("FABRIC_CUT", 2, 1)
    :requirement("sewing_standard", 200)
    :requirement("tailoring_nomex_patchwork", 40)
    :requirement("glue_strong", 1000)
    :requires_skill("tailor", 6)
    :book("textbook_fireman", 8)
    :book("tailor_portfolio", 8)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "entry_suit_xs",
    result = "entry_suit_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("sheet_kevlar_layered", 6)
    :component_any({
            { id = "kevlar", count = 1 },
            { id = "ballistic_vest_light", count = 1 },
            { id = "ballistic_vest_esapi", count = 1 },
            { id = "sheet_kevlar_layered", count = 18 }
        })
    :quality("FABRIC_CUT", 2, 1)
    :requirement("sewing_standard", 150)
    :requirement("tailoring_nomex_patchwork", 30)
    :requirement("glue_strong", 750)
    :requires_skill("tailor", 6)
    :book("textbook_fireman", 8)
    :book("tailor_portfolio", 8)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "xl_entry_suit",
    result = "xl_entry_suit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 2430000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :component("sheet_kevlar_layered", 12)
    :component_any({
            { id = "kevlar", count = 2 },
            { id = "ballistic_vest_light", count = 2 },
            { id = "ballistic_vest_esapi", count = 2 },
            { id = "sheet_kevlar_layered", count = 30 }
        })
    :quality("FABRIC_CUT", 2, 1)
    :requirement("sewing_standard", 300)
    :requirement("tailoring_nomex_patchwork", 50)
    :requirement("glue_strong", 1500)
    :requires_skill("tailor", 6)
    :book("textbook_fireman", 8)
    :book("tailor_portfolio", 8)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "jumpsuit",
    result = "jumpsuit",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 180000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_cotton_patchwork", 20)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
)

content.add(content.Recipe {
    id = "jumpsuit_xs",
    result = "jumpsuit_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 288000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 180000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 15)
    :requirement("tailoring_cotton_patchwork", 15)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
)

content.add(content.Recipe {
    id = "jumpsuit_xl",
    result = "jumpsuit_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 324000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 40)
    :requirement("tailoring_cotton_patchwork", 30)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
)

content.add(content.Recipe {
    id = "jumpsuit_xl_from_jumpsuit",
    result = "jumpsuit_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 228000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 2,
}
    :component("jumpsuit", 1)
    :requirement("sewing_standard", 20)
    :requirement("tailoring_cotton_patchwork", 10)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
)

content.add(content.Recipe {
    id = "kimono",
    result = "kimono",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_cotton_patchwork", 35)
    :book("tailor_japanese", 4)
    :byproduct("cotton_patchwork", 5)
)

content.add(content.Recipe {
    id = "nomex_suit",
    result = "nomex_suit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_nomex_patchwork", 45)
    :book("textbook_fireman", 6)
    :book("tailor_portfolio", 7)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "nomex_suit_xs",
    result = "nomex_suit_xs",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_nomex_patchwork", 34)
    :book("textbook_fireman", 6)
    :book("tailor_portfolio", 7)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "xl_nomex_suit",
    result = "xl_nomex_suit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 2430000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_nomex_patchwork", 52)
    :book("textbook_fireman", 6)
    :book("tailor_portfolio", 7)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "shark_suit_faraday",
    result = "shark_suit_faraday",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
    flags = { "NO_RESIZE" },
}
    :component("shark_suit", 1)
    :component("cable", 17)
    :book("textbook_fabrication", 6)
    :book("advanced_electronics", 6)
    :book("textbook_electronics", 6)
    :proficiency("prof_shock_weapons")
)

content.add(content.Recipe {
    id = "thermal_outfit",
    result = "thermal_outfit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 4,
}
    :component_any({
            { id = "element", count = 18 },
            { id = "crude_heating_element", count = 27 }
        })
    :component("cable", 13)
    :requirement("sewing_standard", 52)
    :requirement("tailoring_cotton_patchwork", 48)
    :requirement("soldering_standard", 100)
    :requires_skill("tailor", 2)
    :book("textbook_fabrication", 3)
    :book("tailor_portfolio", 4)
    :book("textbook_tailor", 3)
    :book("atomic_survival", 3)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "thermal_outfit_thermal_outfit_from_bits",
    result = "thermal_outfit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 4,
}
    :component("thermal_suit", 1)
    :component("thermal_gloves", 1)
    :component("thermal_socks", 1)
    :component("thermal_mask", 1)
    :component("cable", 2)
    :requirement("sewing_standard", 15)
    :requirement("soldering_standard", 10)
    :requires_skill("tailor", 2)
    :book("textbook_fabrication", 3)
    :book("tailor_portfolio", 4)
    :book("textbook_tailor", 3)
    :book("atomic_survival", 3)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "thermal_suit",
    result = "thermal_suit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 4,
}
    :component_any({
            { id = "sheet_cotton", count = 36 },
            { id = "sheet_cotton_patchwork", count = 36 },
            { id = "union_suit", count = 1 }
        })
    :component_any({
            { id = "element", count = 12 },
            { id = "crude_heating_element", count = 18 }
        })
    :component("cable", 7)
    :requirement("sewing_standard", 30)
    :requirement("soldering_standard", 60)
    :requires_skill("tailor", 2)
    :book("textbook_fabrication", 3)
    :book("tailor_portfolio", 4)
    :book("textbook_tailor", 3)
    :book("atomic_survival", 3)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "tunic_rag",
    result = "tunic_rag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("sheet", 1)
    :requirement("cordage", 1)
)

-- OK, I sewed the shirt and pants together, and added laces to the top, so I can put the thing on.
content.add(content.Recipe {
    id = "union_suit",
    result = "union_suit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
    flags = { "NO_RESIZE" },
}
    :component("long_undertop", 1)
    :component("long_underpants", 1)
    :component("cordage", 1, true)
    :requirement("sewing_standard", 20)
    :learn_by_disassembly("tailor", 0)
    :book("mag_tailor", 0)
    :book("manual_tailor", 0)
    :book("textbook_tailor", 0)
)

content.add(content.Recipe {
    id = "wetsuit_spring",
    result = "wetsuit_spring",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2340000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :component("zipper_long_plastic", 1)
    :quality("SEW_CURVED", 1, 1)
    :requirement("tailoring_neoprene_patchwork", 22)
    :book("textbook_tailor", 3)
    :book("manual_tailor", 4)
    :book("tailor_portfolio", 3)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "wool_suit",
    result = "wool_suit",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_felt_patchwork", 14)
)

content.add(content.Recipe {
    id = "yukata",
    result = "yukata",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_cotton_patchwork", 8)
    :book("tailor_japanese", 3)
)

content.add(content.Recipe {
    id = "zentai",
    result = "zentai",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_lycra_patchwork", 20)
    :book("mag_animecon", 1)
    :proficiency("prof_elastics")
    :byproduct("scrap_lycra", 3)
)

content.add(content.Recipe {
    id = "armor_lc_lightplate",
    result = "armor_lc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 319680000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 80)
    :requirement("lc_steel_standard", 20)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armor_lc_lightplate",
    result = "xl_armor_lc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 351474000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 128)
    :requirement("lc_steel_standard", 32)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_lc_lightplate_assembly",
    result = "armor_lc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_lc_light_chestplate", 1)
    :component("armor_lc_lightarmguard", 2)
    :component("armor_lc_light_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_lc_lightplate_assembly",
    result = "xl_armor_lc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_lc_light_chestplate", 1)
    :component("xl_armor_lc_lightarmguard", 2)
    :component("xl_armor_lc_light_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_mc_lightplate",
    result = "armor_mc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 319680000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 80)
    :requirement("mc_steel_standard", 20)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armor_mc_lightplate",
    result = "xl_armor_mc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 351474000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 128)
    :requirement("mc_steel_standard", 32)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_mc_lightplate_assembly",
    result = "armor_mc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_mc_light_chestplate", 1)
    :component("armor_mc_lightarmguard", 2)
    :component("armor_mc_light_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_mc_lightplate_assembly",
    result = "xl_armor_mc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_mc_light_chestplate", 1)
    :component("xl_armor_mc_lightarmguard", 2)
    :component("xl_armor_mc_light_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_hc_lightplate",
    result = "armor_hc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 319680000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 80)
    :requirement("hc_steel_standard", 20)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armor_hc_lightplate",
    result = "xl_armor_hc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 351474000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 128)
    :requirement("hc_steel_standard", 32)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_hc_lightplate_assembly",
    result = "armor_hc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_hc_light_chestplate", 1)
    :component("armor_hc_lightarmguard", 2)
    :component("armor_hc_light_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_hc_lightplate_assembly",
    result = "xl_armor_hc_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_hc_light_chestplate", 1)
    :component("xl_armor_hc_lightarmguard", 2)
    :component("xl_armor_hc_light_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_ch_lightplate",
    result = "armor_ch_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 342144000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool("metal_tank", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 80)
    :requirement("lc_steel_standard", 20)
    :requirement("tailoring_leather_patchwork", 3)
    :requirement("carbon", 5)
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
    id = "xl_armor_ch_lightplate",
    result = "xl_armor_ch_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 386622000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :tool("metal_tank", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 128)
    :requirement("lc_steel_standard", 32)
    :requirement("tailoring_leather_patchwork", 5)
    :requirement("carbon", 7)
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
    id = "armor_ch_lightplate_assembly",
    result = "armor_ch_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_ch_light_chestplate", 1)
    :component("armor_ch_lightarmguard", 2)
    :component("armor_ch_light_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_ch_lightplate_assembly",
    result = "xl_armor_ch_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_ch_light_chestplate", 1)
    :component("xl_armor_ch_lightarmguard", 2)
    :component("xl_armor_ch_light_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_qt_lightplate",
    result = "armor_qt_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 357696000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 240 },
            { id = "water_clean", count = 240 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 80)
    :requirement("mc_steel_standard", 20)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_lightplate",
    result = "xl_armor_qt_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 404196000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 240 },
            { id = "water_clean", count = 240 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 128)
    :requirement("mc_steel_standard", 32)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_qt_lightplate_assembly",
    result = "armor_qt_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_qt_light_chestplate", 1)
    :component("armor_qt_lightarmguard", 2)
    :component("armor_qt_light_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_lightplate_assembly",
    result = "xl_armor_qt_lightplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_qt_light_chestplate", 1)
    :component("xl_armor_qt_lightarmguard", 2)
    :component("xl_armor_qt_light_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_lc_plate",
    result = "armor_lc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 342144000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 100)
    :requirement("lc_steel_standard", 25)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armor_lc_plate",
    result = "xl_armor_lc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 386622000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 156)
    :requirement("lc_steel_standard", 39)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_lc_plate_assembly",
    result = "armor_lc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_lc_chestplate", 1)
    :component("armor_lc_armguard", 2)
    :component("armor_lc_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_lc_plate_assembly",
    result = "xl_armor_lc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_lc_chestplate", 1)
    :component("xl_armor_lc_armguard", 2)
    :component("xl_armor_lc_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_mc_plate",
    result = "armor_mc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 342144000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 100)
    :requirement("mc_steel_standard", 25)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armor_mc_plate",
    result = "xl_armor_mc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 386622000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 156)
    :requirement("mc_steel_standard", 39)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_mc_plate_assembly",
    result = "armor_mc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_mc_chestplate", 1)
    :component("armor_mc_armguard", 2)
    :component("armor_mc_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_mc_plate_assembly",
    result = "xl_armor_mc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_mc_chestplate", 1)
    :component("xl_armor_mc_armguard", 2)
    :component("xl_armor_mc_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_hc_plate",
    result = "armor_hc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 342144000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 100)
    :requirement("hc_steel_standard", 25)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armor_hc_plate",
    result = "xl_armor_hc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 386622000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 156)
    :requirement("hc_steel_standard", 39)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_hc_plate_assembly",
    result = "armor_hc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_hc_chestplate", 1)
    :component("armor_hc_armguard", 2)
    :component("armor_hc_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_hc_plate_assembly",
    result = "xl_armor_hc_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_hc_chestplate", 1)
    :component("xl_armor_hc_armguard", 2)
    :component("xl_armor_hc_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_ch_plate",
    result = "armor_ch_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 376200000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 100)
    :requirement("lc_steel_standard", 25)
    :requirement("tailoring_leather_patchwork", 3)
    :requirement("carbon", 5)
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
    id = "xl_armor_ch_plate",
    result = "xl_armor_ch_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 425280000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 156)
    :requirement("lc_steel_standard", 39)
    :requirement("tailoring_leather_patchwork", 5)
    :requirement("carbon", 7)
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
    id = "armor_ch_plate_assembly",
    result = "armor_ch_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_ch_chestplate", 1)
    :component("armor_ch_armguard", 2)
    :component("armor_ch_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_ch_plate_assembly",
    result = "xl_armor_ch_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_ch_chestplate", 1)
    :component("xl_armor_ch_armguard", 2)
    :component("xl_armor_ch_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_qt_plate",
    result = "armor_qt_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 393462000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 240 },
            { id = "water_clean", count = 240 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 80)
    :requirement("mc_steel_standard", 20)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_plate",
    result = "xl_armor_qt_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 444612000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 240 },
            { id = "water_clean", count = 240 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 156)
    :requirement("mc_steel_standard", 39)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_qt_plate_assembly",
    result = "armor_qt_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_qt_chestplate", 1)
    :component("armor_qt_armguard", 2)
    :component("armor_qt_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_plate_assembly",
    result = "xl_armor_qt_plate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_qt_chestplate", 1)
    :component("xl_armor_qt_armguard", 2)
    :component("xl_armor_qt_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_lc_heavyplate",
    result = "armor_lc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 371520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 120)
    :requirement("lc_steel_standard", 30)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armor_lc_heavyplate",
    result = "xl_armor_lc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 421770000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 156)
    :requirement("lc_steel_standard", 39)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_lc_heavyplate_assembly",
    result = "armor_lc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_lc_heavy_chestplate", 1)
    :component("armor_lc_heavyarmguard", 2)
    :component("armor_lc_heavy_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_lc_heavyplate_assembly",
    result = "xl_armor_lc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_lc_heavy_chestplate", 1)
    :component("xl_armor_lc_heavyarmguard", 2)
    :component("xl_armor_lc_heavy_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_mc_heavyplate",
    result = "armor_mc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 371520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 120)
    :requirement("mc_steel_standard", 30)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armor_mc_heavyplate",
    result = "xl_armor_mc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 371520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 156)
    :requirement("mc_steel_standard", 39)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_mc_heavyplate_assembly",
    result = "armor_mc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_mc_heavy_chestplate", 1)
    :component("armor_mc_heavyarmguard", 2)
    :component("armor_mc_heavy_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_mc_heavyplate_assembly",
    result = "xl_armor_mc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_mc_heavy_chestplate", 1)
    :component("xl_armor_mc_heavyarmguard", 2)
    :component("xl_armor_mc_heavy_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_hc_heavyplate",
    result = "armor_hc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 371520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 120)
    :requirement("hc_steel_standard", 30)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_armor_hc_heavyplate",
    result = "xl_armor_hc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 421770000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 156)
    :requirement("hc_steel_standard", 39)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "armor_hc_heavyplate_assembly",
    result = "armor_hc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_hc_heavy_chestplate", 1)
    :component("armor_hc_heavyarmguard", 2)
    :component("armor_hc_heavy_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_hc_heavyplate_assembly",
    result = "xl_armor_hc_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_hc_heavy_chestplate", 1)
    :component("xl_armor_hc_heavyarmguard", 2)
    :component("xl_armor_hc_heavy_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_ch_heavyplate",
    result = "armor_ch_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 410568000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :tool("metal_tank", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 120)
    :requirement("lc_steel_standard", 30)
    :requirement("tailoring_leather_patchwork", 3)
    :requirement("carbon", 5)
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
    id = "xl_armor_ch_heavyplate",
    result = "xl_armor_ch_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 463944000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("swage", 1)
    :tool("metal_tank", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 156)
    :requirement("lc_steel_standard", 39)
    :requirement("tailoring_leather_patchwork", 5)
    :requirement("carbon", 7)
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
    id = "armor_ch_heavyplate_assembly",
    result = "armor_ch_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_ch_heavy_chestplate", 1)
    :component("armor_ch_heavyarmguard", 2)
    :component("armor_ch_heavy_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_ch_heavyplate_assembly",
    result = "xl_armor_ch_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_ch_heavy_chestplate", 1)
    :component("xl_armor_ch_heavyarmguard", 2)
    :component("xl_armor_ch_heavy_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_qt_heavyplate",
    result = "armor_qt_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 429234000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool_charges("hotcut_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 240 },
            { id = "water_clean", count = 240 }
        })
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 120)
    :requirement("mc_steel_standard", 30)
    :requirement("tailoring_leather_patchwork", 3)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_heavyplate",
    result = "xl_armor_qt_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 485034000,
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
    :requirement("blacksmithing_standard", 156)
    :requirement("mc_steel_standard", 39)
    :requirement("tailoring_leather_patchwork", 5)
    :book("textbook_armwest", 7)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1.1, skill_penalty = 0.15 })
    :proficiency("prof_closures", { time_multiplier = 1.1 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_articulation")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "armor_qt_heavyplate_assembly",
    result = "armor_qt_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("armor_qt_heavy_chestplate", 1)
    :component("armor_qt_heavyarmguard", 2)
    :component("armor_qt_heavy_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "xl_armor_qt_heavyplate_assembly",
    result = "xl_armor_qt_heavyplate",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
    flags = { "NO_RESIZE" },
}
    :component("xl_armor_qt_heavy_chestplate", 1)
    :component("xl_armor_qt_heavyarmguard", 2)
    :component("xl_armor_qt_heavy_leg_guard", 2)
    :proficiency("prof_closures", { skill_penalty = 0 })
    :proficiency("prof_armorsmithing", { skill_penalty = 0 })
    :proficiency("prof_articulation", { skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "armor_riot_assembly",
    result = "armor_riot",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "NO_RESIZE" },
}
    :component("armor_riot_leg", 1)
    :component("armor_riot_arm", 1)
    :component("armor_riot_torso", 1)
)
