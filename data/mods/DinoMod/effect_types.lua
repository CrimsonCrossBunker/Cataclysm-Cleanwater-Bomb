local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "u_met_yoshimi",
})

content.add(content.EffectType {
    id = "mutagen_stego",
    name = ccb.content.text("Stego Mutation"),
    description = ccb.content.text("You consumed stego mutagen."),
    blood_analysis_description = ccb.content.text("Stego Mutagen Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Stego Transformation"))
    :name(ccb.content.text("Stego Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of stego mutagen."))
    :description(ccb.content.text("You consumed a life-changing amount of stego mutagen."))
    :resist_trait("THRESH_STEGO")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "mutagen_horns",
    name = ccb.content.text("Horns Mutation"),
    description = ccb.content.text("You consumed horns mutagen."),
    blood_analysis_description = ccb.content.text("Horns Mutagen Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Horns Transformation"))
    :name(ccb.content.text("Horns Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of horns mutagen."))
    :description(ccb.content.text("You consumed a life-changing amount of horns mutagen."))
    :resist_trait("THRESH_HORNS")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))

content.add(content.EffectType {
    id = "mutagen_tyrant",
    name = ccb.content.text("Tyrant Mutation"),
    description = ccb.content.text("You consumed tyrant mutagen."),
    blood_analysis_description = ccb.content.text("Tyrant Mutagen Contamination"),
    maximum_intensity = 3,
    rating = "bad",
}
    :name(ccb.content.text("Tyrant Transformation"))
    :name(ccb.content.text("Tyrant Metamorphosis"))
    :description(ccb.content.text("You consumed a large amount of tyrant mutagen."))
    :description(ccb.content.text("You consumed a life-changing amount of tyrant mutagen."))
    :resist_trait("THRESH_TYRANT")
    :modifier("hurt", "minimum", { base = 1 })
    :modifier("hurt", "maximum", { base = 2 })
    :modifier("hurt", "chance_numerator", { base = -22, per_intensity = 21 })
    :modifier("hurt", "tick", { base = 75 })
    :modifier("pain", "minimum", { base = 1 })
    :modifier("pain", "maximum", { base = 2 })
    :modifier("pain", "chance_numerator", { base = 100, per_intensity = -30 })
    :modifier("pain", "tick", { base = 75 }))
