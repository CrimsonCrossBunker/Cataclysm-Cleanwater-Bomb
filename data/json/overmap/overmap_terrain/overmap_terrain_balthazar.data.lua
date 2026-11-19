local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "balthazar_bunker_00", "balthazar_bunker_01" },
    name = ccb.content.text("bunker complex"),
    symbol = "B",
    color = "light_red",
    vision_levels = "isolated_building",
    see_cost = "high",
    travel_cost = "impassable",
}

ccb.content.define_overmap_terrain {
    id = { "balthazar_bunker_02", "balthazar_bunker_03" },
    name = ccb.content.text("bunker solar farm"),
    symbol = "B",
    color = "yellow",
    vision_levels = "isolated_electronics",
    see_cost = "medium",
    travel_cost = "impassable",
}

ccb.content.define_overmap_terrain {
    id = { "balthazar_bunker_01_1", "balthazar_bunker_01_2" },
    name = ccb.content.text("bunker complex roof"),
    symbol = "B",
    color = "light_red",
    vision_levels = "roof_or_air",
    see_cost = "full_high",
    travel_cost = "impassable",
}

ccb.content.define_overmap_terrain {
    id = {
        "balthazar_bunker_00_-1", "balthazar_bunker_01_-1", "balthazar_bunker_02_-1",
        "balthazar_bunker_03_-1", "balthazar_bunker_02_-2",
    },
    name = ccb.content.text("underground bunker complex"),
    symbol = "B",
    color = "light_red",
    vision_levels = "underground_dirt",
    see_cost = "full_high",
    travel_cost = "impassable",
}
