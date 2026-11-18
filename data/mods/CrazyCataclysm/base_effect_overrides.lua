local ccb = require("ccb")
local content = ccb.content

content.upsert_effect_type(content.EffectType {
    id = "mutagen_troglobite",
    name = ccb.content.text("Gamer Juice"),
    description = ccb.content.text("You consumed gamer primer."),
    blood_analysis_description = ccb.content.text("Gamer Primer Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Gamer Fuel"))
    :name(ccb.content.text("Gamer Thirst"))
    :description(ccb.content.text("Down in the dark corners of the new world.  That's where you belong."))
    :description(ccb.content.text("Deep and dark, your bones ache and twist."))
    :resist_trait("THRESH_TROGLOBITE")
    :modifier("hurt", "minimum", { base = 2 })
    :modifier("hurt", "maximum", { base = 3 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 150 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 })
    :modifier("strength", "amount", { per_intensity = 2 })
    :modifier("perception", "amount", { per_intensity = -2.5 })
    :modifier("dexterity", "amount", { per_intensity = 1 }))
