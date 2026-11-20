local ccb = require("ccb")

ccb.content.define_map_extra {
    id = "mx_grove_ravine",
    name = ccb.content.text("Grove"),
    description = ccb.content.text("This area is covered with a single type of trees."),
    generator = { method = "map_extra_function", id = "mx_grove" },
    z_levels = { -2, -2 },
    symbol = "F",
    color = "light_green",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_pond_ravine",
    name = ccb.content.text("Pond"),
    description = ccb.content.text("Small pond is here."),
    generator = { method = "map_extra_function", id = "mx_pond" },
    z_levels = { -2, -2 },
    symbol = "p",
    color = "blue",
    visibility = "details",
    flags = { "CLASSIC", "WATER" },
}

ccb.content.define_map_extra {
    id = "mx_pond_forest_ravine",
    name = ccb.content.text("basin"),
    description = ccb.content.text("Small basin is here."),
    generator = { method = "update_mapgen", id = "mx_pond_forest" },
    z_levels = { -2, -2 },
    flags = { "CLASSIC", "WATER" },
}

ccb.content.define_map_extra {
    id = "mx_pond_forest_2_ravine",
    copy_from = "mx_pond_forest",
    generator = { method = "update_mapgen", id = "mx_pond_forest_2" },
    z_levels = { -2, -2 },
    flags = { "CLASSIC", "WATER" },
}

ccb.content.define_map_extra {
    id = "mx_shrubbery_ravine",
    name = ccb.content.text("Shrubbery"),
    description = ccb.content.text("This area is covered with a single type of shrubs."),
    generator = { method = "map_extra_function", id = "mx_shrubbery" },
    z_levels = { -2, -2 },
    symbol = "s",
    color = "light_green",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}
