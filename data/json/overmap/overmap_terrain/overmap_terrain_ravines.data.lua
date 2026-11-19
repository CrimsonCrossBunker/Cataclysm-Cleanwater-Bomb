local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "generic_ravine",
    vision_levels = "always_full",
    name = ccb.content.text("ravine"),
    symbol = ".",
    color = "blue",
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    id = "ravine",
    copy_from = "generic_ravine",
    flags = { "NO_ROTATE", "RAVINE" },
}

ccb.content.define_overmap_terrain {
    id = "ravine_edge",
    copy_from = "generic_ravine",
    symbol = "v",
    name = ccb.content.text("cliffside"),
    color = "light_gray",
    flags = { "NO_ROTATE", "RAVINE_EDGE" },
    mapgen = { { builtin = "ravine_edge" } },
}

ccb.content.define_overmap_terrain {
    id = "ravine_floor_edge",
    copy_from = "generic_ravine",
    symbol = "^",
    name = ccb.content.text("cliffside"),
    color = "light_gray",
    flags = { "NO_ROTATE", "RAVINE_EDGE" },
    mapgen = { { builtin = "ravine_edge" } },
}

ccb.content.define_overmap_terrain {
    id = "ravine_floor",
    copy_from = "generic_ravine",
    symbol = ".",
    name = ccb.content.text("ravine floor"),
    color = "light_gray",
    flags = { "NO_ROTATE", "RAVINE" },
}
