local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "afs_tunnel_ravine_edge" },
    layout = {
        rows = {
            "##0.................####",
            "###0................00##",
            "###00..............00###",
            "####0.............00####",
            "####000..........000####",
            "####00............00####",
            "####0.............00####",
            "####000...........00####",
            "######0...........00####",
            "######0...........0#####",
            "######0..........0######",
            "######0..........0######",
            "######0..........0######",
            "######0..........0######",
            "######0..........0######",
            "000000..'......'.0000000",
            "''''''''''...'..''''''''",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
        },
        palettes = { "afs_tunnel_any" },
        nested = {
            { otherwise = { "tunnel_corner_l" }, x = 0, y = 15, neighbors = { west = "ravine" } },
            { otherwise = { "tunnel_corner_r" }, x = 15, y = 15, neighbors = { east = "ravine" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tunnel_corner_l",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "#####    ",
            "####     ",
            "####     ",
            "####     ",
            "####     ",
            "####     ",
            "####     ",
            "#####    ",
            "######## ",
        },
        palettes = { "afs_tunnel" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "tunnel_corner_r",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "  #######",
            "    #####",
            "      ###",
            "     ####",
            "       ##",
            "      ###",
            "      ###",
            "    #####",
            " ## #####",
        },
        palettes = { "afs_tunnel" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}
