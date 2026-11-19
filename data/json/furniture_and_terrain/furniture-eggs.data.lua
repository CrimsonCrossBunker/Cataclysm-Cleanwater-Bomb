local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_egg_sackbw",
    name = ccb.content.text("spider egg sac"),
    description = ccb.content.text("A sizable, off-white sac of large eggs.  Upon watching closer, you can see them moving slightly.  Gross."),
    symbol = "O",
    color = "white",
    move_cost_mod = 3,
    required_strength = 6,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "ORGANIC", "MOUNTABLE", "TINY" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 16,
        sound = ccb.content.text("splat!"),
        failure_sound = ccb.content.text("whump."),
        furniture = "f_egg_sacke",
    },
}

ccb.content.define_furniture {
    id = "f_egg_sackcs",
    name = ccb.content.text("spider egg sac"),
    description = ccb.content.text("A bulbous mass of off-white spider eggs.  Upon watching closer, you can see them moving a bit.  Really gross."),
    symbol = "O",
    color = "white",
    looks_like = "f_sack_bw",
    move_cost_mod = 3,
    required_strength = 6,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "ORGANIC", "MOUNTABLE", "TINY" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 16,
        sound = ccb.content.text("splat!"),
        failure_sound = ccb.content.text("whump."),
        furniture = "f_egg_sacke",
    },
}

ccb.content.define_furniture {
    id = "f_egg_sackws",
    name = ccb.content.text("spider egg sac"),
    description = ccb.content.text("A gigantic sac of spider eggs, each one larger than your fist.  They're definitely moving around.  Really gross, just seeing it makes your skin crawl."),
    symbol = "O",
    color = "yellow",
    looks_like = "f_sack_bw",
    move_cost_mod = 3,
    required_strength = 6,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "ORGANIC", "MOUNTABLE", "TINY" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 8,
        sound = ccb.content.text("splat!"),
        failure_sound = ccb.content.text("whump."),
        furniture = "f_egg_sacke",
    },
}

ccb.content.define_furniture {
    id = "f_egg_sacke",
    name = ccb.content.text("ruptured egg sac"),
    description = ccb.content.text("A disgusting, ruptured sac of giant spider eggs.  The thought of all those massive baby spiders pouring out of it is almost terrifying on its own."),
    symbol = "X",
    color = "white",
    move_cost_mod = 3,
    required_strength = 6,
    flags = { "TRANSPARENT", "CONTAINER", "FLAMMABLE_ASH", "ORGANIC", "MOUNTABLE", "TINY" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 6,
        sound = ccb.content.text("splat!"),
        failure_sound = ccb.content.text("whump."),
    },
}
