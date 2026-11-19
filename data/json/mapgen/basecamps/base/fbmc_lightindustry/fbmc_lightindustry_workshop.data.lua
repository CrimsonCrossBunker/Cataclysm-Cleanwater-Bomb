local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fbmc_lightindustry_workshop_palette",
    layout = { terrain = { x = "t_null" }, furniture = { x = "f_clear" } },
}

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

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lightindustry_workshop_drop_hammer",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_drophammer", x = 12, y = 12 } },
    },
}
