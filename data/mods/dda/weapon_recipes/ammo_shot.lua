local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- Assumes standard 9 pellet 00 load. 1166 mg gunpowder rounded to 12 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_shot_00",
    result = "reloaded_shot_00",
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
    :component_any({
            { id = "gunpowder_pistol", count = 12 },
            { id = "gunpowder_shotgun", count = 12 }
        })
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

-- 971 mg gunpowder rounded to 10 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_410shot_000",
    result = "reloaded_410shot_000",
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
    :component_any({
            { id = "gunpowder_pistol", count = 10 },
            { id = "gunpowder_shotgun", count = 10 }
        })
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

-- 1101 mg gunpowder rounded to 11 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_410shot_bird",
    result = "reloaded_410shot_bird",
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
    :component_any({
            { id = "gunpowder_pistol", count = 11 },
            { id = "gunpowder_shotgun", count = 11 }
        })
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

-- 971 mg gunpowder rounded to 10 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_410shot_slug",
    result = "reloaded_410shot_slug",
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
    :component_any({
            { id = "gunpowder_pistol", count = 10 },
            { id = "gunpowder_shotgun", count = 10 }
        })
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
    id = "410shot_scrap",
    result = "410shot_scrap",
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
    :component_any({
            { id = "gunpowder_pistol", count = 10 },
            { id = "gunpowder_shotgun", count = 10 }
        })
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

-- 1490 mg gunpowder rounded to 15 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_shot_bird",
    result = "reloaded_shot_bird",
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
    :component_any({
            { id = "gunpowder_pistol", count = 15 },
            { id = "gunpowder_shotgun", count = 15 }
        })
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

-- same charge as a 1 oz load, could find no reference to actual loading data. 1490 mg gunpowder rounded to
-- 15 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_shot_dragon",
    result = "reloaded_shot_dragon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press", 1)
    :component_any({
            { id = "gunpowder_pistol", count = 15 },
            { id = "gunpowder_shotgun", count = 15 }
        })
    :component("magnesium", 5)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 0)
    :book("manual_shotgun", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- Wikipedia states the shells contain 20 7.3 grain flechettes for a 146 grain or 1/3 oz load.
-- http://www.sabotdesigns.com/002.html lists flechette velocity at 1950 fps. Gunpowder charge is calculated
-- as if it was a solid slug for sake of ease. 750 mg gunpowder rounded to 8 100 mg 'pieces
content.add(content.Recipe {
    id = "reloaded_shot_flechette",
    result = "reloaded_shot_flechette",
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
    :component_any({
            { id = "gunpowder_pistol", count = 8 },
            { id = "gunpowder_shotgun", count = 8 }
        })
    :component("combatnail", 10)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 0)
    :book("manual_shotgun", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- assumes 1 oz slug. 1684 mg gunpowder rounded to 17 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_shot_slug",
    result = "reloaded_shot_slug",
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
    :component_any({
            { id = "gunpowder_pistol", count = 17 },
            { id = "gunpowder_shotgun", count = 17 }
        })
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
    id = "bp_shot_flechette",
    result = "bp_shot_flechette",
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
    :component("chem_black_powder", 8)
    :component("combatnail", 10)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 0)
    :book("manual_shotgun", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1166 mg gunpowder rounded to 12 100 mg 'pieces'; recipe makes two shells
-- currently halved inputs (rounding up) and result pending fix of casing duplication
content.add(content.Recipe {
    id = "shot_scrap",
    result = "shot_scrap",
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
    :component_any({
            { id = "gunpowder_pistol", count = 12 },
            { id = "gunpowder_shotgun", count = 12 }
        })
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
            { id = "bismuth", count = 4 },
            { id = "shrapnel", count = 2 }
        })
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_handloading")
    :batch_discount(50, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "signal_flare",
    result = "signal_flare",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("press", 1)
    :component("incendiary", 25)
    :requirement("ammo_shot", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 0)
    :book("manual_shotgun", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "wax_slug",
    result = "wax_slug",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_charges("surface_heat", 1, true)
    :tool_charges("candle", 5)
    :component("shot_bird", 1)
    :quality("CUT_FINE", 1, 1)
    :requires_skill("shotgun", 2)
    :book("manual_shotgun", 1)
    :batch_discount(60, 5)
    :result_charges(1)
)
