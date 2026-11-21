local ccb = require("ccb")

ccb.content.define_mutation {
    id = "FELINE_LEAP",
    name = ccb.content.text("Pounce"),
    description = ccb.content.text("You've gained a strong ability to leap a short distance from a standing position with little preparation time."),
    categories = { "FELINE" },
    prerequisites = { "TAIL_LONG" },
    secondary_prerequisites = { "STRONG_LEGS" },
    threshold_requirements = { "THRESH_FELINE" },
    cancels = { "LEAPING_LEGS", "LEAPING_LEGS2" },
    points = 3,
    active = true,
    vitamin_cost = 160,
    activation_setup_only = false,
    consumes_stamina = true,
    cost = 2000,
    on_activate = "activate_feline_leap",
}
