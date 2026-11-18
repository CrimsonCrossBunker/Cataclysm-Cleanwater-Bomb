local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "gloves_faux_fur",
    result = "gloves_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_faux_fur_small", 3)
    :requires_skill("survival", 1)
    :book("manual_tailor", 1)
    :book("textbook_survival", 1)
    :book("pocket_survival", 1)
    :book("recipe_fauxfur", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("scrap_faux_fur", 3)
)

content.add(content.Recipe {
    id = "xs_gloves_faux_fur",
    result = "xs_gloves_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_faux_fur_small", 2)
    :requires_skill("survival", 1)
    :book("manual_tailor", 1)
    :book("textbook_survival", 1)
    :book("pocket_survival", 1)
    :book("recipe_fauxfur", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("scrap_faux_fur", 3)
)

content.add(content.Recipe {
    id = "xl_gloves_faux_fur",
    result = "xl_gloves_faux_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3660000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_faux_fur_small", 5)
    :requires_skill("survival", 1)
    :book("manual_tailor", 1)
    :book("textbook_survival", 1)
    :book("pocket_survival", 1)
    :book("recipe_fauxfur", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :byproduct("scrap_faux_fur", 3)
)

content.add(content.Recipe {
    id = "gloves_wsurvivor_nofur",
    result = "gloves_wsurvivor_nofur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("duct_tape", 80)
    :component("faux_fur", 4)
    :component_any({
            { id = "gloves_leather", count = 1 },
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 },
            { id = "wetsuit_gloves", count = 1 },
            { id = "fire_gauntlets", count = 1 }
        })
    :requirement("sewing_standard", 50)
    :requirement("tailoring_kevlar_fabric", 1)
    :requires_skill("fabrication", 5)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_articulation")
    :byproduct("scrap_faux_fur", 5)
)

content.add(content.Recipe {
    id = "xs_gloves_wsurvivor_nofur",
    result = "xs_gloves_wsurvivor_nofur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("duct_tape", 60)
    :component("faux_fur", 3)
    :component_any({
            { id = "gloves_leather", count = 1 },
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 },
            { id = "wetsuit_gloves", count = 1 },
            { id = "fire_gauntlets", count = 1 }
        })
    :requirement("sewing_standard", 37)
    :requirement("tailoring_kevlar_fabric", 1)
    :requires_skill("fabrication", 5)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_articulation")
    :byproduct("scrap_faux_fur", 4)
)

content.add(content.Recipe {
    id = "xl_gloves_wsurvivor_nofur",
    result = "xl_gloves_wsurvivor_nofur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("duct_tape", 120)
    :component("faux_fur", 5)
    :component_any({
            { id = "gloves_leather", count = 1 },
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 },
            { id = "wetsuit_gloves", count = 1 },
            { id = "fire_gauntlets", count = 1 }
        })
    :requirement("sewing_standard", 75)
    :requirement("tailoring_kevlar_fabric", 2)
    :requires_skill("fabrication", 5)
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_polymerworking")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_articulation")
    :byproduct("scrap_faux_fur", 4)
)

content.add(content.Recipe {
    id = "sockmitts",
    result = "sockmitts",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    flags = { "BLIND_EASY", "NO_RESIZE" },
}
    :component("socks", 1)
)

content.add(content.Recipe {
    id = "wool_sockmitts",
    result = "wool_sockmitts",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    flags = { "BLIND_EASY", "NO_RESIZE" },
}
    :component("socks_wool", 1)
)

content.add(content.Recipe {
    id = "nomex_sockmitts",
    result = "nomex_sockmitts",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    flags = { "BLIND_EASY", "NO_RESIZE" },
}
    :component("nomex_socks", 1)
)

-- Should use fabric_neoprene when the tailoring recipe audit is done.
content.add(content.Recipe {
    id = "wetsuit_gloves",
    result = "wetsuit_gloves",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("glue_weak", 250)
    :requirement("tailoring_neoprene_patchwork", 4)
    :requirement("tailoring_nylon_patchwork", 5)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xl_wetsuit_gloves",
    result = "xl_wetsuit_gloves",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("glue_weak", 250)
    :requirement("tailoring_neoprene_patchwork", 6)
    :requirement("tailoring_nylon_patchwork", 8)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xs_wetsuit_gloves",
    result = "xs_wetsuit_gloves",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
}
    :component("glue_weak", 250)
    :requirement("tailoring_neoprene_patchwork", 3)
    :requirement("tailoring_nylon_patchwork", 4)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "wetsuit_gloves_thick",
    result = "wetsuit_gloves_thick",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("glue_weak", 250)
    :requirement("tailoring_neoprene_patchwork", 6)
    :requirement("tailoring_nylon_patchwork", 10)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xl_wetsuit_gloves_thick",
    result = "xl_wetsuit_gloves_thick",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("glue_weak", 250)
    :requirement("tailoring_neoprene_patchwork", 8)
    :requirement("tailoring_nylon_patchwork", 15)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xs_wetsuit_gloves_thick",
    result = "xs_wetsuit_gloves_thick",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
}
    :component("glue_weak", 250)
    :requirement("tailoring_neoprene_patchwork", 5)
    :requirement("tailoring_nylon_patchwork", 8)
    :book("textbook_tailor", 4)
    :book("manual_tailor", 5)
    :book("tailor_portfolio", 4)
    :proficiency("prof_elastics")
    :proficiency("prof_closures_waterproofing")
)
