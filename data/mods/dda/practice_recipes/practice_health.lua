local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "prac_health_care_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_HEALTH",
    name = content.text("bandaging (beginner)"),
    description = content.text("Practice bandaging imaginary wounds while making sure your bandage won't fall off during activities."),
    skill = "firstaid",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 1 },
    autolearn = true,
    flags = { "BLIND_HARD" },
}
    :tool_any({
            { id = "bandages", count = 1 },
            { id = "bandages_makeshift", count = 1 },
            { id = "bandages_makeshift_bleached", count = 1 },
            { id = "bandages_makeshift_boiled", count = 1 }
        })
    :learn_automatically("firstaid", 0)
    :proficiency("prof_wound_care", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_health_care_int",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_HEALTH",
    name = content.text("bandaging (advanced)"),
    description = content.text("Practice bandaging different limbs and less accessible parts of your body using both hands and each of your hands alone."),
    skill = "firstaid",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
    flags = { "BLIND_HARD" },
}
    :tool_any({
            { id = "bandages", count = 1 },
            { id = "bandages_makeshift", count = 1 },
            { id = "bandages_makeshift_bleached", count = 1 },
            { id = "bandages_makeshift_boiled", count = 1 }
        })
    :learn_automatically("firstaid", 1)
    :book("booklet_firstaid", 0)
    :book("mag_firstaid", 0)
    :book("pocket_firstaid", 0)
    :book("manual_first_aid", 0)
    :proficiency("prof_wound_care", { required = true })
    :proficiency("prof_wound_care_expert", { time_multiplier = 1, skill_penalty = 0 })
)
