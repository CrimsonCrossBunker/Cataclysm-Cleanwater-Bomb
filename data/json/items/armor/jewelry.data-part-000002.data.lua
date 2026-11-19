local ccb = require("ccb")

ccb.content.define_item {
    id = "bead_necklace",
    name = ccb.content.plural_text("beaded necklace", "beaded necklaces"),
    description = ccb.content.text("A simple necklace made of string and wooden beads.  Also doubles as a set of prayer beads, if you're so inclined."),
    looks_like = "silver_necklace",
    mass = "18 g",
    volume = "30 ml",
    price = "1 USD",
    survival_price = "10 cent",
    materials = { "wood" },
    symbol = "u",
    color = "brown",
    flags = { "NO_WEAR_EFFECT" },
    armor = {},
    use_actions = { "MEDITATE" },
}
