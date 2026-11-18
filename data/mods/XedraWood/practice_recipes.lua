local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "practice_deduction",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_OCCULT",
    name = content.text("natural observations"),
    description = content.text("Observe the flight of birds, the movement of the stars, the wind among the trees, and the tremors of the earth.  There's something more out there, if you look for it."),
    skill = "deduction",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 1 },
    autolearn = true,
}
    :learn_automatically("occult", 0)
)
