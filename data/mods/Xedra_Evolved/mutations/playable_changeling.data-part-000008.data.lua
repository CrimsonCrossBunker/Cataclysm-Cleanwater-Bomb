local ccb = require("ccb")

ccb.content.define_mutation {
    id = "POOKA_WOLF_TAIL",
    name = ccb.content.text("Wolf Tail (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow the tail of a wolf, making it harder to wear pants but improving your balance."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_TAIL_LONG",
    name = ccb.content.text("Cat Tail (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow the tail of a cat, making it harder to wear pants but improving your balance."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_TAIL_STING",
    name = ccb.content.text("Spiked Tail (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow the tail of a scorpion, making it harder to wear pants but allowing you to attack with the stinger."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}
