local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "generic_lake",
    copy_from = "generic_water",
    vision_levels = "water_body",
    name = ccb.content.text("lake"),
    symbol = "#",
    color = "blue",
    see_cost = "none",
    flags = { "NO_ROTATE", "LAKE", "SOURCE_DRINK", "WATER" },
}

ccb.content.define_overmap_terrain {
    id = "lake_shore",
    copy_from = "generic_lake",
    name = ccb.content.text("lake shore"),
    color = "light_blue",
    delete = { flags = { "LAKE" } },
    extend = { flags = { "LAKE_SHORE", "IGNORE_ROTATION_FOR_ADJACENCY" } },
    extras = "lake_shore",
    travel_cost = "shore",
    mapgen = { { builtin = "lake_shore" } },
}

ccb.content.define_overmap_terrain {
    id = "lake_surface",
    copy_from = "generic_lake",
    travel_cost = "water",
    uniform_terrain = "t_water_dp",
}

ccb.content.define_overmap_terrain {
    id = "lake_water_cube",
    copy_from = "generic_lake",
    name = ccb.content.text("lake (submerged)"),
    uniform_terrain = "t_water_cube",
}

ccb.content.define_overmap_terrain {
    id = "lake_bed",
    copy_from = "generic_lake",
    name = ccb.content.text("lake bed (submerged)"),
}

ccb.content.define_overmap_terrain {
    abstract = "generic_ocean",
    copy_from = "generic_water",
    vision_levels = "water_body",
    name = ccb.content.text("ocean"),
    symbol = "#",
    color = "blue",
    see_cost = "none",
    flags = { "NO_ROTATE", "OCEAN" },
}

ccb.content.define_overmap_terrain {
    id = "ocean_shore",
    copy_from = "generic_ocean",
    name = ccb.content.text("ocean shore"),
    color = "light_blue",
    delete = { flags = { "OCEAN" } },
    extend = { flags = { "OCEAN_SHORE", "IGNORE_ROTATION_FOR_ADJACENCY" } },
    extras = "ocean_shore",
    travel_cost = "shore",
    mapgen = { { builtin = "ocean_shore" } },
}

ccb.content.define_overmap_terrain {
    id = "ocean_surface",
    copy_from = "generic_ocean",
    travel_cost = "water",
    uniform_terrain = "t_swater_dp",
}

ccb.content.define_overmap_terrain {
    id = "ocean_water_cube",
    copy_from = "generic_ocean",
    name = ccb.content.text("ocean (submerged)"),
    uniform_terrain = "t_saltwater_cube",
}

ccb.content.define_overmap_terrain {
    id = "ocean_bed",
    copy_from = "generic_ocean",
    name = ccb.content.text("ocean bed (submerged)"),
    extras = "ocean_bed",
}
