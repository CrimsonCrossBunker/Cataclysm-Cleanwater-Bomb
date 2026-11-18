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
