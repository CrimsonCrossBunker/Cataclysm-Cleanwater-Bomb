local ccb = require("ccb")

ccb.content.define_item {
    id = "broken_exodii_quad_jotunn",
    symbol = ",",
    color = "light_gray",
    name = ccb.content.plural_text("broken Exodii quadruped", "broken Exodii quadrupeds"),
    category = "other",
    description = ccb.content.text("A broken Exodii Jotunn walker.  Still looks incredibly intimidating despite being permanently inoperative, due to the sheer size, mass, and protruding weapons.  Could be gutted for parts."),
    price = "10 USD",
    materials = { "qt_steel" },
    volume = "410 L",
    mass = "498 kg",
    flags = { "TRADER_AVOID", "NO_REPAIR" },
    melee_damage = { bash = 20, cut = 15 },
}
