local ccb = require("ccb")

-- Obsolete 2024-06-24. Remains to generate in older saves
ccb.content.define_mapgen {
    kind = "overmap",
    id = "cs_market_small_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "open_air_market_palette" },
        fill_terrain = "t_open_air",
    },
}
