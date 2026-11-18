local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_afs_esper_tincture_side_effects",
    name = "",
    description = "",
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_afs_esper_tincture_side_effects_0"))

content.add(content.EffectType {
    id = "effect_afs_esper_tincture_geist",
    name = ccb.content.text("Enkindling Tincture"),
    description = ccb.content.text("You used the enkindling tincture and something about it seems to be working."),
    rating = "mixed",
}
    :enchantment("INLINE_ENCH_effect_afs_esper_tincture_geist_0"))

content.add(content.EffectType {
    id = "effect_afs_esper_tincture_spark",
    name = ccb.content.text("Enkindling Tincture"),
    description = ccb.content.text("You used the enkindling tincture and something about it seems to be working."),
    rating = "mixed",
}
    :enchantment("INLINE_ENCH_effect_afs_esper_tincture_spark_0"))

content.add(content.EffectType {
    id = "effect_afs_esper_tincture_sybil",
    name = ccb.content.text("Enkindling Tincture"),
    description = ccb.content.text("You used the enkindling tincture and something about it seems to be working."),
    rating = "mixed",
}
    :enchantment("INLINE_ENCH_effect_afs_esper_tincture_sybil_0"))

content.add(content.EffectType {
    id = "effect_afs_esper_tincture_whisper",
    name = ccb.content.text("Enkindling Tincture"),
    description = ccb.content.text("You used the enkindling tincture and something about it seems to be working."),
    rating = "mixed",
}
    :enchantment("INLINE_ENCH_effect_afs_esper_tincture_whisper_0"))

