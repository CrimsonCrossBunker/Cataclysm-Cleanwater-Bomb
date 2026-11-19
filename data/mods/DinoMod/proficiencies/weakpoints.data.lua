local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_wp_dino",
    category = "prof_weakpoint",
    name = ccb.content.text("Dinosaur Biology"),
    description = ccb.content.text("You are familiar with general dinosaur anatomy, and can exploit potential weaknesses."),
    requires = { "prof_gross_anatomy" },
    can_learn = true,
    time_to_learn = "30 m",
    weakpoint_bonus = 1,
    weakpoint_penalty = 0,
}
