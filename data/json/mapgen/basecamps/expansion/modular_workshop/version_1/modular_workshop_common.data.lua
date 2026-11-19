local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_0",
    layout = {
        size = { width = 6, height = 6 },
        palettes = { "fbmw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_workshop_0",
    layout = {
        nested = { { id = "fbmw_0", x = 15, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room1_common",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "  ftL ",
            "      ",
            "      ",
            "      ",
            "    x ",
        },
        palettes = { "fbmw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room1_roof_common",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "  C   ",
            "      ",
            "      ",
            "      ",
            "    C ",
        },
        palettes = { "fbmw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room2_common",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "r     ",
            "    c ",
            "  A c ",
            "    c ",
            "      ",
        },
        palettes = { "fbmw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room10_common",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " Q    ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "fbmw_common_palette" },
    },
}
