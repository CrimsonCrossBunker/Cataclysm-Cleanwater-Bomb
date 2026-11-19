local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "generic_meadow",
    copy_from = "generic_open_land",
    name = ccb.content.text("meadow"),
    symbol = ",",
    color = "brown",
    travel_cost = "forest",
    spawns = { group = "GROUP_FOREST", population = { 0, 1 }, chance = 13 },
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = "meadow_core",
    copy_from = "generic_meadow",
    extend = { flags = { "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = "meadow_end",
    copy_from = "generic_meadow",
}
