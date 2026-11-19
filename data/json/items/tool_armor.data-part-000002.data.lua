local ccb = require("ccb")

ccb.content.define_item {
    id = "ear_plugs",
    name = ccb.content.plural_text("ear plugs (pair)", "ear plugs (pair)"),
    description = ccb.content.text("Industrial-grade ear plugs.  They fit inside the ears."),
    mass = "10 g",
    volume = "10 ml",
    price = "10 cent",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = ";",
    color = "light_gray",
    flags = { "DEAF", "OVERSIZE", "POWERARMOR_COMPATIBLE" },
    armor = { thickness = 1 },
}

ccb.content.define_item {
    id = "leg_splint",
    name = ccb.content.text("leg splint"),
    description = ccb.content.text("A tool to help set leg bones and hold them in place."),
    mass = "500 g",
    volume = "1 L",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "wood", "cotton" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "white",
    flags = { "WATER_FRIENDLY", "OUTER", "SPLINT", "ALLOWS_TAIL" },
    armor = {
        sided = true,
        warmth = 5,
        thickness = 1,
        portions = { { encumbrance = 70, coverage = 75, covers = { "leg_l", "leg_r" } } },
    },
}

ccb.content.define_item {
    id = "leg_xlsplint",
    name = ccb.content.text("leg splint"),
    description = ccb.content.text("A tool to help set leg bones and hold them in place.  It is specifically designed to fit Huge people."),
    copy_from = "leg_splint",
    mass = "1000 g",
    volume = "2 L",
    price = "250 USD",
    survival_price = "50 cent",
    materials = { "wood", "cotton" },
    flags = { "OVERSIZE", "PREFIX_XL", "WATER_FRIENDLY", "OUTER", "SPLINT", "ALLOWS_TAIL" },
    armor = {},
}

ccb.content.define_item {
    id = "leg_xs_splint",
    name = ccb.content.text("leg splint"),
    description = ccb.content.text("A tool to help set leg bones and hold them in place.  It is specifically designed to fit Tiny people."),
    copy_from = "leg_splint",
    mass = "250 g",
    volume = "500 ml",
    price = "250 USD",
    survival_price = "50 cent",
    flags = { "UNDERSIZE", "PREFIX_XS", "WATER_FRIENDLY", "OUTER", "SPLINT", "ALLOWS_TAIL" },
    armor = {},
}
