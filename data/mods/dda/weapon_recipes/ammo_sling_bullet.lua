local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "sling_bullet_clay_250",
    result = "sling_bullet_clay_250",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "fire", count = 1 },
            { id = "char_kiln", charges = 25 },
            { id = "forge", charges = 25 }
        })
    :component("clay_lump", 1)
    :requires_skill("throw", 1)
    :batch_discount(80, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "sling_bullet_clay_500",
    result = "sling_bullet_clay_500",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "fire", count = 1 },
            { id = "char_kiln", charges = 25 },
            { id = "forge", charges = 25 }
        })
    :component("clay_lump", 1)
    :requires_skill("throw", 1)
    :batch_discount(80, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling_bullet_clay_750",
    result = "sling_bullet_clay_750",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "fire", count = 1 },
            { id = "char_kiln", charges = 25 },
            { id = "forge", charges = 25 }
        })
    :component("clay_lump", 3)
    :requires_skill("throw", 1)
    :batch_discount(80, 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "sling_bullet_stone_250",
    result = "sling_bullet_stone_250",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("rock", 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("throw", 1)
    :result_charges(2)
)

content.add(content.Recipe {
    id = "sling_bullet_stone_500",
    result = "sling_bullet_stone_500",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 60000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("rock", 1)
    :quality("HAMMER", 1, 1)
    :requires_skill("throw", 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling_bullet_steel_250",
    result = "sling_bullet_steel_250",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :quality("GRIND", 1, 1)
    :requirement("blacksmithing_simple", 1)
    :requirement("steel_chunk_any", 1)
    :requires_skill("throw", 1)
    :proficiency("prof_metalworking")
    :batch_discount(80, 3)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling_bullet_steel_500",
    result = "sling_bullet_steel_500",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :quality("GRIND", 1, 1)
    :requirement("blacksmithing_simple", 2)
    :requirement("steel_chunk_any", 2)
    :requires_skill("throw", 1)
    :proficiency("prof_metalworking")
    :batch_discount(80, 3)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling_bullet_steel_750",
    result = "sling_bullet_steel_750",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 180000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :quality("GRIND", 1, 1)
    :requirement("blacksmithing_simple", 3)
    :requirement("steel_chunk_any", 3)
    :requires_skill("throw", 1)
    :proficiency("prof_metalworking")
    :batch_discount(80, 3)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling_bullet_lead_250",
    result = "sling_bullet_lead_250",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 },
            { id = "iron_pot", count = 1 },
            { id = "pan", count = 1 },
            { id = "pot_makeshift", count = 1 }
        })
    :component("lead", 50)
    :quality("CUT", 1, 1)
    :quality("VISE", 1, 1)
    :requirement("blacksmithing_simple", 1)
    :requires_skill("throw", 1)
    :batch_discount(80, 3)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling_bullet_lead_500",
    result = "sling_bullet_lead_500",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 },
            { id = "iron_pot", count = 1 },
            { id = "pan", count = 1 },
            { id = "pot_makeshift", count = 1 }
        })
    :component("lead", 100)
    :quality("CUT", 1, 1)
    :quality("VISE", 1, 1)
    :requirement("blacksmithing_simple", 2)
    :requires_skill("throw", 1)
    :batch_discount(80, 3)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "sling_bullet_lead_750",
    result = "sling_bullet_lead_750",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 },
            { id = "iron_pot", count = 1 },
            { id = "pan", count = 1 },
            { id = "pot_makeshift", count = 1 }
        })
    :component("lead", 150)
    :quality("CUT", 1, 1)
    :quality("VISE", 1, 1)
    :requirement("blacksmithing_simple", 3)
    :requires_skill("throw", 1)
    :batch_discount(80, 3)
    :result_charges(1)
)
