local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_wp_megafauna",
    category = "prof_weakpoint",
    name = ccb.content.text("Megafaunal Biology"),
    description = ccb.content.text("You are familiar with the general anatomy of megafauna, and can exploit potential weaknesses."),
    requires = { "prof_intro_biology" },
    can_learn = true,
    time_to_learn = "6 h",
    weakpoint_bonus = 4,
    weakpoint_penalty = -2,
}
