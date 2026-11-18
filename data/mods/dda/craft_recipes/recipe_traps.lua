local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "caltrops",
    result = "caltrops",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 600000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("swage", 1)
    :requirement("blacksmithing_standard", 1)
    :requirement("steel_chunk_any", 1)
    :requires_skill("traps", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
)

content.add(content.Recipe {
    id = "caltrops_glass",
    result = "caltrops_glass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("glass_shard", 4)
    :quality("HAMMER", 1, 1)
    :requirement("glue_any", 4)
    :requires_skill("traps", 1)
)

content.add(content.Recipe {
    id = "caltrops_from wire",
    result = "caltrops",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component_any({
            { id = "wire_barbed", count = 10 },
            { id = "any_wire", count = 10, requirement = true },
            { id = "nails", count = 10, requirement = true }
        })
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("VISE", 1, 1)
    :requirement("welding_standard", 5)
    :requires_skill("traps", 2)
    :proficiency("prof_welding_basic")
    :proficiency("prof_metalworking")
)

content.add(content.Recipe {
    id = "caltrops_teeth",
    result = "caltrops_teeth",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("nm_teeth", 4)
    :requirement("glue_any", 4)
    :requires_skill("traps", 1)
)

content.add(content.Recipe {
    id = "telepad",
    result = "telepad",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 27000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("teleporter", 1)
    :component("amplifier", 1)
    :component("solar_cell", 1)
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :requirement("soldering_standard", 16)
    :requires_skill("traps", 5)
    :learn_by_disassembly("electronics", 5)
    :book("recipe_lab_elec", 8)
    :proficiency("prof_elec_soldering")
)

content.add(content.Recipe {
    id = "tripwire",
    result = "tripwire",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "traps",
    difficulty = 1,
}
    :component("glue_strong", 1)
    :requirement("cordage", 1)
    :proficiency("prof_traps")
)

content.add(content.Recipe {
    id = "board_trap",
    result = "board_trap",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("2x4", 3)
    :component("nails", 20, true)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "board_trap_use_nailboards",
    result = "board_trap",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("nailboard", 3)
    :component("nails", 2, true)
    :quality("HAMMER", 1, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "beartrap",
    result = "beartrap",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "traps",
    difficulty = 2,
}
    :component("spring", 1)
    :quality("WRENCH", 1, 1)
    :requirement("blacksmithing_standard", 44)
    :requirement("steel_standard", 11)
    :requires_skill("mechanics", 3)
    :requires_skill("fabrication", 3)
    :learn_by_disassembly("traps", 2)
    :book("mag_traps", 1)
    :book("manual_mechanics", 2)
    :book("manual_traps", 1)
    :book("howto_traps", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_toolsmithing")
    :proficiency("prof_traps")
    :proficiency("prof_trapsetting")
)

content.add(content.Recipe {
    id = "crossbow_trap",
    result = "crossbow_trap",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 150000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "traps",
    difficulty = 3,
}
    :component("crossbow", 1)
    :component_any({
            { id = "bolt_steel", count = 1 },
            { id = "bolt_wood", count = 4 }
        })
    :requirement("cordage", 1)
    :requires_skill("archery", 1)
    :learn_by_disassembly("traps", 2)
    :proficiency("prof_traps")
    :proficiency("prof_trapsetting")
)

content.add(content.Recipe {
    id = "shotgun_trap",
    result = "shotgun_trap",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 150000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "traps",
    difficulty = 3,
}
    :component("slamfire_shotgun_d", 1)
    :component_any({
            { id = "shot_00", count = 2 },
            { id = "shot_slug", count = 2 },
            { id = "shot_flechette", count = 2 }
        })
    :requirement("cordage", 1)
    :requires_skill("gun", 1)
    :learn_by_disassembly("traps", 2)
    :proficiency("prof_traps")
    :proficiency("prof_trapsetting")
)

-- 撤销 PR #86231 — 恢复刀片陷阱配方
content.add(content.Recipe {
    id = "blade_trap",
    result = "blade_trap",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 4,
}
    :component("motor_small", 1)
    :component("blade", 2)
    :component("cordage", 1, true)
    :quality("WRENCH", 1, 1)
    :requires_skill("traps", 3)
    :learn_by_disassembly("mechanics", 3)
    :book("manual_mechanics", 3)
    :book("manual_traps", 3)
    :book("howto_traps", 3)
    :book("book_icef", 4)
    :proficiency("prof_traps")
)

content.add(content.Recipe {
    id = "boobytrap_closed_cans_such_as_drinks",
    result = "boobytrap",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TRAPS",
    duration_moves = 150000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "traps",
    difficulty = 3,
}
    :component("grenade", 1)
    :component_any({
            { id = "clay_canister", count = 1 },
            { id = "can_drink", count = 1 },
            { id = "can_food", count = 1 },
            { id = "canister_empty", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requirement("cordage_short", 1)
    :book("manual_traps_mil_basic", 3)
    :book("manual_traps_mil", 3)
    :proficiency("prof_traps")
    :proficiency("prof_trapsetting")
)
