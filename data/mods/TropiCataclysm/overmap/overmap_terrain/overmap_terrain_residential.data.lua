local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "overgrownlot",
    copy_from = "generic_city_building",
    name = ccb.content.text("overgrown lot"),
    symbol = "O",
    color = "i_green",
    spawns = { group = "GROUP_TRIFFID_URBAN", population = { 8, 12 }, chance = 100 },
    extend = { flags = { "GENERIC_LOOT" } },
}

ccb.content.define_overmap_terrain {
    id = "overtakenlot",
    copy_from = "generic_city_building",
    name = ccb.content.text("overtaken lot"),
    symbol = "O",
    color = "i_green",
    spawns = { group = "GROUP_FUNGI_URBAN", population = { 8, 12 }, chance = 100 },
    extend = { flags = { "GENERIC_LOOT" } },
}
