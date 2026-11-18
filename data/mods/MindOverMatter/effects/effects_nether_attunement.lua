local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "psi_nether_attention",
    name = ccb.content.text("Observed"),
    description = ccb.content.text("You have the strong impression that someone, or something, is watching you."),
    remove_message = ccb.content.text("The endless feeling of being watched finally fades away."),
    rating = "bad",
    show_intensity = false,
    maximum_intensity = 10,
    maximum_duration_turns = 1814400,
    intensity_duration_turns = 259200,
})

content.add(content.EffectType {
    id = "effect_nether_attunement_raiser",
    name = ccb.content.text("Nether Conduit"),
    description = ccb.content.text("Your skin prickles."),
    remove_message = ccb.content.text("The tingling sensation finally vanishes."),
}
    :vitamin("vitamin_psionic_drain", {
        rates = { { minimum = 1, maximum = 2 } },
        tick_turns = { 300 },
    }))

content.add(content.EffectType {
    id = "effect_nether_attunement_attenuation",
    name = ccb.content.text("Nether Attenuation"),
    description = ccb.content.text("You have to work extra hard to draw enough energy to use your powers."),
    remove_message = ccb.content.text("Your difficulty in drawing on the Nether fades."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_nether_attunement_attenuation_0"))

content.add(content.EffectType {
    id = "effect_nether_attunement_extra_kcal",
    name = ccb.content.text("Gnawing Hunger"),
    description = ccb.content.text("Whenever you use your powers, your stomach rumbles."),
    remove_message = ccb.content.text("Your stomach finally calms down."),
    rating = "bad",
})

content.add(content.EffectType {
    id = "effect_nether_attunement_feedback",
    name = ccb.content.text("Feedback"),
    description = ccb.content.text("You feel a persistent itching that will not go away."),
    rating = "bad",
})

content.add(content.EffectType {
    id = "effect_nether_attunement_electrokinetic_power_drain",
    name = ccb.content.text("Power Void"),
    description = ccb.content.text("Is it cold in here?"),
    remove_message = ccb.content.text("The unearthly chill fades away."),
    rating = "bad",
})

content.add(content.EffectType {
    id = "effect_nether_attunement_biokinetic_inversion",
    name = ccb.content.text("Metabolic Inversion"),
    description = ccb.content.text("You're getting pretty hungry and thirsty."),
    remove_message = ccb.content.text("Your gnawing hunger finally fades away."),
    rating = "bad",
})

content.add(content.EffectType {
    id = "effect_teleport_mishap_tindrift_warning",
    name = ccb.content.text("Hunted"),
    description = ccb.content.text("You feel the sensation of watching eyes and see prowling forms out of the corners of your vision.  Using further teleportation powers would be very unwise."),
    remove_message = ccb.content.text("The prowling forms finally fade away."),
    rating = "bad",
})

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_in_the_nether_warning_timer",
    name = "",
    description = "",
})

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_nether_attunement_pyrokinetic_fog",
    name = "",
    description = "",
    apply_message = ccb.content.text("A roiling fog coalesces out of the surrounding air."),
    remove_message = ccb.content.text("The roiling fog surrounding you dissipates."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_nether_attunement_pyrokinetic_fog_0"))

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_observed_rate_limiter",
    name = "",
    description = "",
})

-- Hidden effect, part of an enchantment
content.add(content.EffectType {
    id = "effect_mom_incense_nether_attunement_minor",
    name = "",
    description = "",
}
    :vitamin("vitamin_psionic_drain", {
        rates = { { minimum = 1, maximum = 5 } },
        tick_turns = { 30 },
    }))

-- Hidden effect, part of an enchantment
content.add(content.EffectType {
    id = "effect_mom_incense_nether_attunement_major",
    name = "",
    description = "",
}
    :vitamin("vitamin_psionic_drain", {
        rates = { { minimum = 3, maximum = 6 } },
        tick_turns = { 5 },
    }))
