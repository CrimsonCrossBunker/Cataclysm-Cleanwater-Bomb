local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "fbmf_2_common_palette",
    layout = {
        terrain = {
            F = "t_splitrail_fence",
            g = "t_splitrail_fencegate_c",
            m = "t_dirtmound",
            p = "t_palisade",
            P = "t_palisade_pulley",
            G = "t_palisade_gate",
            [";"] = "t_dirt",
        },
        furniture = { [";"] = "f_clear" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmf_2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            ";;;;;;;;;;;;;;;;;;;;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                 ;;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";                  ;    ",
            "; ;;;;;;;;;;;;;;;; ;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            "                        ",
        },
        palettes = { "fbmf_2_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_farm_2_0",
    layout = {
        nested = { { id = "fbmf_2", x = 0, y = 0 } },
    },
}

-- Dummy map to add recipes to preexisting farm extensions as a fallback
ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmf_2_fallback_recipe_1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            " ",
        },
        palettes = { "fbmf_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_fallback_recipe_1",
    layout = {
        nested = { { id = "fbmf_2_fallback_recipe_1", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_plot_1",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 21,
                end_y = 21,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_plot_2",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 1,
                end_y = 1,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_plot_3",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 18,
                end_y = 18,
            },
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 19,
                end_y = 19,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_plot_4",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 15,
                end_y = 15,
            },
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 16,
                end_y = 16,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_plot_5",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 12,
                end_y = 12,
            },
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 13,
                end_y = 13,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_plot_6",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 9,
                end_y = 9,
            },
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 10,
                end_y = 10,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_plot_7",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 6,
                end_y = 6,
            },
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 7,
                end_y = 7,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_plot_8",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 3,
                end_y = 3,
            },
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirtmound",
                x = 2,
                end_x = 17,
                y = 4,
                end_y = 4,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_fence_1",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_splitrail_fence",
                x = 0,
                end_x = 0,
                y = 0,
                end_y = 22,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_fence_2",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_splitrail_fence",
                x = 1,
                end_x = 19,
                y = 0,
                end_y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_fence_3",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_splitrail_fence",
                x = 1,
                end_x = 17,
                y = 22,
                end_y = 22,
            },
            {
                shape = "point",
                operation = "terrain",
                id = "t_splitrail_fencegate_c",
                x = 18,
                y = 22,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_fence_4",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_splitrail_fence",
                x = 19,
                end_x = 19,
                y = 0,
                end_y = 13,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_gate",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_palisade", x = 19, y = 14 },
            {
                shape = "line",
                operation = "terrain",
                id = "t_palisade_gate",
                x = 19,
                end_x = 19,
                y = 15,
                end_y = 21,
            },
            { shape = "point", operation = "terrain", id = "t_palisade", x = 19, y = 22 },
            { shape = "point", operation = "terrain", id = "t_palisade_pulley", x = 18, y = 14 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmf_2_fence_5",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_splitrail_fence",
                x = 19,
                end_x = 19,
                y = 14,
                end_y = 22,
            },
        },
    },
}
