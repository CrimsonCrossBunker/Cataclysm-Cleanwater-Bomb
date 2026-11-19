local ccb = require("ccb")

ccb.content.define_item {
    id = "arm_splint",
    name = ccb.content.text("arm splint"),
    description = ccb.content.text("A tool to help set arm bones and hold them in place."),
    mass = "300 g",
    volume = "1 L",
    price = "200 USD",
    survival_price = "50 cent",
    materials = { "wood", "cotton" },
    symbol = "[",
    looks_like = "armguard_hard",
    color = "white",
    flags = { "WATER_FRIENDLY", "OUTER", "SPLINT" },
    armor = {
        sided = true,
        warmth = 8,
        thickness = 1,
        portions = { { encumbrance = 70, coverage = 75, covers = { "arm_l", "arm_r" } } },
    },
}

ccb.content.define_item {
    id = "arm_xlsplint",
    name = ccb.content.text("arm splint"),
    description = ccb.content.text("A tool to help set arm bones and hold them in place.  It is specifically designed to fit Huge survivors."),
    copy_from = "arm_splint",
    looks_like = "arm_splint",
    mass = "600 g",
    volume = "2 L",
    price = "250 USD",
    survival_price = "50 cent",
    materials = { "wood", "cotton" },
    flags = { "OVERSIZE", "PREFIX_XL", "WATER_FRIENDLY", "OUTER", "SPLINT" },
    armor = {},
}

ccb.content.define_item {
    id = "arm_xs_splint",
    name = ccb.content.text("arm splint"),
    description = ccb.content.text("A tool to help set arm bones and hold them in place.  It is specifically designed to fit Tiny survivors."),
    copy_from = "arm_splint",
    looks_like = "arm_splint",
    mass = "150 g",
    volume = "500 ml",
    price = "150 USD",
    survival_price = "50 cent",
    flags = { "UNDERSIZE", "PREFIX_XS", "WATER_FRIENDLY", "OUTER", "SPLINT" },
    armor = {},
}
