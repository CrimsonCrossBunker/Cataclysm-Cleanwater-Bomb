local ccb = require("ccb")

ccb.content.define_proficiency_category {
    id = "prof_occult_research",
    name = ccb.content.text("Occult Research"),
    description = ccb.content.text("Proficiencies for discovering the hidden truths of the world."),
}

ccb.content.define_proficiency {
    id = "prof_occult_exploration",
    name = ccb.content.text("Occult Exploration"),
    category = "prof_occult_research",
    description = ccb.content.text("You have developed a systemized approach to understanding otherworldly phenomenon, and may be able to learn more if you devote yourself."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.25,
    time_to_learn = "16 h",
}

ccb.content.define_proficiency {
    id = "prof_thaumatology",
    name = ccb.content.text("Thaumatology"),
    category = "prof_occult_research",
    description = ccb.content.text("An understanding of how the hidden forces of the world interact, and possible ways to manipulate them yourself."),
    can_learn = true,
    time_multiplier = 3,
    skill_penalty = 0.2,
    time_to_learn = "32 h",
}

ccb.content.define_proficiency {
    id = "prof_bookbinding",
    category = "prof_misc_craft",
    name = ccb.content.text("Bookbinding"),
    description = ccb.content.text("Turning paper, leather, wood, and thread into a book."),
    can_learn = true,
    time_multiplier = 2.5,
    skill_penalty = 0.2,
    time_to_learn = "20 h",
}
