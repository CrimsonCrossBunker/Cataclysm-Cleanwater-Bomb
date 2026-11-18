local ccb = require("ccb")
local content = ccb.content

content.upsert_effect_type(content.EffectType {
    id = "effect_iron_allergy_wearing_iron",
    name = ccb.content.text("Touching Iron"),
    description = ccb.content.text("You are in contact with iron.  It will cause you pain and discomfort until removed."),
    apply_message = ccb.content.text("As the iron touches you, your skin begins to burn."),
    remove_message = ccb.content.text("The burning from the iron finally fades."),
    rating = "bad",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
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

content.upsert_effect_type(content.EffectType {
    id = "effect_iron_allergy_wearing_steel",
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
    :modifier("pain", "chance_numerator", { base = 6 })
    :modifier("pain", "maximum_value", { base = 50 })
    :modifier("pain", "tick", { base = 120 })
    :limb_score("breathing", { multiplier = 0.95 }))

content.upsert_effect_type(content.EffectType {
    id = "haste",
    name = ccb.content.text("Hasted"),
    description = ccb.content.text("Your speed is boosted enormously."),
    apply_message = ccb.content.text("Your speed is boosted to superhuman levels!"),
    remove_message = ccb.content.text("You return to your normal speed."),
    rating = "good",
    maximum_duration_turns = 480,
}
    :removes_effect("magic_slowed")
    :enchantment("INLINE_ENCH_haste_0"))

content.upsert_effect_type(content.EffectType {
    id = "natures_commune",
    name = ccb.content.text("Nature's Commune"),
    description = ccb.content.text("You can feel Mother Nature welcoming you, revitalizing your body and calming the natural fauna around you."),
    apply_message = ccb.content.text("A warm embrace surrounds you, like that of a mother with her child."),
    remove_message = ccb.content.text("Your communion with Mother Nature fades."),
    rating = "good",
    maximum_duration_turns = 14400,
}
    :flag("ANIMALEMPATH")
    :modifier("health", "minimum", { base = 1 })
    :modifier("health", "chance_numerator", { base = 40 })
    :modifier("health_modifier", "minimum", { base = 1 })
    :modifier("health_modifier", "chance_numerator", { base = 80 })
    :modifier("health", "tick", { base = 30 }))

content.upsert_effect_type(content.EffectType {
    id = "effect_flame_immunity",
    name = ccb.content.text("Flame Immunity"),
    description = ccb.content.text("You are immune to heat and fire."),
    rating = "good",
    show_in_info = true,
}
    :flag("HEAT_IMMUME")
    :removes_effect("onfire")
    :blocks_effect("blisters")
    :enchantment("INLINE_ENCH_effect_flame_immunity_0"))
