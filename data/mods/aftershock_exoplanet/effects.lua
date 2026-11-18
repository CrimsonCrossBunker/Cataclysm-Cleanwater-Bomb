local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "migo_rad_away",
    blood_analysis_description = ccb.content.text("Strange proteins are ingesting radioactive particles and flushing themselves from the host."),
    maximum_duration_turns = 10800,
    duration_add_percent = 35,
    rating = "good",
}
    :modifier("radiation", "chance_numerator", { base = 600 })
    :modifier("radiation", "minimum", { base = -1 }))

content.add(content.EffectType {
    id = "migo_rad_flush",
    blood_analysis_description = ccb.content.text("Strange proteins are ingesting radioactive particles and containing all emmissions."),
    maximum_duration_turns = 10800,
    duration_add_percent = 35,
    rating = "good",
}
    :modifier("radiation", "chance_numerator", { base = 600 })
    :modifier("radiation", "minimum", { base = -5 }))

content.add(content.EffectType {
    id = "mutagen_mastodon",
    name = ccb.content.text("Mastodon Mutation"),
    description = ccb.content.text("You consumed mastodon mutagen."),
    blood_analysis_description = ccb.content.text("Mastodon Mutagen Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Mastodon Transformation"))
    :name(ccb.content.text("Mastodon Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of mastodon mutagen."))
    :description(ccb.content.text("You consumed a life-changing amount of mastodon mutagen."))
    :resist_trait("THRESH_MASTODON")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "mutagen_migo",
    name = ccb.content.text("Mi-go Mutation"),
    description = ccb.content.text("You consumed mi-go mutagen."),
    blood_analysis_description = ccb.content.text("Mi-go Mutagen Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Mi-go Transformation"))
    :name(ccb.content.text("Mi-go Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of mi-go mutagen."))
    :description(ccb.content.text("You consumed a life-changing amount of mi-go mutagen."))
    :resist_trait("THRESH_YUGGOTH")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "foamcrete_slow",
    name = ccb.content.text("Slowed"),
    description = ccb.content.text("A partial covering of foamcrete is slowing you down."),
    rating = "bad",
    maximum_intensity = 10,
    intensity_add_value = 1,
    intensity_decay_tick = 600,
    show_in_info = true,
}
    :name(ccb.content.text("Slowed"))
    :name(ccb.content.text("Slowed"))
    :name(ccb.content.text("Sluggish"))
    :name(ccb.content.text("Sluggish"))
    :name(ccb.content.text("Sluggish"))
    :name(ccb.content.text("Sluggish"))
    :name(ccb.content.text("Sluggish"))
    :name(ccb.content.text("Sluggish"))
    :name(ccb.content.text("Encased in foamcrete"))
    :modifier("dexterity", "amount", { base = -0.34, per_intensity = -0.34, resisted_base = -0.17, resisted_per_intensity = -0.17 })
    :modifier("speed", "amount", { base = -15, per_intensity = -15 })
    :miss_message(ccb.content.text("You feel stiff."), 3))

