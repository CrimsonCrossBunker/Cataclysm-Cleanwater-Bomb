local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "40x46mm_hornets_nest_22lr",
    result = "40x46mm_hornets_nest_22lr",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 6000,
    reversible = true,
    skill = "pistol",
    difficulty = 1,
}
    :component("22_lr", 10)
    :component("40x46mm_hornets_nest_22lr_casing", 1)
    :component("lgpistol_primer", 1)
    :requires_skill("launcher", 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "40x46mm_hornets_nest_410_slug",
    result = "40x46mm_hornets_nest_410_slug",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 6000,
    reversible = true,
    skill = "shotgun",
    difficulty = 1,
}
    :component_any({
            { id = "410shot_slug", count = 4 },
            { id = "reloaded_410shot_slug", count = 4 }
        })
    :component("40x46mm_hornets_nest_410_casing", 1)
    :component("lgpistol_primer", 1)
    :requires_skill("launcher", 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "40x46mm_hornets_nest_410_bird",
    result = "40x46mm_hornets_nest_410_bird",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 6000,
    reversible = true,
    skill = "shotgun",
    difficulty = 1,
}
    :component_any({
            { id = "410shot_bird", count = 4 },
            { id = "reloaded_410shot_bird", count = 4 }
        })
    :component("40x46mm_hornets_nest_410_casing", 1)
    :component("lgpistol_primer", 1)
    :requires_skill("launcher", 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "40x46mm_hornets_nest_410",
    result = "40x46mm_hornets_nest_410",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 6000,
    reversible = true,
    skill = "shotgun",
    difficulty = 1,
}
    :component_any({
            { id = "410shot_000", count = 4 },
            { id = "reloaded_410shot_000", count = 4 }
        })
    :component("40x46mm_hornets_nest_410_casing", 1)
    :component("lgpistol_primer", 1)
    :requires_skill("launcher", 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "40x46mm_hornets_nest_410_scrap",
    result = "40x46mm_hornets_nest_410_scrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 6000,
    reversible = true,
    skill = "shotgun",
    difficulty = 1,
}
    :component("410shot_scrap", 4)
    :component("40x46mm_hornets_nest_410_casing", 1)
    :component("lgpistol_primer", 1)
    :requires_skill("launcher", 1)
    :result_charges(1)
)
