local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "string_dimension_void",
    layout = {
        fill_terrain = "t_string_void",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "string_dimension_true_void",
    layout = {
        fill_terrain = "t_string_true_void",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "string_dimension_crossroads",
    layout = {
        rows = {
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "---------+-+-+----------",
            "         | | |          ",
            "---------+-+-+----------",
            "         | | |          ",
            "---------+-+-+----------",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
            "         | | |          ",
        },
        terrain = {
            ["|"] = "t_string_y",
            ["-"] = "t_string_x",
            ["+"] = "t_string_xy",
            [" "] = {
                { id = "t_string_void", copies = 194 },
                { id = "t_string_point_big", copies = 1 },
                { id = "t_string_point_big", copies = 1 },
                { id = "t_string_point_small_gray", copies = 2 },
                { id = "t_string_point_small_gray", copies = 2 },
            },
        },
        fill_terrain = "t_string_void",
        monster_glyphs = {
            ["|"] = { id = "mon_linelander_cyan", chance = 1 },
            ["-"] = { id = "mon_linelander_magenta", chance = 1 },
        },
    },
}
