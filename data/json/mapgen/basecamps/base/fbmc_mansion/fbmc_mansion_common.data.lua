local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_mansion_farm_field",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "fffff",
            "fffff",
            "     ",
            "     ",
            "     ",
        },
        terrain = { f = "t_dirtmound" },
        furniture = { f = "f_clear" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_mansion_farm_field_thin",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "fffff",
            "     ",
            "     ",
            "     ",
            "     ",
        },
        terrain = { f = "t_dirtmound" },
        furniture = { f = "f_clear" },
    },
}
