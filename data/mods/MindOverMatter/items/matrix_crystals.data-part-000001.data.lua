local ccb = require("ccb")

ccb.content.define_item {
    id = "matrix_crystal_biokinesis_artifact",
    category = "artifacts",
    name = ccb.content.plural_text("strange crystal, pink", "strange crystal, pink"),
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing pink light in its depths.  Holding it, you feel more capable."),
    color = "pink",
    symbol = "+",
    volume = "10 ml",
    mass = "150 g",
    length = "21 mm",
    materials = { "nether_crystal" },
    looks_like = "matrix_crystal_biokinesis",
    flags = { "MATRIX_CRYSTAL_BIOKINESIS", "RELIC_PINK" },
    artifact = {},
}

ccb.content.define_item {
    id = "matrix_crystal_clairsentience_artifact",
    category = "artifacts",
    name = ccb.content.plural_text("strange crystal, gray", "strange crystal, gray"),
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing gray light in its depths.  Holding it, you feel more perceptive."),
    color = "dark_gray",
    symbol = "+",
    volume = "10 ml",
    mass = "150 g",
    length = "21 mm",
    materials = { "nether_crystal" },
    looks_like = "matrix_crystal_clairsentience",
    flags = { "MATRIX_CRYSTAL_CLAIRSENTIENCE", "RELIC_PINK" },
    artifact = {},
}

ccb.content.define_item {
    id = "matrix_crystal_electrokinesis_artifact",
    category = "artifacts",
    name = ccb.content.plural_text("strange crystal, cyan", "strange crystal, cyan"),
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing cyan light in its depths.  Holding it, you feel more energetic."),
    color = "cyan",
    symbol = "+",
    volume = "10 ml",
    mass = "150 g",
    length = "21 mm",
    materials = { "nether_crystal" },
    looks_like = "matrix_crystal_electrokinesis",
    flags = { "MATRIX_CRYSTAL_ELECTROKINESIS", "RELIC_PINK" },
    artifact = {},
}

ccb.content.define_item {
    id = "matrix_crystal_photokinesis_artifact",
    category = "artifacts",
    name = ccb.content.plural_text("strange crystal, golden", "strange crystal, golden"),
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing golden light in its depths.  Holding it, you feel radiant."),
    color = "dark_gray",
    symbol = "+",
    volume = "10 ml",
    mass = "150 g",
    length = "21 mm",
    materials = { "nether_crystal" },
    looks_like = "matrix_crystal_photokinesis",
    flags = { "MATRIX_CRYSTAL_PHOTOKINESIS", "RELIC_PINK" },
    artifact = {},
}
