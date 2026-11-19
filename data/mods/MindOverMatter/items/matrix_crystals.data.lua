local ccb = require("ccb")

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
