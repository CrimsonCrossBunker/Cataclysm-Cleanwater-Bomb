local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "outer_space",
    layout = {
        nested = {
            {
                x = 0,
                y = 0,
                required_flags = { north = { "ROAD", "SIDEWALK" } },
                id = "24x24_wall_h_hunvre",
            },
            {
                x = 0,
                y = 22,
                required_flags = { south = { "ROAD", "SIDEWALK" } },
                id = "24x24_wall_h_hunvre",
            },
            {
                x = 0,
                y = 0,
                required_flags = { west = { "ROAD", "SIDEWALK" } },
                id = "24x24_wall_v_hunvre",
            },
            {
                x = 22,
                y = 0,
                required_flags = { east = { "ROAD", "SIDEWALK" } },
                id = "24x24_wall_v_hunvre",
            },
            {
                x = 0,
                y = 0,
                required_flags = { north_west = { "ROAD", "SIDEWALK" } },
                id = "2x2_corner_hunvre",
            },
            {
                x = 22,
                y = 0,
                required_flags = { north_east = { "ROAD", "SIDEWALK" } },
                id = "2x2_corner_hunvre",
            },
            {
                x = 0,
                y = 22,
                required_flags = { south_west = { "ROAD", "SIDEWALK" } },
                id = "2x2_corner_hunvre",
            },
            {
                x = 22,
                y = 22,
                required_flags = { south_east = { "ROAD", "SIDEWALK" } },
                id = "2x2_corner_hunvre",
            },
        },
        fill_terrain = "t_hard_vacuum",
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_wall_v_hunvre",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
            "##                      ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "road_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_wall_h_hunvre",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "########################",
            "########################",
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
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "road_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "2x2_corner_hunvre",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "##",
            "##",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "road_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "ship_frame",
    layout = {
        fill_terrain = "t_open_air",
    },
}

ccb.content.define_overmap_terrain {
    id = "outer_space",
    vision_levels = "large_building",
    see_cost = "full_high",
    name = ccb.content.text("outer space"),
    symbol = ".",
    color = "black",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "ship_frame",
    vision_levels = "large_building",
    see_cost = "full_high",
    name = ccb.content.text("frame"),
    symbol = ".",
    color = "black",
    flags = { "NO_ROTATE" },
}
