local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_big_special",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "-----------",
            "-         -",
            "-         -",
            "-         -",
            "-         -",
            "-         -",
            "-         -",
            "-         -",
            "-         -",
            "-         -",
            "-----------",
        },
        erase_before_terrain = true,
        palettes = { "backrooms_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_big_special",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "--------",
            "-      -",
            "-      -",
            "-      -",
            "-      -",
            "-      -",
            "-      -",
            "--------",
        },
        erase_before_terrain = true,
        palettes = { "backrooms_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_small_special",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "----",
            "-  -",
            "-  -",
            "----",
        },
        erase_before_terrain = true,
        palettes = { "backrooms_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_small_special",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "------",
            "-    -",
            "-    -",
            "-    -",
            "-    -",
            "------",
        },
        erase_before_terrain = true,
        palettes = { "backrooms_palette" },
    },
}
