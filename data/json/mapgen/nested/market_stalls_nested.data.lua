local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_6x6_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
            "RRRRRR",
        },
        terrain = { R = "t_canvas_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_4x4_roof",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "RRRR",
            "RRRR",
            "RRRR",
            "RRRR",
        },
        terrain = { R = "t_canvas_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_5x5_roof",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "RRRRR",
            "RRRRR",
            "RRRRR",
            "RRRRR",
            "RRRRR",
        },
        terrain = { R = "t_canvas_roof" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "market_7x7_roof",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
            "RRRRRRR",
        },
        terrain = { R = "t_canvas_roof" },
    },
}
