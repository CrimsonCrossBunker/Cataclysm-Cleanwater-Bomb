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
