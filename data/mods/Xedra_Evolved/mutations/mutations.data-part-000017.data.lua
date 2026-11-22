local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BLOODHASTE",
    points = 5,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Blood-Driven Speed"),
    description = ccb.content.text("Your body exceeds normal human reaction limits as blood turns to ash in your veins.\n\n<color_light_red>Initial Blood Cost:</color> 750 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 375 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Warmth floods your limbs as you move with inhuman speed."),
    on_activate = "vampire_bloodhaste_on",
    on_deactivate = "vampire_bloodhaste_off",
}
