local ccb = require("ccb")
local content = ccb.content

content.upsert_effect_type(content.EffectType {
    id = "haste",
    name = ccb.content.text("Hasted"),
    description = ccb.content.text("Your speed is boosted enormously."),
    apply_message = ccb.content.text("Your speed is boosted to superhuman levels!"),
    remove_message = ccb.content.text("You return to your normal speed."),
    rating = "good",
    maximum_duration_turns = 120,
}
    :enchantment("INLINE_ENCH_haste_0"))

content.add(content.EffectType {
    id = "spell_karma_arms_eff",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "stalker_eyes_eff",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "devil_tail_eff",
    name = "",
    description = "",
})

-- typo id and non-typo id were both mentioned, so the typo id is being obsoleted
content.add(content.EffectType {
    id = "effect_lilin_temmporary_glorious",
    name = "",
    description = "",
})

content.add(content.EffectType {
    id = "effect_arvore_tree_immobility",
    name = ccb.content.text("Rooted"),
    description = ccb.content.text("Your roots sink into the ground and you are nearly immobile."),
    apply_message = "",
    remove_message = "",
    rating = "mixed",
    maximum_intensity = 100000,
    show_intensity = false,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("EFFECT_IMPEDING")
    :limb_score("lift", { multiplier = 0.51 })
    :limb_score("grip", { multiplier = 0.25 }))

content.add(content.EffectType {
    id = "effect_changeling_summer_light_spell",
    name = ccb.content.text("Bonefire's Light"),
    description = ccb.content.text("A wisp of flickering insubstantial fire hovers near your shoulder."),
    apply_message = "",
    remove_message = ccb.content.text("The wisp winks out."),
    maximum_duration_turns = 43200,
})

content.add(content.EffectType {
    id = "effect_changeling_summer_sun_glasses_spell",
    name = ccb.content.text("Shading Your Eyes"),
    description = ccb.content.text("Nearby lights don't seem quite as bright now."),
    apply_message = "",
    remove_message = ccb.content.text("You blink as nearby lights grow brighter."),
    maximum_duration_turns = 43200,
})

content.add(content.EffectType {
    id = "effect_changeling_fire_melee_damage_spell",
    name = ccb.content.text("Burning Solar Grasp"),
    description = ccb.content.text("Ethereal flames flicker around your hands"),
    apply_message = "",
    remove_message = ccb.content.text("The flames gutter out."),
    maximum_duration_turns = 43200,
})

content.add(content.EffectType {
    id = "effect_arvore_sylph_undine_wearing_iron",
    name = ccb.content.text("Touching Iron"),
    description = ccb.content.text("You are in contact with iron, the ancient bane of the fae.  It will cause you pain and discomfort until removed."),
    apply_message = ccb.content.text("As the iron touches you, your skin begins to burn."),
    remove_message = ccb.content.text("The burning from the iron finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_FEY_MAGIC")
    :modifier("pain", "amount", { base = 10 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "maximum_value", { base = 200 })
    :modifier("pain", "tick", { base = 90 })
    :limb_score("balance", { multiplier = 0.75 })
    :limb_score("breathing", { multiplier = 0.7 })
    :limb_score("lift", { multiplier = 0.8 })
    :limb_score("grip", { multiplier = 0.8 })
    :limb_score("reaction", { multiplier = 0.8 }))

content.add(content.EffectType {
    id = "effect_arvore_sylph_undine_wearing_steel",
    name = ccb.content.text("Touching Steel"),
    description = ccb.content.text("You are in contact with steel, the closest material to iron, the ancient bane of the fae.  It will cause you pain and discomfort until removed."),
    apply_message = ccb.content.text("As the steel touches you, your skin begins to burn."),
    remove_message = ccb.content.text("The burning from the steel finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_FEY_MAGIC")
    :modifier("pain", "amount", { base = 8 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 2 })
    :modifier("pain", "maximum_value", { base = 100 })
    :modifier("pain", "tick", { base = 120 })
    :limb_score("balance", { multiplier = 0.8 })
    :limb_score("breathing", { multiplier = 0.75 })
    :limb_score("lift", { multiplier = 0.9 })
    :limb_score("grip", { multiplier = 0.85 })
    :limb_score("reaction", { multiplier = 0.85 }))

content.add(content.EffectType {
    id = "effect_ierde_salamander_wearing_iron",
    name = ccb.content.text("Touching Iron"),
    description = ccb.content.text("You are in contact with iron, the ancient bane of the fae.  It will cause you pain and discomfort until removed."),
    apply_message = ccb.content.text("As the iron touches you, your skin begins to burn."),
    remove_message = ccb.content.text("The burning from the iron finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_FEY_MAGIC")
    :modifier("pain", "amount", { base = 5 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 3 })
    :modifier("pain", "maximum_value", { base = 100 })
    :modifier("pain", "tick", { base = 120 })
    :limb_score("balance", { multiplier = 0.9 })
    :limb_score("breathing", { multiplier = 0.85 })
    :limb_score("lift", { multiplier = 0.9 })
    :limb_score("grip", { multiplier = 0.9 })
    :limb_score("reaction", { multiplier = 0.9 }))

content.add(content.EffectType {
    id = "effect_ierde_salamander_wearing_steel",
    name = ccb.content.text("Touching Steel"),
    description = ccb.content.text("You are in contact with steel, the closest material to iron, the ancient bane of the fae.  It will cause you pain and discomfort until removed."),
    apply_message = ccb.content.text("As the steel touches you, your skin begins to itch."),
    remove_message = ccb.content.text("The itching from the steel finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("pain", "amount", { base = 2 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 6 })
    :modifier("pain", "maximum_value", { base = 50 })
    :modifier("pain", "tick", { base = 120 })
    :limb_score("breathing", { multiplier = 0.95 }))

content.add(content.EffectType {
    id = "effect_changeling_wearing_iron",
    name = ccb.content.text("Touching Iron"),
    description = ccb.content.text("You are in contact with iron.  It will cause you pain and discomfort until removed."),
    apply_message = ccb.content.text("As the iron touches you, your skin begins to itch fiercely."),
    remove_message = ccb.content.text("The itch from the iron finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :flag("NO_FEY_MAGIC")
    :modifier("pain", "amount", { base = 5 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 5 })
    :modifier("pain", "maximum_value", { base = 35 })
    :modifier("pain", "tick", { base = 120 })
    :limb_score("balance", { multiplier = 0.9 })
    :limb_score("breathing", { multiplier = 0.85 })
    :limb_score("lift", { multiplier = 0.9 })
    :limb_score("grip", { multiplier = 0.9 })
    :limb_score("reaction", { multiplier = 0.9 }))

content.add(content.EffectType {
    id = "effect_changeling_wearing_steel",
    name = ccb.content.text("Touching Steel"),
    description = ccb.content.text("You are in contact with steel.  It will cause you pain and discomfort until removed."),
    apply_message = ccb.content.text("As the steel touches you, your skin begins to itch."),
    remove_message = ccb.content.text("The itching from the steel finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :modifier("pain", "amount", { base = 2 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 3 })
    :modifier("pain", "chance_numerator", { base = 10 })
    :modifier("pain", "maximum_value", { base = 15 })
    :modifier("pain", "tick", { base = 120 })
    :limb_score("breathing", { multiplier = 0.95 }))
