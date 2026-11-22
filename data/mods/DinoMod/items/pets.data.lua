local ccb = require("ccb")

ccb.content.define_item {
    id = "dino_carrier",
    name = "large pet carrier",
    description = "A sturdy reinforced plastic container meant to hold dinosaurs for transport.  Use it on a suitable animal to capture, use it on an empty tile to release.",
    symbol = "#",
    color = "light_gray",
    looks_like = "pet_carrier",
    mass = "10000 g",
    volume = "50 L",
    price = "20 USD",
    survival_price = "2 USD",
    flags = { "TRADER_AVOID" },
    materials = { "steel", "plastic" },
    melee_damage = { bash = 1, cut = 1 },
    properties = { creature_size_capacity = "HUGE" },
    use_actions = { "CAPTURE_MONSTER_ACT" },
    tool = {},
}

ccb.content.define_item {
    id = "dino_carrier_wooden",
    name = "large wooden pet carrier",
    description = "A sturdy reinforced wooden container meant to hold dinosaurs for transport.  Use it on a suitable animal to capture, use it on an empty tile to release.",
    symbol = "#",
    color = "brown",
    looks_like = "pet_carrier",
    mass = "15000 g",
    volume = "50 L",
    price = "16 USD",
    survival_price = "1 USD",
    flags = { "TRADER_AVOID" },
    materials = { "wood" },
    melee_damage = { bash = 1, cut = 1 },
    properties = { creature_size_capacity = "HUGE" },
    use_actions = { "CAPTURE_MONSTER_ACT" },
    tool = {},
}
