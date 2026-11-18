local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_perk_bellringer",
    name = ccb.content.text("Bell-ringing"),
    description = ccb.content.text("This is really going to hurt.  Applied to targets of the Bellringer perk."),
    apply_message = "",
    rating = "bad",
    maximum_duration_turns = 1,
}
    :enchantment("INLINE_ENCH_effect_perk_bellringer_0"))

content.add(content.EffectType {
    id = "effect_perk_closetland_sleepiness",
    name = ccb.content.text("Soporific Atmosphere"),
    description = ccb.content.text("Being here is making you very sleepy, but you feel that falling asleep would be a very, very bad idea."),
    apply_message = ccb.content.text("You yawn as you step through the hidden path.  Best to make your stay here brief."),
    rating = "bad",
}
    :enchantment("INLINE_ENCH_effect_perk_closetland_sleepiness_0"))

-- Hidden effect, prevents you from dying by falling as soon as you shift to a new dimension
content.add(content.EffectType {
    id = "effect_perk_closetland_temp_levitation",
    name = "",
    description = "",
}
    :flag("LEVITATION"))

-- Hidden effect, used as a tracker
content.add(content.EffectType {
    id = "effect_bombastic_escaped_closetland",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_perk_duck_and_weave",
    name = ccb.content.text("Running without Rhythm"),
    description = ccb.content.text("You definitely won't attract the worm.  +5 effective dodge, +1 dodge attempt, 50% chance to dodge ranged attacks outright."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_perk_duck_and_weave_0"))

content.add(content.EffectType {
    id = "effect_perk_eagle_eyes",
    name = "",
    description = "",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("vision", { multiplier = 1.25 })
    :limb_score("night_vis", { multiplier = 1.25 }))

content.add(content.EffectType {
    id = "effect_zombie",
    name = ccb.content.text("Zombie Empathy"),
    description = ccb.content.text("You are really feeling for the last zombie you killed.  That must have been really hard for it to die again.  Though you aren't really feeling pain right now."),
    apply_message = ccb.content.text("You feel a bit hungry for brains."),
    blood_analysis_description = ccb.content.text("Zombie?"),
    rating = "good",
    maximum_intensity = 1,
    intensity_duration_turns = 30,
}
    :decay_message(ccb.content.text("Brains are overrated anyways."), "bad")
    :enchantment("INLINE_ENCH_effect_zombie_0"))

content.add(content.EffectType {
    id = "effect_animal",
    name = ccb.content.text("Animal Empathy"),
    description = ccb.content.text("You are really feeling for the last animal you killed.  Reminds you of that scene in the movie where they kill the pet, really sad stuff.  Though you are feeling ready to learn to fight right now."),
    apply_message = ccb.content.text("You are ready for a fight."),
    blood_analysis_description = ccb.content.text("Animal?"),
    rating = "good",
    maximum_intensity = 1,
    intensity_duration_turns = 30,
}
    :decay_message(ccb.content.text("Your animal instincts dissipate."), "bad")
    :enchantment("INLINE_ENCH_effect_animal_0"))

content.add(content.EffectType {
    id = "effect_nether",
    name = ccb.content.text("Nether Empathy"),
    description = ccb.content.text("You are really feeling for the last demon you killed.  Must be hard to die when you don't truly exist.  Though you are feeling rejuvenated."),
    apply_message = ccb.content.text("You feel your wounds begin to seal."),
    blood_analysis_description = ccb.content.text("Nothing?"),
    rating = "good",
    maximum_intensity = 1,
    intensity_duration_turns = 30,
}
    :decay_message(ccb.content.text("Your regeneration ceases."), "bad")
    :modifier("health", "minimum", { base = 1 })
    :modifier("health", "chance_numerator", { base = 40 })
    :modifier("health_modifier", "minimum", { base = 1 })
    :modifier("health_modifier", "chance_numerator", { base = 80 }))

content.add(content.EffectType {
    id = "effect_fungus",
    name = ccb.content.text("Fungal Empathy"),
    description = ccb.content.text("You are really feeling for the last mushroom you killed.  You always hated mushrooms on food, too earthy for your taste.  Though you feel like your illness is gone."),
    apply_message = ccb.content.text("You feel like something eats all the sickness inside you."),
    blood_analysis_description = ccb.content.text("Mushroom?"),
    rating = "good",
    maximum_intensity = 1,
    intensity_duration_turns = 30,
}
    :removes_effect("infected")
    :removes_effect("bite")
    :removes_effect("bleed")
    :removes_effect("fungus")
    :removes_effect("dermatik")
    :removes_effect("winded")
    :removes_effect("poison")
    :removes_effect("badpoison")
    :removes_effect("venom_dmg")
    :removes_effect("venom_weaken"))

content.add(content.EffectType {
    id = "effect_insect",
    name = ccb.content.text("Bug Empathy"),
    description = ccb.content.text("You are really feeling for the last bug you killed.  You always hated squishing bugs, what did they ever do to you.  Though you feel like your skin has hardened."),
    apply_message = ccb.content.text("Your skin hardens significantly."),
    blood_analysis_description = ccb.content.text("Bug?"),
    rating = "good",
    maximum_intensity = 1,
    intensity_duration_turns = 30,
}
    :decay_message(ccb.content.text("Your skin softens again."), "bad")
    :enchantment("INLINE_ENCH_effect_insect_0"))

-- Hidden effect, turns off Uncanny Dodge when you get hit
content.add(content.EffectType {
    id = "effect_perk_situational_uncanny_dodge_remover",
    name = "",
    description = "",
})

-- Hidden effect, gives you Uncanny Dodge
content.add(content.EffectType {
    id = "effect_perk_situational_uncanny_dodge",
    name = "",
    description = "",
}
    :flag("UNCANNY_DODGE"))

content.add(content.EffectType {
    id = "effect_ewwww_de_zombie",
    name = ccb.content.text("Ewwww de Zombie"),
    description = ccb.content.text("You're covered in zombie blood and guts.  Disgusting."),
    apply_message = ccb.content.text("You rub the ewwww de zombie all over yourself.  Disgusting, but hopefully effective."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_effect_ewwww_de_zombie_0")
    :enchantment("INLINE_ENCH_effect_ewwww_de_zombie_1"))

-- Hidden effect, cancels Ewwww de Zombie briefly
content.add(content.EffectType {
    id = "effect_ewwww_de_zombie_canceller",
    name = "",
    description = "",
})

-- Hidden effect used as a tracker
content.add(content.EffectType {
    id = "effect_perk_firstest_aid",
    name = "",
    description = "",
    maximum_duration_turns = 120,
})

-- No name or description to hide effect
content.add(content.EffectType {
    id = "effect_perk_grit_your_teeth_cooldown",
    name = "",
    description = "",
    rating = "bad",
})

-- Hidden effect, cancels Hive Queen briefly
content.add(content.EffectType {
    id = "effect_hive_queen_canceller",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_perk_mighty_thews",
    name = "",
    description = "",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("lift", { multiplier = 1.05 })
    :limb_score("manip", { multiplier = 1.05 })
    :limb_score("grip", { multiplier = 1.05 }))

content.add(content.EffectType {
    id = "effect_perk_moonstruck_full",
    name = ccb.content.text("Moonstruck: Full Moon"),
    description = ccb.content.text("Under the clear light of the full moon, you have unlocked your greatest potential."),
    apply_message = "",
    rating = "good",
    maximum_duration_turns = 86400,
}
    :enchantment("INLINE_ENCH_effect_perk_moonstruck_full_0"))

content.add(content.EffectType {
    id = "effect_perk_moonstruck_waxing",
    name = ccb.content.text("Moonstruck: Waxing Moon"),
    description = ccb.content.text("The silver light of the waxing moon enhances your prowess."),
    apply_message = "",
    rating = "good",
    maximum_duration_turns = 86400,
}
    :enchantment("INLINE_ENCH_effect_perk_moonstruck_waxing_0"))

content.add(content.EffectType {
    id = "effect_perk_moonstruck_new",
    name = ccb.content.text("Moonstruck: New Moon"),
    description = ccb.content.text("In the dark of the moon, you feel your vital essence weaken."),
    apply_message = "",
    rating = "bad",
    maximum_duration_turns = 86400,
}
    :enchantment("INLINE_ENCH_effect_perk_moonstruck_new_0"))

content.add(content.EffectType {
    id = "effect_perk_pantherish_grace",
    name = "",
    description = "",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("reaction", { multiplier = 1.05 })
    :limb_score("balance", { multiplier = 1.05 })
    :limb_score("footing", { multiplier = 1.05 }))

content.add(content.EffectType {
    id = "effect_perk_percussive_entry",
    name = "",
    description = "",
    maximum_intensity = 100,
    intensity_add_value = 3,
}
    :enchantment("INLINE_ENCH_effect_perk_percussive_entry_0"))

content.add(content.EffectType {
    id = "spinach_strength",
    name = ccb.content.text("Strength of Spinach"),
    description = ccb.content.text("You have the strength of a sailor!"),
    apply_message = ccb.content.text("You feel strong!"),
    remove_message = ccb.content.text("Your strength deflates."),
    rating = "good",
}
    :enchantment("INLINE_ENCH_spinach_strength_0"))

content.add(content.EffectType {
    id = "effect_perk_rage_against_the_unnatural_penalty",
    name = ccb.content.text("Red Rage"),
    description = ccb.content.text("You are filled with a furious rage that is sending your swings wide."),
    apply_message = ccb.content.text("Crimson clouds your vision as a rage fills you at the presence of these hell-spawn.  You must slay them!  It is they who should feel the sting of your blade, not the rabble!"),
    maximum_duration_turns = 60,
    rating = "bad",
}
    :modifier("hit", "amount", { base = -5 })
    :modifier("dodge", "amount", { base = -2 }))

-- Hidden effect
content.add(content.EffectType {
    id = "effect_perk_safety_squint_reduced_vision",
    name = "",
    description = "",
}
    :flag("MYOPIC_SUPERNATURAL"))

content.add(content.EffectType {
    id = "effect_perk_second_chance",
    name = ccb.content.text("Surge of Energy"),
    description = ccb.content.text("You are filled with vitality!"),
    remove_message = ccb.content.text("Your surge of vitality fades away!"),
    maximum_duration_turns = 5,
    maximum_intensity = 5,
    intensity_duration_turns = 1,
    rating = "good",
}
    :flag("PAIN_IMMUNE")
    :removes_effect("dazed")
    :removes_effect("downed")
    :removes_effect("bleed")
    :removes_effect("blind")
    :removes_effect("deaf")
    :removes_effect("stunned")
    :enchantment("INLINE_ENCH_effect_perk_second_chance_0")
    :modifier("stamina", "minimum", { per_intensity = 2000 })
    :modifier("stamina", "maximum", { per_intensity = 4500 })
    :modifier("stamina", "chance_numerator", { per_intensity = 1 }))

-- Hidden effect
content.add(content.EffectType {
    id = "effect_perk_second_wind_cooldown",
    name = "",
    description = "",
})

-- Hidden effect
content.add(content.EffectType {
    id = "effect_perk_second_wind_currently_active",
    name = "",
    description = "",
})

-- Hidden effect, blocks grab for one turn.
content.add(content.EffectType {
    id = "effect_perk_slippery_escape",
    name = "",
    description = "",
}
    :removes_effect("grabbed"))

-- hidden effect, cures cold and flu
content.add(content.EffectType {
    id = "effect_perk_soul_for_soul_sickness_blocker",
    name = "",
    description = "",
}
    :removes_effect("pre_common_cold")
    :removes_effect("common_cold")
    :removes_effect("pre_flu")
    :removes_effect("flu"))

content.add(content.EffectType {
    id = "effect_perk_twice_shy",
    name = ccb.content.text("Twice Shy"),
    description = ccb.content.text("That first time really smarts.  +2 effective dodge, +1 dodge attempt."),
    rating = "good",
    intensity_duration_turns = 1,
    maximum_duration_turns = 5,
    show_in_info = true,
}
    :enchantment("INLINE_ENCH_effect_perk_twice_shy_0"))

-- No name or description to hide effect
content.add(content.EffectType {
    id = "effect_perk_undying_loyalty_self",
    name = "",
    description = "",
    rating = "bad",
})

content.add(content.EffectType {
    id = "effect_perk_undying_loyalty",
    name = ccb.content.text("Undying Loyalty"),
    description = ccb.content.text("You'll protect your allies no matter the cost."),
    apply_message = "",
    rating = "good",
    show_in_info = true,
    maximum_duration_turns = 60,
}
    :enchantment("INLINE_ENCH_effect_perk_undying_loyalty_0"))

content.add(content.EffectType {
    id = "effect_perk_vengeful",
    rating = "good",
    intensity_duration_turns = 1,
    maximum_duration_turns = 2,
    show_in_info = true,
})
