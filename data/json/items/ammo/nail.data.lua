local ccb = require("ccb")

ccb.content.define_item {
    id = "combatnail",
    name = ccb.content.text("flechette"),
    copy_from = "nail",
    description = ccb.content.text("A tiny steel dart.  Can be fired from a nail gun or similar weapon, or used for crafting ammunition."),
    ascii_picture = "combatnail",
    materials = { "steel" },
    symbol = "=",
    color = "dark_gray",
    inheritance = { scale = { price = 3.0 } },
    ammunition = {
        loudness = 0,
        range = 6,
        damage = { type = "bullet", amount = 6, penetration = 3 },
        dispersion = 90,
    },
}

ccb.content.define_item {
    id = "bronze_nail",
    name = ccb.content.text("bronze nail"),
    copy_from = "nail",
    description = ccb.content.text("A pin-shaped piece of bronze.  It can be used to construct various things with a hammer."),
    materials = { "bronze" },
    ammunition = {},
}

-- stats from 4.5 inch nail, aka 30d
ccb.content.define_item {
    id = "nail",
    category = "spare_parts",
    name = ccb.content.text("nail"),
    description = ccb.content.text("A pin-shaped piece of steel.  It can be used to construct various things with a hammer."),
    ascii_picture = "nail",
    mass = "20 g",
    volume = "3 ml",
    length = "115 mm",
    price = "1 USD 11 cent",
    survival_price = "2 cent",
    flags = { "PUNCTURE_VEHICLE_WHEELS" },
    materials = { "lc_steel" },
    symbol = "=",
    color = "cyan",
    stack_size = 1,
    stackable = true,
    ammunition = {
        count = 1,
        type = "nail",
        loudness = 0,
        range = 3,
        damage = { type = "bullet", amount = 3, penetration = 1 },
        dispersion = 180,
        effects = { "NON_FOULING", "HURT_WHEN_WIELDED" },
    },
}

ccb.content.define_item {
    id = "rivets",
    category = "spare_parts",
    name = ccb.content.text("rivet"),
    description = ccb.content.text("A solid rivet, outdated, unless you plan on doing medieval smithing."),
    mass = "4 g",
    volume = "250 ml",
    survival_price = "1 USD 50 cent",
    materials = { "lc_steel" },
    symbol = "=",
    color = "cyan",
    stack_size = 100,
    stackable = true,
    ammunition = { type = "rivets", count = 100 },
}
