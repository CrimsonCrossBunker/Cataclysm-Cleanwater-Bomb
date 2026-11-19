local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "microlab_ratkin" },
    layout = {
        fill_terrain = "t_strconc_floor",
        nested = {
            { id = "microlab_generic_tile", x = 0, y = 0 },
            {
                otherwise = { "concrete_corner" },
                x = 0,
                y = 0,
                neighbors = { north_west = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 23,
                y = 0,
                neighbors = { north_east = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 23,
                y = 23,
                neighbors = { south_east = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 0,
                y = 23,
                neighbors = { south_west = "microlab" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "microlab_ratkin_edge" },
    layout = {
        fill_terrain = "t_strconc_floor",
        nested = {
            { id = "microlab_generic_edge_tile", x = 0, y = 0 },
            { otherwise = { "concrete_wall_ew" }, x = 0, y = 0, neighbors = { north = "microlab" } },
            { otherwise = { "concrete_wall_ns" }, x = 23, y = 0, neighbors = { east = "microlab" } },
            {
                otherwise = { "concrete_wall_ew" },
                x = 0,
                y = 23,
                neighbors = { south = "microlab" },
            },
            { otherwise = { "concrete_wall_ns" }, x = 0, y = 0, neighbors = { west = "microlab" } },
            {
                otherwise = { "concrete_corner" },
                x = 0,
                y = 0,
                neighbors = { north_west = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 23,
                y = 0,
                neighbors = { north_east = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 23,
                y = 23,
                neighbors = { south_east = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 0,
                y = 23,
                neighbors = { south_west = "microlab" },
            },
        },
    },
}
