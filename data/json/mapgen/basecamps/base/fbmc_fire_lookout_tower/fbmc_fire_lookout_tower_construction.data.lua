local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_fire_lookout_tower_construction_shack_0",
    layout = {
        nested = {
            { id = "fbmc_construction_wall_vertical", x = 7, y = 5 },
            { id = "fbmc_construction_shack_south", x = 8, y = 5 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_fire_lookout_tower_construction_shack_1",
    layout = {
        nested = {
            { id = "fbmc_construction_wall_vertical", x = 9, y = 14 },
            { id = "fbmc_construction_shack_north", x = 10, y = 14 },
        },
    },
}
