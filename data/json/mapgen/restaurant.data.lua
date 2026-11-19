local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "3x3_foodplace_stairwell",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "#@+",
            "#< ",
            "###",
        },
        palettes = { "restaurant_palette" },
        terrain = {
            ["<"] = "t_stairs_up",
            ["+"] = "t_door_metal_locked",
            ["@"] = "t_card_fp",
            [" "] = "t_null",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_angry_diners",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "   @@   @@    @@   @@   ",
            "                        ",
            "                        ",
            "   @@   @@    @@   @@   ",
            "                        ",
            "   @@   @@    @@   @@   ",
            "                        ",
            "                        ",
            "   @@   @@    @@   @@   ",
            "                        ",
            "                        ",
            " @                      ",
            "                      @ ",
            " @      @      @        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        nested_glyphs = {
            ["@"] = { choices = { { id = "1x1_GROUP_GROCERY", weight = 1 }, { id = "null", weight = 4 } } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "13x13_checkered_floor",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "wgwgwgwgwgwgw",
            "gwgwgwgwgwgwg",
            "wgwgwgwgwgwgw",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
            "             ",
        },
        terrain = { w = "t_linoleum_white", g = "t_linoleum_gray" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "s_restaurant_upper_roof_2" },
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
            "     -----              ",
            "     -...-              ",
            "     -----              ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "roof_palette" },
        fill_terrain = "t_flat_roof",
    },
}
