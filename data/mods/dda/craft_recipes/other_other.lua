local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "fish_bait",
    result = "fish_bait",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "survival",
}
    :component_any({
            { id = "meat_red_raw", count = 1, requirement = true },
            { id = "poultry_raw_any", count = 1, requirement = true },
            { id = "fish", count = 1 },
            { id = "dry_meat", count = 1 },
            { id = "dry_fish", count = 1 },
            { id = "corn_kernels", count = 1 },
            { id = "rehydrated_corn_kernels", count = 1 },
            { id = "carrot", count = 1 },
            { id = "bread", count = 1 },
            { id = "wastebread", count = 1 },
            { id = "cornbread", count = 1 },
            { id = "macaroni_raw", count = 1 },
            { id = "spaghetti_raw", count = 1 },
            { id = "earthworm", count = 10 },
            { id = "earthworm_handful", count = 1 }
        })
    :quality("CUT", 1, 1)
    :book("mag_survival", 1)
    :book("textbook_survival", 1)
    :book("survival_book", 1)
    :book("pocket_survival", 1)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "deck_of_cards_deck_of_cards_makeshift",
    result = "deck_of_cards",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    variant = "deck_of_cards_makeshift",
}
    :tool_charges("drawing_tool", 5, true)
    :component("cardboard", 10)
)

content.add(content.Recipe {
    id = "deck_of_tarot_cards_makeshift",
    result = "deck_of_tarot_cards",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    variant = "makeshift",
}
    :tool_charges("drawing_tool", 5, true)
    :component("cardboard", 10)
)

-- Tying equipment or other fasteners. Maybe one day we will have coat hangars.
content.add(content.Recipe {
    id = "outfit_storage",
    result = "outfit_storage",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("cordage", 10, true)
)

content.add(content.Recipe {
    id = "tic_tac",
    result = "tic_tac",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 1000,
    reversible = true,
    skill = "fabrication",
}
    :tool_charges("drawing_tool", 5, true)
    :component("paper", 1)
    :component_any({
            { id = "box_small", count = 1 },
            { id = "plastic_shopping_bag", count = 1 }
        })
    :component("button_plastic", 3)
)

content.add(content.Recipe {
    id = "makeshift_dominoes",
    result = "makeshift_dominoes",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
}
    :tool_charges("drawing_tool", 5, true)
    :component("cardboard", 28)
    :component_any({
            { id = "box_small", count = 1 },
            { id = "plastic_shopping_bag", count = 1 }
        })
)

content.add(content.Recipe {
    id = "makeshift_checkers",
    result = "makeshift_checkers",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 1000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 1000,
    reversible = true,
    skill = "fabrication",
}
    :tool_charges("drawing_tool", 5, true)
    :component("paper", 1)
    :component_any({
            { id = "box_small", count = 1 },
            { id = "plastic_shopping_bag", count = 1 }
        })
    :component("button_plastic", 12)
)

content.add(content.Recipe {
    id = "hammock",
    result = "hammock",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("sheet", 1)
    :component("rope_natural_short", 4, true)
    :requirement("sewing_standard", 30)
)

content.add(content.Recipe {
    id = "hammock_net",
    result = "hammock_net",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("cordage_superior", 20, true)
    :component("rope_natural_short", 4, true)
    :learn_by_disassembly("tailor", 1)
)

content.add(content.Recipe {
    id = "money_strap_one",
    result = "money_strap_one",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_one", 100)
    :component("paper", 1)
)

content.add(content.Recipe {
    id = "money_strap_two",
    result = "money_strap_two",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_two", 100)
    :component("paper", 1)
)

content.add(content.Recipe {
    id = "money_strap_five",
    result = "money_strap_five",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_five", 100)
    :component("paper", 1)
)

content.add(content.Recipe {
    id = "money_strap_ten",
    result = "money_strap_ten",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_ten", 100)
    :component("paper", 1)
)

content.add(content.Recipe {
    id = "money_strap_twenty",
    result = "money_strap_twenty",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_twenty", 100)
    :component("paper", 1)
)

content.add(content.Recipe {
    id = "money_strap_fifty",
    result = "money_strap_fifty",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_fifty", 100)
    :component("paper", 1)
)

content.add(content.Recipe {
    id = "money_strap_hundred",
    result = "money_strap_hundred",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_hundred", 100)
    :component("paper", 1)
)

content.add(content.Recipe {
    id = "money_strap_FMCNote",
    result = "money_strap_FMCNote",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("FMCNote", 100)
    :component("paper", 1)
)

content.add(content.Recipe {
    id = "money_bundle_one",
    result = "money_bundle_one",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_strap_one", 10)
    :component_any({
            { id = "rubber_band", count = 2 },
            { id = "cordage_short", count = 2, requirement = true }
        })
)

content.add(content.Recipe {
    id = "money_bundle_two",
    result = "money_bundle_two",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_strap_two", 10)
    :component_any({
            { id = "rubber_band", count = 2 },
            { id = "cordage_short", count = 2, requirement = true }
        })
)

content.add(content.Recipe {
    id = "money_bundle_five",
    result = "money_bundle_five",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_strap_five", 10)
    :component_any({
            { id = "rubber_band", count = 2 },
            { id = "cordage_short", count = 2, requirement = true }
        })
)

content.add(content.Recipe {
    id = "money_bundle_ten",
    result = "money_bundle_ten",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_strap_ten", 10)
    :component_any({
            { id = "rubber_band", count = 2 },
            { id = "cordage_short", count = 2, requirement = true }
        })
)

content.add(content.Recipe {
    id = "money_bundle_twenty",
    result = "money_bundle_twenty",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_strap_twenty", 10)
    :component_any({
            { id = "rubber_band", count = 2 },
            { id = "cordage_short", count = 2, requirement = true }
        })
)

content.add(content.Recipe {
    id = "money_bundle_fifty",
    result = "money_bundle_fifty",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_strap_fifty", 10)
    :component_any({
            { id = "rubber_band", count = 2 },
            { id = "cordage_short", count = 2, requirement = true }
        })
)

content.add(content.Recipe {
    id = "money_bundle_hundred",
    result = "money_bundle_hundred",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_strap_hundred", 10)
    :component_any({
            { id = "rubber_band", count = 2 },
            { id = "cordage_short", count = 2, requirement = true }
        })
)

content.add(content.Recipe {
    id = "money_bundle_FMCNote",
    result = "money_bundle_FMCNote",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    disassembly_moves = 400,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("money_strap_FMCNote", 10)
    :component_any({
            { id = "rubber_band", count = 2 },
            { id = "cordage_short", count = 2, requirement = true }
        })
)

content.add(content.Recipe {
    id = "coin_wrapper",
    result = "coin_wrapper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 100,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    flags = { "BLIND_EASY" },
}
    :component("paper", 1)
)

content.add(content.Recipe {
    id = "cigar_handrolled",
    result = "cigar",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    variant = "handrolled",
}
    :component("tobacco", 4)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "cigar_handrolled_with_cutter_puncher",
    result = "cigar",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    variant = "handrolled",
}
    :tool_any({
            { id = "cigar_cutter", count = 1 },
            { id = "cigar_punch", count = 1 }
        })
    :component("tobacco", 4)
)
