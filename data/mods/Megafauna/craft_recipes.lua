local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "mammoth_shelter_kit",
    result = "mammoth_shelter_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 2,
}
    :component_any({
            { id = "large_bone", count = 8 },
            { id = "mammoth_tusk", count = 2 }
        })
    :component_any({
            { id = "leather", count = 64 },
            { id = "sheet_leather_patchwork", count = 8 },
            { id = "tanned_hide", count = 8 },
            { id = "tanned_pelt", count = 8 }
        })
    :component("filament", 40, true)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("fabrication", 1)
    :proficiency("prof_leatherworking_basic", { required = false, time_multiplier = 2, skill_penalty = 0.5 })
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "large_mammoth_shelter_kit",
    result = "large_mammoth_shelter_kit",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 4,
}
    :component_any({
            { id = "large_bone", count = 24 },
            { id = "mammoth_tusk", count = 6 }
        })
    :component_any({
            { id = "leather", count = 192 },
            { id = "sheet_leather_patchwork", count = 24 },
            { id = "tanned_hide", count = 24 },
            { id = "tanned_pelt", count = 24 }
        })
    :component("filament", 120, true)
    :quality("SEW", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("fabrication", 3)
    :proficiency("prof_leatherworking_basic", { required = false, time_multiplier = 2, skill_penalty = 0.5 })
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures", { required = false, time_multiplier = 1.5 })
    :proficiency("prof_closures_waterproofing")
)
