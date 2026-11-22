local ccb = require("ccb")

ccb.content.define_mutation {
    id = "LILIN_TRANSFORM_INTO_WAR_OWL_FORM",
    name = ccb.content.text("The Strix's Wrath"),
    points = 10,
    description = ccb.content.text("You can combine your forms, transforming into a large owl-human hybrid with wings, rending talons, and a deadly beak.  You won't be able to drain ruach while you are in this form."),
    starting_trait = false,
    purifiable = false,
    active = true,
    activation_setup_only = true,
    prerequisites = { "LILIN_SPEED_DODGE_BOOST" },
    secondary_prerequisites = { "LILIN_TURN_INTO_OWL" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    activation_message = "",
    on_activate = "lilin_war_owl_on",
    on_deactivate = "lilin_war_owl_off",
}

ccb.content.define_mutation {
    id = "LILIN_WAR_OWL_FORM_LEAPER",
    name = ccb.content.text("Strix's Leap"),
    description = ccb.content.text("While you cannot fly, with your bird-like legs and your wings, you can leap quite a distance."),
    valid = false,
    points = 0,
    active = true,
    activation_setup_only = false,
    activation_message = "",
    on_activate = "lilin_strix_leap",
}
