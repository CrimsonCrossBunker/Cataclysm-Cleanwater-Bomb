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
