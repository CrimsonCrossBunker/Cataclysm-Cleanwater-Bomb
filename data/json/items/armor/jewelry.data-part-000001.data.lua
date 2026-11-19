local ccb = require("ccb")

ccb.content.define_item {
    id = "bead_ear",
    name = ccb.content.plural_text("beaded earrings (pair)", "beaded earrings (pair)"),
    description = ccb.content.text("A simple pair of earrings made of string and wooden beads."),
    mass = "600 mg",
    volume = "1 ml",
    price = "1 USD",
    survival_price = "10 cent",
    materials = { "wood" },
    symbol = "[",
    looks_like = "gold_ear",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
}
