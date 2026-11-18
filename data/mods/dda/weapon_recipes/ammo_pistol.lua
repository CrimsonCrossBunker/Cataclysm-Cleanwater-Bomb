local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "bp_9mm",
    result = "bp_9mm",
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
    :component("chem_black_powder", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_9mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_9mmfmj",
    result = "bp_9mmfmj",
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
    :component("chem_black_powder", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_9mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_40fmj",
    result = "bp_40fmj",
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
    :component("unprimed_40_casing", 1)
    :component("smpistol_primer", 1)
    :component("chem_black_powder", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_40sw",
    result = "bp_40sw",
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
    :component("unprimed_40_casing", 1)
    :component("smpistol_primer", 1)
    :component("chem_black_powder", 6)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_32_acp",
    result = "bp_32_acp",
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
    :component("chem_black_powder", 2)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_32", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_32_acp_jhp",
    result = "bp_32_acp_jhp",
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
    :component("chem_black_powder", 2)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_32", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_38_fmj",
    result = "bp_38_fmj",
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
    :component("chem_black_powder", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38spc", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_38super_fmj",
    result = "bp_38super_fmj",
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
    :component("chem_black_powder", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38super", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_38super",
    result = "bp_38super",
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
    :component("chem_black_powder", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38super", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_44fmj",
    result = "bp_44fmj",
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
    :component("unprimed_44_casing", 1)
    :component("lgpistol_primer", 1)
    :component("chem_black_powder", 7)
    :component("copper", 2)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_45_acp",
    result = "bp_45_acp",
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
    :component("unprimed_45_casing", 1)
    :component("lgpistol_primer", 1)
    :component("chem_black_powder", 3)
    :component("copper", 2)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_45_jhp",
    result = "bp_45_jhp",
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
    :component("unprimed_45_casing", 1)
    :component("lgpistol_primer", 1)
    :component("chem_black_powder", 5)
    :component("copper", 1)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_500_Magnum",
    result = "bp_500_Magnum",
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
    :component("unprimed_500_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 19)
    :component("copper", 5)
    :requirement("bullet_forming", 6)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_50ae_jhp",
    result = "bp_50ae_jhp",
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
    :component("unprimed_50ae_casing", 1)
    :component("lgpistol_primer", 1)
    :component("chem_black_powder", 16)
    :component("copper", 5)
    :requirement("bullet_forming", 6)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_50ae_fmj",
    result = "bp_50ae_fmj",
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
    :component("unprimed_50ae_casing", 1)
    :component("lgpistol_primer", 1)
    :component("chem_black_powder", 16)
    :component("copper", 6)
    :requirement("bullet_forming", 6)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_762_25",
    result = "bp_762_25",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("chem_black_powder", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_762_25", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_9x18mm",
    result = "bp_9x18mm",
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
    :component("unprimed_9x18mm_casing", 1)
    :component("smpistol_primer", 1)
    :component("chem_black_powder", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_9x18mmfmj",
    result = "bp_9x18mmfmj",
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
    :component("unprimed_9x18mm_casing", 1)
    :component("smpistol_primer", 1)
    :component("chem_black_powder", 4)
    :component("copper", 1)
    :component("9x18_steel_core", 1)
    :requirement("bullet_forming", 2)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_380_JHP",
    result = "bp_380_JHP",
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
    :component("chem_black_powder", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_380", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_380_FMJ",
    result = "bp_380_FMJ",
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
    :component("chem_black_powder", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_380", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_57mm",
    result = "bp_57mm",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("chem_black_powder", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 1)
    :requirement("ammo_57", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "36navy",
    result = "36navy",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("chem_black_powder", 4)
    :component("smpistol_primer", 1)
    :component_any({
            { id = "paper", count = 1 },
            { id = "aluminum_foil", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "44army",
    result = "44army",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_PISTOL",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("chem_black_powder", 4)
    :component("lgpistol_primer", 1)
    :component_any({
            { id = "paper", count = 1 },
            { id = "aluminum_foil", count = 1 }
        })
    :quality("CUT", 2, 1)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 207 mg gunpowder rounded to 2 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_32_acp",
    result = "reloaded_32_acp",
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
            { id = "gunpowder_pistol", count = 2 },
            { id = "gunpowder_shotgun", count = 2 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_32", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 207 mg gunpowder rounded to 2 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_32_acp_jhp",
    result = "reloaded_32_acp_jhp",
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
            { id = "gunpowder_pistol", count = 2 },
            { id = "gunpowder_shotgun", count = 2 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_32", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 315 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_38_fmj",
    result = "reloaded_38_fmj",
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
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38spc", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 315 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_38_special",
    result = "reloaded_38_special",
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
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38spc", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 447 mg gunpowder rounded to 4 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_38_special_p",
    result = "reloaded_38_special_p",
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
            { id = "gunpowder_pistol", count = 4 },
            { id = "gunpowder_shotgun", count = 4 }
        })
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38spc", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 370 mg gunpowder rounded to 4 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_357sig_fmj",
    result = "reloaded_357sig_fmj",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "gunpowder_rifle", count = 4 },
            { id = "gunpowder_magnum_pistol", count = 4 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 7)
    :requirement("ammo_357sig", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 531 mg gunpowder rounded to 5 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_357sig_jhp",
    result = "reloaded_357sig_jhp",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component_any({
            { id = "gunpowder_rifle", count = 5 },
            { id = "gunpowder_magnum_pistol", count = 5 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 8)
    :requirement("ammo_357sig", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_357sig_fmj",
    result = "bp_357sig_fmj",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("chem_black_powder", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 7)
    :requirement("ammo_357sig", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_357sig_jhp",
    result = "bp_357sig_jhp",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("chem_black_powder", 5)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 8)
    :requirement("ammo_357sig", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 520 mg gunpowder rounded to 5 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_357mag_fmj",
    result = "reloaded_357mag_fmj",
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
            { id = "gunpowder_rifle", count = 5 },
            { id = "gunpowder_magnum_pistol", count = 5 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_357mag", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 520 mg gunpowder rounded to 5 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_357mag_jhp",
    result = "reloaded_357mag_jhp",
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
            { id = "gunpowder_rifle", count = 5 },
            { id = "gunpowder_magnum_pistol", count = 5 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 4)
    :requirement("ammo_357mag", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_357mag_fmj",
    result = "bp_357mag_fmj",
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
    :component("chem_black_powder", 5)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_357mag", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_357mag_jhp",
    result = "bp_357mag_jhp",
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
    :component("chem_black_powder", 5)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 4)
    :requirement("ammo_357mag", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_38_special",
    result = "bp_38_special",
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
    :component("chem_black_powder", 3)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38spc", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 320 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_40fmj",
    result = "reloaded_40fmj",
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
    :component("unprimed_40_casing", 1)
    :component("smpistol_primer", 1)
    :component_any({
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 576 mg gunpowder rounded to 6 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_40sw",
    result = "reloaded_40sw",
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
    :component("unprimed_40_casing", 1)
    :component("smpistol_primer", 1)
    :component_any({
            { id = "gunpowder_pistol", count = 6 },
            { id = "gunpowder_shotgun", count = 6 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 473 mg gunpowder rounded to 5 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_10mmP",
    result = "reloaded_10mmP",
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
    :component("gunpowder_magnum_pistol", 5)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_10mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 330 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_10mm_fmj",
    result = "reloaded_10mm_fmj",
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
    :component("gunpowder_magnum_pistol", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_10mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_10mm_fmj",
    result = "bp_10mm_fmj",
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
    :component("chem_black_powder", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_10mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 330 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_10mm_jhp",
    result = "reloaded_10mm_jhp",
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
    :component("gunpowder_magnum_pistol", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_10mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_10mm_jhp",
    result = "bp_10mm_jhp",
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
    :component("chem_black_powder", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_10mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 660 mg gunpowder rounded to 7 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_44fmj",
    result = "reloaded_44fmj",
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
    :component("unprimed_44_casing", 1)
    :component("lgpistol_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 7 },
            { id = "gunpowder_magnum_pistol", count = 7 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 660 mg gunpowder rounded to 7 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_44magnum",
    result = "reloaded_44magnum",
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
    :component("unprimed_44_casing", 1)
    :component("lgpistol_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 7 },
            { id = "gunpowder_magnum_pistol", count = 7 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_44magnum",
    result = "bp_44magnum",
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
    :component("unprimed_44_casing", 1)
    :component("lgpistol_primer", 1)
    :component("chem_black_powder", 7)
    :component("copper", 2)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 330 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_45_acp",
    result = "reloaded_45_acp",
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
    :component("unprimed_45_casing", 1)
    :component("lgpistol_primer", 1)
    :component_any({
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 466 mg gunpowder rounded to 5 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_45_jhp",
    result = "reloaded_45_jhp",
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
    :component("unprimed_45_casing", 1)
    :component("lgpistol_primer", 1)
    :component_any({
            { id = "gunpowder_pistol", count = 5 },
            { id = "gunpowder_shotgun", count = 5 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 513 mg gunpowder rounded to 5 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_45_super",
    result = "reloaded_45_super",
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
    :component("unprimed_45_casing", 1)
    :component("lgpistol_primer", 1)
    :component("gunpowder_pistol", 5)
    :component("copper", 1)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1574 mg gunpowder rounded to 16 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_454_Casull",
    result = "reloaded_454_Casull",
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
    :component("unprimed_454_casing", 1)
    :component("smrifle_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 16 },
            { id = "gunpowder_magnum_pistol", count = 16 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 6)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_454_Casull",
    result = "bp_454_Casull",
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
    :component("unprimed_454_casing", 1)
    :component("smrifle_primer", 1)
    :component("chem_black_powder", 16)
    :component("copper", 2)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 6)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 505 mg gunpowder rounded to 5 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_45colt_jhp",
    result = "reloaded_45colt_jhp",
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
            { id = "gunpowder_pistol", count = 5 },
            { id = "gunpowder_shotgun", count = 5 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_45colt", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_45colt_jhp",
    result = "bp_45colt_jhp",
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
    :component("chem_black_powder", 5)
    :component("copper", 2)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_45colt", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 505 mg gunpowder rounded to 5 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_45colt_fmj",
    result = "reloaded_45colt_fmj",
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
            { id = "gunpowder_pistol", count = 5 },
            { id = "gunpowder_shotgun", count = 5 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_45colt", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_45colt_fmj",
    result = "bp_45colt_fmj",
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
    :component("chem_black_powder", 5)
    :component("copper", 2)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_45colt", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 311 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_45colt_cowboy",
    result = "reloaded_45colt_cowboy",
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
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_45colt", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_45colt_cowboy",
    result = "bp_45colt_cowboy",
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
    :component("chem_black_powder", 3)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_45colt", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1943 mg gunpowder rounded to 19 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_500_Magnum",
    result = "reloaded_500_Magnum",
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
    :component("unprimed_500_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 19 },
            { id = "gunpowder_magnum_pistol", count = 19 }
        })
    :component("copper", 5)
    :requirement("bullet_forming", 6)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1619 mg gunpowder rounded to 16 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_50ae_jhp",
    result = "reloaded_50ae_jhp",
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
    :component("unprimed_50ae_casing", 1)
    :component("lgpistol_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 16 },
            { id = "gunpowder_magnum_pistol", count = 16 }
        })
    :component("copper", 5)
    :requirement("bullet_forming", 6)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1619 mg gunpowder rounded to 16 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_50ae_fmj",
    result = "reloaded_50ae_fmj",
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
    :component("unprimed_50ae_casing", 1)
    :component("lgpistol_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 16 },
            { id = "gunpowder_magnum_pistol", count = 16 }
        })
    :component("copper", 6)
    :requirement("bullet_forming", 6)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 388 mg gunpowder rounded to 4 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_57mm",
    result = "reloaded_57mm",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("unprimed_57mm_casing", 1)
    :component("smrifle_primer", 1)
    :component("gunpowder_pistol", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 390 mg gunpowder rounded to 4 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_762_25",
    result = "reloaded_762_25",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("gunpowder_pistol", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_762_25", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 290 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_9mm",
    result = "reloaded_9mm",
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
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_9mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 537 mg gunpowder rounded to 5 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_9mmP",
    result = "reloaded_9mmP",
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
    :component("gunpowder_pistol", 5)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_9mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- Arbitrary powder amount as +p+ is not a real standard but an informal one which has about 20% higher
-- pressure than standard 9mm, while +p is a standard that has 10% higher pressure. 580 mg gunpowder rounded
-- to 6 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_9mmP2",
    result = "reloaded_9mmP2",
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
    :component("gunpowder_pistol", 6)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_9mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 290 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_9mmfmj",
    result = "reloaded_9mmfmj",
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
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_9mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 401 mg gunpowder rounded to 4 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_9x18mm",
    result = "reloaded_9x18mm",
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
    :component("unprimed_9x18mm_casing", 1)
    :component("smpistol_primer", 1)
    :component_any({
            { id = "gunpowder_pistol", count = 4 },
            { id = "gunpowder_shotgun", count = 4 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 401 mg gunpowder rounded to 4 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_9x18mmfmj",
    result = "reloaded_9x18mmfmj",
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
    :component("unprimed_9x18mm_casing", 1)
    :component("smpistol_primer", 1)
    :component_any({
            { id = "gunpowder_pistol", count = 4 },
            { id = "gunpowder_shotgun", count = 4 }
        })
    :component("copper", 1)
    :component("9x18_steel_core", 1)
    :requirement("bullet_forming", 2)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- Arbitrary powder amount as +p+ is not a real standard but an informal one which has about 20% higher
-- pressure than standard 9mm, while +p is a standard that has 10% higher pressure. 481 mg gunpowder rounded
-- to 5 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_9x18mmP2",
    result = "reloaded_9x18mmP2",
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
    :component("unprimed_9x18mm_casing", 1)
    :component("smpistol_primer", 1)
    :component_any({
            { id = "gunpowder_pistol", count = 5 },
            { id = "gunpowder_shotgun", count = 5 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 375 mg gunpowder rounded to 4 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_38super_fmj",
    result = "reloaded_38super_fmj",
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
            { id = "gunpowder_pistol", count = 4 },
            { id = "gunpowder_shotgun", count = 4 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38super", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 375 mg gunpowder rounded to 4 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_38_super",
    result = "reloaded_38_super",
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
            { id = "gunpowder_pistol", count = 4 },
            { id = "gunpowder_shotgun", count = 4 }
        })
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38super", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 278 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_380_JHP",
    result = "reloaded_380_JHP",
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
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_380", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 320 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_380_p",
    result = "reloaded_380_p",
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
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_380", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 278 mg gunpowder rounded to 3 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_380_FMJ",
    result = "reloaded_380_FMJ",
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
            { id = "gunpowder_pistol", count = 3 },
            { id = "gunpowder_shotgun", count = 3 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_380", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2683 mg gunpowder rounded to 27 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_460sw",
    result = "reloaded_460sw",
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
    :component("gunpowder_magnum_pistol", 27)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_460sw", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2624 mg gunpowder rounded to 26 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_460sw_jhp",
    result = "reloaded_460sw_jhp",
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
    :component("gunpowder_magnum_pistol", 26)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 4)
    :requirement("ammo_460sw", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_9mm",
    result = "matchhead_9mm",
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
    :component("red_phosphorous_small", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_9mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_9mmfmj",
    result = "matchhead_9mmfmj",
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
    :component("red_phosphorous_small", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_9mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_40fmj",
    result = "matchhead_40fmj",
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
    :component("unprimed_40_casing", 1)
    :component("smpistol_primer", 1)
    :component("red_phosphorous_small", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_40sw",
    result = "matchhead_40sw",
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
    :component("unprimed_40_casing", 1)
    :component("smpistol_primer", 1)
    :component("red_phosphorous_small", 6)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_32_acp",
    result = "matchhead_32_acp",
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
    :component("red_phosphorous_small", 2)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_32", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_32_acp_jhp",
    result = "matchhead_32_acp_jhp",
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
    :component("red_phosphorous_small", 2)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_32", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_38_fmj",
    result = "matchhead_38_fmj",
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
    :component("red_phosphorous_small", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38spc", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_38_special",
    result = "matchhead_38_special",
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
    :component("red_phosphorous_small", 3)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38spc", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_38_super_fmj",
    result = "matchhead_38_super_fmj",
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
    :component("red_phosphorous_small", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38super", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_38_super",
    result = "matchhead_38_super",
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
    :component("red_phosphorous_small", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_38super", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_45_acp",
    result = "matchhead_45_acp",
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
    :component("unprimed_45_casing", 1)
    :component("lgpistol_primer", 1)
    :component("red_phosphorous_small", 3)
    :component("copper", 2)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_45_jhp",
    result = "matchhead_45_jhp",
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
    :component("unprimed_45_casing", 1)
    :component("lgpistol_primer", 1)
    :component("red_phosphorous_small", 5)
    :component("copper", 1)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_762_25",
    result = "matchhead_762_25",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("red_phosphorous_small", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_762_25", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_9x18mm",
    result = "matchhead_9x18mm",
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
    :component("unprimed_9x18mm_casing", 1)
    :component("smpistol_primer", 1)
    :component("red_phosphorous_small", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_9x18mmfmj",
    result = "matchhead_9x18mmfmj",
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
    :component("unprimed_9x18mm_casing", 1)
    :component("smpistol_primer", 1)
    :component("red_phosphorous_small", 4)
    :component("copper", 1)
    :component("9x18_steel_core", 1)
    :requirement("bullet_forming", 2)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_380_JHP",
    result = "matchhead_380_JHP",
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
    :component("red_phosphorous_small", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_380", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_380_FMJ",
    result = "matchhead_380_FMJ",
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
    :component("red_phosphorous_small", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_380", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_357sig_fmj",
    result = "matchhead_357sig_fmj",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("red_phosphorous_small", 4)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 7)
    :requirement("ammo_357sig", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_357sig_jhp",
    result = "matchhead_357sig_jhp",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("red_phosphorous_small", 5)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 8)
    :requirement("ammo_357sig", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_357mag_fmj",
    result = "matchhead_357mag_fmj",
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
    :component("red_phosphorous_small", 5)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_357mag", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_357mag_jhp",
    result = "matchhead_357mag_jhp",
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
    :component("red_phosphorous_small", 5)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 4)
    :requirement("ammo_357mag", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_10mm_fmj",
    result = "matchhead_10mm_fmj",
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
    :component("red_phosphorous_small", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_10mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_10mm_jhp",
    result = "matchhead_10mm_jhp",
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
    :component("red_phosphorous_small", 3)
    :component("copper", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_10mm", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_45colt_fmj",
    result = "matchhead_45colt_fmj",
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
    :component("red_phosphorous_small", 5)
    :component("copper", 2)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_45colt", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_45colt_cowboy",
    result = "matchhead_45colt_cowboy",
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
    :component("red_phosphorous_small", 3)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_45colt", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_45colt_jhp",
    result = "matchhead_45colt_jhp",
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
    :component("red_phosphorous_small", 5)
    :component("copper", 2)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_45colt", 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_50ae_jhp",
    result = "matchhead_50ae_jhp",
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
    :component("unprimed_50ae_casing", 1)
    :component("lgpistol_primer", 1)
    :component("red_phosphorous_small", 16)
    :component("copper", 5)
    :requirement("bullet_forming", 6)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_50ae_fmj",
    result = "matchhead_50ae_fmj",
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
    :component("unprimed_50ae_casing", 1)
    :component("lgpistol_primer", 1)
    :component("red_phosphorous_small", 16)
    :component("copper", 6)
    :requirement("bullet_forming", 6)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("manual_pistol", 0)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)
