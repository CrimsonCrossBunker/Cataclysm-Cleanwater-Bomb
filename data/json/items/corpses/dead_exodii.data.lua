local ccb = require("ccb")

ccb.content.define_item {
    id = "broken_exodii_worker",
    symbol = ",",
    color = "light_gray",
    name = ccb.content.plural_text("broken Exodii worker", "broken Exodii workers"),
    category = "other",
    description = ccb.content.text("A broken Exodii worker.  It's possible it could be gutted for parts."),
    price = "10 USD",
    materials = { "qt_steel" },
    volume = "119 L",
    mass = "221 kg",
    flags = { "TRADER_AVOID", "NO_REPAIR" },
}

ccb.content.define_item {
    id = "broken_exodii_quad",
    symbol = ",",
    color = "light_gray",
    name = ccb.content.plural_text("broken Exodii quadruped", "broken Exodii quadrupeds"),
    category = "other",
    description = ccb.content.text("A broken Exodii walker.  Still looks intimidating despite being permanently inoperative, possibly due to the sheer size and mass.  Could be gutted for parts."),
    price = "10 USD",
    materials = { "qt_steel" },
    volume = "410 L",
    mass = "498 kg",
    flags = { "TRADER_AVOID", "NO_REPAIR" },
}
