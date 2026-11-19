local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "c_cave_entrance",
    name = ccb.content.text("river cave entrance"),
    vision_levels = "natural_outcropping",
    symbol = "O",
    color = "light_cyan",
    see_cost = "spaced_high",
    flags = { "KNOWN_DOWN", "RISK_HIGH", "REQUIRES_PREDECESSOR", "RIVER", "LAKE_SHORE" },
}

ccb.content.define_overmap_terrain {
    id = "river_cave_food",
    name = ccb.content.text("kraken food storage"),
    vision_levels = "underground_dirt",
    symbol = "O",
    color = "cyan_green",
    see_cost = "full_high",
    spawns = { group = "GROUP_KRAKEN", population = { 6, 10 }, chance = 100 },
}

ccb.content.define_overmap_terrain {
    id = "river_cave_nest",
    copy_from = "river_cave_food",
    name = ccb.content.text("river cave nest"),
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = "river_cave_kraken",
    copy_from = "river_cave_food",
    name = ccb.content.text("kraken chamber"),
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = "river_cave",
    name = ccb.content.text("river cave tunnel"),
    vision_levels = "underground_dirt",
    color = "brown",
    see_cost = "full_high",
    spawns = { group = "GROUP_KRAKEN", population = { 4, 6 }, chance = 100 },
    flags = { "LINEAR" },
}
