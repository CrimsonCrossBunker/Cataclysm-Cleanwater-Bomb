local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_dirt_cracked",
    looks_like = "t_sand",
    name = ccb.content.text("scorched earth"),
    description = ccb.content.text("Cracked and dry soil that doesn't look like it will be capable of supporting anything in your lifetime."),
    symbol = ".",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_dirt_cracked",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}
