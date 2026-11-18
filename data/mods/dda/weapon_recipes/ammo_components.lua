local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "incendiary",
    result = "incendiary",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_COMPONENTS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :component_any({
            { id = "magnesium", count = 100 },
            { id = "chem_aluminium_powder", count = 100 }
        })
    :component("oxy_powder", 200)
    :quality("CHEM", 1, 1)
    :requirement("surface_heat", 25)
    :book("textbook_chemistry", 4)
    :book("recipe_bullets", 3)
    :book("textbook_anarch", 0)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :result_charges(200)
)

content.add(content.Recipe {
    id = "gunpowder",
    result = "gunpowder",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_COMPONENTS",
    duration_moves = 1500,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "gunpowder_shotgun", count = 10 },
            { id = "gunpowder_pistol", count = 10 },
            { id = "gunpowder_magnum_pistol", count = 10 },
            { id = "gunpowder_rifle", count = 10 },
            { id = "gunpowder_large_rifle", count = 10 },
            { id = "gunpowder_artillery", count = 10 }
        })
    :quality("FINE_GRIND", 1, 1)
    :quality("SIEVE", 1, 1)
    :book("pocket_firearms", 3)
    :book("manual_gun", 2)
    :book("recipe_bullets", 1)
    :book("textbook_anarch", 0)
    :result_charges(10)
)

-- Basic knowledge of chemicals handling is in order.
content.add(content.Recipe {
    id = "smpistol_primer",
    result = "smpistol_primer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("punch_nail", 1)
    :tool("soapy_water", 1)
    :component("spent_smpistol_primer", 1)
    :component_any({
            { id = "chem_mercury_fulminate", count = 1 },
            { id = "chem_lead_azide", count = 1 }
        })
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 1, 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 3)
    :book("recipe_bullets", 2)
    :proficiency("prof_intro_chemistry")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "lgpistol_primer",
    result = "lgpistol_primer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("punch_nail", 1)
    :tool("soapy_water", 1)
    :component("spent_lgpistol_primer", 1)
    :component_any({
            { id = "chem_mercury_fulminate", count = 1 },
            { id = "chem_lead_azide", count = 1 }
        })
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 1, 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 3)
    :book("recipe_bullets", 2)
    :proficiency("prof_intro_chemistry")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "smrifle_primer",
    result = "smrifle_primer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("punch_nail", 1)
    :tool("soapy_water", 1)
    :component("spent_smrifle_primer", 1)
    :component_any({
            { id = "chem_mercury_fulminate", count = 1 },
            { id = "chem_lead_azide", count = 1 }
        })
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 1, 1)
    :requires_skill("gun", 3)
    :book("mag_rifle", 3)
    :book("recipe_bullets", 2)
    :proficiency("prof_intro_chemistry")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "lgrifle_primer",
    result = "lgrifle_primer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("punch_nail", 1)
    :tool("soapy_water", 1)
    :component("spent_lgrifle_primer", 1)
    :component_any({
            { id = "chem_mercury_fulminate", count = 1 },
            { id = "chem_lead_azide", count = 1 }
        })
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 1, 1)
    :requires_skill("gun", 3)
    :book("mag_rifle", 3)
    :book("recipe_bullets", 2)
    :proficiency("prof_intro_chemistry")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "shotgun_primer",
    result = "shotgun_primer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("punch_nail", 1)
    :tool("soapy_water", 1)
    :component("spent_shotgun_primer", 1)
    :component_any({
            { id = "chem_mercury_fulminate", count = 1 },
            { id = "chem_lead_azide", count = 1 }
        })
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 1, 1)
    :requires_skill("gun", 3)
    :book("manual_shotgun", 3)
    :book("recipe_bullets", 2)
    :proficiency("prof_intro_chemistry")
    :result_charges(1)
)

