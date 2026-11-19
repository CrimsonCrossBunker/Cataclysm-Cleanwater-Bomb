local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_bed_1",
    layout = {
        nested = {
            { id = "fbmc_bed_vertical", x = 15, y = 13 },
            { id = "fbmc_bed_horizontal", x = 1, y = 20 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_bed_2",
    layout = {
        nested = { { id = "fbmc_bed_vertical", x = 10, y = 8 }, { id = "fbmc_bed_vertical", x = 8, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_bed_3",
    layout = {
        nested = {
            { id = "fbmc_bed_vertical", x = 8, y = 15 },
            { id = "fbmc_bed_horizontal", x = 6, y = 13 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_bed_4",
    layout = {
        nested = {
            { id = "fbmc_bed_vertical", x = 1, y = 12 },
            { id = "fbmc_bed_horizontal", x = 2, y = 8 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_00_bed_5",
    layout = {
        nested = {
            { id = "fbmc_bed_vertical", x = 1, y = 17 },
            { id = "fbmc_bed_horizontal", x = 1, y = 15 },
        },
    },
}
