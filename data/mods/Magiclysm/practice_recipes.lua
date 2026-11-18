local content = require("ccb").content

local MODERATE_EXERCISE = 4
local EXTRA_EXERCISE = 10

content.add(content.Recipe {
    id = "prac_druidic_shapeshifting_bear",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("shapeshifting (forest king)"),
    description = content.text("Practice the druidic art of shapeshifting into a bear.  Once you've mastered that, "),
    skill = "spellcraft",
    duration_moves = 360000,
    activity_level = EXTRA_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 0 },
    autolearn = false,
    flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
}
    :component("crystallized_mana", 5)
    :book("druid_shapeshifting_learn_book_bear", 7)
    :proficiency("prof_druid_transformation_bear", { time_multiplier = 3, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_druidic_shapeshifting_cougar",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("shapeshifting (stalking hunter)"),
    description = content.text("Practice the druidic art of shapeshifting into a cougar."),
    skill = "spellcraft",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 0 },
    autolearn = false,
    flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
}
    :component("crystallized_mana", 3)
    :book("druid_shapeshifting_learn_book_cougar", 6)
    :proficiency("prof_druid_transformation_cougar", { time_multiplier = 3, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_druidic_shapeshifting_deer",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("shapeshifting (swift runner)"),
    description = content.text("Practice the druidic art of shapeshifting into a deer."),
    skill = "spellcraft",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 0 },
    autolearn = false,
    flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
}
    :component("crystallized_mana", 2)
    :book("druid_shapeshifting_learn_book_deer", 5)
    :proficiency("prof_druid_transformation_deer", { time_multiplier = 3, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_druidic_shapeshifting_raven",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("shapeshifting (soaring wings)"),
    description = content.text("Practice the druidic art of shapeshifting into a raven."),
    skill = "spellcraft",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 0 },
    autolearn = false,
    flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
}
    :component("crystallized_mana", 4)
    :book("druid_shapeshifting_learn_book_raven", 7)
    :proficiency("prof_druid_transformation_raven", { time_multiplier = 3, skill_penalty = 0 })
)
