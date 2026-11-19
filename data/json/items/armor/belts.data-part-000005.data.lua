local ccb = require("ccb")

ccb.content.define_item {
    id = "suspenders_cloth",
    name = ccb.content.plural_text("suspenders", "suspenders"),
    description = ccb.content.text("A pair of black suspenders, which reach over the wearer's shoulders and hook to their waist.  Gives a wonderful western feel!"),
    mass = "250 g",
    volume = "500 ml",
    price = "10 USD",
    survival_price = "25 cent",
    materials = { "cotton", "steel" },
    repair_like = "scarf",
    symbol = "#",
    looks_like = "leather_belt",
    color = "dark_gray",
    flags = { "BELTED", "WATER_FRIENDLY" },
    armor = {
        thickness = 1.5,
        portions = { { coverage = 50, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}

ccb.content.define_item {
    id = "suspenders_leather",
    name = ccb.content.plural_text("leather suspenders", "leather suspenders"),
    description = ccb.content.text("A pair of leather suspenders, which reach over the wearer's shoulders and hook to their waist.  Gives a wonderful western feel!"),
    materials = { "leather", "steel" },
    color = "brown",
    copy_from = "suspenders_cloth",
    armor = {},
}
