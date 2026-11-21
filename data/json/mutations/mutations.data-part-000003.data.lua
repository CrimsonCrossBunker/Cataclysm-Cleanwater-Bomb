local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SLIME_SPRAY",
    name = ccb.content.text("Slime Spray"),
    description = ccb.content.text("You exude slime from your pores.  You can spread that slime on an opponent in melee range."),
    categories = { "GASTROPOD" },
    prerequisites = { "VISCOUS", "AMORPHOUS" },
    points = 1,
    active = true,
    cost = 700,
    vitamin_cost = 60,
    consumes_calories = true,
    visibility = 1,
    ugliness = 2,
    activation_setup_only = false,
    on_activate = "activate_slime_spray",
}
