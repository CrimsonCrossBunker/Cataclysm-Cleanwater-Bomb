local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "railroad",
    name = ccb.content.text("railroad"),
    copy_from = "generic_transportation",
    color = "light_green",
    see_cost = "none",
    flags = { "LINEAR", "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_railroad_bridge",
    copy_from = "generic_transportation",
    name = ccb.content.text("railroad bridge"),
    symbol = "│",
    color = "white",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "railroad_bridge",
    copy_from = "generic_railroad_bridge",
    color = "light_cyan",
    flags = { "RIVER" },
}

ccb.content.define_overmap_terrain {
    id = "railroad_bridge_overpass",
    copy_from = "generic_bridge",
    name = ccb.content.text("railroad bridge (overpass)"),
}

ccb.content.define_overmap_terrain {
    id = "railroad_bridgehead_ground",
    copy_from = "generic_railroad_bridge",
    name = ccb.content.text("railroad bridgehead (ground)"),
    symbol = "v",
    extras = "bridgehead_railroad_ground",
}

ccb.content.define_overmap_terrain {
    id = "railroad_bridgehead_ramp",
    copy_from = "generic_railroad_bridge",
    name = ccb.content.text("railroad bridgehead (ramp)"),
    symbol = "^",
}

ccb.content.define_overmap_terrain {
    id = "railroad_level_crossing",
    name = ccb.content.text("railroad level crossing"),
    symbol = "┼",
    color = "red",
    see_cost = "none",
    extras = "road",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_railroad_station",
    name = ccb.content.text("railroad station"),
    copy_from = "generic_city_building_no_sidewalk",
    delete = { flags = { "GENERIC_LOOT" } },
    symbol = "R",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_railroad_station_under",
    copy_from = "generic_railroad_station",
    color = "dark_gray",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_railroad_station_parking_lot",
    name = ccb.content.text("railroad station parking lot"),
    copy_from = "generic_railroad_station",
    symbol = "O",
    color = "dark_gray",
}

ccb.content.define_overmap_terrain {
    id = { "railroad_station_0_1", "railroad_station_0_2", "railroad_station_0_3", "railroad_station_0_4" },
    copy_from = "generic_railroad_station",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = {
        "railroad_station_1_1", "railroad_station_1_2", "railroad_station_1_3", "railroad_station_1_4",
        "railroad_station_0_1_roof", "railroad_station_0_2_roof", "railroad_station_0_3_roof",
        "railroad_station_1_1_roof", "railroad_station_1_2_roof", "railroad_station_1_3_roof",
        "railroad_station_1_4_roof", "railroad_station_2_4_roof",
    },
    copy_from = "generic_railroad_station",
}

ccb.content.define_overmap_terrain {
    id = { "railroad_station_2_1", "railroad_station_2_2", "railroad_station_2_3", "railroad_station_2_4" },
    copy_from = "generic_railroad_station_parking_lot",
}

ccb.content.define_overmap_terrain {
    id = {
        "railroad_station_under_0_1", "railroad_station_under_0_2", "railroad_station_under_0_3",
        "railroad_station_under_1_1", "railroad_station_under_1_2", "railroad_station_under_1_3",
    },
    copy_from = "generic_railroad_station_under",
}
