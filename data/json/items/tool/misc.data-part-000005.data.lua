local ccb = require("ccb")

ccb.content.define_item {
    id = "survival_marker",
    name = ccb.content.plural_text("survival marker", "survival markers"),
    description = ccb.content.text("A sharpened piece of charcoal used as an improvised pencil.  Almost guaranteed to get your hands all covered in charcoal.  Activate it to write something down."),
    mass = "113 g",
    volume = "15 ml",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "charcoal" },
    symbol = ",",
    color = "dark_gray",
    flags = { "WRITE_MESSAGE" },
    tool = { initial_charges = 100, max_charges = 100, charges_per_use = 1 },
    use_actions = {
        {
            kind = "inscribe",
            verb = ccb.content.text("Write"),
            gerund = ccb.content.text("Written"),
            on_terrain = true,
            material_restricted = false,
        },
    },
}

ccb.content.define_item {
    id = "spray_can",
    name = "spray can",
    description = "An aerosol spray can filled with paint.  Activate it to make graffiti on the floor.",
    symbol = ";",
    color = "light_gray",
    mass = "340 g",
    volume = "250 ml",
    length = "21 cm",
    price = "5 USD",
    survival_price = "10 cent",
    flags = { "WRITE_MESSAGE", "NO_RELOAD", "NO_UNLOAD" },
    materials = { "aluminum" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            watertight = true,
            ammunition = { aerosol_paint = 10 },
        },
    },
    use_actions = {
        "SPRAY_CAN",
        { kind = "paint_vehicle" },
    },
    tool = { charges_per_use = 1 },
}
