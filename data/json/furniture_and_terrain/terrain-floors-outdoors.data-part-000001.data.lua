local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_fault",
    name = ccb.content.text("odd fault"),
    description = ccb.content.text("An unnaturally humanoid-shaped hole, it seems oddly familiar.  You feel a strange urge to examine it closer, as if it belongs to you somehow."),
    symbol = "#",
    color = "magenta",
    looks_like = "t_pit",
    move_cost = 0,
    roof = "t_rock_floor",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL" },
    examine_handler = "examine_t_fault",
}
