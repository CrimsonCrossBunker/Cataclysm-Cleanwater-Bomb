local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_shore_boulder",
    name = ccb.content.text("smooth rocky outcropping"),
    description = ccb.content.text("A medium rocky outcropping, smoothed by the waves and weather."),
    symbol = "O",
    color = "dark_gray",
    move_cost = 6,
    coverage = 45,
    flags = { "NOITEM", "TRANSPARENT", "UNSTABLE", "MOUNTABLE", "SHORT" },
}

ccb.content.define_terrain {
    id = "t_shore_boulder_oyster",
    name = ccb.content.text("oyster-encrusted boulder"),
    description = ccb.content.text("An oyster-encrusted boulder, promising the potential for a tasty meal if you can get to it and pry the oysters off."),
    symbol = "@",
    color = "white",
    move_cost = 6,
    coverage = 45,
    flags = { "NOITEM", "TRANSPARENT", "UNSTABLE", "MOUNTABLE", "SHORT" },
    builtin_examine = "harvest_ter",
    harvest_by_season = { { seasons = { "spring", "autumn", "winter" }, harvest = "oyster_harv" } },
    transforms_into = "t_shore_boulder",
}
