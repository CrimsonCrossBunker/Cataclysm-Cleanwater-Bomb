local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "basement_bionic" },
    copy_from = "generic_city_house_basement",
    spawns = { group = "GROUP_BASEMENT_HOUSE", population = { 1, 1 }, chance = 80 },
}

ccb.content.define_overmap_terrain {
    id = "lmoe_under_full",
    copy_from = "lmoe_under",
}
