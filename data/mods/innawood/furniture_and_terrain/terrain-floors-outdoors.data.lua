local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_pavement",
    name = ccb.content.text("pavement"),
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
    description = ccb.content.text("A segment of asphalt, slowly degrading from cracks, frost heaves and lack of maintenance."),
    symbol = ".",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "MINEABLE" },
    bash = {
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = { { item = "rock", count = { 2, 10 } } },
    },
}

ccb.content.define_terrain {
    id = "t_pavement_y",
    name = ccb.content.text("yellow pavement"),
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
    description = ccb.content.text("Streaks of carefully aligned yellow paint mark the road to inform drivers not to cross.  No one is enforcing these rules anymore."),
    symbol = ".",
    color = "yellow",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "MINEABLE" },
    bash = {
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = { { item = "rock", count = { 2, 10 } } },
    },
}
