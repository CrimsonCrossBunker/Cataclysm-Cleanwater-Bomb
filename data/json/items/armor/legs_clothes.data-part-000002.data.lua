local ccb = require("ccb")

ccb.content.define_item {
    id = "jeans_ripped",
    name = ccb.content.plural_text("ripped jeans", "ripped jeans"),
    description = ccb.content.text("A pair of jeans that has been ripped over the knees.  It may have been fashionable before Cataclysm, but it's just a pair of sub-par jeans now."),
    mass = "580 g",
    volume = "2 L",
    price = "50 USD",
    survival_price = "1 USD",
    materials = { "denim" },
    symbol = "[",
    looks_like = "jeans",
    color = "light_blue",
    faults = { { group = "fabric_denim" } },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1250 ml",
            mass_limit = "4 kg",
            max_item_length = "19 cm",
            moves = 80,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
        {
            kind = "CONTAINER",
            capacity = "1080 ml",
            mass_limit = "4 kg",
            max_item_length = "165 mm",
            moves = 100,
        },
    },
    flags = { "VARSIZE", "POCKETS" },
    armor = {
        portions = {
            {
                encumbrance = { 7, 11 },
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = {
                    "leg_hip_l",
                    "leg_upper_l",
                    "leg_lower_l",
                    "leg_hip_r",
                    "leg_upper_r",
                    "leg_lower_r",
                },
            },
            {
                encumbrance = { 0, 0 },
                coverage = 20,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_knee_l", "leg_knee_r" },
            },
        },
        warmth = 8,
        thickness = 0.65,
    },
}
