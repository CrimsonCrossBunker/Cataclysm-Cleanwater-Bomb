local ccb = require("ccb")

ccb.content.define_mutation {
    id = "EYEGLEAM",
    points = 2,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Gleaming Eyes"),
    description = ccb.content.text("Your eyes gleam lightly red as the light catches in them and with a few drops of the stolen blood in your veins you are able to see in the dark.\n\n<color_light_red>Initial Blood Cost:</color> 100 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 50 ml"),
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_eyegleam_on",
    on_deactivate = "vampire_eyegleam_off",
    enchantments = {
        "INLINE_ENCH_EYEGLEAM_0",
        "INLINE_ENCH_EYEGLEAM_1",
    },
}
