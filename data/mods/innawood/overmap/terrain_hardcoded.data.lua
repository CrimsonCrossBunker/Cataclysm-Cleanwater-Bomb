local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "cave_innawood",
    name = ccb.content.text("cave"),
    looks_like = "cave",
    symbol = "C",
    color = "brown",
    see_cost = "high",
    flags = { "NO_ROTATE", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "cave_underground_innawood",
    name = ccb.content.text("cave"),
    looks_like = "cave_underground",
    symbol = "C",
    color = "brown",
    see_cost = "full_high",
    flags = { "NO_ROTATE", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "cave_rat_underground_innawood",
    name = ccb.content.text("rat cave"),
    looks_like = "cave_rat_underground",
    symbol = "C",
    color = "brown",
    see_cost = "full_high",
    flags = { "NO_ROTATE", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "cave_rat_innawood",
    name = ccb.content.text("rat cave"),
    looks_like = "cave_rat",
    symbol = "C",
    color = "dark_gray",
    see_cost = "full_high",
    flags = { "KNOWN_DOWN", "NO_ROTATE", "SOURCE_SAFETY" },
}
