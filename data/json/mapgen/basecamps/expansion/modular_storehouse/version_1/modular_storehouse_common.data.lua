local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_0",
    layout = {
        size = { width = 6, height = 6 },
        palettes = { "fbms_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_storehouse_0",
    layout = {
        nested = { { id = "fbms_0", x = 10, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_furniture1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "     t",
            " BBB t",
            " B   t",
            " B   t",
            " BBB t",
            "     t",
        },
        palettes = { "fbms_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_furniture1_west",
    layout = {
        nested = { { id = "fbms_furniture1", x = 3, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_furniture2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "t     ",
            "t lll ",
            "t   l ",
            "t   l ",
            "t lll ",
            "t     ",
        },
        palettes = { "fbms_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_furniture2_east",
    layout = {
        nested = { { id = "fbms_furniture2", x = 15, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_furniture3",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "t tt t",
            "t tt t",
            "t tt t",
            "t tt t",
            "t tt t",
            "t tt t",
        },
        palettes = { "fbms_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_furniture3_center",
    layout = {
        nested = { { id = "fbms_furniture3", x = 9, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_decorative1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "      ",
            "  b   ",
            "bbb   ",
        },
        palettes = { "fbms_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_decorative1_northwest",
    layout = {
        nested = { { id = "fbms_decorative1", x = 3, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_decorative2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "      ",
            "   b  ",
            "   bbb",
        },
        palettes = { "fbms_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_decorative2_northeast",
    layout = {
        nested = { { id = "fbms_decorative2", x = 15, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_decorative3",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "   bbb",
            "   b  ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "fbms_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_decorative3_southeast",
    layout = {
        nested = { { id = "fbms_decorative3", x = 15, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbms_decorative4",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "bbb   ",
            "  b   ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "fbms_common_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_decorative4_southwest",
    layout = {
        nested = { { id = "fbms_decorative4", x = 3, y = 15 } },
    },
}