content.add(content.EffectType {
    id = "effect_afs_psi_intense_concentration",
    name = ccb.content.text("Intense Concentration"),
    description = ccb.content.text("It's taking a lot of concentration to maintain your powers."),
    apply_message = "",
    remove_message = "",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("dodge", "amount", { base = -1 })
    :limb_score("breathing", { multiplier = 0.95 })
    :limb_score("reaction", { multiplier = 0.97 }))

content.add(content.EffectType {
    id = "effect_afs_esper_headache",
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
    id = "effect_afs_esper_health_penalty",
    name = "",
    description = "",
    rating = "bad",
    maximum_duration_turns = 30,
}
    :modifier("health", "minimum", { base = -1 })
    :modifier("health", "chance_numerator", { base = 2 }))

content.add(content.EffectType {
    id = "effect_afs_electrokin_see_electricity",
    name = ccb.content.text("Spark Sight"),
    description = ccb.content.text("Your powers reveal electrical creatures and robots to you."),
    apply_message = "",
    remove_message = ccb.content.text("You can no longer sense the flow of current."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_afs_electrokin_see_electricity_0"))

content.add(content.EffectType {
    id = "effect_afs_electrokin_zap_enemies",
    name = ccb.content.text("Electrical Discharge"),
    description = ccb.content.text("Your body is filled with electrical currents."),
    apply_message = "",
    remove_message = ccb.content.text("The tingling on your skin fades."),
    rating = "good",
    maximum_duration_turns = 1200,
    maximum_intensity = 49,
    duration_add_percent = 10,
    intensity_duration_turns = 25,
}
    :decay_message(ccb.content.text("The protective electrical currents are nearly gone."), "bad")
    :decay_message(ccb.content.text("Your skin is losing its charge."), "bad")
    :flag("EMP_IMMUNE")
    :enchantment("enchant_afs_electrokin_zap_enemies"))

content.add(content.EffectType {
    id = "effect_afs_electrokin_hacking_interface",
    name = ccb.content.text("Hacking Interface"),
    description = ccb.content.text("You are capable of hacking into computers with only the power of your mind."),
    apply_message = "",
    remove_message = ccb.content.text("You can no longer manipulate the circuitry of nearby devices."),
    rating = "good",
    maximum_duration_turns = 604800,
})

content.add(content.EffectType {
    id = "effect_afs_electrokin_personal_battery",
    name = ccb.content.text("Electron Overflow"),
    description = ccb.content.text("You are generating a wireless aura of electrical power."),
    apply_message = "",
    remove_message = ccb.content.text("You stop the flow of electricity to your devices."),
    rating = "good",
    maximum_duration_turns = 604800,
})

content.add(content.EffectType {
    id = "effect_afs_precog_danger_sense",
    name = ccb.content.text("Premonition"),
    description = ccb.content.text("You are preternaturally aware of nearby movement and possible dangers."),
    apply_message = "",
    remove_message = ccb.content.text("Your preternatural awareness fades."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_afs_precog_danger_sense_0"))

-- Needs to be FORCEFIELD because it has to check if you get hit to be removed, and if it's EVASION, you'll never get hit.
content.add(content.EffectType {
    id = "effect_afs_precog_damage_foresee",
    name = ccb.content.text("Forewarning"),
    description = ccb.content.text("You are warned of any dangers that would strike you."),
    remove_message = ccb.content.text("This was it.  You avoided the attack, but can you avoid the next one?"),
    rating = "good",
    maximum_duration_turns = 1800,
}
    :enchantment("INLINE_ENCH_effect_afs_precog_damage_foresee_0"))

content.add(content.EffectType {
    id = "effect_afs_precog_ranged_enhance",
    name = ccb.content.text("Dead Aim"),
    description = ccb.content.text("By predicting your enemies' movements, aiming becomes much easier."),
    apply_message = "",
    remove_message = ccb.content.text("The possible futures all snap back into the present."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_afs_precog_ranged_enhance_0")
    :enchantment("INLINE_ENCH_effect_afs_precog_ranged_enhance_1"))

content.add(content.EffectType {
    id = "effect_afs_precog_craft_bonus",
    name = ccb.content.text("Intuitive Artistry"),
    description = ccb.content.text("You just know what you need to do next.  It's harder for you to pay attention to anything else due to the shifting futures, however, and you will lose awareness of the outside world entirely when making something."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :flag("MYOPIC")
    :flag("CRAFT_IN_DARKNESS")
    :enchantment("INLINE_ENCH_effect_afs_precog_craft_bonus_0"))

-- Hidden effect, blinds you while crafting.
content.add(content.EffectType {
    id = "effect_afs_precog_craft_bonus_blindness",
    name = "",
    description = "",
}
    :flag("BLIND"))

content.add(content.EffectType {
    id = "effect_afs_precog_dodge_bonus",
    name = ccb.content.text("Prescient Dodge"),
    description = ccb.content.text("You can see your enemies' attacks in advance."),
    apply_message = "",
    remove_message = ccb.content.text("The fore-images of your enemies fade away."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :flag("HARDTOHIT")
    :enchantment("INLINE_ENCH_effect_afs_precog_dodge_bonus_0"))

content.add(content.EffectType {
    id = "effect_afs_precog_melee_enhance",
    name = ccb.content.text("Martial Trance"),
    description = ccb.content.text("By predicting your enemies' movements, melee combat becomes much easier."),
    apply_message = "",
    remove_message = ccb.content.text("The possible futures all snap back into the present."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :flag("MYOPIC_SUPERNATURAL")
    :enchantment("INLINE_ENCH_effect_afs_precog_melee_enhance_0")
    :enchantment("INLINE_ENCH_effect_afs_precog_melee_enhance_1"))

content.add(content.EffectType {
    id = "effect_afs_telekinetic_momentum",
    name = ccb.content.text("Altered Momentum"),
    description = ccb.content.text("Your powers are affecting movement around you; dangerous objects are slowed and your own speed is increased."),
    apply_message = "",
    remove_message = ccb.content.text("Nearby movement returns to normal."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :flag("MUSCLE_VEH_BOOST")
    :enchantment("INLINE_ENCH_effect_afs_telekinetic_momentum_0"))

content.add(content.EffectType {
    id = "effect_afs_telepath_sense_minds",
    name = ccb.content.text("Sensing Minds"),
    description = ccb.content.text("You are looking out for other minds."),
    apply_message = "",
    remove_message = ccb.content.text("Your awareness of other minds fades away."),
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_afs_telepath_sense_minds_0"))

content.add(content.EffectType {
    id = "effect_afs_telepathic_suggestion",
    name = ccb.content.text("Mind Trick"),
    description = ccb.content.text("You are preparing to influence the minds of others to make them more amenable to your point of view."),
    apply_message = "",
    remove_message = "",
    rating = "good",
    maximum_duration_turns = 604800,
}
    :enchantment("INLINE_ENCH_effect_afs_telepathic_suggestion_0"))

content.add(content.EffectType {
    id = "effect_afs_telepathic_psi_armor",
    name = ccb.content.text("Telepathic Shield"),
    description = ccb.content.text("Your mind is warded against telepathic attack or detection."),
    apply_message = "",
    remove_message = ccb.content.text("Your thoughts are once again unguarded."),
    rating = "good",
    maximum_duration_turns = 604800,
    maximum_intensity = 17,
}
    :flag("TEEPSHIELD")
    :removes_effect("taint")
    :removes_effect("tindrift")
    :removes_effect("hallu")
    :removes_effect("hallucination_attacks")
    :removes_effect("visuals")
    :removes_effect("fearparalyze")
    :removes_effect("amigara")
    :removes_effect("psi_stunned")
    :removes_optional_effect("telepathic_ignorance"))
