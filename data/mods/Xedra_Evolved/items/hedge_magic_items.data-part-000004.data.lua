local ccb = require("ccb")

ccb.content.define_item {
    id = "item_hedge_astral_projection_cord",
    name = ccb.content.plural_text("[Ψ]silver cord", "[Ψ]silver cord"),
    description = ccb.content.text("A thin silver cord, stretching off into the distance, connecting you to your body.  You could follow it back to return."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    symbol = "[",
    color = "light_gray",
    flags = {
        "PERSONAL", "UNBREAKABLE", "ZERO_WEIGHT", "ALLOWS_NATURAL_ATTACKS", "INTEGRATED", "PADDED",
        "SEMITANGIBLE", "WATER_FRIENDLY", "NO_DROP",
    },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { environmental_protection = 0 },
}
