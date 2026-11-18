local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.replace(content.Recipe {
    id = "xl_armor_chitin",
    result = "xl_armor_chitin",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1980000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("cordage_superior", 1, true)
    :component("demon_chitin_plate", 1)
    :component("demon_chitin_piece", 3)
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
    id = "parabolan_blouse",
    result = "parabolan_blouse",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 1800000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("parabolan_felt_patch", 120)
    :component("parabolan_yarn", 40)
    :requirement("sewing_standard", 20)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :book("mag_beauty", 1)
)

content.add(content.Recipe {
    id = "parabolan_breeches",
    result = "parabolan_breeches",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("parabolan_felt_patch", 104)
    :component("parabolan_yarn", 40)
    :requirement("sewing_standard", 20)
    :requirement("fastener_small", 1)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :book("mag_beauty", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "gambeson_parabolan",
    result = "gambeson_parabolan",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 23400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("parabolan_felt_patch", 2370)
    :component("parabolan_yarn", 1500)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xl_gambeson_parabolan",
    result = "xl_gambeson_parabolan",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 34920000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("parabolan_felt_patch", 3555)
    :component("parabolan_yarn", 2250)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 15)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xs_gambeson_parabolan",
    result = "xs_gambeson_parabolan",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 17640000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("parabolan_felt_patch", 1777)
    :component("parabolan_yarn", 1125)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 8)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "gambeson_parabolan_thinsleeved",
    result = "gambeson_parabolan_thinsleeved",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 20880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("parabolan_felt_patch", 2096)
    :component("parabolan_yarn", 1250)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xl_gambeson_parabolan_thinsleeved",
    result = "xl_gambeson_parabolan_thinsleeved",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 31320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("parabolan_felt_patch", 3114)
    :component("parabolan_yarn", 1875)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 15)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xs_gambeson_parabolan_thinsleeved",
    result = "xs_gambeson_parabolan_thinsleeved",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 15840000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("parabolan_felt_patch", 1572)
    :component("parabolan_yarn", 937)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 8)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "gambeson_parabolan_vest",
    result = "gambeson_parabolan_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 12960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("parabolan_felt_patch", 1824)
    :component("parabolan_yarn", 1125)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_large", 2)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xl_gambeson_parabolan_vest",
    result = "xl_gambeson_parabolan_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("parabolan_felt_patch", 2736)
    :component("parabolan_yarn", 1687)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_large", 2)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xs_gambeson_parabolan_vest",
    result = "xs_gambeson_parabolan_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 9720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("parabolan_felt_patch", 1368)
    :component("parabolan_yarn", 843)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_large", 2)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "gambeson_pants_parabolan",
    result = "gambeson_pants_parabolan",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 14400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("parabolan_felt_patch", 547)
    :component("parabolan_yarn", 400)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_small", 5)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xl_gambeson_pants_parabolan",
    result = "xl_gambeson_pants_parabolan",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 21600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("parabolan_felt_patch", 820)
    :component("parabolan_yarn", 600)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_small", 7)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xs_gambeson_pants_parabolan",
    result = "xs_gambeson_pants_parabolan",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("parabolan_felt_patch", 410)
    :component("parabolan_yarn", 300)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_small", 5)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "gambeson_gloves_parabolan",
    result = "gambeson_gloves_parabolan",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("parabolan_felt_patch", 116)
    :component("parabolan_yarn", 90)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_small", 2)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xl_gambeson_gloves_parabolan",
    result = "xl_gambeson_gloves_parabolan",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("parabolan_felt_patch", 174)
    :component("parabolan_yarn", 135)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_small", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xs_gambeson_gloves_parabolan",
    result = "xs_gambeson_gloves_parabolan",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HANDS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("parabolan_felt_patch", 87)
    :component("parabolan_yarn", 67)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("fastener_small", 2)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)
