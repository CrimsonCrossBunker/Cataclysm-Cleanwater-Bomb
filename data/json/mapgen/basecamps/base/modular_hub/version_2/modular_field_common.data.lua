local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2",
    layout = {
        rows = {
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,,,,,,,        ,,,,,",
            ",,,,,,,,,,,        ,,,,,",
            ",,,,,,,,,,,        ,,,,,",
            ",,,,,,,,,,,        ,,,,,",
            ",,,,,,,,,,,        ,,,,,",
            ",,,,,,,,,,,        ,,,,,",
            ",,,,,              ,,,,,",
            ",,,,,    ,;  , ,,  ,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,              ,,,,,",
            ",,,,,              ,,,,,",
            ",,,,,              ,,,,,",
            ",,,,,              ,,,,,",
            ",,,,,              ,,,,,",
            ",,,,,              ,,,,,",
            ",,,,,              ,,,,,",
            ",,,,,              ,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
        },
        palettes = { "fbmh_2_palette_common" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_cooking_NE",
    layout = {
        nested = {
            { id = "fbmh_2_cooking_NE", x = 22, y = 2, z = 0 },
            { id = "fbmh_2_cooking_NE_roof", x = 22, y = 2, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_tent_cooking_NE",
    layout = {
        nested = {
            { id = "fbmh_2_tent_cooking_NE", x = 22, y = 2, z = 0 },
            { id = "fbmh_2_tent_cooking_NE_roof", x = 22, y = 2, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_bed_NE_1",
    layout = {
        nested = { { id = "fbmh_2_bedset_east", x = 20, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_bed_NE_2",
    layout = {
        nested = { { id = "fbmh_2_bedset_east", x = 20, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_bed_ENE",
    layout = {
        nested = {
            { id = "fbmh_2_bedset_east", x = 20, y = 6 },
            { id = "fbmh_2_bedset_east", x = 20, y = 9 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_bed_ESE",
    layout = {
        nested = {
            { id = "fbmh_2_bedset_east", x = 20, y = 14 },
            { id = "fbmh_2_bedset_east", x = 20, y = 17 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_bed_SE",
    layout = {
        nested = {
            { id = "fbmh_2_bedset_east", x = 20, y = 19 },
            { id = "fbmh_2_bedset_east", x = 20, y = 22 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_bed_NW",
    layout = {
        nested = { { id = "fbmh_2_bedset_west", x = 1, y = 1 }, { id = "fbmh_2_bedset_west", x = 1, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_bed_WNW",
    layout = {
        nested = { { id = "fbmh_2_bedset_west", x = 1, y = 6 }, { id = "fbmh_2_bedset_west", x = 1, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_bed_WSW",
    layout = {
        nested = {
            { id = "fbmh_2_bedset_west", x = 1, y = 14 },
            { id = "fbmh_2_bedset_west", x = 1, y = 17 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_bed_SW",
    layout = {
        nested = {
            { id = "fbmh_2_bedset_west", x = 1, y = 19 },
            { id = "fbmh_2_bedset_west", x = 1, y = 22 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_center_table_west",
    layout = {
        nested = { { id = "fbmh_2_tableset", x = 6, y = 10 }, { id = "fbmh_2_tableset", x = 6, y = 11 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_center_table_east",
    layout = {
        nested = { { id = "fbmh_2_tableset", x = 15, y = 10 }, { id = "fbmh_2_tableset", x = 15, y = 11 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_center_table",
    layout = {
        nested = {
            { id = "fbmh_2_tableset_large", x = 10, y = 10 },
            { id = "fbmh_2_tableset_large", x = 10, y = 11 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_parkour",
    layout = {
        nested = { { id = "fbmh_2_parkour", x = 5, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_parkour",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            ".cc...",
            "....#.",
            "..x.#.",
            "...x..",
            "......",
            ".eEe..",
        },
        palettes = { "fbmh_2_palette_common" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_brazier_NE",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_brazier", x = 22, y = 2 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_center_fireplace",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_fireplace", x = 2, y = 12, z = 0 },
            { shape = "point", operation = "furniture", id = "f_chimney", x = 2, y = 12, z = 1 },
            { shape = "point", operation = "furniture", id = "f_counter", x = 3, y = 12, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_center_butchery",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_butcher_rack", x = 21, y = 11 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_center_toolrack",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bookcase", x = 4, y = 12 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tableset",
    layout = {
        size = { width = 3, height = 3 },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_chair", x = 0, y = 1 },
            { shape = "point", operation = "furniture", id = "f_table", x = 1, y = 1 },
            { shape = "point", operation = "furniture", id = "f_chair", x = 2, y = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tableset_large",
    layout = {
        size = { width = 4, height = 4 },
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_chair", x = 0, y = 1 },
            { shape = "point", operation = "furniture", id = "f_table", x = 1, y = 1 },
            { shape = "point", operation = "furniture", id = "f_table", x = 2, y = 1 },
            { shape = "point", operation = "furniture", id = "f_chair", x = 3, y = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_center_stove",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_woodstove", x = 19, y = 11, z = 0 },
            { shape = "point", operation = "furniture", id = "f_vent_pipe", x = 19, y = 11, z = 1 },
            { shape = "point", operation = "furniture", id = "f_counter", x = 20, y = 11, z = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_well",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_water_pump", x = 9, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_root_cellar",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_rootcellar", x = 13, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_radio_tower",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_radio_tower", x = 17, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_radio_console",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_radio_controls", x = 16, y = 8 } },
    },
}
