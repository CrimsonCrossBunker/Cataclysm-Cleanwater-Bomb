local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "field",
    copy_from = "generic_open_land",
    name = ccb.content.text("drylands"),
    symbol = ".",
    color = "yellow",
    see_cost = "none",
    extras = "field",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "forest",
    copy_from = "generic_forest",
    name = ccb.content.text("shrubland"),
    symbol = "*",
    color = "green",
    see_cost = "low",
    extras = "forest",
    spawns = { group = "GROUP_FOREST", population = { 0, 3 }, chance = 13 },
    flags = { "NO_ROTATE", "SOURCE_FORAGE" },
}

ccb.content.define_overmap_terrain {
    id = "forest_thick",
    copy_from = "generic_forest",
    name = ccb.content.text("woodland"),
    symbol = "F",
    color = "green",
    see_cost = "spaced_high",
    extras = "forest_thick",
    spawns = { group = "GROUP_FOREST", population = { 0, 6 }, chance = 15 },
    flags = { "NO_ROTATE", "SOURCE_FORAGE" },
}

ccb.content.define_overmap_terrain {
    id = "forest_water",
    copy_from = "generic_wetland_forest",
    name = ccb.content.text("desert pavement"),
    symbol = ",",
    color = "dark_gray",
    see_cost = "spaced_high",
    extras = "forest_water",
    spawns = { group = "GROUP_SWAMP", population = { 1, 4 }, chance = 16 },
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "sandstone",
    name = ccb.content.text("sandstone"),
    symbol = "%",
    color = "brown",
    see_cost = "opaque",
    flags = { "NO_ROTATE" },
    uniform_terrain = "t_sandstone",
}

ccb.content.define_overmap_terrain {
    id = "mesa",
    name = ccb.content.text("mesa"),
    symbol = "%",
    color = "i_brown",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = {
        "mesa_2way_v1", "mesa_3way_v1", "mesa_edge_v1", "mesa_corner_v1", "mesa_2way_v2",
        "mesa_3way_v2", "mesa_edge_v2", "mesa_corner_v2",
    },
    name = ccb.content.text("mesa"),
    symbol = "%",
    color = "brown",
    see_cost = "full_high",
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = {
        "mesa_2way_top_v1", "mesa_3way_top_v1", "mesa_edge_top_v1", "mesa_corner_top_v1",
        "mesa_2way_top_v2", "mesa_3way_top_v2", "mesa_edge_top_v2", "mesa_corner_top_v2",
    },
    name = ccb.content.text("drylands"),
    symbol = ".",
    color = "brown",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_canyon",
    name = ccb.content.text("canyon"),
    symbol = "V",
    color = "light_gray",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = {
        "canyon_2way", "canyon_3way", "canyon_edge", "canyon_corner", "canyon_2way_bottom",
        "canyon_3way_bottom", "canyon_edge_bottom", "canyon_corner_bottom",
    },
    copy_from = "generic_canyon",
}

ccb.content.define_overmap_terrain {
    id = { "canyon_2way_ground", "canyon_3way_ground", "canyon_edge_ground", "canyon_corner_ground" },
    copy_from = "generic_canyon",
    see_cost = "all_clear",
    flags = { "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_lake",
    copy_from = "generic_water",
    name = ccb.content.text("lake bed"),
    symbol = "#",
    color = "dark_gray",
    see_cost = "full_high",
    flags = { "NO_ROTATE", "LAKE" },
}

ccb.content.define_overmap_terrain {
    id = "lake_shore",
    copy_from = "generic_lake",
    name = ccb.content.text("lake bed shore"),
    color = "light_gray",
    delete = { flags = { "LAKE" } },
    extend = { flags = { "LAKE_SHORE", "IGNORE_ROTATION_FOR_ADJACENCY" } },
    extras = "lake_shore",
}

ccb.content.define_overmap_terrain {
    id = "lake_bed",
    copy_from = "generic_lake",
    name = ccb.content.text("lake bed"),
}

ccb.content.define_overmap_terrain {
    abstract = "generic_river",
    copy_from = "generic_water",
    name = ccb.content.text("riverbed"),
    symbol = "R",
    color = "dark_gray",
    see_cost = "none",
    flags = { "RIVER", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_river_bank",
    copy_from = "generic_river",
    name = ccb.content.text("riverbed shore"),
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = "river_center",
    copy_from = "generic_river",
}

ccb.content.define_overmap_terrain {
    id = "river",
    copy_from = "generic_river_bank",
    extras = "river",
    delete = { flags = { "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = { "river_c_not_ne", "river_c_not_nw", "river_c_not_se", "river_c_not_sw" },
    copy_from = "generic_river_bank",
    extras = "river",
}

ccb.content.define_overmap_terrain {
    id = { "river_ne", "river_nw", "river_se", "river_sw" },
    extras = "river",
    copy_from = "generic_river_bank",
}
