local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_bulletin_evac",
    name = ccb.content.text("evac shelter info board"),
    looks_like = "f_bulletin",
    description = ccb.content.text("A wide wooden frame surrounding a sheet of cork, on to which a number of full-page notices have been neatly tacked.  Most seem to provide emergency information, or instructions now woefully outdated considering the state of things, but a map pointing to the nearest refugee center catches your eye.  You should take a closer look."),
    symbol = "6",
    color = "blue",
    move_cost_mod = -1,
    coverage = 75,
    required_strength = -1,
    flags = { "FLAMMABLE", "ORGANIC", "TRANSPARENT", "FREE_TO_EXAMINE", "EASY_DECONSTRUCT" },
    max_volume = "120 ml",
    deconstruct = {
        furniture = "f_bulletin",
        drops = { { item = "paper", count = 4 } },
    },
    bash = {
        minimum_strength = 3,
        maximum_strength = 40,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump."),
        drops = {
            { item = "2x4", count = { 0, 3 } },
            { item = "nail", charges = { 4, 6 } },
            { item = "splinter", count = { 1, 4 } },
            { item = "flyer_evac", count = { 1, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    examine_handler = "examine_f_bulletin_evac",
}
