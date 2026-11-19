local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "anthill",
    name = ccb.content.text("anthill"),
    vision_levels = "natural_outcropping",
    symbol = "%",
    color = "brown",
    see_cost = "none",
    flags = { "KNOWN_DOWN", "RISK_EXTREME", "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = "ants_food",
    vision_levels = "underground_dirt",
    name = ccb.content.text("ant food storage"),
    symbol = "O",
    color = "green",
    see_cost = "full_high",
    spawns = { group = "GROUP_ANT", population = { 6, 10 }, chance = 100 },
}

ccb.content.define_overmap_terrain {
    id = "acid_ants_food",
    vision_levels = "underground_dirt",
    name = ccb.content.text("ant food storage"),
    symbol = "O",
    color = "green",
    see_cost = "full_high",
    spawns = { group = "GROUP_ACID_ANT", population = { 6, 10 }, chance = 100 },
}

ccb.content.define_overmap_terrain {
    id = "ants_larvae",
    copy_from = "ants_food",
    name = ccb.content.text("ant larva chamber"),
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = "acid_ants_larvae",
    copy_from = "ants_food",
    name = ccb.content.text("ant larva chamber"),
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = "ants_queen",
    copy_from = "ants_food",
    name = ccb.content.text("ant queen chamber"),
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = "acid_ants_queen",
    copy_from = "ants_food",
    name = ccb.content.text("ant queen chamber"),
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = "ants_fungus_colony",
    copy_from = "ants_food",
    name = ccb.content.text("ant fungus colony"),
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = "acid_ants_fungus_colony",
    copy_from = "acid_ants_food",
    name = ccb.content.text("ant fungus colony"),
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = "ants",
    vision_levels = "underground_dirt",
    name = ccb.content.text("ant tunnel"),
    color = "brown",
    see_cost = "full_high",
    spawns = { group = "GROUP_ANT", population = { 4, 6 }, chance = 100 },
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = "acid_ants",
    vision_levels = "underground_dirt",
    name = ccb.content.text("ant tunnel"),
    color = "brown",
    see_cost = "full_high",
    spawns = { group = "GROUP_ACID_ANT", population = { 4, 6 }, chance = 100 },
    flags = { "LINEAR" },
}
