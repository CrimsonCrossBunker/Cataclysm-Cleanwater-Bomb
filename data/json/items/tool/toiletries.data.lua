local ccb = require("ccb")

ccb.content.define_item {
    id = "bathroom_scale",
    name = "bathroom scale",
    description = "A small bathroom scale, meant to weigh a person while naked.",
    symbol = "_",
    color = "light_gray",
    mass = "1200 g",
    volume = "2250 ml",
    length = "30 cm",
    price = "5 USD",
    survival_price = "50 cent",
    flags = { "ALLOWS_REMOTE_USE" },
    materials = { "steel" },
    melee_damage = { bash = 6 },
    use_actions = {
        { kind = "weigh_self", max_weight = "150 kg" },
    },
    tool = {},
}

ccb.content.define_item {
    id = "hair_dye_kit",
    name = "hair dye kit",
    description = "A kit featuring all the tools needed to dye hair, including an applicator brush, combs, and plastic gloves.",
    symbol = ")",
    color = "brown",
    ascii_picture = "box_small",
    mass = "154 g",
    volume = "2250 ml",
    length = "21 cm",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "cardboard", "plastic" },
    tool = {},
}
