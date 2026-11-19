local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_1_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "rr     ",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_1_construction",
    layout = {
        nested = {
            { id = "fbmg_2_1_construction", x = 0, y = 16, z = 0 },
            { id = "fbmg_2_1_roof_construction", x = 0, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_2_roof_construction",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "rrrrrr ",
            "    rr ",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_2_construction",
    layout = {
        nested = {
            { id = "fbmg_2_2_construction", x = 14, y = 16, z = 0 },
            { id = "fbmg_2_2_roof_construction", x = 14, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_wall_1_3_roof_construction",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "     ",
            "     ",
            "     ",
            "rrrrr",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_wall_2_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
            "rrrrrr",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_wall_construction",
    layout = {
        nested = {
            { id = "fbmg_2_wall_1_construction", x = 2, y = 18, z = 0 },
            { id = "fbmg_2_wall_1_3_roof_construction", x = 2, y = 18, z = 1 },
            { id = "fbmg_2_wall_2_construction", x = 7, y = 17, z = 0 },
            { id = "fbmg_2_wall_2_roof_construction", x = 7, y = 17, z = 1 },
            { id = "fbmg_2_wall_3_construction", x = 13, y = 18, z = 0 },
            { id = "fbmg_2_wall_1_3_roof_construction", x = 13, y = 18, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_4_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "r     ",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_4_construction",
    layout = {
        nested = {
            { id = "fbmg_2_4_construction", x = 0, y = 10, z = 0 },
            { id = "fbmg_2_4_roof_construction", x = 0, y = 10, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_5_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "     r",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_5_construction",
    layout = {
        nested = {
            { id = "fbmg_2_5_construction", x = 14, y = 10, z = 0 },
            { id = "fbmg_2_5_roof_construction", x = 14, y = 10, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_7_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "r     ",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            " rrrrr",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_7_construction",
    layout = {
        nested = {
            { id = "fbmg_2_7_construction", x = 0, y = 5, z = 0 },
            { id = "fbmg_2_7_roof_construction", x = 0, y = 5, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_8_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "     r",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrr ",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_8_construction",
    layout = {
        nested = {
            { id = "fbmg_2_8_construction", x = 14, y = 5, z = 0 },
            { id = "fbmg_2_8_roof_construction", x = 14, y = 5, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_10_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "r     ",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            " rrrrr",
            "      ",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_10_construction",
    layout = {
        nested = {
            { id = "fbmg_2_10_construction", x = 0, y = 1, z = 0 },
            { id = "fbmg_2_10_roof_construction", x = 0, y = 1, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmg_2_11_roof_construction",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "     r",
            "rrrrrr",
            "rrrrrr",
            "rrrrrr",
            "rrrrr ",
            "      ",
        },
        palettes = { "fbmg_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmg_2_11_construction",
    layout = {
        nested = {
            { id = "fbmg_2_11_construction", x = 14, y = 1, z = 0 },
            { id = "fbmg_2_11_roof_construction", x = 14, y = 1, z = 1 },
        },
    },
}
