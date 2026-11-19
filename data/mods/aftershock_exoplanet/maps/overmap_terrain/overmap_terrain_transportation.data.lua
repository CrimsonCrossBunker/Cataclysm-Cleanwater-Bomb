local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "road",
    name = ccb.content.text("road"),
    copy_from = "generic_transportation",
    travel_cost = "road",
    color = "dark_gray",
    see_cost = "none",
    extras = "road",
    flags = { "LINEAR", "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = "bridge",
    copy_from = "generic_bridge",
    travel_cost = "road",
    color = "blue",
    flags = { "RAVINE" },
}

ccb.content.define_overmap_terrain {
    id = "bridge_road",
    copy_from = "generic_bridge",
    travel_cost = "road",
    name = ccb.content.text("bridge structure"),
    flags = { "RAVINE" },
}

ccb.content.define_overmap_terrain {
    id = "bridgehead_ground",
    copy_from = "generic_bridge",
    name = ccb.content.text("bridgehead (ground)"),
    travel_cost = "road",
    symbol = "v",
    extras = "road",
    flags = { "RAVINE_EDGE" },
}

ccb.content.define_overmap_terrain {
    id = "bridgehead_ramp",
    copy_from = "generic_bridge",
    name = ccb.content.text("bridgehead structure"),
    symbol = "^",
    travel_cost = "road",
    flags = { "RAVINE_EDGE" },
}
