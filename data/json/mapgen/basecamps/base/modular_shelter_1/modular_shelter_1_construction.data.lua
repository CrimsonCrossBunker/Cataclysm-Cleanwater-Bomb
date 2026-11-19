local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bedroom_NW",
    layout = {
        nested = { { id = "fbmc_shelter_1_bedroom_NW", x = 8, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bedroom_W1",
    layout = {
        nested = { { id = "fbmc_shelter_1_bedroom_W1", x = 5, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bedroom_W2",
    layout = {
        nested = { { id = "fbmc_shelter_1_bedroom_W2", x = 5, y = 13 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bedroom_SW",
    layout = {
        nested = {
            { id = "fbmc_shelter_1_bedroom_SW", x = 5, y = 19 },
            { id = "fbmc_shelter_1_bedroom_W3", x = 5, y = 16 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bedroom_S",
    layout = {
        nested = {
            { id = "fbmc_shelter_1_bedroom_S1", x = 8, y = 19 },
            { id = "fbmc_shelter_1_bedroom_S2", x = 12, y = 19 },
        },
    },
}
