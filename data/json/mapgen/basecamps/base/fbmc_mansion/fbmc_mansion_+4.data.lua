local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_mansion_+4_prefarm",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "dddddd",
            "dddddd",
            "dddddd",
            "dddddd",
            "      ",
            "      ",
        },
        terrain = { d = "t_dirt" },
        furniture = { d = "f_clear" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_mansion_+4_farm",
    layout = {
        nested = {
            { id = "fbmc_mansion_+4_prefarm", x = 4, y = 10 },
            { id = "fbmc_mansion_+4_prefarm", x = 14, y = 10 },
            { id = "fbmc_mansion_farm_field", x = 4, y = 11 },
            { id = "fbmc_mansion_farm_field", x = 15, y = 11 },
        },
    },
}
