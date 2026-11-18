local ccb = require("ccb")
local content = ccb.content

content.upsert_effect_type(content.EffectType {
    id = "visuals",
    name = ccb.content.text("Hallucinating"),
    description = ccb.content.text("You can't trust everything that you see."),
    blood_analysis_description = ccb.content.text("Hallucinations"),
    rating = "bad",
}
    :resist_effect("relative_physics")
    :modifier("intelligence", "amount", { base = -2 })
    :modifier("dexterity", "amount", { base = -1 })
    :modifier("perception", "amount", { base = -4 }))

content.upsert_effect_type(content.EffectType {
    id = "hallu",
    blood_analysis_description = ccb.content.text("Hallucinations"),
    maximum_duration_turns = 21600,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :resist_effect("relative_physics")
    :limb_score("reaction", { multiplier = 0.8, per_intensity = -0.2 })
    :limb_score("block", { multiplier = 0.8, per_intensity = -0.2 }))
