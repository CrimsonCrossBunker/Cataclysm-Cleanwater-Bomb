local ccb = require("ccb")

ccb.content.define_mutation {
    id = "COAGULANTWEAVE",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Coagulant Weave"),
    description = ccb.content.text("Your body prepares to prevent the loss of any blood to combat damage.\n\n<color_light_red>Initial Blood Cost:</color> 500 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 250 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You hold tightly to your blood, preventing it from leaving your body."),
    on_activate = "vampire_coagulantweave_on",
    on_deactivate = "vampire_coagulantweave_off",
}
