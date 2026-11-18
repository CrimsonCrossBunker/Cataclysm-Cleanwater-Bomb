local content = require("ccb").content

local MODERATE_EXERCISE = 4

-- You destroy the rocks with your practice, leaving you with some pebbles.
content.add(content.Recipe {
    id = "prac_knapping",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_SURVIVAL",
    name = content.text("basic knapping"),
    description = content.text("Practice basic knapping by hammering some rocks into rough shapes."),
    skill = "survival",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :component_any({
            { id = "rock", count = 2 },
            { id = "sharp_rock", count = 2 }
        })
    :quality("HAMMER", 1, 1)
    :quality("HAMMER_SOFT", 1, 1)
    :requires_skill("fabrication", 1)
    :learn_automatically("survival", 2)
    :book("manual_survival", 0)
    :book("pocket_survival", 1)
    :proficiency("prof_knapping", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("pebble", 1)
)

content.add(content.Recipe {
    id = "prac_knapping_speed",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_SURVIVAL",
    name = content.text("speed knapping"),
    description = content.text("Practice more advanced knapping by shaping some rocks into precise forms and shapes."),
    skill = "survival",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :component_any({
            { id = "rock", count = 3 },
            { id = "sharp_rock", count = 3 }
        })
    :quality("HAMMER", 2, 1)
    :quality("HAMMER_SOFT", 1, 1)
    :quality("CUT", 1, 1)
    :quality("PUNCH", 1, 1)
    :requires_skill("fabrication", 2)
    :learn_automatically("survival", 3)
    :book("manual_survival", 0)
    :book("pocket_survival", 1)
    :book("fun_survival", 2)
    :proficiency("prof_knapping", { required = true })
    :proficiency("prof_knapping_speed", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("pebble", 1)
)
