local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "mom_shoggothed_world_default",
    copy_from = "generic_open_land",
    name = ccb.content.text("desolation"),
    symbol = ".",
    travel_cost = "field",
    looks_like = "field",
    color = "brown",
    see_cost = "none",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "mom_shoggothed_world_ravine_floor",
    copy_from = "ravine_floor",
    name = ccb.content.text("scar"),
    symbol = ".",
    travel_cost = "field",
    looks_like = "field",
    color = "brown",
    see_cost = "none",
    flags = { "NO_ROTATE", "RAVINE" },
}
