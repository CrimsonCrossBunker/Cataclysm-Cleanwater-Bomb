local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "field",
    copy_from = "field",
    spawns = { group = "GROUP_FOREST", population = { 0, 1 }, chance = 3 },
}

ccb.content.define_overmap_terrain {
    id = "forest",
    copy_from = "forest",
    spawns = { group = "GROUP_FOREST", population = { 0, 2 }, chance = 3 },
}

ccb.content.define_overmap_terrain {
    id = "forest_thick",
    copy_from = "forest_thick",
    spawns = { group = "GROUP_FOREST_THICK", population = { 0, 4 }, chance = 5 },
}

ccb.content.define_overmap_terrain {
    id = "forest_water",
    copy_from = "forest_water",
    spawns = { group = "GROUP_SWAMP", population = { 1, 4 }, chance = 8 },
}
