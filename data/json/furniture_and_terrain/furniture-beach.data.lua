local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_beach_seaweed",
    name = ccb.content.text("scattered seaweed"),
    description = ccb.content.text("Seaweed and other detritus, scattered along the high water line of the beach."),
    symbol = "{",
    looks_like = "f_leaves_pile",
    color = "green",
    move_cost_mod = 0,
    required_strength = -1,
    bash = {
        minimum_strength = 0,
        maximum_strength = 2,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("whish."),
        drops = { { item = "seaweed", count = { 2, 10 } } },
    },
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "ORGANIC" },
}

ccb.content.define_furniture {
    id = "f_beach_log",
    name = ccb.content.text("driftwood"),
    description = ccb.content.text("A hollow and twisted piece of a root or a branch, bleached white by sun and salt."),
    symbol = "-",
    looks_like = "t_trunk",
    color = "white",
    move_cost_mod = 1,
    required_strength = 12,
    bash = {
        minimum_strength = 6,
        maximum_strength = 30,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        drops = { { item = "splinter", count = { 25, 100 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "ORGANIC", "MOUNTABLE" },
}
