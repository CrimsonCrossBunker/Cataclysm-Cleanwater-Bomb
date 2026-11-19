local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "fungal_tower",
    vision_levels = "blends_till_details",
    name = ccb.content.text("fungal tower"),
    symbol = "T",
    color = "yellow",
    see_cost = "spaced_high",
    extras = "marloss",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "fungal_bloom",
    vision_levels = "blends_till_details",
    name = ccb.content.text("fungal bloom"),
    symbol = "T",
    color = "light_gray",
    see_cost = "spaced_high",
    extras = "marloss",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "fungal_flowers",
    vision_levels = "blends_till_details",
    name = ccb.content.text("fungal flowers"),
    symbol = "T",
    color = "cyan",
    see_cost = "spaced_high",
    extras = "marloss",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "house_fungus_01",
    name = ccb.content.text("strange house"),
    symbol = "H",
    color = "cyan",
    see_cost = "high",
    spawns = { group = "GROUP_FUNGI_ZOMBIE", population = { 6, 8 }, chance = 100 },
    extras = "marloss",
}

ccb.content.define_overmap_terrain {
    id = "house_fungus_roof_01",
    name = ccb.content.text("house roof"),
    symbol = "H",
    color = "cyan",
    see_cost = "high",
    spawns = { group = "GROUP_FUNGI_ZOMBIE", population = { 0, 3 }, chance = 4 },
}
