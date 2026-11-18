local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- You drain the battery charge but the kit can be reused.
content.add(content.Recipe {
    id = "prac_mechanics_basic_hydraulics",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MECHANICS",
    name = content.text("basic mechanics - hydraulics"),
    description = content.text("Practice basic mechanics by using a pre-Cataclysm edutainment set.  Learn about hydraulics."),
    skill = "mechanics",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 1, skill_limit = 2 },
    autolearn = false,
}
    :tool_charges("engineering_makerspace_kit", 50)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :book("manual_makerspace", 0)
    :proficiency("prof_plumbing", { time_multiplier = 1, skill_penalty = 0 })
)

-- You drain the battery charge but the kit can be reused.
content.add(content.Recipe {
    id = "prac_mechanics_basic_robotics",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MECHANICS",
    name = content.text("basic mechanics - robotics"),
    description = content.text("Practice basic mechanics by using a pre-Cataclysm edutainment set.  Learn about robots."),
    skill = "mechanics",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 1 },
    autolearn = false,
}
    :tool_charges("engineering_robotics_kit", 50)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :book("manual_robotics_kit", 0)
    :proficiency("prof_elec_circuits", { time_multiplier = 1, skill_penalty = 0 })
)

-- You drain the battery charge but the kit can be reused.
content.add(content.Recipe {
    id = "prac_mechanics_basic_engine",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MECHANICS",
    name = content.text("basic mechanics - engines"),
    description = content.text("Practice basic mechanics by using a pre-Cataclysm edutainment set.  Learn about engines."),
    skill = "mechanics",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 2, skill_limit = 3 },
    autolearn = false,
}
    :tool_charges("engineering_engine_kit", 50)
    :quality("SCREW", 1, 1)
    :quality("WRENCH", 1, 1)
    :book("manual_engine_kit", 0)
    :proficiency("prof_basic_engines", { time_multiplier = 1, skill_penalty = 0 })
)
