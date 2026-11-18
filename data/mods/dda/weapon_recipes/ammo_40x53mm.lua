local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- 11.5x the propellant and 11.5x the payload of 12 gauge 00 shot load. 13409 mg gunpowder rounded to 134 100
-- mg 'pieces'
content.add(content.Recipe {
    id = "40x53mm_buckshot_m169",
    result = "40x53mm_buckshot_m169",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 30000,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("press", 1)
    :tool("swage", 1)
    :component("sheet_metal_small", 1)
    :component_any({
            { id = "paper", count = 1 },
            { id = "wax_any", count = 1, requirement = true }
        })
    :component("gunpowder_shotgun", 134)
    :component("40x53mm_m169_casing", 1)
    :component("lgrifle_primer", 1)
    :quality("CUT", 2, 1)
    :requirement("shot_forming", 12)
    :requirement("ammo_bullet", 126)
    :requires_skill("launcher", 2)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 11.5x the propellant and 11.5x the payload of 12 gauge slug load. 19366 mg gunpowder rounded to 194 100 mg
-- 'pieces'
content.add(content.Recipe {
    id = "40x53mm_slug_m169",
    result = "40x53mm_slug_m169",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 30000,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("press", 1)
    :tool("swage", 1)
    :component("sheet_metal_small", 1)
    :component_any({
            { id = "paper", count = 1 },
            { id = "wax_any", count = 1, requirement = true }
        })
    :component("gunpowder_shotgun", 194)
    :component("40x53mm_m169_casing", 1)
    :component("lgrifle_primer", 1)
    :quality("CUT", 2, 1)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 115)
    :requires_skill("launcher", 2)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 11.5x the propellant and 11.5x the payload of 12 gauge flechette load. 8625 mg gunpowder rounded to 86 100
-- mg 'pieces'
content.add(content.Recipe {
    id = "40x53mm_flechette_m169",
    result = "40x53mm_flechette_m169",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 30000,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("press", 1)
    :tool("swage", 1)
    :component("sheet_metal_small", 1)
    :component_any({
            { id = "paper", count = 1 },
            { id = "wax_any", count = 1, requirement = true }
        })
    :component("combatnail", 115)
    :component("gunpowder_shotgun", 86)
    :component("40x53mm_m169_casing", 1)
    :component("lgrifle_primer", 1)
    :quality("CUT", 2, 1)
    :requires_skill("launcher", 2)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_40x53mm_buckshot_m169",
    result = "bp_40x53mm_buckshot_m169",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 30000,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("press", 1)
    :tool("swage", 1)
    :component("sheet_metal_small", 1)
    :component_any({
            { id = "paper", count = 1 },
            { id = "wax_any", count = 1, requirement = true }
        })
    :component("chem_black_powder", 134)
    :component("40x53mm_m169_casing", 1)
    :component("lgrifle_primer", 1)
    :quality("CUT", 2, 1)
    :requirement("shot_forming", 12)
    :requirement("ammo_bullet", 126)
    :requires_skill("launcher", 2)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_40x53mm_slug_m169",
    result = "bp_40x53mm_slug_m169",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 30000,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("press", 1)
    :tool("swage", 1)
    :component("sheet_metal_small", 1)
    :component_any({
            { id = "paper", count = 1 },
            { id = "wax_any", count = 1, requirement = true }
        })
    :component("chem_black_powder", 194)
    :component("40x53mm_m169_casing", 1)
    :component("lgrifle_primer", 1)
    :quality("CUT", 2, 1)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 115)
    :requires_skill("launcher", 2)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_40x53mm_flechette_m169",
    result = "bp_40x53mm_flechette_m169",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 30000,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("press", 1)
    :tool("swage", 1)
    :component("sheet_metal_small", 1)
    :component_any({
            { id = "paper", count = 1 },
            { id = "wax_any", count = 1, requirement = true }
        })
    :component("combatnail", 115)
    :component("chem_black_powder", 86)
    :component("40x53mm_m169_casing", 1)
    :component("lgrifle_primer", 1)
    :quality("CUT", 2, 1)
    :requires_skill("launcher", 2)
    :book("recipe_bullets", 3)
    :book("manual_shotgun", 3)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)
