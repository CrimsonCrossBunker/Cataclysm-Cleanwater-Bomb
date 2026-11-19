local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmsw_0",
    layout = {
        size = { width = 6, height = 6 },
        palettes = { "fbmsw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmsw_0",
    layout = {
        nested = { { id = "fbmsw_0", x = 15, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmsw_brewery1_still",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "       ",
            "       ",
            "    ^  ",
            "    #  ",
            "  s tr ",
            "       ",
        },
        palettes = { "fbmsw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmsw_brewery1_still_roof",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "       ",
            "       ",
            "       ",
            "       ",
            "  C    ",
            "       ",
        },
        palettes = { "fbmsw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmsw_brewery1_southwest",
    layout = {
        nested = {
            { id = "fbmsw_brewery1_still", x = 3, y = 14, z = 0 },
            { id = "fbmsw_brewery1_still_roof", x = 3, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmsw_brewery2_kegs",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            " H   r ",
            "       ",
            "       ",
            " H     ",
            " H     ",
            "       ",
        },
        palettes = { "fbmsw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmsw_brewery2_southwest",
    layout = {
        nested = { { id = "fbmsw_brewery2_kegs", x = 3, y = 14 } },
    },
}
