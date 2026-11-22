local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRIC_STRENGTH",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Vigor Mortis"),
    description = ccb.content.text("Your stolen blood reinforces your muscles, making your grip crack bone and your punches dent steel.\n\n<color_light_red>Initial Blood Cost:</color> 150 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 75 ml"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You feel a surge of power as blood floods your muscles."),
    on_activate = "vampire_strength_on",
    on_deactivate = "vampire_strength_off",
    enchantments = { "INLINE_ENCH_VAMPIRIC_STRENGTH_0" },
}

ccb.content.define_mutation {
    id = "VAMPIRIC_RESILIENCE",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Sanguine Resilience"),
    description = ccb.content.text("Your cold flesh is not as vulnerable as it once was.  Activate to render it even more resistant to physical damage.\n\n<color_light_red>Initial Blood Cost:</color> 150 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 75 ml"),
    active = true,
    activation_setup_only = true,
    on_activate = "vampire_resilience_on",
    on_deactivate = "vampire_resilience_off",
    enchantments = {
        "INLINE_ENCH_VAMPIRIC_RESILIENCE_0",
        "INLINE_ENCH_VAMPIRIC_RESILIENCE_1",
    },
    active_flags = { "SUNBURN_SUPERNATURAL_REDUCTION" },
}
