local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_monster_physical_enhancement",
    name = ccb.content.text("Physical Enhancement"),
    description = ccb.content.text("You are enhancing your strength and agility."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_monster_physical_enhancement_0")
    :modifier("dodge", "amount", { base = 1 }))

content.add(content.EffectType {
    id = "effect_monster_physical_enhancement_improved",
    name = ccb.content.text("Physical Enhancement"),
    description = ccb.content.text("You are greatly enhancing your strength and agility."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_monster_physical_enhancement_improved_0")
    :modifier("dodge", "amount", { base = 2 }))

content.add(content.EffectType {
    id = "effect_monster_hardened_skin",
    name = ccb.content.text("Hardened Skin"),
    description = ccb.content.text("You are more resilient than normal."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_monster_hardened_skin_0"))

-- VISION_RANGE enchant is a proxy for perception, which monsters do not have
content.add(content.EffectType {
    id = "effect_monster_heightened_reflex",
    name = ccb.content.text("Heightened Reflexes"),
    description = ccb.content.text("You are enhancing your speed and senses."),
    show_in_info = true,
}
    :removes_effect("blind")
    :removes_effect("deaf")
    :enchantment("INLINE_ENCH_effect_monster_heightened_reflex_0"))

-- Hidden effect, used to prep for feral biokinetics using Hurricane Blows
content.add(content.EffectType {
    id = "effect_psi_biokin3_hurricane_blows",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_psi_biokin3_hurricane_blows_0"))

content.add(content.EffectType {
    id = "effect_feral_heightened_senses",
    name = ccb.content.text("Heightened Senses"),
    description = ccb.content.text("Your base senses are heightened."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_feral_heightened_senses_0"))

content.add(content.EffectType {
    id = "effect_feral_heightened_senses_2",
    name = ccb.content.text("Heightened Senses"),
    description = ccb.content.text("Your base senses are heightened."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_feral_heightened_senses_2_0"))

content.add(content.EffectType {
    id = "effect_feral_combat_sense_2",
    name = ccb.content.text("Combat Sense"),
    description = ccb.content.text("You are predicting your enemies' movements in advance."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_feral_combat_sense_2_0")
    :modifier("dodge", "amount", { base = 2 }))

content.add(content.EffectType {
    id = "effect_feral_combat_sense_3",
    name = ccb.content.text("Combat Sense"),
    description = ccb.content.text("You are predicting your enemies' movements in advance."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_feral_combat_sense_3_0")
    :modifier("dodge", "amount", { base = 5 }))

content.add(content.EffectType {
    id = "effect_feral_heightened_senses_3",
    name = ccb.content.text("Heightened Senses"),
    description = ccb.content.text("Your base senses are heightened."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_feral_heightened_senses_3_0"))

content.add(content.EffectType {
    id = "effect_monster_neuro_acceleration",
    name = ccb.content.text("Neuro-Acceleration"),
    description = ccb.content.text("You are enhancing your speed."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_monster_neuro_acceleration_0"))

content.add(content.EffectType {
    id = "effect_monster_neuro_acceleration_enhanced",
    name = ccb.content.text("Neuro-Acceleration"),
    description = ccb.content.text("You are enhancing your speed."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_monster_neuro_acceleration_enhanced_0"))

content.add(content.EffectType {
    id = "effect_photokinetic_illumination",
    name = ccb.content.text("Illuminated"),
    description = ccb.content.text("You are glowing.  The light is a color you have no name for, a kind of actinic purple-red."),
    apply_message = ccb.content.text("A harsh glow springs up around you!"),
    remove_message = ccb.content.text("The harsh glow around you fades away."),
    rating = "bad",
    maximum_duration_turns = 300,
}
    :enchantment("INLINE_ENCH_effect_photokinetic_illumination_0")
    :modifier("dodge", "amount", { base = -2 }))

content.add(content.EffectType {
    id = "effect_monster_pyrokinetic_fire_immunity",
    name = ccb.content.text("Flame Immunity"),
    description = ccb.content.text("You are immune to fire."),
}
    :enchantment("INLINE_ENCH_effect_monster_pyrokinetic_fire_immunity_0"))

content.add(content.EffectType {
    id = "effect_monster_momentum_alteration",
    name = ccb.content.text("Momentum Alteration"),
    description = ccb.content.text("You are altering the motion of nearby objects in your favor."),
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_monster_momentum_alteration_0"))

content.add(content.EffectType {
    id = "effect_monster_inertial_barrier",
    name = ccb.content.text("Inertial Barrier"),
    description = ccb.content.text("A barrier of telekinetic force is protecting you."),
    show_in_info = true,
}
    :flag("TELEKIN_SHIELD")
    :enchantment("INLINE_ENCH_effect_monster_inertial_barrier_0"))

content.add(content.EffectType {
    id = "effect_monster_inertial_barrier_improved",
    name = ccb.content.text("Inertial Barrier"),
    description = ccb.content.text("A barrier of telekinetic force is protecting you."),
    show_in_info = true,
}
    :flag("TELEKIN_SHIELD")
    :removes_effect("effect_monster_inertial_barrier")
    :enchantment("INLINE_ENCH_effect_monster_inertial_barrier_improved_0"))

content.add(content.EffectType {
    id = "effect_monster_telekinetic_aegis",
    name = ccb.content.text("Aegis"),
    description = ccb.content.text("An impenetrable barrier is protecting you."),
    show_in_info = true,
}
    :flag("TELEKIN_SHIELD")
    :flag("CANNOT_MOVE")
    :flag("CANNOT_ATTACK")
    :flag("NO_PSIONICS")
    :enchantment("INLINE_ENCH_effect_monster_telekinetic_aegis_0"))

-- Hidden effect, acts as a cooldown for Aegis
content.add(content.EffectType {
    id = "effect_monster_aegis_limiter",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "eff_monster_immune_to_telepathy",
    name = ccb.content.text("Telepathic Shield"),
    description = ccb.content.text("You have a shield up to prevent telepathic detection and attack."),
    show_in_info = true,
    maximum_intensity = 20,
})

content.add(content.EffectType {
    id = "effect_teleport_reactive_displacement_monster",
    name = ccb.content.text("Reactive Displacement"),
    description = ccb.content.text("You will automatically teleport enemies that strike you away from yourself."),
    show_in_info = true,
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_teleport_reactive_displacement_monster_0"))

content.add(content.EffectType {
    id = "effect_monster_warped_strikes",
    name = ccb.content.text("Warped Strikes"),
    description = ccb.content.text("Your melee attacks travel further than the range of your weapons makes it seem like they should."),
    show_in_info = true,
    rating = "good",
})

-- Hidden affect, reduces effects of extended stride
content.add(content.EffectType {
    id = "effect_mom_tindalos_hounds_corrupted_stride",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_mom_tindalos_hounds_corrupted_stride_warning",
    name = ccb.content.text("Corrupted Stride"),
    description = ccb.content.text("Your Extended Stride isn't working nearly as well as it should."),
    rating = "bad",
})

content.add(content.EffectType {
    id = "effect_hound_extended_speed_bonus",
    name = ccb.content.text("Moving Oddly"),
    description = ccb.content.text("The Hound flickers as it moves."),
    show_in_info = true,
}
    :modifier("speed", "amount", { base = 35 }))

content.add(content.EffectType {
    id = "effect_riftwalker_teleport",
    name = ccb.content.text("Dimensionally Unstable"),
    description = ccb.content.text("You feel like you're barely part of the world."),
    apply_message = "",
    remove_message = ccb.content.text("With a jolt, you feel more solid again."),
    rating = "bad",
}
    :immune_character_flag("TELESTOP")
    :immune_character_flag("DIMENSIONAL_ANCHOR")
    :enchantment("enchant_riftwalker_teleport"))

content.add(content.EffectType {
    id = "effect_teleporting_lock",
    name = ccb.content.text("Caught in the Angles"),
    description = ccb.content.text("You feel a strange, inward force."),
    apply_message = ccb.content.text("You feel a strange, inward force."),
    remove_message = ccb.content.text("The strange, inward force suddenly vanishes."),
    rating = "bad",
}
    :flag("TELEPORT_LOCK"))

content.add(content.EffectType {
    id = "effect_vitakinetic_health_down",
    name = ccb.content.text("Feeling Unwell"),
    description = ccb.content.text("You feel weak and shaky."),
    apply_message = "",
    remove_message = ccb.content.text("The feeling of weakness fades away."),
    rating = "bad",
    maximum_duration_turns = 43200,
}
    :modifier("strength", "amount", { base = -1 })
    :modifier("health_modifier", "minimum", { base = -2 })
    :modifier("health_modifier", "chance_numerator", { base = 1 })
    :modifier("health_modifier", "chance_denominator", { base = 5 })
    :modifier("health_modifier", "tick", { base = 600 })
    :modifier("healing", "amount", { base = 0.75 }))

content.add(content.EffectType {
    id = "effect_vitakinetic_health_down_monster",
    name = "",
    description = "",
    maximum_intensity = 50,
    intensity_add_value = 1,
    intensity_decay_step = -1,
    intensity_decay_tick = 1800,
    intensity_decay_removes = true,
}
    :modifier("hit", "amount", { base = -0.2, per_intensity = -0.2 })
    :modifier("dodge", "amount", { base = -0.2, per_intensity = -0.2 })
    :modifier("speed", "amount", { base = -1, per_intensity = -1 }))

content.add(content.EffectType {
    id = "effect_vitakinetic_healing_down",
    name = ccb.content.text("Feeling Very Unwell"),
    description = ccb.content.text("You feel fatigued and shaky."),
    apply_message = "",
    remove_message = ccb.content.text("The feeling of weakness fades away."),
    rating = "bad",
    maximum_duration_turns = 64800,
}
    :enchantment("INLINE_ENCH_effect_vitakinetic_healing_down_0")
    :modifier("strength", "amount", { base = -2 })
    :modifier("health_modifier", "minimum", { base = -2 })
    :modifier("health_modifier", "chance_numerator", { base = 1 })
    :modifier("health_modifier", "chance_denominator", { base = 4 })
    :modifier("health_modifier", "tick", { base = 500 })
    :vitamin("iron", {
        rates = { { minimum = -10, maximum = -10 } },
        tick_turns = { 60 },
    }))

content.add(content.EffectType {
    id = "effect_vitakinetic_healing_down_super",
    name = ccb.content.text("Feeling Extremely Unwell"),
    description = ccb.content.text("You feel exhausted and shaky."),
    apply_message = "",
    remove_message = ccb.content.text("The feeling of weakness fades away."),
    rating = "bad",
    maximum_duration_turns = 64800,
}
    :enchantment("INLINE_ENCH_effect_vitakinetic_healing_down_super_0")
    :modifier("strength", "amount", { base = -3 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("health_modifier", "minimum", { base = -3 })
    :modifier("health_modifier", "chance_numerator", { base = 1 })
    :modifier("health_modifier", "chance_denominator", { base = 4 })
    :modifier("health_modifier", "tick", { base = 300 })
    :vitamin("iron", {
        rates = { { minimum = -10, maximum = -10 } },
        tick_turns = { 60 },
    }))

content.add(content.EffectType {
    id = "psi_vitakinetic_degeneration",
    name = ccb.content.text("Deteriorating"),
    description = ccb.content.text("Your skin seems to be slowly crumbling as you watch."),
    rating = "bad",
    maximum_duration_turns = 7200,
}
    :modifier("perception", "amount", { base = -1 })
    :modifier("pain", "chance_numerator", { base = 15 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "maximum_value", { base = 40 })
    :modifier("pain", "tick", { base = 60 })
    :modifier("hurt", "chance_numerator", { base = 50 })
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "tick", { base = 120 }))

content.add(content.EffectType {
    id = "pigeon_aura",
    name = "",
    blood_analysis_description = ccb.content.text("Blood sample contains noetic steroid particles and pigeon dander."),
}
    :modifier("strength", "amount", { base = 1 })
    :modifier("stimulant", "amount", { base = 1 })
    :modifier("stimulant", "tick", { base = 500 })
    :modifier("stimulant", "maximum_value", { base = 10 }))

content.add(content.EffectType {
    id = "pigeon_aura_prep",
    blood_analysis_description = ccb.content.text("Patient has allergens in blood stream."),
    rating = "neutral",
}
    :modifier("cough", "chance_numerator", { base = 2 })
    :modifier("perspiration", "chance_numerator", { base = 1 }))

-- Hidden counter, used to prevent the guardian amalgamation from shielding too many targets at once.
content.add(content.EffectType {
    id = "effect_amalgamation_telekinetic_shielder_counter",
    name = "",
    description = "",
    maximum_intensity = 5,
    intensity_add_value = 1,
    intensity_decay_step = -1,
    intensity_decay_tick = 60,
    intensity_decay_removes = true,
})

content.add(content.EffectType {
    id = "effect_nether_silent_one_resistances",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_effect_nether_silent_one_resistances_0"))

content.add(content.EffectType {
    id = "effect_silent_one_monster_drain",
    name = "",
    description = "",
    maximum_intensity = 50,
    intensity_add_value = 1,
    intensity_decay_step = -1,
    intensity_decay_tick = 1800,
    intensity_decay_removes = true,
}
    :modifier("hit", "amount", { base = -0.2, per_intensity = -0.2 })
    :modifier("dodge", "amount", { base = -0.2, per_intensity = -0.2 })
    :modifier("speed", "amount", { base = -1, per_intensity = -1 }))
