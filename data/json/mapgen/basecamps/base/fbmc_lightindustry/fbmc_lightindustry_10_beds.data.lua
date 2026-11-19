local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_bed_1",
    layout = {
        nested = {
            { id = "fbmc_bed_vertical", x = 19, y = 13 },
            { id = "fbmc_bed_vertical", x = 14, y = 13 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_bed_2",
    layout = {
        nested = { { id = "fbmc_bed_vertical", x = 6, y = 13 }, { id = "fbmc_bed_vertical", x = 9, y = 13 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_bed_3",
    layout = {
        nested = { { id = "fbmc_bed_vertical", x = 6, y = 7 }, { id = "fbmc_bed_vertical", x = 14, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_bed_4",
    layout = {
        nested = {
            { id = "fbmc_bed_horizontal", x = 6, y = 4 },
            { id = "fbmc_bed_horizontal", x = 13, y = 4 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_10_bed_5",
    layout = {
        nested = {
            { id = "fbmc_bed_horizontal", x = 2, y = 5 },
            { id = "fbmc_bed_horizontal", x = 1, y = 13 },
        },
    },
}
