local ccb = require("ccb")

-- ["https://www.amazon.co.uk/gp/product/B07GRNHPST", "Size: 6.88 x 4.75 x 1.73 cm"]
-- Open flame or effectively so. ~5 seconds to transfer flame assuming optimal conditions, a minute at worst.
-- USB 1/2 should take 2 hours for full
ccb.content.define_item {
    id = "electric_lighter",
    name = ccb.content.plural_text("electric lighter", "electric lighters"),
    description = ccb.content.text("A rechargeable electric lighter."),
    mass = "51 g",
    volume = "57 ml",
    length = "69 mm",
    price = "10 dollars",
    survival_price = "1 dollar",
    materials = { "plastic", "zinc" },
    symbol = ",",
    color = "blue",
    flags = { "FIRESTARTER", "NO_UNLOAD", "NO_RELOAD", "ELECTRONIC" },
    faults = { { group = "electronic_general" } },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 30 } } },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    use_actions = {
        { kind = "firestarter", moves = 500, slow_moves = 6000 },
        { kind = "link_up", cable_length = 3, charge_rate = "5 W" },
    },
}
