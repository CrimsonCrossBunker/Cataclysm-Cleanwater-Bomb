local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "psionic_awakened",
    name = ccb.content.text("Awakened"),
    description = ccb.content.text("Your exposure to the portal storm has awakened latent psionic powers in you."),
    rating = "neutral",
    maximum_duration_turns = 86400,
})

content.add(content.EffectType {
    id = "psionic_overload",
    name = ccb.content.text("Headache"),
    description = ccb.content.text("Your head is pounding and you feel unwell."),
    rating = "bad",
    intensity_add_value = 1,
    maximum_intensity = 10,
    maximum_duration_turns = 86400,
}
    :name(ccb.content.text("Headache"))
    :name(ccb.content.text("Headache"))
    :name(ccb.content.text("Bad Headache"))
    :name(ccb.content.text("Bad Headache"))
    :name(ccb.content.text("Splitting Headache"))
    :name(ccb.content.text("Splitting Headache"))
    :name(ccb.content.text("Excruciating Headache"))
    :name(ccb.content.text("Excruciating Headache"))
    :name(ccb.content.text("Pure Agony"))
    :description(ccb.content.text("Your head is pounding and you feel unwell."))
    :description(ccb.content.text("Your head is pounding and you feel unwell."))
    :description(ccb.content.text("Your head throbs and it's hard to see straight."))
    :description(ccb.content.text("Your head throbs and it's hard to see straight."))
    :description(ccb.content.text("You can barely think through the pain in your head."))
    :description(ccb.content.text("You can barely think through the pain in your head."))
    :description(ccb.content.text("Your skull feels like it's going to explode."))
    :description(ccb.content.text("Your skull feels like it's going to explode."))
    :description(ccb.content.text("The agony is the only thing in the world that matters."))
    :modifier("perception", "amount", { base = -1, per_intensity = -0.8 })
    :modifier("pain", "chance_numerator", { base = 100 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 1 })
    :modifier("pain", "maximum_value", { base = 20, per_intensity = 5 })
    :modifier("pain", "tick", { base = 200 })
    :modifier("vomiting", "chance_numerator", { base = 100, per_intensity = -2 })
    :modifier("vomiting", "tick", { base = 200 })
    :modifier("hurt", "chance_numerator", { base = 300, per_intensity = -5 })
    :modifier("hurt", "amount", { per_intensity = 2, resisted_per_intensity = 1 })
    :modifier("hurt", "tick", { base = 200, per_intensity = -15 })
    :modifier("intelligence", "amount", { per_intensity = -0.6 }))

content.add(content.EffectType {
    id = "effect_psi_null",
    name = ccb.content.text("Nullified"),
    description = ccb.content.text("You can't use your powers."),
    apply_message = ccb.content.text("You feel a dull pain behind your eyes and a terrible sense of loss."),
    remove_message = ccb.content.text("You have a sudden sense of regaining something you had lost."),
    rating = "bad",
    maximum_duration_turns = 60,
    show_intensity = false,
    maximum_intensity = 10,
    intensity_decay_step = -2,
    intensity_add_value = 2,
    intensity_decay_tick = 1,
    intensity_decay_removes = true,
}
    :name(ccb.content.text("Nullified"))
    :name(ccb.content.text("Nullified"))
    :name(ccb.content.text("Nullified"))
    :name(ccb.content.text("Nullified"))
    :name(ccb.content.text("Nullified"))
    :name(ccb.content.text("Nullified"))
    :name(ccb.content.text("Nullified"))
    :name(ccb.content.text("Nullified"))
    :name(ccb.content.text("Nullified"))
    :description(ccb.content.text("You can't use your powers."))
    :description(ccb.content.text("You can't use your powers."))
    :description(ccb.content.text("You can't use your powers."))
    :description(ccb.content.text("You can't use your powers."))
    :description(ccb.content.text("You can't use your powers."))
    :description(ccb.content.text("You can't use your powers."))
    :description(ccb.content.text("You can't use your powers."))
    :description(ccb.content.text("You can't use your powers."))
    :description(ccb.content.text("You can't use your powers."))
    :flag("NO_PSIONICS"))

-- Same as above but without automatically removing itself
content.add(content.EffectType {
    id = "effect_psi_null_unbound",
    name = ccb.content.text("Nullified"),
    description = ccb.content.text("You can't use your powers."),
    apply_message = ccb.content.text("You feel a dull pain behind your eyes and a terrible sense of loss."),
    remove_message = ccb.content.text("You have a sudden sense of regaining something you had lost."),
    rating = "bad",
}
    :flag("NO_PSIONICS"))

-- This exists to trigger EoCs or as a rider on other psi effects
content.add(content.EffectType {
    id = "effect_psi_turn_off_powers",
    name = "",
    description = "",
}
    :flag("NO_PSIONICS"))

-- This exists to trigger EoCs or as a rider on other psi effects
content.add(content.EffectType {
    id = "effect_psi_dimensionally_anchored",
    name = "",
    description = "",
}
    :flag("NO_PSIONICS"))

