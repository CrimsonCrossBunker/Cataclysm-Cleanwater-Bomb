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
