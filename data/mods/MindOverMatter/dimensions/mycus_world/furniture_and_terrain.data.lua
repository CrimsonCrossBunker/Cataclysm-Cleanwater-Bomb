local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_trunk_fungal",
    looks_like = "t_trunk",
    name = ccb.content.text("fungal tree trunk"),
    description = ccb.content.text("A section of trunk from a fungal tree that has collapsed or fallen over due to being overcome with rot.  It looks like those pictures of smokers' lungs they showed you back in school."),
    symbol = "1",
    color = "brown",
    move_cost = 4,
    coverage = 45,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "DIGGABLE", "REDUCE_SCENT", "MOUNTABLE", "SHORT" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "splinter", count = { 5, 15 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_puddle_mycus",
    name = ccb.content.text("recess"),
    description = ccb.content.text("A shallow pit in the ground.  The surface is covered in a thin coating of mycus spores."),
    looks_like = "t_dirt",
    symbol = "~",
    color = "light_blue",
    move_cost = 3,
    liquid_source = { item = "water_mycus", count = { 40, 240 } },
    flags = { "TRANSPARENT", "LIQUIDCONT" },
    builtin_examine = "finite_water_source",
}
