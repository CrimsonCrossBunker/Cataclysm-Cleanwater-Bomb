local ccb = require("ccb")

ccb.content.define_item {
    id = "calculator_watch",
    name = ccb.content.plural_text("calculator watch", "calculator watches"),
    description = "A watch with a built-in calculator, for when you need to determine exactly how many zombies are in that horde.",
    symbol = "[",
    color = "light_gray",
    category = "clothing",
    looks_like = "smart_watch",
    mass = "61 g",
    volume = "125 ml",
    price = "100 USD",
    survival_price = "1 USD 50 cent",
    flags = {
        "WATCH",
        "ALARMCLOCK",
        "BELTED",
        "FRAGILE",
        "ALLOWS_NATURAL_ATTACKS",
        "WATER_FRIENDLY",
        "OVERSIZE",
    },
    materials = {
        { id = "plastic", portions = 75 },
        { id = "aluminum", portions = 25 },
    },
    tool = {},
    armor = { sided = true },
    subtype_order = { "tool", "armor" },
}
