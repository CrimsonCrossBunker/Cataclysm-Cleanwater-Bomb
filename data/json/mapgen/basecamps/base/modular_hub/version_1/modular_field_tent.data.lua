local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_large_tent_east",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " wwwww",
            " w...w",
            " +...w",
            " w...w",
            " wwwww",
        },
        palettes = { "fbmh_tent_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_large_tent_roof_east",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " rrrrr",
            " rrrrr",
            " rrrrr",
            " rrrrr",
            " rrrrr",
        },
        palettes = { "fbmh_tent_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_tent_northeast",
    layout = {
        nested = {
            { id = "fbmh_large_tent_east", x = 15, y = 3, z = 0 },
            { id = "fbmh_large_tent_roof_east", x = 15, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_tent_east",
    layout = {
        nested = {
            { id = "fbmh_large_tent_east", x = 15, y = 9, z = 0 },
            { id = "fbmh_large_tent_roof_east", x = 15, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_tent_southeast",
    layout = {
        nested = {
            { id = "fbmh_large_tent_east", x = 15, y = 15, z = 0 },
            { id = "fbmh_large_tent_roof_east", x = 15, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_large_tent_west",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "wwwww ",
            "w...w ",
            "w...+ ",
            "w...w ",
            "wwwww ",
        },
        palettes = { "fbmh_tent_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_large_tent_roof_west",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "rrrrr ",
            "rrrrr ",
            "rrrrr ",
            "rrrrr ",
            "rrrrr ",
        },
        palettes = { "fbmh_tent_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_tent_northwest",
    layout = {
        nested = {
            { id = "fbmh_large_tent_west", x = 3, y = 3, z = 0 },
            { id = "fbmh_large_tent_roof_west", x = 3, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_tent_west",
    layout = {
        nested = {
            { id = "fbmh_large_tent_west", x = 3, y = 9, z = 0 },
            { id = "fbmh_large_tent_roof_west", x = 3, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_tent_southwest",
    layout = {
        nested = {
            { id = "fbmh_large_tent_west", x = 3, y = 15, z = 0 },
            { id = "fbmh_large_tent_roof_west", x = 3, y = 15, z = 1 },
        },
    },
}
