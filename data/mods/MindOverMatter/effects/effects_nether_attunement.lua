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

content.add(content.EffectType {
    id = "effect_disease_psionic_drain",
    name = ccb.content.text("Nether-Attunement"),
    description = ccb.content.text("You feel a little odd and your control over your powers isn't as sure as it was.  There might be unexpected results of you channeling psionics now."),
    remove_message = ccb.content.text("You take a deep breath as the strange feelings fade.  You are in full control of your powers once again."),
    maximum_intensity = 12,
}
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message(ccb.content.text("The constant hum of power fades, just a little.  It's easier to think now."), "mixed")
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :decay_message(ccb.content.text("The roar of the Nether subsides.  You can finally hear your own thoughts again."), "mixed")
    :decay_message("", "mixed")
    :decay_message("", "mixed")
    :apply_message(ccb.content.text("You feel a little odd, like you've just awoken from a dream.  All that psionic channeling might have unexpected effects."), "mixed")
    :apply_message("", "mixed")
    :apply_message("", "mixed")
    :apply_message("", "mixed")
    :apply_message(ccb.content.text("Your mind thrums with power.  It's intoxicating, but growing increasingly harder to control."), "mixed")
    :apply_message("", "mixed")
    :apply_message("", "mixed")
    :apply_message("", "mixed")
    :apply_message("", "mixed")
    :apply_message("", "mixed")
    :apply_message(ccb.content.text("Your whole body pulses with a raging torrent of energy.  It's taking almost all of your concentration to hold on."), "mixed")
    :apply_message("", "mixed"))

content.add(content.EffectType {
    id = "effect_nether_attunement_clair_blurred_sight",
    name = ccb.content.text("Blurred Sight"),
    description = ccb.content.text("Your vision is blurry."),
    remove_message = ccb.content.text("Your vision finally clears."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("HYPEROPIC")
    :flag("MYOPIC_SUPERNATURAL")
    :limb_score("night_vis", { multiplier = 0.1 })
    :limb_score("vision", { multiplier = 0.2 }))

content.add(content.EffectType {
    id = "effect_psi_reduced_breathing",
    name = ccb.content.text("Short of Breath"),
    description = ccb.content.text("You're having a hard time getting enough air."),
    remove_message = ccb.content.text("You finally manage to catch your breath"),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("cough", "chance_numerator", { base = 20 })
    :modifier("cough", "tick", { base = 120 })
    :limb_score("breathing", { multiplier = 0.5 })
    :limb_score("lift", { multiplier = 0.8 }))

content.add(content.EffectType {
    id = "effect_nether_attunement_pyrokinetic_fever",
    name = ccb.content.text("Feverish"),
    description = ccb.content.text("You feel feverish and weak."),
    remove_message = ccb.content.text("Your fever finally breaks."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_nether_attunement_pyrokinetic_fever_0")
    :limb_score("grip", { multiplier = 0.8 })
    :limb_score("block", { multiplier = 0.8 })
    :limb_score("manip", { multiplier = 0.8 })
    :limb_score("lift", { multiplier = 0.8 }))
