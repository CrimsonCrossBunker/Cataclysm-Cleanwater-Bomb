local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_augustmoon_shuttle_console",
    name = ccb.content.text("Shuttle Guidance Console"),
    description = ccb.content.text("The simplified guidance interface of a drone shuttle.  Activating it will transport you to Port Augustmoon."),
    symbol = "6",
    looks_like = "t_afs_shuttlepod_g",
    color = "light_blue",
    move_cost = 0,
    coverage = 50,
    roof = "t_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "NOITEM", "INDOORS" },
    examine_handler = "examine_t_augustmoon_shuttle_console",
}
