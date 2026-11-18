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
