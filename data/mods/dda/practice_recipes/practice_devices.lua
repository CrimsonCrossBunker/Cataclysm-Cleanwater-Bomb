local content = require("ccb").content

local NO_EXERCISE = 1

-- Crude picks will eventually lose their shape
-- Lock picking is mostly done by touch, but complete darkness makes it slightly harder.
content.add(content.Recipe {
    id = "prac_lockpicking_crude",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_DEVICES",
    name = content.text("lockpicking (improvised)"),
    description = content.text("Practice picking simple locks."),
    skill = "traps",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :tool("lock", 1)
    :component("crude_picklock", 1)
    :learn_automatically("traps", 3)
    :book("book_lockpick", 1)
    :proficiency("prof_lockpicking", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_lockpicking",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_DEVICES",
    name = content.text("lockpicking"),
    description = content.text("Practice picking simple locks."),
    skill = "traps",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :tool("lock", 1)
    :quality("LOCKPICK", 5, 1)
    :learn_automatically("traps", 3)
    :book("book_lockpick", 1)
    :proficiency("prof_lockpicking", { time_multiplier = 1, skill_penalty = 0 })
)
