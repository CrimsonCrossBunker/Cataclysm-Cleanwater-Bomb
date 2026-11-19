local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_den_small",
    name = ccb.content.text("small den"),
    description = ccb.content.text("A small den that burrowing animals such as groundhogs or hares call home."),
    symbol = "0",
    color = "yellow",
    looks_like = "t_den_large",
    move_cost = 3,
    flags = { "TRANSPARENT", "DIGGABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_den_large",
    name = ccb.content.text("large den"),
    description = ccb.content.text("A large den that burrowing animals such as bears and foxes call home."),
    symbol = "0",
    color = "yellow",
    looks_like = "t_pit_shallow",
    move_cost = 6,
    flags = { "TRANSPARENT", "DIGGABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_slime",
    name = ccb.content.text("slime"),
    description = ccb.content.text("A disgusting, slippery mess.  Could be used to stash things, because who'd want to touch it?"),
    symbol = "~",
    color = "green",
    move_cost = 6,
    flags = { "TRANSPARENT", "CONTAINER", "PLACE_ITEM" },
}
