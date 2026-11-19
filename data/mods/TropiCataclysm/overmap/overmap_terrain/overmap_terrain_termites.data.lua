local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "termitemound",
    name = ccb.content.text("termite mound"),
    symbol = "%",
    color = "brown",
    see_cost = "medium",
    flags = { "KNOWN_UP", "KNOWN_DOWN", "RISK_EXTREME", "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = "termites_roof",
    name = ccb.content.text("termite mound"),
    symbol = "%",
    color = "brown",
    see_cost = "none",
    flags = { "KNOWN_DOWN", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "termites_food",
    name = ccb.content.text("food storage"),
    symbol = "O",
    color = "green",
    see_cost = "high",
    spawns = { group = "GROUP_TERMITES", population = { 6, 10 }, chance = 100 },
}

ccb.content.define_overmap_terrain {
    id = "termites_larvae",
    copy_from = "termites_food",
    name = ccb.content.text("nymph nursery"),
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = "termites_queen",
    copy_from = "termites_food",
    name = ccb.content.text("royal chamber"),
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = "termites_water",
    copy_from = "termites_food",
    name = ccb.content.text("groundwater reservoir"),
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = "termites",
    name = ccb.content.text("termite tunnel"),
    color = "brown",
    see_cost = "high",
    spawns = { group = "GROUP_TERMITES", population = { 4, 6 }, chance = 100 },
    flags = { "LINEAR" },
}
