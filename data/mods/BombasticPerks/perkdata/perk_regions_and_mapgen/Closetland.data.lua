local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "closetland_nether_glass",
    name = ccb.content.text("Endless crystal"),
    symbol = "T",
    color = "light_red",
    see_cost = "none",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "perk_closetland_closet_area",
    name = ccb.content.text("Closetland"),
    symbol = "C",
    color = "light_red",
    see_cost = "none",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "perk_closetland_closet_area_roof",
    name = ccb.content.text("The roof"),
    symbol = "T",
    color = "light_red",
    see_cost = "none",
    flags = { "NO_ROTATE" },
}
