local ccb = require("ccb")

ccb.content.define_item {
    id = "sharped_bone",
    category = "spare_parts",
    price = "10 USD",
    name = ccb.content.text("sharpened bone"),
    symbol = "=",
    color = "dark_gray",
    description = ccb.content.text("A sharp bone, you wonder why someone had the trouble to make this."),
    flags = { "TRADER_AVOID" },
    volume = "250ml",
    mass = "37 g",
    melee_damage = { bash = 6, cut = 2 },
    ammunition = {
        type = "barb",
        damage = { type = "stab", amount = 10, penetration = 10 },
        dispersion = 120,
        loudness = 0,
        count = 10,
        show_stats = true,
    },
}
