local content = require("ccb").content

local NO_EXERCISE = 1
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "prac_athletics_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_ATHLETICS",
    name = content.text("athletics (beginner)"),
    description = content.text("Practice some basic calisthenics like pushups, squats, dips and crunches."),
    skill = "swimming",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :learn_automatically("swimming", 0)
)

content.add(content.Recipe {
    id = "prac_athletics_int",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_ATHLETICS",
    name = content.text("athletics (intermediate)"),
    description = content.text("Practice calisthenics using specialized equipment."),
    skill = "swimming",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 4, skill_limit = 5 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :tool_any({
            { id = "pseudo_exercise_machine", count = 1 },
            { id = "pseudo_punching_bag", count = 1 },
            { id = "pseudo_ergometer_mechanical", count = 1 },
            { id = "pseudo_treadmill_mechanical", count = 1 }
        })
    :learn_automatically("swimming", 2)
    :proficiency("prof_athlete_basic", { time_multiplier = 1.5, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_parkour",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_ATHLETICS",
    name = content.text("parkour"),
    description = content.text("Practice parkour using a complex obstacle course."),
    skill = "swimming",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 3, max_difficulty = 6, skill_limit = 5 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :tool("parkour_practice", 1)
    :learn_automatically("swimming", 5)
    :proficiency("prof_parkour", { time_multiplier = 2, skill_penalty = 2 })
)

content.add(content.Recipe {
    id = "prac_athletic_form",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_ATHLETICS",
    name = content.text("athlete's form (expert)"),
    description = content.text("Improve your athletic form using workout equipment."),
    skill = "swimming",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :tool_any({
            { id = "pseudo_exercise_machine", count = 1 },
            { id = "pseudo_punching_bag", count = 1 },
            { id = "pseudo_ergometer_mechanical", count = 1 },
            { id = "pseudo_treadmill_mechanical", count = 1 }
        })
    :learn_automatically("swimming", 3)
    :book("mag_swimming", 2)
    :book("manual_swimming", 2)
    :proficiency("prof_athlete_basic", { required = true })
    :proficiency("prof_athlete_expert", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_master_athletic_form",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_ATHLETICS",
    name = content.text("athlete's form (master)"),
    description = content.text("Refine your athletic form with a high-intensity workout."),
    skill = "swimming",
    duration_moves = 360000,
    activity_level = ACTIVE_EXERCISE,
    practice = { min_difficulty = 3, max_difficulty = 4, skill_limit = 5 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :tool_any({
            { id = "pseudo_exercise_machine", count = 1 },
            { id = "pseudo_ergometer_mechanical", count = 1 }
        })
    :learn_automatically("swimming", 4)
    :book("manual_swimming", 3)
    :proficiency("prof_athlete_basic", { required = true })
    :proficiency("prof_athlete_expert", { required = true })
    :proficiency("prof_athlete_master", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_dextrous_paws",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_ATHLETICS",
    name = content.text("practice your new fingers"),
    description = content.text("You've kept your fingers and thumbs but they're a bit different now.  You'll need practice to use them properly."),
    skill = "swimming",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 0, skill_limit = 1 },
    autolearn = false,
    flags = { "BLIND_EASY" },
}
    :on_complete("finish_prac_dextrous_paws")
)
