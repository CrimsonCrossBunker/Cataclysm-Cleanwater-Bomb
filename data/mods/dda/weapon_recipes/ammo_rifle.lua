local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "flintlock_ammo",
    result = "flintlock_ammo",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("chem_black_powder", 30)
    :component("paper", 1)
    :quality("CUT", 2, 1)
    :requirement("ammo_bullet", 10)
    :requires_skill("gun", 2)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "flintlock_shot",
    result = "flintlock_shot",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("chem_black_powder", 30)
    :component("paper", 1)
    :quality("CUT", 2, 1)
    :requirement("ammo_bullet", 10)
    :requires_skill("gun", 2)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 65 mg gunpowder rounded to 1 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_22_fmj",
    result = "reloaded_22_fmj",
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
    :component("22_casing_new", 1)
    :component("gunpowder_pistol", 1)
    :component("copper", 1)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("manual_pistol", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 65 mg gunpowder rounded to 1 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_22_lr",
    result = "reloaded_22_lr",
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
    :component("22_casing_new", 1)
    :component("gunpowder_pistol", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("manual_pistol", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_22_fmj",
    result = "bp_22_fmj",
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
    :component("22_casing_new", 1)
    :component("chem_black_powder", 1)
    :component("copper", 1)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("manual_pistol", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_22_lr",
    result = "bp_22_lr",
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
    :component("22_casing_new", 1)
    :component("chem_black_powder", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("manual_pistol", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1500 mg gunpowder rounded to 15 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_223",
    result = "reloaded_223",
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
    :component("unprimed_223_casing", 1)
    :component("smrifle_primer", 1)
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 15 },
            { id = "gunpowder_rifle", count = 15 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_223",
    result = "bp_223",
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
    :component("unprimed_223_casing", 1)
    :component("smrifle_primer", 1)
    :component("chem_black_powder", 15)
    :component("copper", 1)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2974 mg gunpowder rounded to 30 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_270win_jsp",
    result = "reloaded_270win_jsp",
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
            { id = "gunpowder_magnum_pistol", count = 30 },
            { id = "gunpowder_rifle", count = 30 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 8)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_270win", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_270win_jsp",
    result = "bp_270win_jsp",
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
    :component("chem_black_powder", 30)
    :component("copper", 1)
    :requirement("bullet_forming", 8)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_270win", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2974 mg gunpowder rounded to 30 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_270win_fmj",
    result = "reloaded_270win_fmj",
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
            { id = "gunpowder_magnum_pistol", count = 30 },
            { id = "gunpowder_rifle", count = 30 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 8)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_270win", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_270win_fmj",
    result = "bp_270win_fmj",
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
    :component("chem_black_powder", 30)
    :component("copper", 1)
    :requirement("bullet_forming", 8)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_270win", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 4327 mg gunpowder rounded to 43 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_300_winmag",
    result = "reloaded_300_winmag",
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
    :component("unprimed_300_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 43 },
            { id = "gunpowder_large_rifle", count = 43 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_300_winmag",
    result = "bp_300_winmag",
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
    :component("unprimed_300_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 43)
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3200 mg gunpowder rounded to 32 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_3006",
    result = "reloaded_3006",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component_any({
            { id = "gunpowder_rifle", count = 32 },
            { id = "gunpowder_large_rifle", count = 32 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_3006", 1)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3200 mg gunpowder rounded to 32 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_3006_jsp",
    result = "reloaded_3006_jsp",
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
            { id = "gunpowder_rifle", count = 32 },
            { id = "gunpowder_large_rifle", count = 32 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_3006", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3175 mg gunpowder rounded to 32 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_3006fmj",
    result = "reloaded_3006fmj",
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
            { id = "gunpowder_rifle", count = 32 },
            { id = "gunpowder_large_rifle", count = 32 }
        })
    :component("3006_steel_core", 1)
    :component("copper", 1)
    :requirement("bullet_forming", 12)
    :requirement("ammo_3006", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3175 mg gunpowder rounded to 32 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_3006_incendiary",
    result = "reloaded_3006_incendiary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 32 },
            { id = "gunpowder_rifle", count = 32 },
            { id = "gunpowder_large_rifle", count = 32 }
        })
    :component("copper", 2)
    :component("incendiary", 8)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_3006", 1)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_3006",
    result = "bp_3006",
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
    :component("chem_black_powder", 32)
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_3006", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_3006_jsp",
    result = "bp_3006_jsp",
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
    :component("chem_black_powder", 32)
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_3006", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_3006fmj",
    result = "bp_3006fmj",
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
    :component("chem_black_powder", 32)
    :component("3006_steel_core", 1)
    :component("copper", 1)
    :requirement("bullet_forming", 12)
    :requirement("ammo_3006", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_3006_incendiary",
    result = "bp_3006_incendiary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("chem_black_powder", 32)
    :component("copper", 2)
    :component("incendiary", 8)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_3006", 1)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2700 mg gunpowder rounded to 28 100 mg 'pieces'.  168gr SB HPBT 2200, .308 win case, 0.474in s.depth,
-- 2.014 c.len, 2.704g h4895 hodgdon.
content.add(content.Recipe {
    id = "reloaded_308",
    result = "reloaded_308",
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
            { id = "gunpowder_magnum_pistol", count = 27 },
            { id = "gunpowder_rifle", count = 27 },
            { id = "gunpowder_large_rifle", count = 27 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_308", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2600 mg gunpowder rounded to 26 100 mg 'pieces'.  168gr SB HPBT 2200, 7.62x51nato case, 0.474in s.depth,
-- 2.014 c.len, 2.605g h4895 hodgdon.
content.add(content.Recipe {
    id = "reloaded_308_from_762x51",
    result = "reloaded_308",
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
            { id = "gunpowder_magnum_pistol", count = 26 },
            { id = "gunpowder_rifle", count = 26 },
            { id = "gunpowder_large_rifle", count = 26 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_762_51", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_308",
    result = "bp_308",
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
    :component("chem_black_powder", 27)
    :component("copper", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_308", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_308_from_762x51",
    result = "bp_308",
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
    :component("chem_black_powder", 26)
    :component("copper", 1)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_762_51", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2844 mg gunpowder rounded to 28 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_4570_sp",
    result = "reloaded_4570_sp",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("unprimed_4570_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 28 },
            { id = "gunpowder_magnum_pistol", count = 28 }
        })
    :component("lead", 5)
    :component("copper", 3)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 5)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3000 mg gunpowder rounded to 30 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_4570_pen",
    result = "reloaded_4570_pen",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("unprimed_4570_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 30 },
            { id = "gunpowder_rifle", count = 30 }
        })
    :component("copper", 5)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1944 mg gunpowder rounded to 19 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_4570_low",
    result = "reloaded_4570_low",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("unprimed_4570_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 19 },
            { id = "gunpowder_rifle", count = 19 }
        })
    :component("copper", 3)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "reloaded_4570_bp",
    result = "reloaded_4570_bp",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("unprimed_4570_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 19)
    :component("copper", 3)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 15800 mg gunpowder rounded to 158 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_50bmg",
    result = "reloaded_50bmg",
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
    :component("unprimed_50_casing", 1)
    :component("lgrifle_primer", 1)
    :component("gunpowder_large_rifle", 158)
    :component("copper", 6)
    :requirement("bullet_forming", 18)
    :requirement("ammo_bullet", 12)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_50match",
    result = "bp_50match",
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
    :component("unprimed_50_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 158)
    :component("copper", 6)
    :requirement("bullet_forming", 18)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 15800 mg gunpowder rounded to 158 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_50_incendiary",
    result = "reloaded_50_incendiary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("unprimed_50_casing", 1)
    :component("lgrifle_primer", 1)
    :component("gunpowder_large_rifle", 158)
    :component("copper", 6)
    :component("incendiary", 20)
    :requirement("bullet_forming", 21)
    :requirement("ammo_bullet", 12)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_50_incendiary",
    result = "bp_50_incendiary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("unprimed_50_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 158)
    :component("copper", 6)
    :component("incendiary", 20)
    :requirement("bullet_forming", 21)
    :requirement("ammo_bullet", 12)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 15800 mg gunpowder rounded to 158 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_50ss",
    result = "reloaded_50ss",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("unprimed_50_casing", 1)
    :component("lgrifle_primer", 1)
    :component("gunpowder_large_rifle", 158)
    :component("scrap", 1)
    :component("copper", 6)
    :requirement("bullet_forming", 21)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_50ss",
    result = "bp_50ss",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("unprimed_50_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 158)
    :component("scrap", 1)
    :component("copper", 6)
    :requirement("bullet_forming", 21)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1295 mg gunpowder rounded to 13 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_545",
    result = "reloaded_545",
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
    :component("unprimed_545_casing", 1)
    :component("smrifle_primer", 1)
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 13 },
            { id = "gunpowder_rifle", count = 13 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_545",
    result = "bp_545",
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
    :component("unprimed_545_casing", 1)
    :component("smrifle_primer", 1)
    :component("chem_black_powder", 13)
    :component("copper", 1)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1295 mg gunpowder rounded to 13 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_545_ap",
    result = "reloaded_545_ap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("unprimed_545_casing", 1)
    :component("smrifle_primer", 1)
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 13 },
            { id = "gunpowder_rifle", count = 13 }
        })
    :component("copper", 1)
    :component("545_steel_core", 1)
    :requirement("bullet_forming", 4)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_545_ap",
    result = "bp_545_ap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("unprimed_545_casing", 1)
    :component("smrifle_primer", 1)
    :component("chem_black_powder", 13)
    :component("copper", 1)
    :component("545_steel_core", 1)
    :requirement("bullet_forming", 4)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1133 mg gunpowder rounded to 11 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_300blk",
    result = "reloaded_300blk",
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
    :component("gunpowder_rifle", 11)
    :component("copper", 1)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_300blk", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_300blk",
    result = "bp_300blk",
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
    :component("chem_black_powder", 11)
    :component("copper", 1)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 2)
    :requirement("ammo_300blk", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 5.5-6.4 mg gunpowder rounded to 6 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_300blk_ss",
    result = "reloaded_300blk_ss",
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
    :component("gunpowder_rifle", 6)
    :component("copper", 1)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_300blk", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_300blk_ss",
    result = "bp_300blk_ss",
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
    :component("chem_black_powder", 6)
    :component("copper", 1)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_300blk", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1717 mg gunpowder rounded to 17 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_556",
    result = "reloaded_556",
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
    :component("unprimed_223_casing", 1)
    :component("smrifle_primer", 1)
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 17 },
            { id = "gunpowder_rifle", count = 17 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1717 mg gunpowder rounded to 17 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_556_incendiary",
    result = "reloaded_556_incendiary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("unprimed_223_casing", 1)
    :component("smrifle_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 17 },
            { id = "gunpowder_magnum_pistol", count = 17 }
        })
    :component("copper", 1)
    :component("incendiary", 2)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_556",
    result = "bp_556",
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
    :component("unprimed_223_casing", 1)
    :component("smrifle_primer", 1)
    :component("chem_black_powder", 17)
    :component("copper", 1)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_556_incendiary",
    result = "bp_556_incendiary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("unprimed_223_casing", 1)
    :component("smrifle_primer", 1)
    :component("chem_black_powder", 17)
    :component("copper", 1)
    :component("incendiary", 2)
    :requirement("bullet_forming", 4)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 4296 mg gunpowder rounded to 43 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_458wm",
    result = "reloaded_458wm",
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
    :component("gunpowder_large_rifle", 43)
    :component("copper", 10)
    :requirement("bullet_forming", 8)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_458wm", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_458wm",
    result = "bp_458wm",
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
    :component("chem_black_powder", 43)
    :component("copper", 10)
    :requirement("bullet_forming", 8)
    :requirement("ammo_bullet", 5)
    :requirement("ammo_458wm", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2812 mg gunpowder rounded to 28 100 mg 'pieces'. .308 146gr Norma FMJ spitz 67651, seated 0.324in, 7.62x51
-- case, 2.812g Hodgdon H4895.
content.add(content.Recipe {
    id = "reloaded_762_51",
    result = "reloaded_762_51",
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
            { id = "gunpowder_rifle", count = 28 },
            { id = "gunpowder_magnum_pistol", count = 28 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_762_51", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2915 mg gunpowder rounded to 29 100 mg 'pieces'. .308 146gr Norma FMJ spitz 67651, seated 0.324in, .308
-- win case, 2915mg Hodgdon H4895.
content.add(content.Recipe {
    id = "reloaded_762_51_from_308",
    result = "reloaded_762_51",
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
            { id = "gunpowder_rifle", count = 29 },
            { id = "gunpowder_magnum_pistol", count = 29 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_308", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2812 mg gunpowder rounded to 28 100 mg 'pieces'. .308 146gr Norma FMJ spitz 67651, seated 0.324in, 7.62x51
-- case, 2.812g Hodgdon H4895.
content.add(content.Recipe {
    id = "reloaded_762_51_incendiary",
    result = "reloaded_762_51_incendiary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 28 },
            { id = "gunpowder_rifle", count = 28 },
            { id = "gunpowder_large_rifle", count = 28 }
        })
    :component("copper", 2)
    :component("incendiary", 6)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_762_51", 1)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2915 mg gunpowder rounded to 29 100 mg 'pieces'. .308 146gr Norma FMJ spitz 67651, seated 0.324in, .308
-- win case, 2915mg Hodgdon H4895.
content.add(content.Recipe {
    id = "reloaded_762_51_incendiary_from_308",
    result = "reloaded_762_51_incendiary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 29 },
            { id = "gunpowder_rifle", count = 29 },
            { id = "gunpowder_large_rifle", count = 29 }
        })
    :component("copper", 2)
    :component("incendiary", 6)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_308", 1)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2812 mg gunpowder rounded to 28 100 mg 'pieces'. .308 146gr Norma FMJ spitz 67651, seated 0.324in, 7.62x51
-- case, 2.812g Hodgdon H4895.
content.add(content.Recipe {
    id = "bp_762_51",
    result = "bp_762_51",
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
    :component("chem_black_powder", 28)
    :component("copper", 2)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_762_51", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2915 mg gunpowder rounded to 29 100 mg 'pieces'. .308 146gr Norma FMJ spitz 67651, seated 0.324in, .308
-- win case, 2915mg Hodgdon H4895.
content.add(content.Recipe {
    id = "bp_762_51_from_308",
    result = "bp_762_51",
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
    :component("chem_black_powder", 29)
    :component("copper", 2)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_308", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2812 mg gunpowder rounded to 28 100 mg 'pieces'. .308 146gr Norma FMJ spitz 67651, seated 0.324in, 7.62x51
-- case, 2.812g Hodgdon H4895.
content.add(content.Recipe {
    id = "bp_762_51_incendiary",
    result = "bp_762_51_incendiary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("chem_black_powder", 28)
    :component("copper", 2)
    :component("incendiary", 6)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_762_51", 1)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2915 mg gunpowder rounded to 29 100 mg 'pieces'. .308 146gr Norma FMJ spitz 67651, seated 0.324in, .308
-- win case, 2915mg Hodgdon H4895.
content.add(content.Recipe {
    id = "bp_762_51_incendiary_from_308",
    result = "bp_762_51_incendiary",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("chem_black_powder", 29)
    :component("copper", 2)
    :component("incendiary", 6)
    :requirement("bullet_forming", 9)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_308", 1)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2851 mg gunpowder rounded to 29 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_762_54R",
    result = "reloaded_762_54R",
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
    :component("unprimed_762R_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 29 },
            { id = "gunpowder_rifle", count = 29 },
            { id = "gunpowder_large_rifle", count = 29 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 10)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_762_54R",
    result = "bp_762_54R",
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
    :component("unprimed_762R_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 29)
    :component("copper", 2)
    :requirement("bullet_forming", 10)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1535 mg gunpowder rounded to 15 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_762_m87",
    result = "reloaded_762_m87",
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
    :component("unprimed_762_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 15 },
            { id = "gunpowder_rifle", count = 15 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_762_m87",
    result = "bp_762_m87",
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
    :component("unprimed_762_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 15)
    :component("copper", 2)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1535 mg gunpowder rounded to 15 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_762_jhp",
    result = "reloaded_762_jhp",
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
    :component("unprimed_762_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 15 },
            { id = "gunpowder_rifle", count = 15 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_762_jhp",
    result = "bp_762_jhp",
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
    :component("unprimed_762_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 15)
    :component("copper", 2)
    :requirement("bullet_forming", 5)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bb",
    result = "bb",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 270000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "weights", count = 34, requirement = true },
            { id = "steel_chunk_any", count = 2, requirement = true }
        })
    :requirement("forging_standard", 5)
    :requires_skill("gun", 1)
    :book("textbook_fabrication", 1)
    :result_charges(500)
)

-- 3100 mg gunpowder rounded to 31 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_303",
    result = "reloaded_303",
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
            { id = "gunpowder_rifle", count = 31 },
            { id = "gunpowder_large_rifle", count = 31 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_303", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3100 mg gunpowder rounded to 31 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_303fmj",
    result = "reloaded_303fmj",
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
            { id = "gunpowder_rifle", count = 31 },
            { id = "gunpowder_large_rifle", count = 31 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_303", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3100 mg gunpowder rounded to 31 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_303sp",
    result = "reloaded_303sp",
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
            { id = "gunpowder_rifle", count = 31 },
            { id = "gunpowder_large_rifle", count = 31 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_303", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_303",
    result = "bp_303",
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
    :component("chem_black_powder", 31)
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_303", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_303fmj",
    result = "bp_303fmj",
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
    :component("chem_black_powder", 31)
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_303", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_303sp",
    result = "bp_303sp",
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
    :component("chem_black_powder", 31)
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requirement("ammo_303", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3700 mg gunpowder rounded to 37 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_77mm_arisaka_jsp",
    result = "reloaded_77mm_arisaka_jsp",
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
    :component("unprimed_77arisaka_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 37 },
            { id = "gunpowder_large_rifle", count = 37 }
        })
    :component("lead", 3)
    :component("copper", 3)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_77mm_arisaka_jsp",
    result = "bp_77mm_arisaka_jsp",
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
    :component("unprimed_77arisaka_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 37)
    :component("lead", 3)
    :component("copper", 3)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1004 mg gunpowder rounded to 10 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_30carbine",
    result = "reloaded_30carbine",
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
            { id = "gunpowder_magnum_pistol", count = 10 },
            { id = "gunpowder_rifle", count = 10 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 20)
    :requirement("ammo_bullet", 1)
    :requirement("ammo_30carbine", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_30carbine",
    result = "bp_30carbine",
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
    :component("chem_black_powder", 10)
    :component("copper", 1)
    :requirement("bullet_forming", 20)
    :requirement("ammo_bullet", 1)
    :requirement("ammo_30carbine", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_30carbine",
    result = "matchhead_30carbine",
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
    :component("red_phosphorous_small", 10)
    :component("copper", 1)
    :requirement("bullet_forming", 20)
    :requirement("ammo_bullet", 1)
    :requirement("ammo_30carbine", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1004 mg gunpowder rounded to 10 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_30carbine_jsp",
    result = "reloaded_30carbine_jsp",
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
            { id = "gunpowder_magnum_pistol", count = 10 },
            { id = "gunpowder_rifle", count = 10 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 20)
    :requirement("ammo_bullet", 1)
    :requirement("ammo_30carbine", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_30carbine_jsp",
    result = "bp_30carbine_jsp",
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
    :component("chem_black_powder", 10)
    :component("copper", 1)
    :requirement("bullet_forming", 20)
    :requirement("ammo_bullet", 1)
    :requirement("ammo_30carbine", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_30carbine_jsp",
    result = "matchhead_30carbine_jsp",
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
    :component("red_phosphorous_small", 10)
    :component("copper", 1)
    :requirement("bullet_forming", 20)
    :requirement("ammo_bullet", 1)
    :requirement("ammo_30carbine", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- This is an alien cartridge, so it'd require a bit of guesswork on the load data, hence the higher skill
-- req for crafting + book.
-- 3200 mg gunpowder rounded to 32 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_123ln",
    result = "reloaded_123ln",
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
    :component("unprimed_123ln_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 32 },
            { id = "gunpowder_large_rifle", count = 32 }
        })
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 2)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_123ln",
    result = "bp_123ln",
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
    :component("unprimed_123ln_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 32)
    :component("copper", 2)
    :requirement("bullet_forming", 12)
    :requirement("ammo_bullet", 4)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 2)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- Skill level bumped up cause its armour piercing, recipe needs some fixing but ap uncrafts/recipies are
-- kinda broken currently.
-- 3200 mg gunpowder rounded to 32 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_123ln_ap",
    result = "reloaded_123ln_ap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("unprimed_123ln_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 32 },
            { id = "gunpowder_large_rifle", count = 32 }
        })
    :component("copper", 1)
    :component("123_steel_core", 1)
    :requirement("bullet_forming", 12)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 2)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_123ln_ap",
    result = "bp_123ln_ap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("unprimed_123ln_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 32)
    :component("copper", 1)
    :component("123_steel_core", 1)
    :requirement("bullet_forming", 12)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 2)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1720 mg gunpowder rounded to 17 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_50beowulf_xtp",
    result = "reloaded_50beowulf_xtp",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("unprimed_50beowulf_casing", 1)
    :component("lgpistol_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 17 },
            { id = "gunpowder_magnum_pistol", count = 17 }
        })
    :component("lead", 5)
    :component("copper", 3)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 5)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2120 mg gunpowder rounded to 21 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_50beowulf_penetrator",
    result = "reloaded_50beowulf_penetrator",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("unprimed_50beowulf_casing", 1)
    :component("lgpistol_primer", 1)
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 21 },
            { id = "gunpowder_rifle", count = 21 }
        })
    :component("copper", 6)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 1720 mg gunpowder rounded to 17 100 mg 'pieces'
content.add(content.Recipe {
    id = "bp_50beowulf_xtp",
    result = "bp_50beowulf_xtp",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("unprimed_50beowulf_casing", 1)
    :component("lgpistol_primer", 1)
    :component("chem_black_powder", 17)
    :component("lead", 5)
    :component("copper", 3)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2120 mg gunpowder rounded to 21 100 mg 'pieces'
content.add(content.Recipe {
    id = "bp_50beowulf_penetrator",
    result = "bp_50beowulf_penetrator",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("unprimed_50beowulf_casing", 1)
    :component("lgpistol_primer", 1)
    :component("chem_black_powder", 21)
    :component("copper", 6)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3730 mg gunpowder rounded to 37 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_450_ftx",
    result = "reloaded_450_ftx",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("unprimed_450_casing", 1)
    :component("smrifle_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 37 },
            { id = "gunpowder_magnum_pistol", count = 37 }
        })
    :component("lead", 5)
    :component("copper", 3)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 5)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3430 mg gunpowder rounded to 34 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_450_penetrator",
    result = "reloaded_450_penetrator",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("unprimed_450_casing", 1)
    :component("smrifle_primer", 1)
    :component_any({
            { id = "gunpowder_magnum_pistol", count = 34 },
            { id = "gunpowder_rifle", count = 34 }
        })
    :component("copper", 6)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3730 mg gunpowder rounded to 37 100 mg 'pieces'
content.add(content.Recipe {
    id = "bp_450_ftx",
    result = "bp_450_ftx",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("unprimed_450_casing", 1)
    :component("smrifle_primer", 1)
    :component("chem_black_powder", 37)
    :component("lead", 5)
    :component("copper", 3)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 3430 mg gunpowder rounded to 34 100 mg 'pieces'
content.add(content.Recipe {
    id = "bp_450_penetrator",
    result = "bp_450_penetrator",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("unprimed_450_casing", 1)
    :component("smrifle_primer", 1)
    :component("chem_black_powder", 34)
    :component("copper", 6)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 4)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2644 mg gunpowder rounded to 26 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_338lapua_hpbt",
    result = "reloaded_338lapua_hpbt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("unprimed_338lapua_casing", 1)
    :component("lgrifle_primer", 1)
    :component("gunpowder_large_rifle", 58)
    :component("lead", 5)
    :component("copper", 3)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 5)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2938 mg gunpowder rounded to 29 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_338lapua_fmjbt",
    result = "reloaded_338lapua_fmjbt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("unprimed_338lapua_casing", 1)
    :component("lgrifle_primer", 1)
    :component("gunpowder_large_rifle", 58)
    :component("scrap", 1)
    :component("copper", 6)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2938 mg gunpowder rounded to 29 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_338lapua_api",
    result = "reloaded_338lapua_api",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("unprimed_338lapua_casing", 1)
    :component("lgrifle_primer", 1)
    :component("gunpowder_large_rifle", 58)
    :component("scrap", 1)
    :component("copper", 3)
    :component("incendiary", 6)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2644 mg gunpowder rounded to 26 100 mg 'pieces'
content.add(content.Recipe {
    id = "bp_338lapua_hpbt",
    result = "bp_338lapua_hpbt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("unprimed_338lapua_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 58)
    :component("lead", 5)
    :component("copper", 3)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2938 mg gunpowder rounded to 29 100 mg 'pieces'
content.add(content.Recipe {
    id = "bp_338lapua_fmjbt",
    result = "bp_338lapua_fmjbt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("unprimed_338lapua_casing", 1)
    :component("lgrifle_primer", 1)
    :component("scrap", 1)
    :component("copper", 6)
    :component("chem_black_powder", 58)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 8)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2938 mg gunpowder rounded to 29 100 mg 'pieces'
content.add(content.Recipe {
    id = "bp_338lapua_api",
    result = "bp_338lapua_api",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("unprimed_338lapua_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 58)
    :component("scrap", 1)
    :component("copper", 3)
    :component("incendiary", 6)
    :requirement("bullet_forming", 15)
    :requirement("ammo_bullet", 3)
    :requires_skill("gun", 5)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_22_fmj",
    result = "matchhead_22_fmj",
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
    :component("22_casing_new", 1)
    :component("red_phosphorous_small", 1)
    :component("copper", 1)
    :requirement("bullet_forming", 3)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("manual_pistol", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "matchhead_22_lr",
    result = "matchhead_22_lr",
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
    :component("22_casing_new", 1)
    :component("red_phosphorous_small", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 1)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("manual_pistol", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2 786 mg gunpowder rounded to 28 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_3030",
    result = "reloaded_3030",
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
    :component("unprimed_3030_casing", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 28 },
            { id = "gunpowder_large_rifle", count = 28 }
        })
    :component("lgrifle_primer", 1)
    :requirement("bullet_forming", 8)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2 786 mg gunpowder rounded to 28 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_3030_fmj",
    result = "reloaded_3030_fmj",
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
    :component("unprimed_3030_casing", 1)
    :component("lgrifle_primer", 1)
    :component_any({
            { id = "gunpowder_rifle", count = 28 },
            { id = "gunpowder_large_rifle", count = 28 }
        })
    :component("copper", 1)
    :requirement("bullet_forming", 8)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2 786 mg gunpowder rounded to 28 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_3030_bp",
    result = "reloaded_3030_bp",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("unprimed_3030_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 28)
    :requirement("bullet_forming", 8)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 2 786 mg gunpowder rounded to 28 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_3030_fmj_bp",
    result = "reloaded_3030_fmj_bp",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 500,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("unprimed_3030_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 28)
    :component("copper", 1)
    :requirement("bullet_forming", 8)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :book("mag_rifle", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

-- 15800 mg gunpowder rounded to 158 100 mg 'pieces'
content.add(content.Recipe {
    id = "reloaded_50bmgfmj",
    result = "reloaded_50bmgfmj",
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
    :component("unprimed_50_casing", 1)
    :component("lgrifle_primer", 1)
    :component("gunpowder_large_rifle", 158)
    :component("50_steel_core", 1)
    :component("copper", 3)
    :requirement("bullet_forming", 18)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "bp_50bmgfmj",
    result = "bp_50bmgfmj",
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
    :component("unprimed_50_casing", 1)
    :component("lgrifle_primer", 1)
    :component("chem_black_powder", 158)
    :component("50_steel_core", 1)
    :component("copper", 3)
    :requirement("bullet_forming", 18)
    :requires_skill("gun", 3)
    :book("recipe_bullets", 0)
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)
