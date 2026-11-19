local ccb = require("ccb")

ccb.content.define_item {
    id = "rebar_rail",
    name = ccb.content.text("rebar rail"),
    description = ccb.content.text("A short piece of ferromagnetic rebar which has been straightened and sharpened on one end.  Could be used as a projectile by a sufficiently powerful electromagnetic weapon."),
    mass = "236 g",
    length = "16 cm",
    volume = "300 ml",
    price = "10 USD",
    survival_price = "2 USD 50 cent",
    accuracy = -1,
    materials = { "steel" },
    symbol = "=",
    color = "light_gray",
    melee_damage = { bash = 5, cut = 1 },
    ammunition = {
        count = 10,
        type = "metal_rail",
        range = 40,
        damage = { type = "bullet", amount = 90, penetration = 40 },
        dispersion = 150,
        effects = { "RECYCLED", "NON_FOULING" },
    },
}

ccb.content.define_item {
    id = "steel_rail",
    copy_from = "rebar_rail",
    name = ccb.content.text("steel rail"),
    description = ccb.content.text("A short piece of steel which has been forged true and sharpened on one end.  Could be used as a projectile by a sufficiently powerful electromagnetic weapon."),
    mass = "212 g",
    volume = "270 ml",
    price = "15 USD",
    survival_price = "5 USD",
    materials = { "steel" },
    color = "light_gray",
    ammunition = { dispersion = 0, effects = { "NON_FOULING" } },
}
