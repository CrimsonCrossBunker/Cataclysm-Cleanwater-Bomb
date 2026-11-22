local ccb = require("ccb")

ccb.content.define_mutation {
    id = "LILIN_TURN_INTO_OWL",
    name = ccb.content.text("On Silent Wings"),
    points = 8,
    description = ccb.content.text("You can transform yourself into an owl and take wing on the night air.  You won't be able to drain ruach while you are in this form."),
    starting_trait = false,
    purifiable = false,
    active = true,
    activation_setup_only = true,
    prerequisites = { "LILIN_HOLD_MORE_RUACH_2", "LILIN_HOLD_MORE_RUACH_3" },
    secondary_prerequisites = { "LILIN_AVOID_SLEEP" },
    categories = { "LILIN" },
    activation_message = "",
    on_activate = "lilin_turn_into_owl_on",
    on_deactivate = "lilin_turn_into_owl_off",
}
