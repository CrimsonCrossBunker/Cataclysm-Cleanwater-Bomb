local ccb = require("ccb")
local content = ccb.content

-- Deliberately not visible in character tab. 1 Intensity = 1 resonance, clears at 600 per hour
content.add(content.EffectType {
    id = "effect_xe_nether_resonance_consequences",
    name = "",
    description = "",
    maximum_intensity = 20000,
    intensity_duration_turns = 6,
}
    :enchantment("INLINE_ENCH_effect_xe_nether_resonance_consequences_0"))

content.add(content.EffectType {
    id = "effect_xe_nether_sorcery_cold_damage_over_time",
    name = ccb.content.text("Ebon Bindings"),
    description = ccb.content.text("You cannot move!"),
    remove_message = ccb.content.text("You can move again."),
    show_in_info = true,
    rating = "bad",
}
    :flag("CANNOT_MOVE"))

content.add(content.EffectType {
    id = "effect_xe_nether_sorcery_cause_withering_damage",
    name = ccb.content.text("The Withering"),
    description = ccb.content.text("You are slowed."),
    remove_message = ccb.content.text("Your strength returns."),
    rating = "bad",
    show_in_info = true,
}
    :modifier("hit", "amount", { base = -2 })
    :modifier("dodge", "amount", { base = -2 })
    :modifier("speed", "amount", { base = -30 }))

content.add(content.EffectType {
    id = "effect_xe_nether_sorcery_wind_dodge_shell",
    name = ccb.content.text("Shell of the Four Winds"),
    description = ccb.content.text("The wind helps you avoid attacks."),
    remove_message = ccb.content.text("The wind around you dies down."),
    rating = "good",
}
    :flag("HARDTOHIT")
    :enchantment("INLINE_ENCH_effect_xe_nether_sorcery_wind_dodge_shell_0"))
