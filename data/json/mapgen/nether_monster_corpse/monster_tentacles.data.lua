local ccb = require("ccb")

-- walls of tentacle wall that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "tentacle_bounds_h",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "###        ###",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- walls of tentacle wall that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "tentacle_bounds_h1",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "###           ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- walls of tentacle wall that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "tentacle_bounds_h2",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "           ###",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- walls of tentacle wall that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "tentacle_bounds_v",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "#             ",
            "#             ",
            "#             ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "#             ",
            "#             ",
            "#             ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- walls of tentacle wall that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "tentacle_bounds_v1",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "#             ",
            "#             ",
            "#             ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- walls of tentacle wall that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "tentacle_bounds_v2",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "#             ",
            "#             ",
            "#             ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
