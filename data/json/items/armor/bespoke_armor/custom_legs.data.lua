local ccb = require("ccb")

-- weight is currently an estimation could be better
ccb.content.define_item {
    id = "armor_mercenary_bottom",
    name = ccb.content.plural_text("mercenary pants", "mercenary pants"),
    description = ccb.content.text("A sturdy pair of pants fit for a soldier of fortune.  Made from work pants padded with Kevlar panels.  It gives good protection and decent storage, but the added thickness makes it uncomfortable to wear any armor over it."),
    mass = "3 kg",
    volume = "7500 ml",
    price = "1 kUSD 800 USD",
    survival_price = "20 USD",
    materials = { "kevlar_layered", "canvas" },
    symbol = "[",
    looks_like = "pants_army",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "5 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "5 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "5 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "5 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    flags = { "POCKETS", "STURDY", "WATERPROOF", "OUTER", "NORMAL" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "canvas", coverage = 100, thickness = 0.5 },
                    { id = "kevlar_layered", coverage = 90, thickness = 4.4 },
                },
                volume_encumbrance = 0.3,
                encumbrance = 9,
                coverage = 100,
                vitals_coverage = 90,
                covers = { "leg_l", "leg_r" },
            },
        },
        warmth = 25,
        thickness = 5,
        valid_mods = { "steel_padded" },
        environmental_protection = 2,
    },
}
