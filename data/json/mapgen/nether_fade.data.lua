local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "nether_glass" },
    layout = {
        fill_terrain = "t_nether_glass_floor",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "nether_glass_deep" },
    layout = {
        fill_terrain = "t_nether_glass_floor",
        nested = {
            {
                otherwise = { "nether_glass_impassable_corner" },
                x = 0,
                y = 0,
                neighbors = { north_west = "nether_glass" },
            },
            {
                otherwise = { "nether_glass_impassable_corner" },
                x = 22,
                y = 0,
                neighbors = { north_east = "nether_glass" },
            },
            {
                otherwise = { "nether_glass_impassable_corner" },
                x = 22,
                y = 22,
                neighbors = { south_east = "nether_glass" },
            },
            {
                otherwise = { "nether_glass_impassable_corner" },
                x = 0,
                y = 22,
                neighbors = { south_west = "nether_glass" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "nether_glass_impassable" },
    layout = {
        fill_terrain = "t_nether_glass_wall",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "nether_glass_imperial_road" },
    layout = {
        fill_terrain = "t_nether_glass_floor",
        nested = {
            { id = "fade_ruins_east", x = 0, y = 0, neighbors = { east = "highland_ruins" } },
            { id = "fade_ruins_west", x = 0, y = 0, neighbors = { west = "highland_ruins" } },
            { id = "fade_ruins_north", x = 0, y = 0, neighbors = { north = "highland_ruins" } },
            { id = "fade_ruins_south", x = 0, y = 0, neighbors = { south = "highland_ruins" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nether_glass_impassable_corner",
    layout = {
        size = { width = 2, height = 2 },
        tile_edits = {
            {
                shape = "point",
                operation = "terrain",
                id = "t_nether_glass_wall",
                x = { 0, 1 },
                y = { 0, 1 },
            },
        },
    },
}
