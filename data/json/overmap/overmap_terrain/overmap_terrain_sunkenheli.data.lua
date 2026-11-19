local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "sunken_helicopter" },
    name = ccb.content.text("sunken heli"),
    symbol = "~",
    color = "light_blue",
    flags = { "NO_ROTATE", "LAKE" },
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "sunken_heli_roof" },
    name = ccb.content.text("sunken heli roof"),
    symbol = "~",
    color = "light_blue",
    flags = { "NO_ROTATE", "LAKE" },
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "nether_cucumber_lake_bed" },
    name = ccb.content.text("nether cucumber lake bed"),
    symbol = "~",
    color = "light_blue",
    flags = { "NO_ROTATE", "LAKE" },
    see_cost = "none",
}
