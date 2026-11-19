local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_0",
    layout = {
        size = { width = 6, height = 6 },
        palettes = { "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_canteen_0",
    layout = {
        nested = { { id = "fbmk_0", x = 10, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_counters",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "     c ",
            "       ",
            "  ccc  ",
            "       ",
            " rr rr ",
            "       ",
        },
        palettes = { "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_canteen_counters",
    layout = {
        nested = { { id = "fbmk_canteen_counters", x = 9, y = 7 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_pantry",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            " rrrrU ",
            " V     ",
            " rrrr  ",
            " V     ",
            " rrrrU ",
            "       ",
        },
        palettes = { "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_pantry_furniture",
    layout = {
        nested = { { id = "fbmk_canteen_pantry", x = 3, y = 7 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_dining_furniture",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "hth hth",
            "hth hth",
            "hth hth",
            "hth hth",
            "       ",
            "       ",
            "       ",
        },
        palettes = { "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_dining_furniture",
    layout = {
        nested = { { id = "fbmk_canteen_dining_furniture", x = 9, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmk_canteen_planters",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "ppp",
            "ppp",
            "   ",
        },
        palettes = { "fbmk_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_planters_1",
    layout = {
        nested = { { id = "fbmk_canteen_planters", x = 4, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_planters_2",
    layout = {
        nested = { { id = "fbmk_canteen_planters", x = 8, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_planters_3",
    layout = {
        nested = { { id = "fbmk_canteen_planters", x = 14, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_planters_4",
    layout = {
        nested = { { id = "fbmk_canteen_planters", x = 18, y = 4 } },
    },
}
