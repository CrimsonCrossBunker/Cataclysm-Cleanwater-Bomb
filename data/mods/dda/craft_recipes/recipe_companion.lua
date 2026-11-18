local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "charcoal_npc",
    result = "charcoal",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
}
    :component_any({
            { id = "log", count = 2 },
            { id = "stick", count = 16 },
            { id = "splinter", count = 80 }
        })
    :byproduct("charcoal", 12)
)

content.add(content.Recipe {
    id = "sheet_metal_npc_drop",
    result = "sheet_metal",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    never_learn = true,
}
    :tool("metalworking_tongs", 1)
    :tool("metal_file", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 5, 1)
    :requirement("forging_standard", 24)
    :requirement("lc_steel_standard", 6)
)

content.add(content.Recipe {
    id = "chain_npc_drop",
    result = "chain",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 312000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
    never_learn = true,
}
    :tool("metalworking_tongs", 1)
    :tool("metal_file", 1)
    :tool("swage", 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 5, 1)
    :requirement("forging_standard", 32)
    :requirement("steel_standard", 8)
)

content.add(content.Recipe {
    id = "nail_npc_drop",
    result = "nail",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
    never_learn = true,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :tool_any({
            { id = "forge", charges = 5 },
            { id = "oxy_torch", charges = 1 }
        })
    :component_any({
            { id = "steel_chunk_any", count = 1, requirement = true },
            { id = "scrap", count = 3 }
        })
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 5, 1)
    :batch_discount(3, 10)
    :result_charges(83)
)

content.add(content.Recipe {
    id = "lc_wire_npc_drop",
    result = "lc_wire",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 18000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
    never_learn = true,
}
    :tool("metalworking_tongs", 1)
    :tool_any({
            { id = "forge", charges = 10 },
            { id = "oxy_torch", charges = 2 }
        })
    :component("scrap", 1)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 5, 1)
)

content.add(content.Recipe {
    id = "pipe_npc_drop",
    result = "pipe",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 72000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    never_learn = true,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :tool_any({
            { id = "forge", charges = 10 },
            { id = "oxy_torch", charges = 2 }
        })
    :component("scrap", 7)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 5, 1)
)

content.add(content.Recipe {
    id = "rebar_npc_drop",
    result = "rebar",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 54000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
    never_learn = true,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :tool_any({
            { id = "forge", charges = 10 },
            { id = "oxy_torch", charges = 2 }
        })
    :component("scrap", 3)
    :quality("ANVIL", 3, 1)
    :quality("HAMMER", 5, 1)
)

content.add(content.Recipe {
    id = "fish_npc_fish_trap",
    result = "fish",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_BASIC",
    duration_moves = 1080000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "survival",
    difficulty = 4,
    never_learn = true,
}
    :quality("FISH_TRAP", 1, 1)
    :requires_skill("survival", 4)
)

content.add(content.Recipe {
    id = "fish_npc_fish_rod_lvl1",
    result = "fish",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_BASIC",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "survival",
    difficulty = 4,
    never_learn = true,
}
    :quality("FISHING_ROD", 1, 1)
    :requires_skill("survival", 4)
)

content.add(content.Recipe {
    id = "fish_npc_fish_rod_lvl2",
    result = "fish",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_BASIC",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "survival",
    difficulty = 4,
    never_learn = true,
}
    :quality("FISHING_ROD", 2, 1)
    :requires_skill("survival", 4)
)

content.add(content.Recipe {
    id = "memory_card_unread_npc_hack",
    result = "memory_card_unread",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "computer",
    difficulty = 2,
    never_learn = true,
}
    :tool_charges("laptop", 120)
    :component("memory_card", 1)
    :requires_skill("computer", 2)
)

content.add(content.Recipe {
    id = "software_useless_npc_hack",
    result = "software_useless",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "computer",
    difficulty = 3,
    container = "usb_drive",
    never_learn = true,
}
    :tool_charges("laptop", 240)
    :component("usb_drive", 1)
    :requires_skill("computer", 3)
)

content.add(content.Recipe {
    id = "software_math_npc_hack",
    result = "software_math",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 900000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "computer",
    difficulty = 4,
    container = "usb_drive",
    never_learn = true,
}
    :tool_charges("laptop", 300)
    :tool("software_hacking", 1)
    :component("usb_drive", 1)
    :requires_skill("computer", 4)
)

content.add(content.Recipe {
    id = "memory_card_science_npc_hack",
    result = "memory_card_science",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 1080000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "computer",
    difficulty = 5,
    never_learn = true,
}
    :tool_charges("laptop", 360)
    :tool("software_hacking", 1)
    :component("memory_card", 1)
    :requires_skill("computer", 5)
)

content.add(content.Recipe {
    id = "software_medical_npc_hack",
    result = "software_medical",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 1260000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "computer",
    difficulty = 5,
    container = "usb_drive",
    never_learn = true,
}
    :tool_charges("laptop", 420)
    :tool("software_hacking", 1)
    :component("usb_drive", 1)
    :requires_skill("computer", 5)
)

content.add(content.Recipe {
    id = "software_electronics_reference_npc_hack",
    result = "software_electronics_reference",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "computer",
    difficulty = 6,
    container = "usb_drive",
    never_learn = true,
}
    :tool_charges("laptop", 480)
    :tool("software_hacking", 1)
    :component("usb_drive", 1)
    :requires_skill("computer", 6)
)

content.add(content.Recipe {
    id = "satellitemap_npc_hack",
    result = "satellitemap",
    category = "CC_CAMP",
    subcategory = "CSC_CAMP_EXPANSIONS",
    duration_moves = 2880000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "computer",
    difficulty = 8,
    never_learn = true,
}
    :tool_charges("laptop", 600)
    :tool_charges("pencil", 50)
    :tool("software_hacking", 1)
    :component("paper", 25)
    :requires_skill("computer", 8)
)
