local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "gauntlets_chitin",
    result = "gauntlets_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_chitin", 2)
    :requirement("strap_small", 2)
    :requirement("clasps", 2)
    :requirement("tailoring_leather_small", 3)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_chitinworking")
    :byproduct("scrap_leather", 7)
)

content.add(content.Recipe {
    id = "xs_gauntlets_chitin",
    result = "xs_gauntlets_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_chitin", 1)
    :requirement("strap_small", 2)
    :requirement("clasps", 2)
    :requirement("tailoring_leather_small", 2)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_chitinworking")
    :byproduct("scrap_leather", 7)
)

content.add(content.Recipe {
    id = "xl_gauntlets_chitin",
    result = "xl_gauntlets_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4050000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_chitin", 3)
    :requirement("strap_small", 2)
    :requirement("clasps", 2)
    :requirement("tailoring_leather_small", 4)
    :requires_skill("fabrication", 3)
    :book("textbook_arthropod", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_closures")
    :proficiency("prof_chitinworking")
    :byproduct("scrap_leather", 7)
)

content.add(content.Recipe {
    id = "gauntlets_acidchitin",
    result = "gauntlets_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("cordage_superior", 1, true)
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_acidchitin", 8)
    :requirement("strap_small", 2)
    :requirement("clasps", 2)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_gauntlets_acidchitin",
    result = "xs_gauntlets_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("cordage_superior", 2, true)
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_acidchitin", 6)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_gauntlets_acidchitin",
    result = "xl_gauntlets_acidchitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4860000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("cordage_superior", 2, true)
    :quality("CUT_FINE", 1, 1)
    :requirement("armor_acidchitin", 12)
    :requirement("strap_small", 2)
    :requirement("clasps", 2)
    :requires_skill("fabrication", 3)
    :requires_skill("chemistry", 2)
    :book("textbook_arthropod", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_chitinworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "gauntlets_larmor",
    result = "gauntlets_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 12)
    :requirement("tailoring_leather_small", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_gauntlets_larmor",
    result = "xs_gauntlets_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 9)
    :requirement("tailoring_leather_small", 3)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_gauntlets_larmor",
    result = "xl_gauntlets_larmor",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3660000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 16)
    :requirement("tailoring_leather_small", 6)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "gloves_fingerless",
    result = "gloves_fingerless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 96000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("gloves_leather", 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "gloves_fingerless_from patches",
    result = "gloves_fingerless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 5)
    :requirement("tailoring_leather_small", 1)
    :book("manual_tailor", 2)
    :book("textbook_tailor", 2)
    :book("recipe_melee", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "gloves_fingerless_mod",
    result = "gloves_fingerless_mod",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 144000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("gloves_fingerless", 1)
    :component("scrap", 2)
    :quality("HAMMER", 2, 1)
    :requirement("sewing_standard", 10)
    :requires_skill("fabrication", 1)
)

content.add(content.Recipe {
    id = "gloves_fur",
    result = "gloves_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_fur_small", 3)
    :requires_skill("survival", 1)
    :book("manual_tailor", 1)
    :book("textbook_survival", 1)
    :book("pocket_survival", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xs_gloves_fur",
    result = "xs_gloves_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_fur_small", 2)
    :requires_skill("survival", 1)
    :book("manual_tailor", 1)
    :book("textbook_survival", 1)
    :book("pocket_survival", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xl_gloves_fur",
    result = "xl_gloves_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3660000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_fur_small", 5)
    :requires_skill("survival", 1)
    :book("manual_tailor", 1)
    :book("textbook_survival", 1)
    :book("pocket_survival", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "gloves_leather",
    result = "gloves_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather_small", 2)
    :book("manual_tailor", 1)
    :book("mag_tailor", 0)
    :book("textbook_survival", 1)
    :book("pocket_survival", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xs_gloves_leather",
    result = "xs_gloves_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather_small", 1)
    :book("manual_tailor", 1)
    :book("mag_tailor", 0)
    :book("textbook_survival", 1)
    :book("pocket_survival", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xl_gloves_leather",
    result = "xl_gloves_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather_small", 3)
    :book("manual_tailor", 1)
    :book("mag_tailor", 0)
    :book("textbook_survival", 1)
    :book("pocket_survival", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "gloves_denim",
    result = "gloves_denim",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_denim_patchwork", 3)
    :proficiency("prof_closures")
    :byproduct("scrap_denim", 6)
)

content.add(content.Recipe {
    id = "gloves_denim_fingerless_from_patchwork",
    result = "gloves_denim_fingerless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_denim_patchwork", 2)
    :proficiency("prof_closures")
    :byproduct("scrap_denim", 6)
)

content.add(content.Recipe {
    id = "gloves_denim_fingerless_from_gloves",
    result = "gloves_denim_fingerless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("gloves_denim", 1)
    :quality("CUT", 1, 1)
    :byproduct("scrap_denim", 10)
)

content.add(content.Recipe {
    id = "gloves_light",
    result = "gloves_light",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 4)
)

content.add(content.Recipe {
    id = "xs_gloves_light",
    result = "xs_gloves_light",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 3)
)

content.add(content.Recipe {
    id = "xl_gloves_light",
    result = "xl_gloves_light",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 6)
)

content.add(content.Recipe {
    id = "gloves_liner",
    result = "gloves_liner",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 1)
    :book("manual_tailor", 1)
    :book("mag_tailor", 0)
    :book("textbook_survival", 2)
    :book("pocket_survival", 2)
)

content.add(content.Recipe {
    id = "xs_gloves_liner",
    result = "xs_gloves_liner",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 1)
    :book("manual_tailor", 1)
    :book("mag_tailor", 0)
    :book("textbook_survival", 2)
    :book("pocket_survival", 2)
)

content.add(content.Recipe {
    id = "xl_gloves_liner",
    result = "xl_gloves_liner",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork", 2)
    :book("manual_tailor", 1)
    :book("mag_tailor", 0)
    :book("textbook_survival", 2)
    :book("pocket_survival", 2)
)

content.add(content.Recipe {
    id = "gloves_plate",
    result = "gloves_plate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("steel_standard", 6)
    :requirement("clasps", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { required = false, time_multiplier = 1.5, learning_time_multiplier = 0.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_gloves_plate",
    result = "xs_gloves_plate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("steel_standard", 4)
    :requirement("clasps", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { required = false, time_multiplier = 1.5, learning_time_multiplier = 0.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_gloves_plate",
    result = "xl_gloves_plate",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2820000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 36)
    :requirement("steel_standard", 9)
    :requirement("clasps", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { required = false, time_multiplier = 1.5, learning_time_multiplier = 0.25, skill_penalty = 0.15 })
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "gloves_survivor",
    result = "gloves_survivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("duct_tape", 80)
    :component_any({
            { id = "gloves_leather", count = 1 },
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 },
            { id = "wetsuit_gloves", count = 1 },
            { id = "fire_gauntlets", count = 1 }
        })
    :requirement("sewing_standard", 50)
    :requirement("tailoring_leather_small", 6)
    :requirement("tailoring_kevlar_fabric", 1)
    :requires_skill("fabrication", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_gloves_survivor",
    result = "xs_gloves_survivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("duct_tape", 60)
    :component_any({
            { id = "gloves_leather", count = 1 },
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 },
            { id = "wetsuit_gloves", count = 1 },
            { id = "fire_gauntlets", count = 1 }
        })
    :requirement("sewing_standard", 37)
    :requirement("tailoring_leather_small", 4)
    :requirement("tailoring_kevlar_fabric", 1)
    :requires_skill("fabrication", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "gloves_wool",
    result = "gloves_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2160000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 100)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "xs_gloves_wool",
    result = "xs_gloves_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2160000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 75)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "xl_gloves_wool",
    result = "xl_gloves_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2430000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 140)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "gloves_wool_fingerless",
    result = "gloves_wool_fingerless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 83)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "gloves_wool_fingerless_from_gloves",
    result = "gloves_wool_fingerless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("gloves_wool", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "xs_gloves_wool_fingerless",
    result = "xs_gloves_wool_fingerless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 62)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "xs_gloves_wool_fingerless_from_gloves",
    result = "xs_gloves_wool_fingerless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("xs_gloves_wool", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "xl_gloves_wool_fingerless",
    result = "xl_gloves_wool_fingerless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 116)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "xl_gloves_wool_fingerless_from_gloves",
    result = "xl_gloves_wool_fingerless",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("xl_gloves_wool", 1)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "gloves_work",
    result = "gloves_work",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("sewing_standard", 6)
    :requirement("tailoring_leather_small", 2)
    :book("manual_tailor", 2)
    :book("mag_tailor", 3)
    :book("textbook_survival", 2)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "gloves_wraps",
    result = "gloves_wraps",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :requirement("tailoring_cotton_small_simple", 6)
)

content.add(content.Recipe {
    id = "gloves_wraps_fur",
    result = "gloves_wraps_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component("fur", 6)
)

content.add(content.Recipe {
    id = "gloves_wraps_leather",
    result = "gloves_wraps_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component("leather", 6)
)

content.add(content.Recipe {
    id = "gloves_wraps_wool",
    result = "gloves_wraps_wool",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    flags = { "BLIND_HARD" },
}
    :component("felt_patch", 6)
)

content.add(content.Recipe {
    id = "gloves_wsurvivor",
    result = "gloves_wsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("duct_tape", 80)
    :component_any({
            { id = "gloves_leather", count = 1 },
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 },
            { id = "wetsuit_gloves", count = 1 },
            { id = "fire_gauntlets", count = 1 }
        })
    :requirement("sewing_standard", 50)
    :requirement("tailoring_fur_small", 4)
    :requirement("tailoring_kevlar_fabric", 1)
    :requires_skill("fabrication", 5)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xs_gloves_wsurvivor",
    result = "xs_gloves_wsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("duct_tape", 60)
    :component_any({
            { id = "gloves_leather", count = 1 },
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 },
            { id = "wetsuit_gloves", count = 1 },
            { id = "fire_gauntlets", count = 1 }
        })
    :requirement("sewing_standard", 37)
    :requirement("tailoring_fur_small", 3)
    :requirement("tailoring_kevlar_fabric", 1)
    :requires_skill("fabrication", 5)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_gloves_wsurvivor",
    result = "xl_gloves_wsurvivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8100000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("duct_tape", 120)
    :component_any({
            { id = "gloves_leather", count = 1 },
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 },
            { id = "wetsuit_gloves", count = 1 },
            { id = "fire_gauntlets", count = 1 }
        })
    :requirement("sewing_standard", 75)
    :requirement("tailoring_fur_small", 5)
    :requirement("tailoring_kevlar_fabric", 2)
    :requires_skill("fabrication", 5)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "xl_gloves_survivor",
    result = "xl_gloves_survivor",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8100000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("cotton_patchwork", 6)
    :component("scrap", 2)
    :component("duct_tape", 160)
    :requirement("sewing_standard", 100)
    :requirement("tailoring_leather_small", 16)
    :requirement("tailoring_kevlar_fabric", 2)
    :requires_skill("fabrication", 4)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "mittens",
    result = "mittens",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 300000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_wool_knitting", 36)
    :proficiency("prof_knitting")
    :proficiency("prof_knitting_speed")
)

content.add(content.Recipe {
    id = "nomex_gloves",
    result = "nomex_gloves",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_nomex_patchwork", 2)
    :book("textbook_fireman", 6)
    :book("textbook_tailor", 5)
    :book("tailor_portfolio", 5)
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "thermal_gloves",
    result = "thermal_gloves",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 4,
}
    :component_any({
            { id = "cotton_patchwork", count = 4 },
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 }
        })
    :component_any({
            { id = "element", count = 2 },
            { id = "crude_heating_element", count = 3 }
        })
    :component("cable", 1)
    :requirement("sewing_standard", 8)
    :requirement("soldering_standard", 20)
    :requires_skill("tailor", 2)
    :book("textbook_fabrication", 3)
    :book("tailor_portfolio", 4)
    :book("textbook_tailor", 3)
    :book("atomic_survival", 3)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "lc_chainmail_hands",
    result = "lc_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 1)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_lc_chainmail_hands",
    result = "xs_lc_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_lc_chainmail_hands",
    result = "xl_lc_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 810000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_lc_chainmail_assembling", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "mc_chainmail_hands",
    result = "mc_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 1)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_mc_chainmail_hands",
    result = "xs_mc_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_mc_chainmail_hands",
    result = "xl_mc_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 810000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_mc_chainmail_assembling", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "hc_chainmail_hands",
    result = "hc_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 1)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_hc_chainmail_hands",
    result = "xs_hc_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_hc_chainmail_hands",
    result = "xl_hc_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 810000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_hc_chainmail_assembling", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "ch_chainmail_hands",
    result = "ch_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 1)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_ch_chainmail_hands",
    result = "xs_ch_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_ch_chainmail_hands",
    result = "xl_ch_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 810000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_ch_chainmail_assembling", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "qt_chainmail_hands",
    result = "qt_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 1)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xs_qt_chainmail_hands",
    result = "xs_qt_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 1)
    :requirement("strap_small", 1)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "xl_qt_chainmail_hands",
    result = "xl_qt_chainmail_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 810000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :requirement("armor_qt_chainmail_assembling", 2)
    :requirement("strap_small", 2)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "lc_demi_gaunt",
    result = "lc_demi_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 21600000,
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
    id = "xl_lc_demi_gaunt",
    result = "xl_lc_demi_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 23040000,
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
    id = "mc_demi_gaunt",
    result = "mc_demi_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 21600000,
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
    id = "xl_mc_demi_gaunt",
    result = "xl_mc_demi_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 23040000,
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
    id = "hc_demi_gaunt",
    result = "hc_demi_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 21600000,
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
    :requirement("armor_hc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_hc_demi_gaunt",
    result = "xl_hc_demi_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 23040000,
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
    id = "ch_demi_gaunt",
    result = "ch_demi_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 23760000,
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
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_demi_gaunt",
    result = "xl_ch_demi_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 27360000,
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
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_demi_gaunt",
    result = "qt_demi_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 23760000,
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
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xl_qt_demi_gaunt",
    result = "xl_qt_demi_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 28080000,
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
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "lc_mitten_gaunt",
    result = "lc_mitten_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 25920000,
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
    id = "xl_lc_mitten_gaunt",
    result = "xl_lc_mitten_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 29520000,
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
    id = "mitten_gaunt_metal_sheets",
    result = "mitten_gaunt_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet_metal_small", 1)
    :component("cordage_6_leather", 4)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("DRILL", 1, 1)
    :requires_skill("tailor", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_articulation")
)

content.add(content.Recipe {
    id = "ch_mitten_gaunt_metal_sheets",
    result = "ch_mitten_gaunt_metal_sheets",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_charges("forge", 16)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("mitten_gaunt_metal_sheets", 1)
    :quality("HAMMER", 2, 1)
    :requirement("carbon", 2)
    :book("textbook_armwest", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "mc_mitten_gaunt",
    result = "mc_mitten_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 25920000,
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
    id = "xl_mc_mitten_gaunt",
    result = "xl_mc_mitten_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 29520000,
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
    id = "hc_mitten_gaunt",
    result = "hc_mitten_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 25920000,
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
    :requirement("armor_hc_chainmail_assembling", 1)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "xl_hc_mitten_gaunt",
    result = "xl_hc_mitten_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 29520000,
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
    :requirement("armor_hc_chainmail_assembling", 2)
    :book("textbook_armwest", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
)

content.add(content.Recipe {
    id = "ch_mitten_gaunt",
    result = "ch_mitten_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 28800000,
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
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_mitten_gaunt",
    result = "xl_ch_mitten_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 32040000,
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
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_leatherworking_basic", { skill_penalty = 0.15 })
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_mitten_gaunt",
    result = "qt_mitten_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 29880000,
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
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "xl_qt_mitten_gaunt",
    result = "xl_qt_mitten_gaunt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 34200000,
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
    :proficiency("prof_tempering")
)

content.add(content.Recipe {
    id = "lc_brigandine_hands",
    result = "lc_brigandine_hands",
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
    :requirement("lc_steel_standard", 1)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_lc_brigandine_hands",
    result = "xl_lc_brigandine_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
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
    :requirement("lc_steel_standard", 1)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "lc_brigandine_hands_xs",
    result = "lc_brigandine_hands_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
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
    :requirement("lc_steel_standard", 1)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "mc_brigandine_hands",
    result = "mc_brigandine_hands",
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
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_mc_brigandine_hands",
    result = "xl_mc_brigandine_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
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
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "mc_brigandine_hands_xs",
    result = "mc_brigandine_hands_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
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
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "hc_brigandine_hands",
    result = "hc_brigandine_hands",
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
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "xl_hc_brigandine_hands",
    result = "xl_hc_brigandine_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
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
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "hc_brigandine_hands_xs",
    result = "hc_brigandine_hands_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
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
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "ch_brigandine_hands",
    result = "ch_brigandine_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5040000,
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
    :requirement("fastener_small", 2)
    :requirement("carbon", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "xl_ch_brigandine_hands",
    result = "xl_ch_brigandine_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
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
    :requirement("fastener_small", 2)
    :requirement("carbon", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "ch_brigandine_hands_xs",
    result = "ch_brigandine_hands_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4680000,
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
    :requirement("fastener_small", 2)
    :requirement("carbon", 1)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_hardening")
)

content.add(content.Recipe {
    id = "qt_brigandine_hands",
    result = "qt_brigandine_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6480000,
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
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "xl_qt_brigandine_hands",
    result = "xl_qt_brigandine_hands",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6840000,
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
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "qt_brigandine_hands_xs",
    result = "qt_brigandine_hands_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6120000,
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
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 5)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_closures", { time_multiplier = 1.25, skill_penalty = 0.15 })
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)
