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
