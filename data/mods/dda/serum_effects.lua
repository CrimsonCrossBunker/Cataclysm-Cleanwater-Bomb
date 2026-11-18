local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "learning_serum_main",
    name = ccb.content.text("Injected 76x-\"Lore\""),
    description = ccb.content.text("You just took a shot of some weird stuff.  You feel sleepy, nauseous, and generally weak, but your wounds are closing up at an unnatural pace."),
    apply_message = ccb.content.text("Without hesitation, you draw the liquid from the ampule, smack it a bit to release any air, and inject it right into a vein, hoping it won't kill you."),
    remove_message = ccb.content.text("Your thoughts slow gradually."),
    rating = "mixed",
    maximum_intensity = 100,
    intensity_add_value = 1,
    show_intensity = false,
    duration_add_percent = 10,
}
    :flag("MYOPIC_IN_LIGHT")
    :flag("CANNOT_SLEEP")
    :removes_effect("learning_serum_crash")
    :enchantment("INLINE_ENCH_learning_serum_main_0")
    :enchantment("INLINE_ENCH_learning_serum_main_1")
    :enchantment("INLINE_ENCH_learning_serum_main_2")
    :enchantment("INLINE_ENCH_learning_serum_main_3")
    :modifier("blood_pressure", "tick", { base = 100 })
    :modifier("blood_pressure", "chance_numerator", { base = 5 })
    :modifier("blood_pressure", "minimum", { base = 5 })
    :modifier("blood_pressure", "maximum_value", { base = 1000 })
    :modifier("heart_rate", "tick", { base = 200 })
    :modifier("heart_rate", "minimum", { base = 2, per_intensity = 1 })
    :modifier("heart_rate", "chance_numerator", { base = 5 })
    :modifier("heart_rate", "maximum_value", { base = 150 }))

content.add(content.EffectType {
    id = "learning_serum_crash",
    name = ccb.content.text("Injected Serum Crash"),
    description = ccb.content.text("Your enhanced focus has faded away, light seems too bright, and you're pretty tired."),
    apply_message = "",
    remove_message = "",
}
    :flag("MYOPIC_IN_LIGHT")
    :enchantment("INLINE_ENCH_learning_serum_crash_0")
    :enchantment("INLINE_ENCH_learning_serum_crash_1"))

content.add(content.EffectType {
    id = "learning_serum_light_pain",
    name = "",
    description = "",
    apply_message = "",
    remove_message = "",
}
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "maximum_value", { base = 25 })
    :modifier("pain", "chance_numerator", { base = 4 })
    :modifier("pain", "tick", { base = 120 }))

