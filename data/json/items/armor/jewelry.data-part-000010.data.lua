local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- typical badges are 1-4 oz and are usually brass with a possible very thin precious metal plating.
ccb.content.define_item {
    id = "badge_abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("badge template"),
    description = ccb.content.text_without_extraction("This is a template for police/medical badges.  If found in a game, it is a bug."),
    mass = "60 g",
    volume = "8 ml",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "brass" },
    symbol = "[",
    color = "yellow",
    flags = { "ALLOWS_NATURAL_ATTACKS", "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = { thickness = 2 },
}
