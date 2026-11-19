local ccb = require("ccb")

ccb.content.define_item {
    id = "crown_golden",
    name = ccb.content.text("golden crown"),
    description = ccb.content.text("A delicate golden crown featuring flowering trees."),
    mass = "1000 g",
    volume = "1 L",
    price = "300 USD",
    survival_price = "1 USD",
    materials = { "gold" },
    symbol = "[",
    looks_like = "hat_cotton",
    color = "yellow",
    armor = { thickness = 2, portions = { { encumbrance = 20, coverage = 30, covers = { "head" } } } },
}

ccb.content.define_item {
    id = "crown_golden_survivor",
    name = ccb.content.text("golden crown"),
    description = ccb.content.text("A golden crown for the monarch of survivors."),
    mass = "1000 g",
    volume = "1 L",
    price = "300 USD",
    survival_price = "1 USD 50 cent",
    materials = { "gold" },
    symbol = "[",
    looks_like = "crown_golden",
    color = "yellow",
    armor = { thickness = 2, portions = { { encumbrance = 20, coverage = 30, covers = { "head" } } } },
}

ccb.content.define_item {
    id = "mouthpiece",
    category = "armor",
    name = ccb.content.text("protective mouthpiece"),
    description = ccb.content.text("A protective piece of equipment commonly used by athletes, worn inside the mouth to protect your teeth."),
    mass = "20 g",
    volume = "430 ml",
    price = "8 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "[",
    color = "yellow",
    flags = { "VARSIZE", "STURDY", "WATER_FRIENDLY", "SKINTIGHT", "POWERARMOR_COMPATIBLE", "PADDED" },
    melee_damage = { bash = 2 },
    armor = { thickness = 1, portions = { { coverage = 50, covers = { "mouth" }, rigid_only = true } } },
}

ccb.content.define_item {
    id = "tie_skinny",
    name = ccb.content.text("skinny tie"),
    description = ccb.content.text("A skinny black and white checkered necktie."),
    mass = "12 g",
    volume = "50 ml",
    price = "7 USD 50 cent",
    survival_price = "10 cent",
    materials = { "cotton" },
    symbol = "[",
    color = "dark_gray",
    armor = {},
}
