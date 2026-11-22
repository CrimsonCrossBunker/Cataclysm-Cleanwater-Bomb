local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_RENDING_TEETH",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Rending Jaws"),
    description = ccb.content.text("You can turn the rest of your teeth into jagged fangs, allowing to you bite and inflict serious injuries in combat.\n\n<color_light_red>Initial Blood Cost:</color> 200 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 100 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Your jaw extends and your teeth grow long and jagged."),
    on_activate = "vampire_rending_teeth_on",
    on_deactivate = "vampire_rending_teeth_off",
}
