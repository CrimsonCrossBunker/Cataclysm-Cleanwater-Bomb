local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                  ;     ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            ";;;;;;;;;;;;;;;;;;;;    ",
            "                        ",
        },
        palettes = { "fbmg_2_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_garage_2_0",
    layout = {
        nested = { { id = "fbmg_2", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_3",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,,,",
            ",,,,,,,,",
            ",,,,,,,,",
            ",,,,,,,,",
            ",,,,,,,,",
            ",,,,,,,,",
            "        ",
            "        ",
        },
        palettes = { "fbmg_2_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_3_roof",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "        ",
            "        ",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_3",
    layout = {
        nested = {
            { id = "fbmg_2_3", x = 6, y = 16, z = 0 },
            { id = "fbmg_2_3_roof", x = 6, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_6_9",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,,,",
            ",,,,,,,,",
            ",,,,,,,,",
            ",,,,,,,,",
            ",,,,,,,,",
            "        ",
            "        ",
            "        ",
        },
        palettes = { "fbmg_2_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_6_9_roof",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "        ",
            "        ",
            "        ",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_6",
    layout = {
        nested = {
            { id = "fbmg_2_6_9", x = 6, y = 11, z = 0 },
            { id = "fbmg_2_6_9_roof", x = 6, y = 11, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_9",
    layout = {
        nested = {
            { id = "fbmg_2_6_9", x = 6, y = 6, z = 0 },
            { id = "fbmg_2_6_9_roof", x = 6, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_12",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,,,",
            ",,,,,,,,",
            ",,,,,,,,",
            ",,,,,,,,",
            "        ",
            "        ",
            "        ",
            "        ",
        },
        palettes = { "fbmg_2_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_12_roof",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "rrrrrrrr",
            "        ",
            "        ",
            "        ",
            "        ",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_12",
    layout = {
        nested = {
            { id = "fbmg_2_12", x = 6, y = 2, z = 0 },
            { id = "fbmg_2_12_roof", x = 6, y = 2, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_furniture",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_counter", x = 1, y = 17 },
            { shape = "point", operation = "furniture", id = "f_counter", x = 1, y = 18 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 1, y = 20 },
            { shape = "point", operation = "furniture", id = "f_rack", x = 1, y = 21 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_gate_2",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_palisade", x = 1, y = 10 },
            {
                shape = "line",
                operation = "terrain",
                id = "t_palisade_gate",
                x = 2,
                end_x = 17,
                y = 10,
                end_y = 10,
            },
            { shape = "point", operation = "terrain", id = "t_palisade", x = 18, y = 10 },
            { shape = "point", operation = "terrain", id = "t_palisade_pulley", x = 18, y = 9 },
            { shape = "point", operation = "terrain", id = "t_palisade_pulley", x = 18, y = 11 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_gate_3",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_palisade", x = 1, y = 5 },
            {
                shape = "line",
                operation = "terrain",
                id = "t_palisade_gate",
                x = 2,
                end_x = 17,
                y = 5,
                end_y = 5,
            },
            { shape = "point", operation = "terrain", id = "t_palisade", x = 18, y = 5 },
            { shape = "point", operation = "terrain", id = "t_palisade_pulley", x = 18, y = 4 },
            { shape = "point", operation = "terrain", id = "t_palisade_pulley", x = 18, y = 6 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_gate_4",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_palisade", x = 1, y = 1 },
            {
                shape = "line",
                operation = "terrain",
                id = "t_palisade_gate",
                x = 2,
                end_x = 17,
                y = 1,
                end_y = 1,
            },
            { shape = "point", operation = "terrain", id = "t_palisade", x = 18, y = 1 },
            { shape = "point", operation = "terrain", id = "t_palisade_pulley", x = 18, y = 0 },
            { shape = "point", operation = "terrain", id = "t_palisade_pulley", x = 18, y = 2 },
        },
    },
}
