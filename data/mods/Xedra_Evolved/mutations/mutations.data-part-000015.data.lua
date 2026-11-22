local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_BEAST_CLAWS",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Claws of the Beast"),
    description = ccb.content.text("You can twist your fingernails into sharp claws, allowing you to inflict extra damage in unarmed combat.\n\n<color_light_red>Initial Blood Cost:</color> 125 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 62 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Your fingers twist into sharp claws."),
    on_activate = "vampire_beast_claws_on",
    on_deactivate = "vampire_beast_claws_off",
}
