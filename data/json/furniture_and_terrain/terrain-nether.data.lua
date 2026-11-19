local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nether_glass_floor",
    name = ccb.content.text("black glass"),
    description = ccb.content.text("An endless expanse of black glass.  It perfectly reflects the darkness around it."),
    symbol = " ",
    color = "black",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_distortion_floor",
    name = ccb.content.text("distorted image"),
    description = ccb.content.text("The landscape looks warped and distorted here, as if had been unnaturally stretched above a thin membrane."),
    symbol = "+",
    color = "magenta",
    looks_like = "fd_fatigue",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_nether_glass_floor_clairvoyance",
    name = ccb.content.text("black glass"),
    description = ccb.content.text("An endless expanse of black glass.  It perfectly reflects the darkness around it."),
    symbol = " ",
    color = "black",
    move_cost = 2,
    emissions = { "emit_clairvoyant" },
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_nether_glass_floor_basalt",
    name = ccb.content.text("basalt floor"),
    looks_like = "t_rock_floor",
    description = ccb.content.text("Flat hexagonal stone plates tile perfectly across the ground, each an exact copy of the next."),
    symbol = ".",
    color = "dark_gray",
    move_cost = 1,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_nether_glass_wall",
    name = ccb.content.text("black glass"),
    description = ccb.content.text("An endless expanse of black glass.  It perfectly reflects the darkness around it."),
    symbol = " ",
    color = "black",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "WALL" },
}

ccb.content.define_terrain {
    id = "t_nether_basalt",
    name = ccb.content.text("perfect basalt wall"),
    description = ccb.content.text("Hexagonal columns of basalt spring from the dark floor, each an exact copy of the next."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "WALL" },
}
