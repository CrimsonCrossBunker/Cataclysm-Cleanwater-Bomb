local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "dragon_terror_debuff",
    name = ccb.content.text("Dragon Terror"),
    description = ccb.content.text("You are uneasy and fearful from a Dragon's mighty presence"),
    rating = "bad",
    maximum_intensity = 20,
}
    :modifier("speed", "amount", { base = -20 }))

content.add(content.EffectType {
    id = "dragon_boost",
    name = ccb.content.text("Dragon Boost"),
    description = ccb.content.text("You are filled with the power of Dragons."),
    apply_message = ccb.content.text("You let out a mighty roar as you are filled with the power of Dragons!"),
    remove_message = ccb.content.text("The Draconic energy fades from within you."),
    rating = "good",
}
    :modifier("strength", "amount", { base = 4 })
    :modifier("speed", "amount", { base = 10 })
    :modifier("stamina", "minimum", { base = 20 }))

content.add(content.EffectType {
    id = "dragon_acidburn",
    name = "Dragon Acid burn",
    description = "Burned with a black dragon's acid",
    maximum_intensity = 4,
    intensity_add_value = 1,
}
    :modifier("speed", "amount", { base = -20, per_intensity = -10 })
    :modifier("pain", "amount", { base = 20, per_intensity = 10 })
    :modifier("hurt", "amount", { base = 3, per_intensity = 1 }))

content.add(content.EffectType {
    id = "lesser_dragon_acidburn",
    name = "Lesser Dragon Acid burn",
    description = "Burned with a less potent version of a black dragon's acid",
    maximum_intensity = 4,
    intensity_add_value = 1,
}
    :modifier("speed", "amount", { base = -10, per_intensity = -5 })
    :modifier("pain", "amount", { base = 10, per_intensity = 5 })
    :modifier("hurt", "amount", { base = 1, per_intensity = 1 }))

content.add(content.EffectType {
    id = "effect_biomancer_npc_wretch_polymorph",
    name = "Fleshwarped Wretch NPC penalties",
    description = "Limb score penalties from being fleshwarped",
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("manip", { multiplier = 0.2 })
    :limb_score("grip", { multiplier = 0.2 })
    :limb_score("block", { multiplier = 0.4 })
    :limb_score("lift", { multiplier = 0.2 })
    :limb_score("crawl", { multiplier = 0.5 })
    :limb_score("breathing", { multiplier = 0.6 }))
