local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_warped_tree_grove",
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
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "warped_tree_grove_chunk", x = { 2, 8 }, y = { 2, 8 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "warped_tree_grove_chunk",
    weight = 1000,
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "  ,,,  ",
            " ,W,W, ",
            ",W,,,W,",
            ",,,,,,,",
            ",W,,,W,",
            " ,W,W, ",
            "  ,,,  ",
        },
        terrain = {
            [","] = { { id = "t_dirt", copies = 50 }, { id = "t_grass_dead", copies = 25 } },
            W = "t_tree_dead_warped",
            [" "] = "t_null",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "warped_tree_grove_chunk",
    weight = 750,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "    ,,,,    ",
            "  ,,W,,W,,  ",
            " ,W,,,,,,W, ",
            " ,,,,,,,,,, ",
            ",W,,,,,,,,W,",
            ",,,,,,,,,,,,",
            ",,,,,,,,,,,,",
            ",W,,,,,,,,W,",
            " ,,,,,,,,,, ",
            " ,W,,,,,,W, ",
            "  ,,W,,W,,  ",
            "    ,,,,    ",
        },
        terrain = {
            [","] = { { id = "t_dirt", copies = 50 }, { id = "t_grass_dead", copies = 25 } },
            W = "t_tree_dead_warped",
            [" "] = "t_null",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
