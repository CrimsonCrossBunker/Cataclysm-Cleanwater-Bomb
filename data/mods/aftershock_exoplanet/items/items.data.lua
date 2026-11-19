local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_titanium_watch",
    name = ccb.content.plural_text("titanium watch", "titanium watches"),
    description = ccb.content.text("A thick, masculine watch made out of titanium.  It is durable, light-weight and water-resistant, an excellent watch to have in a hostile environment."),
    mass = "50 g",
    volume = "250 ml",
    price = "200 USD",
    survival_price = "30 USD",
    accuracy = -1,
    materials = { "titanium" },
    symbol = "[",
    color = "light_gray",
    flags = { "WATCH", "STURDY", "BELTED", "ALLOWS_NATURAL_ATTACKS", "WATER_FRIENDLY", "OVERSIZE" },
    armor = { sided = true, portions = { { coverage = 5, covers = { "hand_l", "hand_r" } } } },
}

ccb.content.define_item {
    id = "afs_titanium_ring",
    name = ccb.content.text("titanium ring"),
    description = ccb.content.text("A thick, masculine ring made out of titanium.  Made in a variety of styles and finishes, they're valued for their durability."),
    mass = "13 g",
    volume = "5 ml",
    price = "7 USD",
    survival_price = "5 USD",
    materials = { "titanium" },
    symbol = "[",
    color = "light_gray",
    flags = { "STURDY" },
    armor = {},
}

ccb.content.define_item {
    id = "afs_glass_AR_device",
    name = ccb.content.text("glass headset"),
    description = ccb.content.text("This transparent lune of computation glass was once an incredibly versatile hypercloud access point.  It continues to display \"No Connection\" in ancient English script.  Although completely useless these sometimes gain popularity as a fashion accessory."),
    mass = "170 g",
    volume = "750 ml",
    price = "7 USD",
    survival_price = "5 USD",
    materials = { "glass" },
    symbol = "[",
    color = "light_gray",
    flags = { "STURDY", "OUTER" },
    armor = { portions = { { encumbrance = 5, coverage = 100, covers = { "eyes" } } }, thickness = 1 },
}
