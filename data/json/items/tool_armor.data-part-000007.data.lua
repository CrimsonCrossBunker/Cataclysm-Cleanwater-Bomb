local ccb = require("ccb")

-- Based on https://www.amazon.com/dp/B0798Q79RV
ccb.content.define_item {
    id = "binoculars",
    category = "tools",
    symbol = ";",
    color = "dark_gray",
    name = ccb.content.plural_text("binoculars", "binoculars"),
    description = ccb.content.text("A pair of optics with a neck strap attached.  Useful for seeing long distances.  Wearing this item or carrying it in your inventory will double the distance around you that is mapped during your travels.  You could also use them to focus the sunlight."),
    price = "34 USD",
    survival_price = "5 USD",
    materials = { { id = "plastic", portions = 9 }, { id = "glass" } },
    flags = { "ZOOM", "OVERSIZE", "BELTED", "ALLOWS_NATURAL_ATTACKS", "FIRESTARTER" },
    mass = "550 g",
    volume = "540 ml",
    length = "15 cm",
    accuracy = { grip = "solid", length = "hand", surface = "any", balance = "uneven" },
    melee_damage = { bash = 3 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        thickness = 2,
        portions = {
            {
                encumbrance = 2,
                coverage = 25,
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
            },
        },
    },
    use_actions = { { kind = "firestarter", moves = 1000, slow_moves = 25000, need_sunlight = true } },
}
