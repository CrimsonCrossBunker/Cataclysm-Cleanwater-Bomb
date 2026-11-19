local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "outer_space" },
    name = ccb.content.text("outer space"),
    symbol = " ",
    color = "black",
    see_cost = "all_clear",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "high_orbit_salus_4", "high_orbit_salus_4tp" },
    name = ccb.content.text("high orbit over Salus IV"),
    symbol = " ",
    color = "black",
    see_cost = "all_clear",
    flags = { "NO_ROTATE" },
}
