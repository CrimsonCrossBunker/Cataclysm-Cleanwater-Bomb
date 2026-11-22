local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRIC_DODGE",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Flow Like Blood"),
    description = ccb.content.text("You can move faster than the eye can see, avoiding the claws and teeth and weapons of your enemies.\n\n<color_light_red>Initial Blood Cost:</color> 250 (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 125 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You begin dodging with preternatural agility."),
    on_activate = "vampire_dodge_on",
    on_deactivate = "vampire_dodge_off",
    enchantments = { "INLINE_ENCH_VAMPIRIC_DODGE_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRIC_STEALTH_BONUS",
    points = 4,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Cloak of Shadows"),
    description = ccb.content.text("When indoors or at night, you can cloud the minds of nearby enemies, making it harder for them to spot you.  This does not make you invisible.\n\n<color_light_red>Initial Blood Cost:</color> 100 (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 50 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You fade slightly into the shadows."),
    on_activate = "vampire_stealth_on",
    on_deactivate = "vampire_stealth_off",
}