content.add(content.EffectType {
    id = "regen_serum_slow_time",
    name = ccb.content.text("Slowed Time"),
    description = ccb.content.text("Everything around you seems to be moving slower."),
    apply_message = ccb.content.text("Everything seems to suddenly slow down!"),
    remove_message = ccb.content.text("The world around you speeds up."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_regen_serum_slow_time_0"))

-- Mute is supposed to represent acute laryngitis.  Allowing communication through whispering would be better
content.add(content.EffectType {
    id = "night_ops_serum_main",
    name = ccb.content.text("Injected 09x-\"Anaximander\""),
    description = ccb.content.text("You just took a shot of that strange vial you found.  The shadows don't seem so dark anymore."),
    apply_message = ccb.content.text("Without hesitation, you draw the liquid from the ampule, smack it a bit to release any air, and inject it right into a vein, hoping it won't kill you."),
    remove_message = ccb.content.text("The darkness returns to impenetrability."),
    rating = "mixed",
    maximum_intensity = 100,
    intensity_add_value = 1,
    show_intensity = false,
    duration_add_percent = 5,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("MYOPIC_IN_LIGHT")
    :flag("MUTE")
    :removes_effect("night_ops_serum_crash")
    :enchantment("INLINE_ENCH_night_ops_serum_main_0")
    :enchantment("INLINE_ENCH_night_ops_serum_main_1")
    :enchantment("INLINE_ENCH_night_ops_serum_main_2")
    :modifier("perspiration", "minimum", { base = 1 })
    :modifier("perspiration", "tick", { base = 300 })
    :modifier("perspiration", "chance_numerator", { base = 6 })
    :modifier("vomiting", "chance_numerator", { base = 50 })
    :modifier("vomiting", "tick", { base = 300 })
    :limb_score("breathing", { multiplier = 0.9 }))

content.add(content.EffectType {
    id = "night_ops_serum_crash",
    name = ccb.content.text("Injected Serum Crash"),
    description = ccb.content.text("The light hurts your eyes and the shadows seem extra dark.  Who knows what could be in there?"),
    apply_message = "",
    remove_message = "",
}
    :flag("MYOPIC_IN_LIGHT")
    :flag("SUNBURN")
    :enchantment("INLINE_ENCH_night_ops_serum_crash_0")
    :modifier("perspiration", "minimum", { base = 1 })
    :modifier("perspiration", "tick", { base = 300 })
    :modifier("perspiration", "chance_numerator", { base = 6 })
    :modifier("blood_pressure", "tick", { base = 250 })
    :modifier("blood_pressure", "chance_numerator", { base = 5 })
    :modifier("blood_pressure", "minimum", { base = -3 })
    :modifier("blood_pressure", "maximum_value", { base = -2500 }))

content.add(content.EffectType {
    id = "night_ops_serum_crash_nyctophobia",
    name = "",
    description = "",
    apply_message = "",
    remove_message = "",
}
    :flag("NYCTOPHOBIA"))

content.add(content.EffectType {
    id = "regen_serum_main",
    name = ccb.content.text("Injected 48x-\"Locutus\""),
    description = ccb.content.text("You just took a shot of some weird stuff.  You feel sleepy, nauseous, and generally weak, but your wounds are closing up at an unnatural pace."),
    apply_message = ccb.content.text("Without hesitation, you draw the liquid from the ampule, smack it a bit to release any air, and inject it right into a vein, hoping it won't kill you."),
    remove_message = ccb.content.text("You feel your rapid regeneration fade away, but you still feel sick."),
    rating = "mixed",
    duration_add_percent = 33,
}
    :flag("MEND_ALL")
    :removes_effect("regen_serum_crash_fatigue")
    :enchantment("INLINE_ENCH_regen_serum_main_0"))

content.add(content.EffectType {
    id = "regen_serum_crash_cardio",
    name = "",
    description = "",
    apply_message = "",
    remove_message = "",
}
    :enchantment("INLINE_ENCH_regen_serum_crash_cardio_0"))

content.add(content.EffectType {
    id = "regen_serum_crash_fatigue",
    name = ccb.content.text("Injected Serum Crash"),
    description = ccb.content.text("Your body regeneration is not as fast as before, but you still feel some weakness."),
    apply_message = "",
    remove_message = "",
}
    :enchantment("INLINE_ENCH_regen_serum_crash_fatigue_0"))

-- Intensity currently only exists to prevent multiple copies of the side effects EoC from firing
-- Once blood clotting is a thing that can happen, repeated doses of Armus should cause it
content.add(content.EffectType {
    id = "resilience_serum_main",
    name = ccb.content.text("Injected 16x-\"Armus\""),
    description = ccb.content.text("You just took a shot of that strange vial you found.  You feel invincible."),
    apply_message = ccb.content.text("Without hesitation, you draw the liquid from the ampule, smack it a bit to release any air, and inject it right into a vein, hoping it won't kill you."),
    remove_message = ccb.content.text("You feel increased resilience fade away with a sudden stab of pain."),
    rating = "mixed",
    maximum_intensity = 100,
    intensity_add_value = 1,
    show_intensity = false,
    duration_add_percent = 25,
}
    :flag("PAUSE_INFECTIONS")
    :removes_effect("resilience_serum_crash")
    :enchantment("INLINE_ENCH_resilience_serum_main_0")
    :enchantment("INLINE_ENCH_resilience_serum_main_1"))

-- Hidden effect, provides the Jittery trait
content.add(content.EffectType {
    id = "resilience_serum_side_effect_jittery",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_resilience_serum_side_effect_jittery_0"))

-- Hidden effect, provides the Bad Temper trait
content.add(content.EffectType {
    id = "resilience_serum_side_effect_badmood",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_resilience_serum_side_effect_badmood_0"))

-- Hidden effect, provides the Kaluptic Psychosis trait
content.add(content.EffectType {
    id = "resilience_serum_side_effect_hallucinations",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_resilience_serum_side_effect_hallucinations_0"))

-- Hidden effect, causes temporary paralysis
content.add(content.EffectType {
    id = "resilience_serum_side_effect_downed",
    name = "",
    description = "",
}
    :enchantment("INLINE_ENCH_resilience_serum_side_effect_downed_0"))

content.add(content.EffectType {
    id = "resilience_serum_crash",
    name = ccb.content.text("Injected Serum Crash"),
    description = ccb.content.text("Your enhanced resilience has faded away, your skin is flushed, and everything hurts."),
    apply_message = "",
    remove_message = "",
}
    :enchantment("INLINE_ENCH_resilience_serum_crash_0")
    :modifier("pain", "minimum", { base = 5 })
    :modifier("pain", "maximum", { base = 15 })
    :modifier("pain", "chance_numerator", { base = 8 })
    :modifier("pain", "tick", { base = 1800 })
    :modifier("blood_pressure", "tick", { base = 100 })
    :modifier("blood_pressure", "chance_numerator", { base = 5 })
    :modifier("blood_pressure", "minimum", { base = 5 })
    :modifier("blood_pressure", "maximum_value", { base = 1500 })
    :modifier("heart_rate", "tick", { base = 200 })
    :modifier("heart_rate", "minimum", { base = 2 })
    :modifier("heart_rate", "chance_numerator", { base = 5 })
    :modifier("heart_rate", "maximum_value", { base = 125 }))

content.add(content.EffectType {
    id = "speed_serum_main",
    name = ccb.content.text("Injected 51x-\"Landru\""),
    description = ccb.content.text("You just took a shot of that strange vial you found.  Time seems to have slowed down."),
    apply_message = ccb.content.text("Without hesitation, you draw the liquid from the ampule, smack it a bit to release any air, and inject it right into a vein, hoping it won't kill you."),
    remove_message = ccb.content.text("The world around you speeds up."),
    rating = "mixed",
    maximum_intensity = 100,
    intensity_add_value = 1,
    show_intensity = false,
    duration_add_percent = 10,
}
    :removes_effect("speed_serum_crash")
    :removes_effect("stim_overdose")
    :enchantment("INLINE_ENCH_speed_serum_main_0")
    :enchantment("INLINE_ENCH_speed_serum_main_1")
    :modifier("stimulant", "tick", { base = 60 })
    :modifier("stimulant", "chance_numerator", { base = 5 })
    :modifier("stimulant", "minimum", { base = 2 })
    :modifier("stimulant", "maximum_value", { base = 45 })
    :modifier("heart_rate", "tick", { base = 200 })
    :modifier("heart_rate", "minimum", { base = 2 })
    :modifier("heart_rate", "chance_numerator", { base = 5 })
    :modifier("heart_rate", "maximum_value", { base = 150 })
    :modifier("respiratory_rate", "tick", { base = 180 })
    :modifier("respiratory_rate", "minimum", { base = 1 })
    :modifier("respiratory_rate", "chance_numerator", { base = 7 })
    :modifier("respiratory_rate", "maximum_value", { base = 45 }))

content.add(content.EffectType {
    id = "speed_serum_crash",
    name = ccb.content.text("Injected Serum Crash"),
    description = ccb.content.text("The world seems jittery and moving too quickly, your stomach hurts, and you're very tired."),
    apply_message = "",
    remove_message = "",
}
    :enchantment("INLINE_ENCH_speed_serum_crash_0")
    :modifier("heart_rate", "tick", { base = 200 })
    :modifier("heart_rate", "minimum", { base = -1 })
    :modifier("heart_rate", "chance_numerator", { base = 10 })
    :modifier("heart_rate", "minimum_value", { base = 50 })
    :modifier("respiratory_rate", "tick", { base = 180 })
    :modifier("respiratory_rate", "minimum", { base = -1 })
    :modifier("respiratory_rate", "chance_numerator", { base = 13 })
    :modifier("respiratory_rate", "minimum_value", { base = 15 }))

-- Focus for learning is set at 15 regardless of actual displayed focus
content.add(content.EffectType {
    id = "super_soldier_serum_main",
    name = ccb.content.text("Injected 29x-\"Noonien\""),
    description = ccb.content.text("You just took a shot of that strange vial you found.  You feel like you could take on the entire world, but your stomach feels a bit odd."),
    apply_message = ccb.content.text("Without hesitation, you draw the liquid from the ampule, smack it a bit to release any air, and inject it right into a vein, hoping it won't kill you."),
    remove_message = ccb.content.text("You feel your enhanced strength fade away, but your stomach still feels odd."),
    rating = "mixed",
    duration_add_percent = 5,
}
    :flag("CANNOT_GAIN_WEARINESS")
    :flag("HUNGER_DISRUPTION")
    :removes_effect("hunger_engorged")
    :removes_effect("hunger_full")
    :removes_effect("hunger_satisfied")
    :removes_effect("hunger_hungry")
    :removes_effect("hunger_very_hungry")
    :removes_effect("hunger_near_starving")
    :removes_effect("hunger_starving")
    :removes_effect("hunger_famished")
    :removes_effect("super_soldier_serum_crash")
    :enchantment("INLINE_ENCH_super_soldier_serum_main_0")
    :enchantment("INLINE_ENCH_super_soldier_serum_main_1")
    :enchantment("INLINE_ENCH_super_soldier_serum_main_2")
    :enchantment("INLINE_ENCH_super_soldier_serum_main_3")
    :enchantment("INLINE_ENCH_super_soldier_serum_main_4")
    :modifier("blood_pressure", "tick", { base = 100 })
    :modifier("blood_pressure", "chance_numerator", { base = 5 })
    :modifier("blood_pressure", "minimum", { base = 5 })
    :modifier("blood_pressure", "maximum_value", { base = 2500 }))

content.add(content.EffectType {
    id = "super_soldier_serum_crash",
    name = ccb.content.text("Injected Serum Crash"),
    description = ccb.content.text("Your enhanced strength has faded away, your body aches, and you're having a hard time concentrating."),
    apply_message = "",
    remove_message = "",
}
    :enchantment("INLINE_ENCH_super_soldier_serum_crash_0")
    :modifier("blood_pressure", "tick", { base = 100 })
    :modifier("blood_pressure", "chance_numerator", { base = 5 })
    :modifier("blood_pressure", "minimum", { base = -5 })
    :modifier("blood_pressure", "maximum_value", { base = -2500 }))
