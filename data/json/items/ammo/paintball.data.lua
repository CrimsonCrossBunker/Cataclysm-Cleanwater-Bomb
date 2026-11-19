local ccb = require("ccb")

ccb.content.define_item {
    id = "paintball",
    price = "10 USD",
    survival_price = "50 cent",
    name = ccb.content.text("paintball"),
    symbol = "=",
    color = "red",
    description = ccb.content.text("A small paintball for recreational shooting.  Getting shot with one stings a little, but you'd be hard-pressed to kill anything with it."),
    ascii_picture = "paintball",
    materials = { "plastic" },
    volume = "250 ml",
    mass = "1 g",
    stack_size = 100,
    ammunition = {
        type = "paintball",
        damage = { type = "bash", amount = 2 },
        dispersion = 100,
        count = 100,
        loudness = 9,
        effects = { "NOGIB" },
    },
}
