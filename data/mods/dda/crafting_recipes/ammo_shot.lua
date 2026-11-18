local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- 971 mg gunpowder rounded to 10 100 mg 'pieces'
content.add(content.Recipe {
    id = "bp_410shot_000",
    result = "bp_410shot_000",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press", 1)
    :component("chem_black_powder", 10)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_410shot", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 0)
    :book("manual_shotgun", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_410shot_000_with_dowel",
    result = "bp_410shot_000",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press_dowel", 1)
    :component("chem_black_powder", 10)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_410shot", 1)
    :requires_skill("gun", 2)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1101 mg gunpowder rounded to 11 100 mg 'pieces'
content.add(content.Recipe {
    id = "bp_410shot_bird",
    result = "bp_410shot_bird",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press", 1)
    :component("chem_black_powder", 11)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_410shot", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 0)
    :book("manual_shotgun", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_410shot_bird_with_dowel",
    result = "bp_410shot_bird",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press_dowel", 1)
    :component("chem_black_powder", 11)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_410shot", 1)
    :requires_skill("gun", 2)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 971 mg gunpowder rounded to 10 100 mg 'pieces'
content.add(content.Recipe {
    id = "bp_410shot_slug",
    result = "bp_410shot_slug",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press", 1)
    :component("chem_black_powder", 10)
    :requirement("bullet_forming", 1)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_410shot", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 0)
    :book("manual_shotgun", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_410shot_slug_with_dowel",
    result = "bp_410shot_slug",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press_dowel", 1)
    :component("chem_black_powder", 10)
    :requirement("bullet_forming", 1)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_410shot", 1)
    :requires_skill("gun", 2)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_410shot_scrap",
    result = "bp_410shot_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press", 1)
    :component("chem_black_powder", 10)
    :component_any({
            { id = "scrap", count = 1 },
            { id = "nails", count = 4, requirement = true },
            { id = "bb", count = 7 },
            { id = "solder_wire", count = 4 },
            { id = "platinum_small", count = 1 },
            { id = "gold_small", count = 1 },
            { id = "bearing", count = 2 },
            { id = "lead", count = 3 },
            { id = "silver_small", count = 3 },
            { id = "bismuth", count = 3 },
            { id = "shrapnel", count = 1 }
        })
    :requirement("ammo_410shot", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :batch_discount(50, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_410shot_scrap_with_dowel",
    result = "bp_410shot_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press_dowel", 1)
    :component("chem_black_powder", 10)
    :component_any({
            { id = "scrap", count = 1 },
            { id = "nails", count = 4, requirement = true },
            { id = "bb", count = 7 },
            { id = "solder_wire", count = 4 },
            { id = "platinum_small", count = 1 },
            { id = "gold_small", count = 1 },
            { id = "bearing", count = 2 },
            { id = "lead", count = 3 },
            { id = "silver_small", count = 3 },
            { id = "bismuth", count = 3 },
            { id = "shrapnel", count = 1 }
        })
    :requirement("ammo_410shot", 1)
    :requires_skill("gun", 1)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(50, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_00",
    result = "bp_shot_00",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press", 1)
    :component("chem_black_powder", 12)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 11)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 0)
    :book("manual_shotgun", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- assumes 1 oz load
content.add(content.Recipe {
    id = "bp_shot_bird",
    result = "bp_shot_bird",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press", 1)
    :component("chem_black_powder", 15)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 0)
    :book("manual_shotgun", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_dragon",
    result = "bp_shot_dragon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press", 1)
    :component("chem_black_powder", 15)
    :component("magnesium", 5)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 0)
    :book("manual_shotgun", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_slug",
    result = "bp_shot_slug",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("chem_black_powder", 17)
    :requirement("bullet_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 0)
    :book("manual_shotgun", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_00_with dowel",
    result = "bp_shot_00",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press_dowel", 1)
    :component("chem_black_powder", 12)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 11)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_bird_with dowel",
    result = "bp_shot_bird",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press_dowel", 1)
    :component("chem_black_powder", 15)
    :requirement("shot_forming", 1)
    :requirement("ammo_bullet", 10)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_dragon_with dowel",
    result = "bp_shot_dragon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press_dowel", 1)
    :component("chem_black_powder", 15)
    :component("magnesium", 5)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_shot_slug_with dowel",
    result = "bp_shot_slug",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press_dowel", 1)
    :tool_any({
            { id = "pipe", count = 1 },
            { id = "cu_pipe", count = 1 },
            { id = "material_sand", count = 1 },
            { id = "material_soil", count = 1 },
            { id = "clay_lump", count = 1 }
        })
    :tool_any({
            { id = "fire", count = 1 },
            { id = "hotplate", charges = 2 },
            { id = "integrated_welder", charges = 2 }
        })
    :component("chem_black_powder", 17)
    :requirement("ammo_bullet", 10)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- currently halved inputs (rounding up) and result pending fix of casing duplication
content.add(content.Recipe {
    id = "bp_shot_scrap",
    result = "bp_shot_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press", 1)
    :component("chem_black_powder", 12)
    :component_any({
            { id = "scrap", count = 1 },
            { id = "nails", count = 5, requirement = true },
            { id = "bb", count = 10 },
            { id = "solder_wire", count = 5 },
            { id = "platinum_small", count = 2 },
            { id = "gold_small", count = 2 },
            { id = "bearing", count = 3 },
            { id = "lead", count = 4 },
            { id = "silver_small", count = 4 },
            { id = "lead", count = 4 },
            { id = "shrapnel", count = 2 }
        })
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :batch_discount(50, 5)
    :result_charges(1)
)

-- currently halved inputs (rounding up) and result pending fix of casing duplication
content.add(content.Recipe {
    id = "bp_shot_scrap_with dowel",
    result = "bp_shot_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press_dowel", 1)
    :component("chem_black_powder", 23)
    :component_any({
            { id = "scrap", count = 1 },
            { id = "nails", count = 5, requirement = true },
            { id = "bb", count = 10 },
            { id = "solder_wire", count = 5 },
            { id = "platinum_small", count = 2 },
            { id = "gold_small", count = 2 },
            { id = "bearing", count = 3 },
            { id = "lead", count = 4 },
            { id = "silver_small", count = 4 },
            { id = "lead", count = 4 },
            { id = "shrapnel", count = 2 }
        })
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 1)
    :book("survival_book", 1)
    :book("mag_survival", 1)
    :proficiency("prof_handloading")
    :batch_discount(50, 5)
    :result_charges(1)
)
