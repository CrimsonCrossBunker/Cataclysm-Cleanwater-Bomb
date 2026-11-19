local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "faction_base_lightindustry_workshop_0" },
    layout = {
        fill_terrain = "t_dirt",
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "faction_base_lightindustry_workshop_0",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "x     ",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "fbmc_lightindustry_workshop_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_lightindustry_workshop_0",
    layout = {
        nested = { { id = "faction_base_lightindustry_workshop_0", x = 0, y = 0 } },
    },
}
