local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "prac_psionics_begin",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_METAPHYSICS",
    name = content.text("meditation (beginner)"),
    description = content.text("Practice calming and emptying your mind, thinking thoughts as they come and then allowing them to flow through you and onward."),
    skill = "metaphysics",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
    flags = { "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
}
    :learn_automatically("metaphysics", 1)
    :book("manual_meditation", 0)
    :book("book_newage_inpsychic", 0)
    :book("occult_glimpses", 0)
    :book("book_newage_generic", 0)
    :book("book_newage_witchcraftbeg", 0)
)

content.add(content.Recipe {
    id = "prac_psionics_inter",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_METAPHYSICS",
    name = content.text("meditation (intermediate)"),
    description = content.text("Clear your mind even in the midst of discomfort, maintaining your calm and poise."),
    skill = "metaphysics",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 3, max_difficulty = 5, skill_limit = 6 },
    autolearn = false,
    flags = { "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
}
    :book("manual_meditation_int", 3)
    :book("occult_glimpses", 3)
    :book("book_newage_witchcraftadv", 3)
)

content.add(content.Recipe {
    id = "prac_psionics_advan",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_METAPHYSICS",
    name = content.text("psionic cultivation"),
    description = content.text("Focus on your inner metal strength, making it easy to call forth your psionic gifts."),
    skill = "metaphysics",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 6, max_difficulty = 9, skill_limit = 10 },
    autolearn = false,
    flags = { "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
}
    :book("manual_psionics_advan", 6)
)

content.add(content.Recipe {
    id = "prac_psionics_prof_basic",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_METAPHYSICS",
    name = content.text("psionic channeling"),
    description = content.text("Practice focusing your powers through a crystalline medium."),
    skill = "metaphysics",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = false,
}
    :tool_any({
            { id = "matrix_shard", count = 1 },
            { id = "matrix_crystal_drained", count = 1 }
        })
    :quality("MATRIX_CHANNEL", 1, 1)
    :book("manual_psionics_advan", 3)
    :book("schematics_matrix_channeling", 3)
    :book("schematics_matrix_aligning", 3)
    :proficiency("prof_psionic_basic", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_psionics_prof_ritual",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_METAPHYSICS",
    name = content.text("thought-form exercises"),
    description = content.text("Practice holding mental images and scenes in your mind for an extended period without your mind wandering."),
    skill = "metaphysics",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    practice = { min_difficulty = 4, max_difficulty = 4, skill_limit = 4 },
    autolearn = false,
    flags = { "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
}
    :tool_any({
            { id = "matrix_shard", count = 1 },
            { id = "matrix_crystal_drained", count = 1 }
        })
    :quality("MATRIX_CHANNEL", 1, 1)
    :book("manual_psionic_ritual", 4)
    :proficiency("prof_psionic_ritual", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_concentration_basic",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_METAPHYSICS",
    name = content.text("concentration (beginner)"),
    description = content.text("Practice emptying your mind and focusing on a specific thought, avoiding distractions."),
    skill = "metaphysics",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 2, skill_limit = 2 },
    autolearn = false,
    flags = { "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
}
    :book("manual_meditation", 2)
    :book("book_newage_inpsychic", 2)
    :book("occult_glimpses", 2)
    :proficiency("prof_concentration_basic", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_concentration_intermediate",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_METAPHYSICS",
    name = content.text("concentration (expert)"),
    description = content.text("Practice maintaining your focus on a specific thought or image even when uncomfortable or distracted."),
    skill = "metaphysics",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 5, max_difficulty = 5, skill_limit = 5 },
    autolearn = false,
    flags = { "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
}
    :book("manual_meditation_int", 5)
    :proficiency("prof_concentration_basic", { required = true })
    :proficiency("prof_concentration_intermediate", { time_multiplier = 1, skill_penalty = 0 })
)