content.add(content.EffectType {
    id = "afs_badpoison",
    name = ccb.content.text("Fatally Poisoned"),
    description = ccb.content.text("The world is spinning around you, and you feel like you're going to die."),
    blood_analysis_description = ccb.content.text("Poison"),
    rating = "bad",
    pain_sizing = true,
    hurt_sizing = true,
    main_parts_only = true,
    show_in_info = true,
}
    :immune_character_flag("BIOLOGICALPROOF")
    :immune_character_flag("BIO_IMMUNE")
    :immune_bodypart_flag("BIONIC_LIMB")
    :resist_effect("prophylactic_antivenom")
    :resist_effect("synth_blood_perf")
    :resist_effect("synth_blood_permanent")
    :resist_trait("POISRESIST")
    :modifier("perception", "amount", { base = -2 })
    :modifier("dexterity", "amount", { base = -2 })
    :modifier("strength", "amount", { base = -3, resisted_base = -1 })
    :modifier("speed", "amount", { base = -10 })
    :modifier("pain", "minimum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 1, resisted_base = 100 })
    :modifier("hurt", "minimum", { base = 11, resisted_base = 2 })
    :modifier("hurt", "maximum", { base = 20, resisted_base = 5 })
    :modifier("hurt", "chance_numerator", { base = 1, resisted_base = 200 })
    :miss_message(ccb.content.text("You feel bad inside."), 2))

-- Empty name and description to hide effect
content.add(content.EffectType {
    id = "afs_remove_stun_biological",
    name = "",
    description = "",
    rating = "good",
}
    :removes_effect("stunned")
    :removes_effect("dazed"))

content.add(content.EffectType {
    id = "afs_generic_speed_bonus",
    name = ccb.content.text("Movement Optimization (1)"),
    description = ccb.content.text("You move with machine-guided precision."),
    rating = "good",
    maximum_intensity = 4,
    intensity_add_value = 1,
    intensity_decay_tick = 500,
    show_in_info = true,
}
    :name(ccb.content.text("Movement Optimization (2)"))
    :name(ccb.content.text("Movement Optimization (3)"))
    :name(ccb.content.text("Movement Optimization (4)"))
    :modifier("dexterity", "amount", { base = 0.5, per_intensity = 0.5 })
    :modifier("speed", "amount", { base = 10, per_intensity = 10 }))

content.add(content.EffectType {
    id = "synth_blood_perf",
    name = ccb.content.text("Synthblood Comedown"),
    description = ccb.content.text("As the synthetic blood decays and is purged throughout your bloodstream, you begin to feel minor symptoms of altitude sickness, making you sluggish and short of breath."),
    blood_analysis_description = ccb.content.text("Synthetic blood"),
    rating = "good",
    intensity_duration_turns = 28800,
    maximum_intensity = 2,
    maximum_duration_turns = 86400,
    show_in_info = true,
}
    :name(ccb.content.text("Synthblood"))
    :description(ccb.content.text("Your breaths instinctively grow shallow as the synthetic blood carries oxygen throughout your body, increasing your speed, stamina, and general endurance."))
    :modifier("speed", "amount", { base = -5, per_intensity = 15 })
    :modifier("stamina", "minimum", { base = -10, per_intensity = 35 })
    :modifier("strength", "amount", { base = -1, per_intensity = 1 })
    :modifier("dexterity", "amount", { base = -1, per_intensity = 1 }))

content.add(content.EffectType {
    id = "synth_blood_permanent",
    name = ccb.content.text("Synthblood"),
    description = ccb.content.text("Your breaths instinctively grow shallow as the synthetic blood carries oxygen throughout your body, increasing your speed, stamina, and general endurance."),
    blood_analysis_description = ccb.content.text("Synthetic blood"),
    rating = "good",
    show_in_info = true,
}
    :removes_effect("synth_blood_perf")
    :modifier("speed", "amount", { base = 15 })
    :modifier("strength", "amount", { base = 1 })
    :modifier("dexterity", "amount", { base = 1 }))

content.add(content.EffectType {
    id = "afs_isohypsa_overwatch",
    name = ccb.content.text("Isohypsa Overwatch"),
    description = "FE09-    A3 65 FF    ATT $#17A\nFE0B-    4E          JMP $5010\nFE0D-    A5 24       DEX $#05\n",
    rating = "good",
    show_in_info = true,
}
    :blocks_effect("sensor_stun")
    :blocks_effect("dazed")
    :blocks_effect("stunned")
    :blocks_effect("blind")
    :modifier("dexterity", "amount", { base = 0.5 })
    :modifier("speed", "amount", { base = 50 }))

content.add(content.EffectType {
    id = "afs_rocket_flight",
    name = ccb.content.text("Rocket Flight"),
    description = ccb.content.text("You are flying with a rocket powered device."),
    rating = "good",
    show_in_info = true,
}
    :flag("LEVITATION"))

content.add(content.EffectType {
    id = "effect_robot_immobilized",
    name = ccb.content.text("Immobilized"),
    description = ccb.content.text("You are completely immobile"),
    remove_message = ccb.content.text("You can move again."),
    rating = "bad",
    show_in_info = true,
}
    :flag("CANNOT_ATTACK")
    :flag("CANNOT_MOVE"))

content.add(content.EffectType {
    id = "afs_medigel_eff_trigger",
})

content.add(content.EffectType {
    id = "afs_hack_done",
})

content.add(content.EffectType {
    id = "smart_targeted",
    name = ccb.content.text("Smart Targeted"),
    description = ccb.content.text("You are being tracked by an advanced targeting system, reducing your armor effectiveness."),
    maximum_duration_turns = 30,
    rating = "bad",
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_smart_targeted_0"))

content.add(content.EffectType {
    id = "vahagan_fired_at",
    maximum_duration_turns = 1,
})

content.add(content.EffectType {
    id = "afs_android_crawling",
    name = ccb.content.text("Crawling"),
    description = ccb.content.text("Even if its been critically damaged, this android continues to crawl towards its target."),
    rating = "bad",
    maximum_duration_turns = 8640000,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_afs_android_crawling_0"))

content.add(content.EffectType {
    id = "afs_weapon_disabled",
    name = ccb.content.text("Disabled weaponry"),
    description = ccb.content.text("The main weaponry of this creature is no longer functional."),
    rating = "bad",
    maximum_duration_turns = 8640000,
    show_in_info = true,
})

content.add(content.EffectType {
    id = "afs_combat_stims",
    name = ccb.content.text("Combat Stimulants"),
    description = ccb.content.text("You are under the effects of powerful military combat stimulants"),
    rating = "good",
    show_in_info = true,
}
    :blocks_effect("stim_overdose")
    :blocks_effect("shakes"))

content.add(content.EffectType {
    id = "afs_medigel_eff",
    name = ccb.content.text("MediGel"),
    description = ccb.content.text("The medical gel applied to your wounds is slowly healing them."),
    rating = "good",
    main_parts_only = true,
    part_descriptions = true,
    maximum_duration_turns = 345600,
}
    :modifier("healing", "amount", { base = 4, per_intensity = 2 })
    :modifier("healing_head", "amount", { base = 50 })
    :modifier("healing_torso", "amount", { base = 150 }))

content.add(content.EffectType {
    id = "decreased_performance",
    name = ccb.content.text("Decreased Performance"),
    description = ccb.content.text("The performance enhancing drugs slowly wear off and leave you in a state of existential grade hangover."),
    blood_analysis_description = ccb.content.text("Post overdose quantities of multiple drugs in analyzed blood."),
    rating = "bad",
    intensity_duration_turns = 28800,
    maximum_duration_turns = 86400,
    show_in_info = true,
}
    :modifier("speed", "amount", { base = -5 })
    :modifier("stamina", "minimum", { base = -10 })
    :modifier("strength", "amount", { base = -2 })
    :modifier("dexterity", "amount", { base = -2 }))

content.add(content.EffectType {
    id = "post_speed_injection",
    name = ccb.content.text("Slowed Reactions"),
    description = ccb.content.text("The performance enhancing drugs slowly wear off and leave you in a state of existential grade hangover."),
    blood_analysis_description = ccb.content.text("Dangerous levels of military grade nervous system medications."),
    rating = "bad",
    intensity_duration_turns = 28800,
    maximum_duration_turns = 86400,
    show_in_info = true,
}
    :modifier("speed", "amount", { base = -45 })
    :modifier("stamina", "minimum", { base = -17 }))

content.add(content.EffectType {
    id = "post_healing_injection",
    name = ccb.content.text("Haggard and drawn"),
    description = ccb.content.text("The performance enhancing drugs slowly wear off and leave you in a state of existential grade hangover."),
    blood_analysis_description = ccb.content.text("Post overdose quantities of multiple drugs in analyzed blood."),
    rating = "bad",
    intensity_duration_turns = 28800,
    maximum_duration_turns = 86400,
    show_in_info = true,
}
    :modifier("stimulant", "minimum", { base = -20 })
    :modifier("stimulant", "minimum_value", { base = -60 })
    :modifier("perspiration", "minimum", { base = 1 })
    :modifier("perspiration", "chance_numerator", { base = 60 })
    :modifier("stamina", "minimum", { base = -10 }))

content.add(content.EffectType {
    id = "post_strength_injection",
    name = ccb.content.text("Weakened and worn down"),
    description = ccb.content.text("The performance enhancing drugs slowly wear off and leave you in a state of existential grade hangover."),
    blood_analysis_description = ccb.content.text("Dangerous levels of steroids."),
    rating = "bad",
    intensity_duration_turns = 28800,
    maximum_duration_turns = 86400,
    show_in_info = true,
}
    :modifier("speed", "amount", { base = -5 })
    :modifier("stamina", "minimum", { base = -10 })
    :modifier("strength", "amount", { base = -4 })
    :modifier("dexterity", "amount", { base = -2 }))

content.add(content.EffectType {
    id = "afs_cureall",
}
    :removes_effect("afs_badpoison")
    :modifier("painkiller", "minimum", { base = 5 }))

content.add(content.EffectType {
    id = "afs_ai_defensive",
    name = ccb.content.text("Defensive Stance"),
    description = ccb.content.text("This creature is actively defending itself."),
    show_in_info = true,
})
