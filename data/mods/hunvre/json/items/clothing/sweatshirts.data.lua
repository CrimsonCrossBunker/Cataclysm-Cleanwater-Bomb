local ccb = require("ccb")

ccb.content.define_item {
    id = "sweatshirt",
    symbol = "[",
    color = "blue",
    looks_like = "longshirt",
    name = ccb.content.text("sweatshirt"),
    description = ccb.content.text("Warm garment that covers the torso."),
    materials = { "nylon" },
    mass = "400 g",
    volume = "400 ml",
    price = "1 USD",
    survival_price = "50 cent",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "OUTER" },
    armor = {
        warmth = 5,
        thickness = 1,
        portions = {
            { coverage = 100, covers = { "torso" } },
            { coverage = 100, covers = { "arm_l", "arm_r" } },
        },
    },
}

ccb.content.define_item {
    id = "hoodie",
    copy_from = "sweatshirt",
    name = ccb.content.text("hoodie"),
    description = ccb.content.text("Warm garment that covers the torso.  It has a hood and a front pocket to warm your hands."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "3 L",
            mass_limit = "4 kg",
            max_item_length = "36 cm",
            moves = 80,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "HOOD", "POCKETS" } }, scale = { mass = 1.1, volume = 1.1 } },
}

ccb.content.define_item {
    id = "zip_hoodie",
    copy_from = "sweatshirt",
    name = ccb.content.text("zip-up hoodie"),
    description = ccb.content.text("Warm garment that covers the torso.  It has a hood."),
    armor = {},
    inheritance = { add = { flags = { "HOOD" } }, scale = { mass = 1.1, volume = 1.1 } },
}
