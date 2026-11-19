local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_carpentry_basic",
    category = "prof_woodworking",
    name = ccb.content.text("Basic Carpentry"),
    description = ccb.content.text("Simple projects involving holding planks and panels of wood together with nails or similar fasteners."),
    can_learn = true,
    time_multiplier = 1.5,
    skill_penalty = 0.15,
    time_to_learn = "4 h",
}

ccb.content.define_proficiency {
    id = "prof_luthier_basic",
    category = "prof_woodworking",
    name = ccb.content.text("Hobbyist Luthier"),
    description = ccb.content.text("Simple projects involving creating musical instruments out of wood."),
    can_learn = true,
    time_multiplier = 3.5,
    skill_penalty = 0.15,
    time_to_learn = "12 h",
}
