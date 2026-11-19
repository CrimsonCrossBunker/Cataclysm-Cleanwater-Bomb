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
