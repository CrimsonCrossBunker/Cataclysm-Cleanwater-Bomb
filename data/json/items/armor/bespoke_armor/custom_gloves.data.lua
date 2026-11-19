local ccb = require("ccb")

ccb.content.define_item {
    id = "gloves_survivor",
    category = "armor",
    name = ccb.content.plural_text("handmade hazard gloves (pair)", "handmade hazard gloves (pair)"),
    description = ccb.content.text("A pair of tough canvas gloves sealed with rubber.  Overall flexibility is lowered, but this makes them quite resistant to chemical hazards."),
    mass = "230 g",
    volume = "350 ml",
    survival_price = "20 USD",
    materials = { "canvas", "rubber" },
    symbol = "[",
    looks_like = "fire_gauntlets",
    color = "brown",
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "SOFT" },
    armor = {
        warmth = 35,
        thickness = 3,
        environmental_protection = 10,
        portions = {
            {
                materials = {
                    { id = "canvas", coverage = 100, thickness = 1.5 },
                    { id = "rubber", coverage = 100, thickness = 0.2 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 25,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_survivor",
    copy_from = "gloves_survivor",
    name = ccb.content.plural_text("handmade hazard gloves (pair)", "handmade hazard gloves (pair)"),
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gloves_survivor",
    copy_from = "gloves_survivor",
    name = ccb.content.plural_text("handmade hazard gloves (pair)", "handmade hazard gloves (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gloves_wsurvivor",
    category = "armor",
    name = ccb.content.plural_text("handmade winter gauntlets (pair)", "handmade winter gauntlets (pair)"),
    description = ccb.content.text("Handmade waterproof gloves made of a durably woven cotton lined with fur and a canvas outer layer.  Restrictive, warm, and tough."),
    mass = "300 g",
    volume = "500 ml",
    survival_price = "25 USD",
    materials = { "cotton", "fur", "canvas" },
    symbol = "[",
    looks_like = "gloves_winter",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    armor = {
        warmth = 70,
        thickness = 3,
        environmental_protection = 5,
        portions = {
            {
                materials = {
                    { id = "cotton_quilted", coverage = 100, thickness = 1.0 },
                    { id = "fur", coverage = 100, thickness = 0.5 },
                    { id = "fur", coverage = 95, thickness = 0.5 },
                    { id = "canvas", coverage = 100, thickness = 0.5 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 30,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_wsurvivor",
    name = ccb.content.plural_text("handmade winter gauntlets (pair)", "handmade winter gauntlets (pair)"),
    copy_from = "gloves_wsurvivor",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gloves_wsurvivor",
    copy_from = "gloves_wsurvivor",
    name = ccb.content.plural_text("handmade winter gauntlets (pair)", "handmade winter gauntlets (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}

ccb.content.define_item {
    id = "gloves_wsurvivor_nofur",
    name = ccb.content.plural_text("handmade faux fur winter gauntlets (pair)", "handmade faux fur winter gauntlets (pair)"),
    description = ccb.content.text("Handmade waterproof gloves made of a durably woven cotton lined with faux fur and a canvas outer layer.  Restrictive, warm, and tough."),
    mass = "300 g",
    volume = "500 ml",
    survival_price = "25 USD",
    materials = { "cotton", "faux_fur", "canvas" },
    symbol = "[",
    looks_like = "gloves_winter",
    color = "light_gray",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    armor = {
        warmth = 70,
        thickness = 3,
        environmental_protection = 5,
        portions = {
            {
                materials = {
                    { id = "cotton_quilted", coverage = 100, thickness = 1.0 },
                    { id = "faux_fur", coverage = 100, thickness = 0.5 },
                    { id = "faux_fur", coverage = 95, thickness = 0.5 },
                    { id = "canvas", coverage = 100, thickness = 0.5 },
                },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 30,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_gloves_wsurvivor_nofur",
    name = ccb.content.plural_text("handmade faux fur winter gauntlets (pair)", "handmade faux fur winter gauntlets (pair)"),
    copy_from = "gloves_wsurvivor_nofur",
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, scale = { mass = 1.5, volume = 1.5 } },
}

ccb.content.define_item {
    id = "xs_gloves_wsurvivor_nofur",
    copy_from = "gloves_wsurvivor_nofur",
    name = ccb.content.plural_text("handmade faux fur winter gauntlets (pair)", "handmade faux fur winter gauntlets (pair)"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