-- Operations required: trimming, resizing.
content.add(content.Recipe {
    id = "unprimed_38_casing",
    result = "unprimed_38_casing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12600,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :tool_charges("cordless_drill", 2)
    :component("unprimed_357mag_casing", 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 5)
    :book("recipe_bullets", 3)
    :batch_discount(80, 5)
)

-- Operations required: trimming, reaming, resizing.
content.add(content.Recipe {
    id = "unprimed_380_casing",
    result = "unprimed_380_casing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("press", 1)
    :tool_any({
            { id = "cordless_drill", charges = 2 },
            { id = "corded_powerdrill", charges = 2 }
        })
    :component_any({
            { id = "unprimed_223_casing", count = 1 },
            { id = "unprimed_300blk_casing", count = 1 }
        })
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requires_skill("gun", 4)
    :book("manual_pistol", 5)
    :book("recipe_bullets", 3)
    :batch_discount(60, 5)
)

-- Operations required: trimming, reforming shoulder, resizing.
content.add(content.Recipe {
    id = "unprimed_300blk_casing",
    result = "unprimed_300blk_casing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("press", 1)
    :tool_any({
            { id = "cordless_drill", charges = 2 },
            { id = "corded_powerdrill", charges = 2 }
        })
    :component("unprimed_223_casing", 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("gun", 4)
    :book("manual_rifle", 5)
    :book("recipe_bullets", 3)
    :batch_discount(60, 5)
)

-- Operations required: trimming, necking down, resizing.
content.add(content.Recipe {
    id = "unprimed_270win_casing",
    result = "unprimed_270win_casing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("press", 1)
    :tool_any({
            { id = "cordless_drill", charges = 2 },
            { id = "corded_powerdrill", charges = 2 }
        })
    :component("unprimed_3006_casing", 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("gun", 4)
    :book("manual_rifle", 5)
    :book("recipe_bullets", 3)
    :batch_discount(60, 5)
)

-- Operations required: trimming, necking down, resizing, removing rim.
content.add(content.Recipe {
    id = "unprimed_123ln_casing",
    result = "unprimed_123ln_casing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 6,
}
    :tool_any({
            { id = "123ln_casing", count = 1 },
            { id = "unprimed_123ln_casing", count = 1 }
        })
    :tool("press", 1)
    :tool_any({
            { id = "cordless_drill", charges = 2 },
            { id = "corded_powerdrill", charges = 2 }
        })
    :component("unprimed_303_casing", 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requires_skill("gun", 4)
    :book("manual_rifle", 6)
    :book("recipe_bullets", 5)
    :batch_discount(40, 5)
)

-- Operations required: trimming, resizing, necking down.
content.add(content.Recipe {
    id = "unprimed_357sig_casing",
    result = "unprimed_357sig_casing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool("press", 1)
    :tool_any({
            { id = "cordless_drill", charges = 2 },
            { id = "corded_powerdrill", charges = 2 }
        })
    :component_any({
            { id = "unprimed_40_casing", count = 1 },
            { id = "unprimed_10mm_casing", count = 1 }
        })
    :quality("SAW_M", 1, 1)
    :requires_skill("gun", 4)
    :book("manual_pistol", 5)
    :book("recipe_bullets", 3)
    :batch_discount(60, 5)
)

-- Operations required: trimming, resizing.
content.add(content.Recipe {
    id = "unprimed_40_casing",
    result = "unprimed_40_casing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12600,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :tool_any({
            { id = "cordless_drill", charges = 2 },
            { id = "corded_powerdrill", charges = 2 }
        })
    :component("unprimed_10mm_casing", 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 5)
    :book("recipe_bullets", 3)
    :batch_discount(80, 5)
)

-- Operations required: trimming, resizing.
content.add(content.Recipe {
    id = "unprimed_45colt_casing",
    result = "unprimed_45colt_casing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12600,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool("press", 1)
    :tool_any({
            { id = "cordless_drill", charges = 2 },
            { id = "corded_powerdrill", charges = 2 }
        })
    :component("unprimed_454_casing", 1)
    :quality("SAW_M", 1, 1)
    :requires_skill("gun", 3)
    :book("manual_pistol", 5)
    :book("recipe_bullets", 3)
    :batch_discount(80, 5)
)

-- Operations required: trimming, reaming, resizing.
content.add(content.Recipe {
    id = "unprimed_45_casing",
    result = "unprimed_45_casing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("press", 1)
    :tool_any({
            { id = "cordless_drill", charges = 2 },
            { id = "corded_powerdrill", charges = 2 }
        })
    :component_any({
            { id = "unprimed_762_51_casing", count = 1 },
            { id = "unprimed_308_casing", count = 1 },
            { id = "unprimed_3006_casing", count = 1 }
        })
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requires_skill("gun", 4)
    :book("manual_pistol", 5)
    :book("recipe_bullets", 3)
    :batch_discount(60, 5)
)

-- Operations required: trimming, reaming, resizing.
content.add(content.Recipe {
    id = "unprimed_50ae_casing",
    result = "unprimed_50ae_casing",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool("press", 1)
    :tool_any({
            { id = "cordless_drill", charges = 2 },
            { id = "corded_powerdrill", charges = 2 }
        })
    :component("unprimed_50beowulf_casing", 1)
    :quality("SAW_M", 1, 1)
    :quality("DRILL", 2, 1)
    :requires_skill("gun", 4)
    :book("manual_pistol", 5)
    :book("recipe_bullets", 3)
    :batch_discount(60, 5)
)
