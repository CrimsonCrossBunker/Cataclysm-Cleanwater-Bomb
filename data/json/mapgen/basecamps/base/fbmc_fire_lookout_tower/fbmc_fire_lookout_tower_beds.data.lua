local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_fire_lookout_tower_beds_0",
    layout = {
        nested = { { id = "fbmc_bed_vertical", x = 8, y = 6 }, { id = "fbmc_bed_vertical", x = 11, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_fire_lookout_tower_beds_1",
    layout = {
        nested = {
            { id = "fbmc_bed_vertical", x = 10, y = 17 },
            { id = "fbmc_bed_vertical", x = 13, y = 17 },
        },
    },
}
