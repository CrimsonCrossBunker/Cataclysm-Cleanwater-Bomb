local ccb = require("ccb")

ccb.content.define_item {
    id = "copper_circlet",
    name = "copper circlet",
    description = "A wooden band with copper trimmings to be worn on the head.  Touching your temples with it on makes you feel very calm.",
    symbol = "[",
    color = "brown",
    category = "armor",
    mass = "700 g",
    volume = "600ml",
    price = "15 USD",
    survival_price = "1 USD",
    flags = { "BELTED", "PADDED" },
    materials = { "copper", "wood" },
    qualities = {
        { id = "MANA_FOCUS", level = 1 },
    },
    armor = {
        thickness = 1,
        warmth = 0,
        portions = {
            {
                covers = { "head" },
                coverage = 5,
                encumbrance = 1,
            },
        },
    },
}

ccb.content.define_item {
    id = "silver_circlet",
    name = "silver circlet",
    description = "A wooden band with silver trimmings to be worn on the head.  Touching your temples with it on makes you feel very calm.",
    symbol = "[",
    color = "light_gray",
    category = "armor",
    mass = "700 g",
    volume = "600ml",
    price = "30 USD",
    survival_price = "2 USD",
    flags = { "BELTED", "PADDED" },
    materials = { "silver", "wood" },
    qualities = {
        { id = "MANA_FOCUS", level = 2, speed = 0.66 },
    },
    armor = {
        thickness = 1,
        warmth = 0,
        portions = {
            {
                covers = { "head" },
                coverage = 5,
                encumbrance = 1,
            },
        },
    },
}
