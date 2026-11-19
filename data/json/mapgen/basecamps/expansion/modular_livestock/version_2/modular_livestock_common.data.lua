local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_livestock_2_0",
    layout = {
        nested = { { id = "fbml_2", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_1",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "F  ",
            "g  ",
            "Fbb",
        },
        palettes = { "fbml_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_bench",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "F    ",
            "g    ",
            "Fb   ",
            " b   ",
            " b   ",
        },
        palettes = { "fbml_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "F  ",
            "g  ",
            "F  ",
        },
        palettes = { "fbml_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "g    ",
            "Fb   ",
            " b   ",
            "Fb   ",
            "g    ",
        },
        palettes = { "fbml_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_shack_furniture",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "rrr",
            "  t",
            "  w",
        },
        palettes = { "fbml_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;       ;;;;;;;    ",
            ";;;;;;       ;;;;;;;    ",
            ";;;;;;       ;;;;;;;    ",
            ";;;;;;       ;;;;;;;    ",
            ";;;;;;       ;;;;;;;    ",
            ";;;;;;       ;;;;;;;    ",
            ";;;;;;       ;;;;;;;    ",
            ";;;;;;       ;     ;    ",
            ";;;;;;       ;     ;    ",
            ";;;;;;       ;     ;    ",
            ";;;;;;       ;     ;    ",
            ";;;;;;       ;     ;    ",
            ";;;;;;       ;;;;;;;    ",
            ";;;;;;             ;    ",
            ";;;;;;             ;    ",
            ";;;;;;             ;    ",
            ";;;;;;             ;    ",
            ";;;;;;         ;;;;;    ",
            ";;;;;;         ;;;;;    ",
            ";;;;;;         ;;;;;    ",
            ";;;;;;         ;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            "                        ",
        },
        palettes = { "fbml_2_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        zone_placements = { { id = "NPC_NO_INVESTIGATE", faction = "your_followers", x = { 0, 23 }, y = { 0, 23 } } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_coop_yard",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_chickenwire_fence",
                x = 13,
                end_x = 13,
                y = 8,
                end_y = 13,
            },
            { shape = "point", operation = "terrain", id = "t_chickenwire_fence", x = 14, y = 7 },
            { shape = "point", operation = "terrain", id = "t_chickenwire_fence", x = 15, y = 7 },
            { shape = "point", operation = "terrain", id = "t_chickenwire_gate_c", x = 16, y = 7 },
            { shape = "point", operation = "terrain", id = "t_chickenwire_fence", x = 17, y = 7 },
            { shape = "point", operation = "terrain", id = "t_chickenwire_fence", x = 18, y = 7 },
            { shape = "point", operation = "terrain", id = "t_chickenwire_fence", x = 14, y = 13 },
            { shape = "point", operation = "terrain", id = "t_chickenwire_fence", x = 15, y = 13 },
            { shape = "point", operation = "terrain", id = "t_chickenwire_gate_c", x = 16, y = 13 },
            { shape = "point", operation = "terrain", id = "t_chickenwire_fence", x = 17, y = 13 },
            { shape = "point", operation = "terrain", id = "t_chickenwire_fence", x = 18, y = 13 },
            {
                shape = "line",
                operation = "terrain",
                id = "t_chickenwire_fence",
                x = 19,
                end_x = 19,
                y = 8,
                end_y = 13,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_remote_fence",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 6, y = 0 },
            { shape = "point", operation = "terrain", id = "t_splitrail_fencegate_c", x = 7, y = 0 },
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 8, y = 0 },
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 9, y = 0 },
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 10, y = 0 },
            {
                shape = "point",
                operation = "terrain",
                id = "t_splitrail_fencegate_c",
                x = 11,
                y = 0,
            },
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 12, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_side_fence",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 19, y = 14 },
            {
                shape = "point",
                operation = "terrain",
                id = "t_splitrail_fencegate_c",
                x = 19,
                y = 15,
            },
            {
                shape = "point",
                operation = "terrain",
                id = "t_splitrail_fencegate_c",
                x = 19,
                y = 16,
            },
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 19, y = 17 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_near_fence",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 6, y = 22 },
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 7, y = 22 },
            {
                shape = "point",
                operation = "terrain",
                id = "t_splitrail_fencegate_c",
                x = 8,
                y = 22,
            },
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 9, y = 22 },
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 10, y = 22 },
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 11, y = 22 },
            {
                shape = "point",
                operation = "terrain",
                id = "t_splitrail_fencegate_c",
                x = 12,
                y = 22,
            },
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 13, y = 22 },
            { shape = "point", operation = "terrain", id = "t_splitrail_fence", x = 14, y = 22 },
        },
    },
}
