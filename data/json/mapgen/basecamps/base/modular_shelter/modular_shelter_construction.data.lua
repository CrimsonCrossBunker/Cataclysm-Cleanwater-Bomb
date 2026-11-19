local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_bedroom_se",
    layout = {
        nested = { { id = "fbmc_shelter_bedroom_SE", x = 15, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_bedroom_e",
    layout = {
        nested = { { id = "fbmc_shelter_bedroom_E", x = 15, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_bedroom_SW",
    layout = {
        nested = { { id = "fbmc_shelter_bedroom_SW", x = 4, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_bedroom_W",
    layout = {
        nested = { { id = "fbmc_shelter_bedroom_W", x = 5, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_bedroom_NW",
    layout = {
        nested = { { id = "fbmc_shelter_bedroom_NW", x = 5, y = 8 } },
    },
}
