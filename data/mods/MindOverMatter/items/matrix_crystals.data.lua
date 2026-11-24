local ccb = require("ccb")

ccb.content.define_item {
    id = "matrix_crystal_biokinesis",
    category = "artifacts",
    name = ccb.content.plural_text("strange crystal, pink", "strange crystal, pink"),
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing pink light in its depths.  Holding it, you feel more capable."),
    color = "pink",
    symbol = "+",
    volume = "10 ml",
    mass = "150 g",
    length = "21 mm",
    materials = { "nether_crystal" },
    looks_like = "art_crystal",
    flags = { "MATRIX_CRYSTAL_BIOKINESIS", "RELIC_PINK" },
    tool = {},
}

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

ccb.content.define_item {
    id = "matrix_crystal_pyrokinesis",
    name = ccb.content.plural_text("strange crystal, red", "strange crystal, red"),
    copy_from = "matrix_crystal_biokinesis",
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing red light in its depths.  Holding it, you feel hot."),
    color = "red",
    flags = { "MATRIX_CRYSTAL_PYROKINESIS", "RELIC_PINK" },
    tool = {},
}

ccb.content.define_item {
    id = "matrix_crystal_pyrokinesis_artifact",
    category = "artifacts",
    name = ccb.content.plural_text("strange crystal, red", "strange crystal, red"),
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing red light in its depths.  Holding it, you feel hot."),
    color = "red",
    symbol = "+",
    volume = "10 ml",
    mass = "150 g",
    length = "21 mm",
    materials = { "nether_crystal" },
    looks_like = "matrix_crystal_pyrokinesis",
    flags = { "MATRIX_CRYSTAL_PYROKINESIS", "RELIC_PINK" },
    artifact = {},
}

ccb.content.define_item {
    id = "matrix_crystal_telekinesis_artifact",
    category = "artifacts",
    name = ccb.content.plural_text("strange crystal, yellow", "strange crystal, yellow"),
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing red light in its depths.  Holding it, you feel lighter."),
    color = "yellow",
    symbol = "+",
    volume = "10 ml",
    mass = "150 g",
    length = "21 mm",
    materials = { "nether_crystal" },
    looks_like = "matrix_crystal_telekinesis",
    flags = { "MATRIX_CRYSTAL_TELEKINESIS", "RELIC_PINK" },
    artifact = {},
}

ccb.content.define_item {
    id = "matrix_crystal_telepathy_artifact",
    category = "artifacts",
    name = ccb.content.plural_text("strange crystal, white", "strange crystal, white"),
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing blue light in its depths.  Holding it, you feel more mobile."),
    color = "white",
    symbol = "+",
    volume = "10 ml",
    mass = "150 g",
    length = "21 mm",
    materials = { "nether_crystal" },
    looks_like = "matrix_crystal_telepathy",
    flags = { "MATRIX_CRYSTAL_TELEPATHY", "RELIC_PINK" },
    artifact = {},
}

ccb.content.define_item {
    id = "matrix_crystal_teleportation_artifact",
    category = "artifacts",
    name = ccb.content.plural_text("strange crystal, blue", "strange crystal, blue"),
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing blue light in its depths.  Holding it, you feel more mobile."),
    color = "blue",
    symbol = "+",
    volume = "10 ml",
    mass = "150 g",
    length = "21 mm",
    materials = { "nether_crystal" },
    looks_like = "matrix_crystal_teleportation",
    flags = { "MATRIX_CRYSTAL_TELEPORTATION", "RELIC_PINK" },
    artifact = {},
}

ccb.content.define_item {
    id = "matrix_crystal_vitakinesis_artifact",
    category = "artifacts",
    name = ccb.content.plural_text("strange crystal, green", "strange crystal, green"),
    description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing green light in its depths.  Holding it, you feel healthier."),
    color = "green",
    symbol = "+",
    volume = "10 ml",
    mass = "150 g",
    length = "21 mm",
    materials = { "nether_crystal" },
    looks_like = "matrix_crystal_vitakinesis",
    flags = { "MATRIX_CRYSTAL_VITAKINESIS", "RELIC_PINK" },
    artifact = {},
}
