local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_vitrified_pool_talker",
    name = ccb.content.text("shallow black pool"),
    description = ccb.content.text("At first glance, this looks like a rippling pool of black water.  Closer examination reveals it to be fine glass dust, blown in slow waves by the breeze."),
    looks_like = "t_water_pool",
    symbol = "~",
    color = "black",
    move_cost = 7,
    flags = { "TRANSPARENT", "LIQUID", "NO_SCENT", "SWIMMABLE", "SHARP" },
    connect_groups = "POOLWATER",
    connects_to = "POOLWATER",
    emissions = { "emit_glimmer" },
    examine_handler = "examine_t_vitrified_pool_talker",
}

ccb.content.define_terrain {
    id = "t_vitrified_soil_talker",
    name = ccb.content.text("soft glass soil"),
    description = ccb.content.text("This little mound of soil is unlike the jagged dirt around it.  It is smooth, welcoming, and pleasant to the touch."),
    looks_like = "t_sand",
    symbol = "~",
    color = "light_gray",
    connect_groups = "SANDGLASS",
    connects_to = "SANDGLASS",
    move_cost = 3,
    flags = { "BLOCKSDOOR" },
    rotates_to = "INDOORFLOOR",
    emissions = { "emit_glimmer" },
    examine_handler = "examine_t_vitrified_soil_talker",
}
