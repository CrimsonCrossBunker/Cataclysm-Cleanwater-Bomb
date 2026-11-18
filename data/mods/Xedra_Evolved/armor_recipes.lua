local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "gambeson_gossamer",
    result = "gambeson_gossamer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 7,
    flags = { "SECRET" },
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("sheet", 10)
    :component("gambeson_batting_gossamer", 153)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 350)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 3)
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_gossamer_basic")
    :proficiency("prof_gossamer")
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "boots_glimmer_fur",
    result = "boots_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 13)
    :requirement("tailoring_leather_patchwork", 3)
    :requirement("tailoring_glimmer_fur", 2)
    :requirement("fastener_shoes", 2)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 3)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xs_boots_glimmer_fur",
    result = "xs_boots_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 9)
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("tailoring_glimmer_fur", 3)
    :requirement("fastener_shoes", 1)
    :requirement("shoe_rubber", 1)
    :requirement("adhesive_rubber", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 3)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xl_boots_glimmer_fur",
    result = "xl_boots_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_FEET",
    duration_moves = 4860000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 16)
    :requirement("tailoring_leather_patchwork", 4)
    :requirement("tailoring_glimmer_fur", 4)
    :requirement("fastener_shoes", 3)
    :requirement("shoe_rubber", 2)
    :requirement("adhesive_rubber", 2)
    :requires_skill("survival", 1)
    :book("textbook_survival", 3)
    :proficiency("prof_cobbling")
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "cloak_glimmer_fur",
    result = "cloak_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :quality("LEATHER_AWL", 1, 1)
    :requirement("tailoring_glimmer_fur", 7)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :book("survival_book", 1)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_furriery")
    :proficiency("prof_aelfen_tailoring")
)

content.add(content.Recipe {
    id = "coat_glimmer_fur",
    result = "coat_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_cotton_patchwork", 6)
    :requirement("tailoring_glimmer_fur", 6)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :book("trappers_companion", 3)
    :book("survival_book", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xs_coat_glimmer_fur",
    result = "xs_coat_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_cotton_patchwork", 4)
    :requirement("tailoring_glimmer_fur", 4)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :book("trappers_companion", 3)
    :book("survival_book", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xl_coat_glimmer_fur",
    result = "xl_coat_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2430000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_cotton_patchwork", 8)
    :requirement("tailoring_glimmer_fur", 8)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :book("textbook_survival", 1)
    :book("trappers_companion", 3)
    :book("survival_book", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

-- The general guideline for sleeveless trenchcoats is the components, volume, weight, time to craft, and
-- value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_trenchcoat_glimmer_fur_from_trenchcoat_glimmer_fur",
    result = "sleeveless_trenchcoat_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("trenchcoat_glimmer_fur", 1)
    :quality("CUT", 2, 1)
    :byproduct("fae_fur", 4)
)

-- The general guideline for sleeveless trenchcoats is the components, volume, weight, time to craft, and
-- value are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_trenchcoat_glimmer_fur_from_scratch",
    result = "sleeveless_trenchcoat_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2550000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :requirement("tailoring_glimmer_fur", 10)
    :requirement("fastener_large", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "trenchcoat_glimmer_fur",
    result = "trenchcoat_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 3000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_glimmer_fur", 12)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "duster_glimmer_fur",
    result = "duster_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 60)
    :requirement("tailoring_glimmer_fur", 7)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xs_duster_glimmer_fur",
    result = "xs_duster_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 45)
    :requirement("tailoring_glimmer_fur", 5)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

content.add(content.Recipe {
    id = "xl_duster_glimmer_fur",
    result = "xl_duster_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 4050000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("sewing_standard", 80)
    :requirement("tailoring_glimmer_fur", 9)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

-- The general guideline for sleeveless dusters is the components, volume, weight, time to craft, and value
-- are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_duster_glimmer_fur",
    result = "sleeveless_duster_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_glimmer_fur", 8)
    :requirement("fastener_large", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_aelfen_tailoring")
    :proficiency("prof_furriery")
)

-- The general guideline for sleeveless dusters is the components, volume, weight, time to craft, and value
-- are 15% lower (rounded down) than the original.  Making it from an original takes 50% the time.
content.add(content.Recipe {
    id = "sleeveless_duster_glimmer_fur_from_duster_glimmer_fur",
    result = "sleeveless_duster_glimmer_fur",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 36000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    flags = { "NO_RESIZE" },
}
    :component("duster_glimmer_fur", 1)
    :quality("CUT", 2, 1)
    :byproduct("fae_fur", 4)
)
