local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "prac_knitting",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_TAILORING",
    name = content.text("knitting"),
    description = content.text("Practice knitting whatever comes to your mind, from simple forms to elaborate and rich designs."),
    skill = "tailor",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :requirement("tailoring_wool_knitting", 40)
    :learn_automatically("tailor", 0)
    :proficiency("prof_knitting", { time_multiplier = 1, skill_penalty = 0 })
    :proficiency("prof_knitting_speed", { time_multiplier = 1, skill_penalty = 0 })
    :on_complete("finish_prac_knitting")
)

content.add(content.Recipe {
    id = "prac_closures",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_TAILORING",
    name = content.text("garment closures"),
    description = content.text("Practice the principles of garment closures by sewing some buttons and similar fasteners to some cotton patches."),
    skill = "tailor",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :component_any({
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "cotton_patchwork", count = 4 },
            { id = "scrap_cotton", count = 8 }
        })
    :requirement("sewing_standard", 10)
    :requirement("fastener_small", 2)
    :learn_automatically("tailor", 2)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :proficiency("prof_closures", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_closures_waterproofing",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_TAILORING",
    name = content.text("fabric waterproofing"),
    description = content.text("Practice the principles of sealing garments and fabric against water by making a basic waterproof layer from plastic sheets duct taped together, you will need some water and a rag."),
    skill = "tailor",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :component("cotton_patchwork", 1)
    :requirement("waterproofing_plastic_sheets", 4)
    :learn_automatically("tailor", 2)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :proficiency("prof_closures_waterproofing", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("water", 2)
    :byproduct("cotton_patchwork", 1)
)

content.add(content.Recipe {
    id = "prac_polymerworking",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_TAILORING",
    name = content.text("advanced polymer sewing"),
    description = content.text("Practice cutting and sewing together advanced polymers like Kevlar or Nomex."),
    skill = "tailor",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :component_any({
            { id = "sheet_kevlar", count = 1 },
            { id = "sheet_kevlar_patchwork", count = 1 },
            { id = "kevlar_patch", count = 6 },
            { id = "scrap_kevlar", count = 20 },
            { id = "sheet_nomex", count = 1 },
            { id = "sheet_nomex_patchwork", count = 1 },
            { id = "nomex", count = 6 },
            { id = "scrap_nomex", count = 20 }
        })
    :requirement("sewing_aramids", 20)
    :learn_automatically("tailor", 2)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :proficiency("prof_polymerworking", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_elastics",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_TAILORING",
    name = content.text("stretch fabric"),
    description = content.text("Practice the use of stretch fabric in clothing by making and modifying some basic garment forms with Lycra patches."),
    skill = "tailor",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :component_any({
            { id = "sheet_lycra", count = 1 },
            { id = "sheet_lycra_patchwork", count = 1 },
            { id = "lycra_patch", count = 6 }
        })
    :requirement("sewing_standard", 20)
    :learn_automatically("tailor", 2)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :proficiency("prof_elastics", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("scrap_lycra", 6)
)

content.add(content.Recipe {
    id = "prac_quilting",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_TAILORING",
    name = content.text("fabric quilting"),
    description = content.text("Practice the beautiful art of quilting by efficiently sewing a pair of padded sheets together in different patterns."),
    skill = "tailor",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :component("sheet_cotton", 2)
    :component("gambeson_batting", 2)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 20)
    :learn_automatically("tailor", 2)
    :book("mag_tailor", 1)
    :book("manual_tailor", 1)
    :book("textbook_armwest", 1)
    :proficiency("prof_quilting", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("cotton_patchwork", 6)
    :byproduct("gambeson_batting", 2)
)

content.add(content.Recipe {
    id = "prac_leather_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_TAILORING",
    name = content.text("leatherworking (beginner)"),
    description = content.text("Practice basic leatherworking skills by cutting and punching holes in leather, and stitching together leather patches."),
    skill = "tailor",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :requirement("tailoring_leather_small", 4)
    :requirement("filament", 20)
    :learn_automatically("tailor", 2)
    :book("mag_animecon", 0)
    :book("dieselpunk_tailor", 0)
    :proficiency("prof_leatherworking_basic", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_leather_adv",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_TAILORING",
    name = content.text("leatherworking (advanced)"),
    description = content.text("Practice the correct cut and sewing of big leather patches in clothing making, using your knowledge to give it practical forms."),
    skill = "tailor",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :component_any({
            { id = "leather", count = 6 },
            { id = "tanned_hide", count = 1 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 30)
    :learn_automatically("tailor", 3)
    :book("dieselpunk_tailor", 2)
    :book("manual_tailor", 2)
    :proficiency("prof_leatherworking_basic", { required = true })
    :proficiency("prof_leatherworking", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_chitinworking",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_TAILORING",
    name = content.text("chitinworking"),
    description = content.text("Practice the use of chitin as an armor component by shaping and attaching several pieces together."),
    skill = "tailor",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 3, max_difficulty = 4, skill_limit = 5 },
    autolearn = true,
}
    :component_any({
            { id = "chitin_piece", count = 6 },
            { id = "acidchitin_piece", count = 6 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 30)
    :requires_skill("fabrication", 3)
    :learn_automatically("tailor", 4)
    :learn_automatically("fabrication", 3)
    :book("textbook_arthropod", 3)
    :proficiency("prof_leatherworking_basic", { required = true })
    :proficiency("prof_chitinworking", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_articulation",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_TAILORING",
    name = content.text("joint articulation"),
    description = content.text("Practice the making of articulated joints in clothing by sewing some gloves and other basic cloth joints with several layers of cotton patches for rigidity."),
    skill = "tailor",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 3, max_difficulty = 4, skill_limit = 5 },
    autolearn = true,
}
    :component_any({
            { id = "gloves_light", count = 1 },
            { id = "gloves_liner", count = 1 },
            { id = "long_glove_white", count = 1 }
        })
    :requirement("tailoring_cotton_patchwork", 8)
    :requirement("filament", 30)
    :learn_automatically("tailor", 4)
    :book("textbook_tailor", 3)
    :proficiency("prof_articulation", { time_multiplier = 1, skill_penalty = 0 })
)
