local ccb = require("ccb")

ccb.content.define_item {
    id = "spike",
    name = ccb.content.plural_text("spike", "spikes"),
    description = ccb.content.text("A large and slightly misshapen metal spike, could do some damage mounted on a vehicle."),
    category = "spare_parts",
    mass = "550 g",
    color = "light_gray",
    symbol = ";",
    materials = { "steel" },
    volume = "250 ml",
    flags = { "ALLOWS_BODY_BLOCK", "PUNCTURE_VEHICLE_WHEELS" },
    qualities = { { id = "BUTCHER", level = -42 } },
    survival_price = "10 cent",
    accuracy = { grip = "bad", length = "hand", surface = "point", balance = "neutral" },
    melee_damage = { bash = 2, stab = 6 },
    weapon_categories = { "SHIVS" },
    stackable = true,
}
