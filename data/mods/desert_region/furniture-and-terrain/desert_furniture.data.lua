local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_tumbleweed",
    name = ccb.content.text("tumbleweed"),
    description = ccb.content.text("Tumbleweed."),
    symbol = "#",
    color = "brown",
    looks_like = "stick",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "SHRUB", "SHORT" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "stick", count = { 1, 2 } } },
    },
}
