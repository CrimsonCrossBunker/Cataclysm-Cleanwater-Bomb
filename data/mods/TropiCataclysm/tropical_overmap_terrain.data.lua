local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "desert",
    copy_from = "generic_open_land",
    name = ccb.content.text("desert"),
    symbol = ".",
    color = "yellow",
    see_cost = "none",
    extras = "field",
    spawns = { group = "GROUP_FOREST", population = { 0, 1 }, chance = 13 },
    flags = { "NO_ROTATE" },
}
