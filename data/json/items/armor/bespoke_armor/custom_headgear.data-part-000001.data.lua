local ccb = require("ccb")

ccb.content.define_item {
    id = "xl_helmet_nomad",
    copy_from = "helmet_nomad",
    name = ccb.content.text("nomad cowl"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_helmet_nomad",
    copy_from = "helmet_nomad",
    name = ccb.content.text("nomad cowl"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

-- Strictly speaking, this probably won't cover your neck or forehead, but for now it covers 100% for the purposes of environmental protection.
ccb.content.define_item {
    id = "hood_survivor",
    category = "armor",
    name = ccb.content.text("handmade traveler hood"),
    description = ccb.content.text("A sturdy leather hood.  While the loose material won't do much to protect you, it's fairly durable and can help protect from chemical attacks."),
    mass = "600 g",
    volume = "2 L",
    survival_price = "20 USD",
    materials = { "leather_treated", "vinyl" },
    symbol = "[",
    looks_like = "hood_rain",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "OUTER" },
    armor = {
        warmth = 15,
        thickness = 0.4,
        environmental_protection = 5,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 100, covers = { "head" } } },
    },
}

-- Strictly speaking, this probably won't cover your neck or forehead, but for now it covers 100% for the purposes of environmental protection.
ccb.content.define_item {
    id = "hood_wsurvivor",
    category = "armor",
    name = ccb.content.text("handmade winter traveler hood"),
    description = ccb.content.text("A sturdy leather hood lined with fur for warmth.  While the loose material won't do much to protect you, it's fairly durable and can help protect from chemical attacks."),
    mass = "870 g",
    volume = "1500 ml",
    survival_price = "25 USD",
    materials = { "leather_treated", "fur", "vinyl" },
    symbol = "[",
    looks_like = "hood_survivor",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "OUTER" },
    armor = {
        warmth = 70,
        thickness = 0.6,
        environmental_protection = 5,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 100, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "xl_hood_wsurvivor",
    copy_from = "hood_wsurvivor",
    name = ccb.content.text("handmade winter traveler hood"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hood_wsurvivor",
    copy_from = "hood_wsurvivor",
    name = ccb.content.text("handmade winter traveler hood"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hood_xlsurvivor",
    copy_from = "hood_survivor",
    name = ccb.content.text("handmade traveler hood"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "hood_xssurvivor",
    copy_from = "hood_survivor",
    name = ccb.content.text("handmade traveler hood"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "hood_wsurvivor_nofur",
    name = ccb.content.text("handmade faux fur traveler hood"),
    description = ccb.content.text("A sturdy leather hood lined with faux fur for warmth.  While the loose material won't do much to protect you, it's fairly durable and can help protect from chemical attacks."),
    copy_from = "hood_wsurvivor",
    materials = { "leather_treated", "fur", "vinyl" },
    symbol = "[",
    looks_like = "hood_wsurvivor",
    color = "pink",
    armor = {},
}

ccb.content.define_item {
    id = "xl_hood_wsurvivor_nofur",
    copy_from = "hood_wsurvivor_nofur",
    name = ccb.content.text("handmade faux fur traveler hood"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_hood_wsurvivor_nofur",
    copy_from = "hood_wsurvivor_nofur",
    name = ccb.content.text("handmade faux fur traveler hood"),
    flags = { "UNDERSIZE", "PREFIX_XS" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}
