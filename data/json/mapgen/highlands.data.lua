local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "highlands",
    copy_from = "generic_open_land",
    name = ccb.content.text("highlands"),
    symbol = ".",
    travel_cost = "field",
    looks_like = "meadow_core",
    color = "green",
    see_cost = "none",
    flags = { "NO_ROTATE" },
}
