local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "oneirosis_effect",
    name = ccb.content.text("16 Hz"),
    description = ccb.content.text("You feel awake, your thoughts are clear."),
    maximum_intensity = 100,
}
    :name(ccb.content.text("8 Hz"))
    :name(ccb.content.text("4 Hz"))
    :name(ccb.content.text("2 Hz"))
    :description(ccb.content.text("You catch yourself having vivid daydreams."))
    :description(ccb.content.text("Reality comes to you in what feels like snaps out of sleepwalks."))
    :description(ccb.content.text("You are trapped in a dream of which you are not the dreamer.")))

content.add(content.EffectType {
    id = "suffocation",
    name = ccb.content.text("Suffocating"),
    description = ccb.content.text("You try to breathe but nothing fills your lungs."),
    apply_message = ccb.content.text("You can't breathe!"),
    rating = "bad",
    maximum_intensity = 6,
}
    :flag("EFFECT_LIMB_SCORE_MOD")
    :limb_score("breathing", { multiplier = 0.8, per_intensity = -0.1 }))
