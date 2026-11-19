local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tent_room_1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " wwwww",
            " w...w",
            " +...w",
            " v...w",
            " w...w",
            " wwwww",
        },
        palettes = { "fbmh_2_tent_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tent_room_1_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " rrrrr",
            " rrrrr",
            " rrrrr",
            " rrrrr",
            " rrrrr",
            " rrrrr",
        },
        palettes = { "fbmh_2_tent_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_tent_room_NE",
    layout = {
        nested = {
            { id = "fbmh_2_tent_room_1", x = 18, y = 0, z = 0 },
            { id = "fbmh_2_tent_room_1_roof", x = 18, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tent_room_2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "w...w",
            "v...w",
            "+...w",
            "w...w",
            "wwwww",
        },
        palettes = { "fbmh_2_tent_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tent_room_2_8_roof",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "rrrrr",
            "rrrrr",
            "rrrrr",
            "rrrrr",
            "rrrrr",
        },
        palettes = { "fbmh_2_tent_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_tent_room_ENE",
    layout = {
        nested = {
            { id = "fbmh_2_tent_room_2", x = 19, y = 6, z = 0 },
            { id = "fbmh_2_tent_room_2_8_roof", x = 19, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tent_room_3",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "w...w",
            "+...w",
            "v...w",
            "w...w",
            "wwwww",
        },
        palettes = { "fbmh_2_tent_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_tent_room_ESE",
    layout = {
        nested = {
            { id = "fbmh_2_tent_room_3", x = 19, y = 14, z = 0 },
            { id = "fbmh_2_tent_room_2_8_roof", x = 19, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tent_room_4",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "w...w",
            "v...w",
            "+...w",
            "w...w",
            "wwwww",
        },
        palettes = { "fbmh_2_tent_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_tent_room_SE",
    layout = {
        nested = {
            { id = "fbmh_2_tent_room_4", x = 19, y = 19, z = 0 },
            { id = "fbmh_2_tent_room_2_8_roof", x = 19, y = 19, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tent_room_5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "w...w",
            "w...v",
            "w...+",
            "w...w",
            "wwwww",
        },
        palettes = { "fbmh_2_tent_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_tent_room_SW",
    layout = {
        nested = {
            { id = "fbmh_2_tent_room_5", x = 0, y = 19, z = 0 },
            { id = "fbmh_2_tent_room_2_8_roof", x = 0, y = 19, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tent_room_6",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "w... ",
            "w...+",
            "w...v",
            "w...w",
            "wwwww",
        },
        palettes = { "fbmh_2_tent_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_tent_room_WSW",
    layout = {
        nested = {
            { id = "fbmh_2_tent_room_6", x = 0, y = 14, z = 0 },
            { id = "fbmh_2_tent_room_2_8_roof", x = 0, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tent_room_7",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "wwwww",
            "w...w",
            "w...v",
            "w...+",
            "w... ",
        },
        palettes = { "fbmh_2_tent_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_tent_room_WNW",
    layout = {
        nested = {
            { id = "fbmh_2_tent_room_7", x = 0, y = 5, z = 0 },
            { id = "fbmh_2_tent_room_2_8_roof", x = 0, y = 5, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmh_2_tent_room_8",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "wwwww",
            "w...w",
            "w...+",
            "w...v",
            "w...w",
        },
        palettes = { "fbmh_2_tent_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_2_tent_room_NW",
    layout = {
        nested = {
            { id = "fbmh_2_tent_room_8", x = 0, y = 0, z = 0 },
            { id = "fbmh_2_tent_room_2_8_roof", x = 0, y = 0, z = 1 },
        },
    },
}
