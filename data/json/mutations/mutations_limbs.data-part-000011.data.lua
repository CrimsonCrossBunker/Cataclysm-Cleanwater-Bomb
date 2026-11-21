local ccb = require("ccb")

ccb.content.define_mutation {
    id = "LEAPING_LEGS",
    name = ccb.content.text("Leaping Legs"),
    description = ccb.content.text("You've gained a strong ability to leap from a standing position."),
    categories = { "BATRACHIAN", "RABBIT" },
    prerequisites = { "STRONG_LEGS" },
    replacements = { "LEAPING_LEGS2" },
    threshold_requirements = { "THRESH_BATRACHIAN", "THRESH_RABBIT" },
    points = 2,
    active = true,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 1,
    activation_setup_only = false,
    consumes_stamina = true,
    cost = 2000,
    on_activate = "activate_short_leap",
}

ccb.content.define_mutation {
    id = "LEAPING_LEGS2",
    name = ccb.content.text("Crushing Leap"),
    description = ccb.content.text("You've gained a strong ability to leap a significant distance from a standing position and crush whatever you land on."),
    categories = { "BATRACHIAN" },
    prerequisites = { "LEAPING_LEGS" },
    threshold_requirements = { "THRESH_BATRACHIAN" },
    strict_threshold_requirements = true,
    points = 4,
    active = true,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 1,
    activation_setup_only = false,
    consumes_stamina = true,
    cost = 6000,
    on_activate = "activate_crushing_leap",
}
