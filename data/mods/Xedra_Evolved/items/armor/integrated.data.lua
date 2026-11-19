local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_riastrad_item",
    category = "armor",
    name = ccb.content.plural_text("Ríastrad", "Ríastrad"),
    description = ccb.content.text("Your foes shall fall."),
    mass = "0 g",
    volume = "0 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "fae_flesh" },
    symbol = ",",
    color = "red",
    techniques = { "CHANGELING_RIASTRAD_KNOCKBACK", "CHANGELING_RIASTRAD_STUN" },
    flags = {
        "INTEGRATED", "SEMITANGIBLE", "ZERO_WEIGHT", "PROVIDES_TECHNIQUES", "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE", "PERSONAL", "SOFT", "TRADER_AVOID",
    },
    armor = {},
}
