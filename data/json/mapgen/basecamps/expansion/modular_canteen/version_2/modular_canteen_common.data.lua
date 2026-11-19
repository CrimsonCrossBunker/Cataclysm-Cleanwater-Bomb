local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_dining_furniture_vertical",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "hth hth",
            "hth hth",
            "hth hth",
            "hth hth",
            "       ",
            "       ",
            "       ",
        },
        palettes = { "fbmk_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_dining_furniture_horizontal",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "hhhh   ",
            "tttt   ",
            "hhhh   ",
            "       ",
            "hhhh   ",
            "tttt   ",
            "hhhh   ",
        },
        palettes = { "fbmk_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_planters_vertical",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "ppp",
            "ppp",
            "   ",
        },
        palettes = { "fbmk_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_planters_horizontal",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "pp ",
            "pp ",
            "pp ",
        },
        palettes = { "fbmk_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " ;;; ;;; ;;; ;;; ;;;    ",
            " ;;; ;;; ;;; ;;; ;;;    ",
            "                        ",
            " ;;; ;;; ;;; ;;; ;;;    ",
            " ;;; ;;; ;;; ;;; ;;;    ",
            "                        ",
            " ;;; ;;; ;;; ;;; ;;;    ",
            " ;;; ;;; ;;; ;;; ;;;    ",
            "                        ",
            ";;;;;;;;;;;;;;;; ;;;    ",
            ";;;;;;;;;;;;;;;; ;;;    ",
            ";;;;;;;;;;;;;;;;        ",
            ";;;;;;;;;;;;;;;;        ",
            ";;;;;;;;;;;;;;;;;       ",
            ";;;;;;;;;;;;;;;;;  ;    ",
            ";;;;;;;;;;;;;;;;;       ",
            ";;;;;;;;;;;;;;;; ; ;    ",
            ";;;;;;;;;;;;;;;;        ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            "                        ",
        },
        palettes = { "fbmk_2_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_canteen_2_0",
    layout = {
        nested = { { id = "fbmk_2", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_counters",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "     ",
            "ccc  ",
            "     ",
            " rrr ",
        },
        palettes = { "fbmk_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_counters",
    layout = {
        nested = { { id = "fbmk_2_counters", x = 11, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_dining_furniture",
    layout = {
        nested = { { id = "fbmk_2_dining_furniture_vertical", x = 7, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_1",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 17, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_2",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 1, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_3",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 5, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_4",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 9, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_5",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 13, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_6",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 17, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_7",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 1, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_8",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 5, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_9",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 9, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_10",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 13, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_11",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 17, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_12",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 1, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_13",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 5, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_14",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 9, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_15",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 13, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_planters_16",
    layout = {
        nested = { { id = "fbmk_2_planters_vertical", x = 17, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_still",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "  D",
            "  a",
            "s c",
        },
        palettes = { "fbmk_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_2_still_vent_pipe",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            "   ",
            "P  ",
        },
        palettes = { "fbmk_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_still",
    layout = {
        nested = {
            { id = "fbmk_2_still", x = 2, y = 19, z = 0 },
            { id = "fbmk_2_still_vent_pipe", x = 2, y = 19, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_fireplace",
    layout = {
        loot_placements = { { id = "pot", x = 10, y = 10 }, { id = "pan", x = 10, y = 10 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_fireplace", x = 11, y = 10, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 11, y = 10, z = 1 },
            { shape = "point", operation = "furniture", id = "f_counter", x = 10, y = 10, z = 0 },
            { shape = "point", operation = "furniture", id = "f_fireplace", x = 13, y = 10, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 13, y = 10, z = 1 },
            { shape = "point", operation = "furniture", id = "f_counter", x = 14, y = 10, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_stove",
    layout = {
        loot_placements = { { id = "pot", x = 10, y = 10 }, { id = "pan", x = 10, y = 10 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_woodstove", x = 11, y = 10, z = 0 },
            { shape = "point", operation = "furniture", id = "f_vent_pipe", x = 11, y = 10, z = 1 },
            { shape = "point", operation = "furniture", id = "f_counter", x = 10, y = 10, z = 0 },
            { shape = "point", operation = "furniture", id = "f_woodstove", x = 13, y = 10, z = 0 },
            { shape = "point", operation = "furniture", id = "f_vent_pipe", x = 13, y = 10, z = 1 },
            { shape = "point", operation = "furniture", id = "f_counter", x = 14, y = 10, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_well",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_water_pump", x = 17, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_smoking_kiln",
    layout = {
        tile_edits = {
            {
                shape = "point",
                operation = "furniture",
                id = "f_smoking_rack",
                x = 19,
                y = 19,
                z = 0,
            },
            {
                shape = "point",
                operation = "furniture",
                id = "f_smoking_rack",
                x = 19,
                y = 20,
                z = 0,
            },
            {
                shape = "point",
                operation = "furniture",
                id = "f_smoking_rack",
                x = 19,
                y = 21,
                z = 0,
            },
            { shape = "point", operation = "furniture", id = "f_kiln_empty", x = 17, y = 18, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 17, y = 18, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_root_cellar",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_rootcellar", x = 9, y = 14 },
            { shape = "point", operation = "terrain", id = "t_rootcellar", x = 11, y = 14 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_pantry",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "furniture",
                id = "f_rack_wood",
                x = 1,
                end_x = 9,
                y = 10,
                end_y = 10,
            },
            {
                shape = "line",
                operation = "furniture",
                id = "f_rack_wood",
                x = 1,
                end_x = 7,
                y = 12,
                end_y = 12,
            },
            {
                shape = "line",
                operation = "furniture",
                id = "f_rack_wood",
                x = 1,
                end_x = 8,
                y = 14,
                end_y = 14,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_butchery",
    layout = {
        loot_placements = { { id = "knife_huge", variant = "knife_butcher", x = 17, y = 22 } },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_butcher_rack", x = 16, y = 22 },
            { shape = "point", operation = "furniture", id = "f_table", x = 17, y = 22 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_bench_bath",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_bench", x = 16, y = 13 },
            { shape = "point", operation = "furniture", id = "f_bench", x = 16, y = 14 },
            { shape = "point", operation = "furniture", id = "f_bench", x = 16, y = 15 },
            { shape = "point", operation = "furniture", id = "f_birdbath", x = 19, y = 14 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_tank",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_standing_tank", x = 1, y = 11 },
            { shape = "point", operation = "furniture", id = "f_standing_tank", x = 1, y = 13 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_display",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "furniture",
                id = "f_rack",
                x = 2,
                end_x = 4,
                y = 16,
                end_y = 16,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_vat",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "furniture",
                id = "f_fvat_empty",
                x = 1,
                end_x = 1,
                y = 16,
                end_y = 21,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_windmill",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_wind_mill", x = 19, y = 16 } },
    },
}
