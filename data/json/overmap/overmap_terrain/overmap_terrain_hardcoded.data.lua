local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "open_air",
    name = ccb.content.text("open air"),
    symbol = ".",
    color = "blue",
    see_cost = "all_clear",
    vision_levels = "roof_or_air",
    travel_cost = "air",
    uniform_terrain = "t_open_air",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "field", "isherwood_barry_rescue_field" },
    copy_from = "generic_open_land",
    name = ccb.content.text("field"),
    symbol = ".",
    color = "brown",
    vision_levels = "always_full",
    see_cost = "none",
    extras = "field",
    spawns = { group = "GROUP_FOREST", population = { 0, 1 }, chance = 13 },
    travel_cost = "field",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "forest",
    copy_from = "generic_forest",
    name = ccb.content.text("forest"),
    symbol = "F",
    color = "green",
    see_cost = "spaced_high",
    extras = "forest",
    spawns = { group = "GROUP_FOREST", population = { 0, 3 }, chance = 13 },
    travel_cost = "forest",
    flags = { "NO_ROTATE", "SOURCE_FORAGE" },
}

ccb.content.define_overmap_terrain {
    id = "forest_thick",
    copy_from = "generic_forest",
    name = ccb.content.text("forest"),
    symbol = "F",
    color = "green",
    see_cost = "spaced_high",
    extras = "forest_thick",
    spawns = { group = "GROUP_FOREST", population = { 0, 6 }, chance = 15 },
    mapgen = { { builtin = "forest" } },
    flags = { "NO_ROTATE", "SOURCE_FORAGE" },
}

ccb.content.define_overmap_terrain {
    id = "forest_water",
    copy_from = "generic_wetland_forest",
    name = ccb.content.text("swamp"),
    symbol = "F",
    color = "cyan",
    vision_levels = "forested_swampy",
    see_cost = "spaced_high",
    extras = "forest_water",
    spawns = { group = "GROUP_SWAMP", population = { 2, 6 }, chance = 50 },
    mapgen = { { builtin = "forest" } },
    travel_cost = "swamp",
    flags = { "NO_ROTATE", "SOURCE_FORAGE", "RISK_HIGH" },
}

ccb.content.define_overmap_terrain {
    id = "standing_stones",
    name = ccb.content.text("standing stones"),
    symbol = "O",
    color = "dark_gray",
    vision_levels = "open_land",
    see_cost = "medium",
    spawns = { group = "GROUP_STANDING_STONES", population = { 1, 4 }, chance = 100 },
    flags = { "NO_ROTATE" },
}

-- Wrong, but doesn't really matter, for underground omts
ccb.content.define_overmap_terrain {
    id = {
        "temple_stairs", "temple_underground_1", "temple_underground_2", "temple_underground_3",
        "temple_underground_4",
    },
    name = ccb.content.text("strange temple"),
    vision_levels = "open_land",
    symbol = "T",
    color = "pink",
    see_cost = "none",
    flags = { "KNOWN_DOWN" },
}

ccb.content.define_overmap_terrain {
    id = "temple_finale",
    vision_levels = "underground_stone",
    name = ccb.content.text("strange temple"),
    symbol = "T",
    color = "yellow",
    see_cost = "full_high",
    flags = { "KNOWN_DOWN" },
}

ccb.content.define_overmap_terrain {
    id = "cave",
    vision_levels = "natural_outcropping",
    name = ccb.content.text("cave"),
    symbol = "C",
    color = "brown",
    see_cost = "high",
    flags = { "NO_ROTATE", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "cave_underground",
    vision_levels = "underground_dirt",
    name = ccb.content.text("cave"),
    symbol = "C",
    color = "brown",
    see_cost = "full_high",
    flags = { "NO_ROTATE", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "cave_rat_underground",
    name = ccb.content.text("rat cave"),
    looks_like = "cave_underground",
    vision_levels = "underground_dirt",
    symbol = "C",
    color = "brown",
    see_cost = "full_high",
    flags = { "NO_ROTATE", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "cave_rat",
    name = ccb.content.text("rat cave"),
    vision_levels = "natural_outcropping",
    looks_like = "cave",
    symbol = "C",
    color = "dark_gray",
    see_cost = "full_high",
    flags = { "KNOWN_DOWN", "NO_ROTATE", "SOURCE_SAFETY" },
}

-- deep_rock is a placeholder solution to differentiate between subway tunnels, remove if per-special connection subtyping is implemented.
ccb.content.define_overmap_terrain {
    id = { "empty_rock", "deep_rock" },
    name = ccb.content.text("solid rock"),
    vision_levels = "always_full",
    symbol = "%",
    color = "dark_gray",
    see_cost = "opaque",
    travel_cost = "impassable",
    uniform_terrain = "t_rock",
    flags = { "NO_ROTATE" },
}
