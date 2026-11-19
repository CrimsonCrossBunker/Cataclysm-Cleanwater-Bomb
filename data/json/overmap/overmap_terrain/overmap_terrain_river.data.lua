local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "generic_river",
    copy_from = "generic_water",
    vision_levels = "water_body",
    name = ccb.content.text("river"),
    symbol = "R",
    color = "blue",
    see_cost = "none",
    flags = { "RIVER", "NO_ROTATE", "SOURCE_DRINK", "WATER" },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_river_bank",
    copy_from = "generic_river",
    travel_cost = "shore",
    name = ccb.content.text("river bank"),
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = "river_center",
    copy_from = "generic_river",
    travel_cost = "water",
    uniform_terrain = "t_water_moving_dp",
}

ccb.content.define_overmap_terrain {
    id = "river",
    copy_from = "generic_river_bank",
    extras = "river",
    delete = { flags = { "NO_ROTATE" } },
    mapgen = { { builtin = "river_straight" } },
}

ccb.content.define_overmap_terrain {
    id = { "river_c_not_ne", "river_c_not_nw", "river_c_not_se", "river_c_not_sw" },
    copy_from = "generic_river_bank",
    extras = "river",
    mapgen = { { builtin = "river_curved_not" } },
}

ccb.content.define_overmap_terrain {
    id = { "river_ne", "river_nw", "river_se", "river_sw" },
    extras = "river",
    copy_from = "generic_river_bank",
    mapgen = { { builtin = "river_curved" } },
}
