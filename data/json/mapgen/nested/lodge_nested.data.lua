local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "lodge_cannibal_15x15",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "DF ARF LRL LRa ",
            "R              ",
            "SF DRA LRa LRL ",
            "               ",
        },
        palettes = { "lodge_items" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lodge_hunting_15x15",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "DF ARF BRB BRa ",
            "R              ",
            "SF DRA BRa BRB ",
            "               ",
        },
        palettes = { "lodge_items" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lodge_pantry_15x15",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "               ",
            "SS SRa SRS SRS ",
            "R              ",
            "SS SRA BRB SRS ",
            "               ",
        },
        palettes = { "lodge_items" },
    },
}