content.add(content.EffectType {
    id = "effect_psi_too_much_pain_cant_channel",
    name = ccb.content.text("Can't Concentrate"),
    description = ccb.content.text("You can't use your powers."),
    apply_message = ccb.content.text("You're in so much pain you can't concentrate to use your powers!"),
    rating = "bad",
}
    :flag("NO_PSIONICS"))

content.add(content.EffectType {
    id = "effect_photokin_lumination_overload",
    name = ccb.content.text("Illuminated"),
    description = ccb.content.text("Your skin is glowing brightly."),
    apply_message = "",
    remove_message = ccb.content.text("The glow from your skin fades."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_photokin_lumination_overload_0"))

content.add(content.EffectType {
    id = "effect_pyrokin_fever_burning",
    name = ccb.content.text("Burning"),
    description = ccb.content.text("The air around you is overheating!"),
}
    :enchantment("enchant_pyrokin_fever"))

-- Duplicate so teleporters can get teleported during portal storms.
content.add(content.EffectType {
    id = "effect_portal_storm_teleport",
    name = ccb.content.text("Dimensionally Unstable"),
    description = ccb.content.text("You feel like you're barely part of the world."),
    apply_message = "",
    remove_message = ccb.content.text("With a jolt, you feel more solid again."),
    rating = "bad",
}
    :enchantment("enchant_riftwalker_teleport"))

content.add(content.EffectType {
    id = "effect_teleporter_overload",
    name = ccb.content.text("Warped Space"),
    description = ccb.content.text("Nothing is quite where it seems to be."),
    apply_message = ccb.content.text("Your vision doesn't agree with where things seem to actually be"),
    remove_message = ccb.content.text("Distances resolve themselves again."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_teleporter_overload_0"))

content.add(content.EffectType {
    id = "effect_psi_teleport_lock",
    name = ccb.content.text("Teleport Lock"),
    description = ccb.content.text("You're not going anywhere."),
    rating = "bad",
    maximum_duration_turns = 86400,
}
    :flag("TELEPORT_LOCK"))

content.add(content.EffectType {
    id = "severe_hay_fever",
    name = ccb.content.text("Severe Hay Fever"),
    description = ccb.content.text("Your eyes are burning and your nose is gushing mucus."),
    rating = "bad",
    show_in_info = true,
}
    :resist_effect("took_flumed")
    :removes_effect("hay_fever")
    :modifier("perception", "amount", { base = -4 })
    :modifier("intelligence", "amount", { base = -3 })
    :modifier("stamina", "minimum", { base = -75 })
    :modifier("stamina", "maximum", { base = -225 })
    :modifier("stamina", "chance_numerator", { base = 200 }))

content.add(content.EffectType {
    id = "effect_mom_dimensionally_anchored_eventually_cancel_concentration",
    name = "",
    description = "",
    rating = "bad",
    maximum_intensity = 100,
    intensity_add_value = 1,
    intensity_decay_step = 1,
    intensity_decay_tick = 1,
})

-- Separate ID to allow telepaths and telepathy-immune monsters to defend against it.
content.upsert_effect_type(content.EffectType {
    id = "psi_stunned",
    name = ccb.content.text("Stunned"),
    description = ccb.content.text("Your mind is reeling."),
    apply_message = ccb.content.text("You're stunned!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("DISABLE_FLIGHT")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_SPELLCASTING")
    :flag("NO_PSIONICS")
    :immune_character_flag("TEEPSHIELD")
    :immune_character_flag("TEEP_IMMUNE")
    :limb_score("balance", { multiplier = 0.2 })
    :limb_score("reaction", { multiplier = 0.0 }))

content.add(content.EffectType {
    id = "effect_biokin_overload",
    name = ccb.content.text("Weakened"),
    description = ccb.content.text("Your muscles and coordination are impaired."),
    apply_message = ccb.content.text("Your muscles tremble with weakness!"),
    remove_message = ccb.content.text("New strength fills you!"),
    rating = "bad",
    maximum_intensity = 10,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_biokin_overload_0")
    :modifier("strength", "amount", { base = -2, per_intensity = -1.2 })
    :modifier("dexterity", "amount", { base = -2, per_intensity = -1.2 })
    :limb_score("lift", { multiplier = 0.9, resisted_multiplier = 1.0, per_intensity = -0.05, resisted_per_intensity = -0.00125 })
    :limb_score("grip", { multiplier = 0.8, resisted_multiplier = 1.0, per_intensity = -0.1, resisted_per_intensity = -0.025 })
    :limb_score("block", { multiplier = 0.9, resisted_multiplier = 1.0, per_intensity = -0.05, resisted_per_intensity = -0.00125 }))

-- This effect and the one below exist so a clairsentient can't cure their powers going haywire using their own powers.
content.add(content.EffectType {
    id = "blind_clair_overload",
    name = ccb.content.text("Blind"),
    description = ccb.content.text("Darkness obscures your vision."),
    apply_message = ccb.content.text("You're blinded!"),
    remove_message = ccb.content.text("Your sight returns!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("BLIND")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :removes_effect("glare")
    :removes_effect("snow_glare")
    :removes_effect("darkness")
    :limb_score("vision", { multiplier = 0.0 })
    :limb_score("night_vis", { multiplier = 0.0 })
    :limb_score("reaction", { multiplier = 0.2 }))

content.add(content.EffectType {
    id = "deaf_clair_overload",
    name = ccb.content.text("Deaf"),
    description = ccb.content.text("You can't hear anything."),
    apply_message = ccb.content.text("All sound is blotted out!"),
    remove_message = ccb.content.text("You can hear again!"),
    rating = "bad",
    maximum_intensity = 3,
    intensity_duration_turns = 100,
}
    :flag("DEAF")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("reaction", { multiplier = 0.9, per_intensity = -0.2 }))

content.add(content.EffectType {
    id = "effect_electrokin_overload",
    name = ccb.content.text("Jerky"),
    description = ccb.content.text("You muscles don't seem to be reacting exactly the way you want them to."),
    apply_message = ccb.content.text("Your limbs twitch involuntarily!"),
    remove_message = ccb.content.text("The twitching stops"),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_electrokin_overload_0")
    :limb_score("reaction", { multiplier = 0.8, per_intensity = -0.2 })
    :limb_score("grip", { multiplier = 0.8 })
    :limb_score("block", { multiplier = 0.8 }))

content.add(content.EffectType {
    id = "effect_photokin_myopia_overload",
    name = ccb.content.text("Blurred Sight"),
    description = ccb.content.text("Objects in the distance aren't where they seem to be."),
    apply_message = ccb.content.text("Your vision blurs."),
    remove_message = ccb.content.text("You shake your head as your vision clears."),
    rating = "bad",
    show_in_info = true,
}
    :flag("MYOPIC_SUPERNATURAL")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("hit", "amount", { base = -2 })
    :limb_score("vision", { multiplier = 0.5 })
    :limb_score("night_vis", { multiplier = 0.5 }))

content.add(content.EffectType {
    id = "blind_photokin_overload",
    name = ccb.content.text("Blind"),
    description = ccb.content.text("Overwhelming light obscures your vision."),
    apply_message = ccb.content.text("You're blinded!"),
    remove_message = ccb.content.text("Your sight returns!"),
    rating = "bad",
    show_in_info = true,
}
    :flag("BLIND")
    :flag("EFFECT_LIMB_SCORE_MOD")
    :removes_effect("darkness")
    :limb_score("vision", { multiplier = 0.0 })
    :limb_score("night_vis", { multiplier = 0.0 })
    :limb_score("reaction", { multiplier = 0.2 }))

content.add(content.EffectType {
    id = "effect_pyrokin_overload",
    name = ccb.content.text("Feverish"),
    description = ccb.content.text("You feel much too warm."),
    apply_message = "",
    remove_message = ccb.content.text("The air feels much cooler now."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_pyrokin_overload_0")
    :enchantment("INLINE_ENCH_effect_pyrokin_overload_1")
    :modifier("perception", "amount", { base = -2 })
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 25 })
    :limb_score("breathing", { multiplier = 0.7 }))

content.add(content.EffectType {
    id = "effect_telekin_overload",
    name = ccb.content.text("Oppressive Weight"),
    description = ccb.content.text("Everything feels so much heavier."),
    apply_message = ccb.content.text("The air itself seems to press down on you!"),
    remove_message = ccb.content.text("The oppressive weight vanishes."),
    rating = "bad",
    maximum_intensity = 10,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_telekin_overload_0")
    :limb_score("balance", { multiplier = 0.7 })
    :limb_score("reaction", { multiplier = 0.7 }))

content.add(content.EffectType {
    id = "effect_vitakin_overload",
    name = ccb.content.text("Muscle Weakness"),
    description = ccb.content.text("Your muscles and coordination are impaired."),
    apply_message = ccb.content.text("You feel awful!"),
    remove_message = ccb.content.text("You don't feel as bad anymore!"),
    rating = "bad",
    maximum_intensity = 10,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :enchantment("INLINE_ENCH_effect_vitakin_overload_0")
    :enchantment("INLINE_ENCH_effect_vitakin_overload_1")
    :modifier("sleepiness", "tick", { base = 300 })
    :modifier("sleepiness", "minimum", { base = 1, per_intensity = 1 })
    :modifier("health", "minimum", { base = -1, per_intensity = -1 })
    :modifier("health", "tick", { base = 400 })
    :limb_score("breathing", { multiplier = 0.8 })
    :limb_score("manip", { multiplier = 0.8 }))

content.add(content.EffectType {
    id = "effect_asthma_disease_absorbed",
    name = ccb.content.text("Difficulty Breathing"),
    description = ccb.content.text("You're having a very hard time taking in enough air."),
    apply_message = "",
    remove_message = ccb.content.text("You can finally breathe freely."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("stamina", "amount", { base = -1000 })
    :limb_score("breathing", { multiplier = 0.8 }))
