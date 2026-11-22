local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_BLIND_THE_SUN",
    points = 10,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Blind the Sun"),
    description = ccb.content.text("You mastery over the shadowed path of blood has become much more potent, allowing you to use your vampiric powers and a massive expense of blood to shroud yourself from the sun for a short time.\n\n<color_light_red>Initial Blood Cost:</color> 1000 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 700 ml"),
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_blind_the_sun_on",
    on_deactivate = "vampire_blind_the_sun_off",
}
