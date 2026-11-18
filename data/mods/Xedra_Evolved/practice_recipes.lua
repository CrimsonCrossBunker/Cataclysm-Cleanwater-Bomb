local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "prac_gramarye_changeling",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_OCCULT",
    name = content.text("gramarye (beginner)"),
    description = content.text("Practice using your newfound glamours to accustom yourself to the use of your powers."),
    skill = "gramarye",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = false,
    flags = { "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
    character_resources = { mana = 1000 },
})
