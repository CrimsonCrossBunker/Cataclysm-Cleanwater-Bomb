local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "prac_airship_piloting",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MECHANICS",
    name = content.text("airship piloting drills"),
    description = content.text("Practice airship piloting with a flight manual, reviewing lift, ballast, wind drift, and propeller steering procedures."),
    skill = "driving",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 3 },
    autolearn = false,
}
    :book("book_airship_piloting", 0)
    :proficiency("prof_airship_pilot", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_helicopter_piloting",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MECHANICS",
    name = content.text("helicopter piloting drills"),
    description = content.text("Practice helicopter piloting with a flight manual, reviewing cyclic, collective, anti-torque, hover, and emergency procedures."),
    skill = "driving",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 3 },
    autolearn = false,
}
    :book("book_airship_piloting", 0)
    :proficiency("prof_helicopter_pilot", { time_multiplier = 1, skill_penalty = 0 })
)
