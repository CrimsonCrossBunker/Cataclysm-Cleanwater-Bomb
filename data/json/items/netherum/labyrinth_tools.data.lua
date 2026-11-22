local ccb = require("ccb")

ccb.content.define_item {
    id = "nl_laser_mass_indexer",
    name = "laser-guided measurement device",
    description = "At first glance this appears to be a set of calipers, with the ability to open and close via a spring-loaded handle.  The tips of the pincers each emit a laser that always meet in the center.  On one side of the handle is a small screen that displays various numbers; while you don't recognize most of them, you do notice grams and pounds are displayed, albeit not next to each other.",
    symbol = ";",
    color = "light_gray",
    mass = "320 g",
    volume = "300 ml",
    price = "0 USD",
    survival_price = "7 USD",
    materials = { "steel" },
    melee_damage = { bash = 1 },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    use_actions = {
        { kind = "weigh_self", max_weight = "25000 kg" },
    },
    tool = {},
}
