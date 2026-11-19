local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "mom_mycus_world_default" },
    weight = 3,
    layout = {
        fill_terrain = "t_region_groundcover",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "mom_mycus_world_default",
    weight = 1,
    layout = {
        fill_terrain = "t_region_groundcover",
    },
}

ccb.content.define_overmap_terrain {
    id = "mom_mycus_world_default",
    copy_from = "generic_open_land",
    name = ccb.content.text("fungal field"),
    symbol = ".",
    travel_cost = "field",
    looks_like = "meadow_core",
    color = "green",
    see_cost = "none",
    flags = { "NO_ROTATE" },
}
