local ccb = require("ccb")

ccb.content.define_mutation {
    id = "POOKA_LEAPING_LEGS",
    name = ccb.content.text("Leaping Legs (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow strong frog- or cat-like legs, allowing you to leap great distances."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_SKUNK_TAIL",
    name = ccb.content.text("Skunk Tail (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow the tail of a skunk, making it harder to wear pants but giving you the ability to stun creatures that have acute sense of smell."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}
