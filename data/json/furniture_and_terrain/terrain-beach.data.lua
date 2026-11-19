local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_coast_rock_surf",
    name = ccb.content.text("rocky coastline"),
    description = ccb.content.text("This is a section of eroded natural stone formations along the beach, the water lapping and splashing at the edges."),
    symbol = "-",
    looks_like = "t_rock_floor",
    color = "cyan",
    move_cost = 3,
    connect_groups = "BEACH_FORMATIONS",
    connects_to = "BEACH_FORMATIONS",
    flags = { "TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_tidepool",
    name = ccb.content.text("tide pool"),
    description = ccb.content.text("A shallow pool of salt water, often filled with interesting life."),
    looks_like = "t_swater_sh",
    symbol = "~",
    color = "cyan",
    move_cost = 4,
    connect_groups = "BEACH_FORMATIONS",
    flags = { "TRANSPARENT", "LIQUIDCONT", "SALT_WATER" },
    builtin_examine = "finite_water_source",
    liquid_source = { item = "salt_water", minimum_temperature = 2.2, count = { 40, 240 } },
}
