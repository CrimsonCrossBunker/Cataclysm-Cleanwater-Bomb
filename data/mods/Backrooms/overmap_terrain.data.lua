local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "backfloorchamber",
    name = ccb.content.text("backroom chamber"),
    symbol = ".",
    color = "white",
    see_cost = "full_high",
    spawns = { group = "GROUP_BACKROOMS", population = { 2, 15 }, chance = 40 },
    extras = "backrooms",
}

ccb.content.define_overmap_terrain {
    id = { "backroom_stairs_bottom", "backroom_stairs_top" },
    name = ccb.content.text("backroom stairs"),
    symbol = "S",
    color = "white",
    see_cost = "full_high",
    spawns = { group = "GROUP_BACKROOMS", population = { 2, 15 }, chance = 40 },
    extras = "backrooms",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "backroom_border",
    name = "",
    symbol = ".",
    color = "white",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}
