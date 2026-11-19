local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_dead_vegetation",
    layout = {
        nested = {
            { id = "15x15_dead_vegetation", x = { 4, 5 }, y = { 4, 5 } },
            { id = "15x15_dead_vegetation", x = { 0, 4 }, y = { 0, 9 } },
            { id = "15x15_dead_vegetation", x = { 5, 9 }, y = { 0, 9 } },
            { id = "15x15_dead_vegetation", x = { 0, 9 }, y = { 0, 4 } },
            { id = "15x15_dead_vegetation", x = { 0, 9 }, y = { 5, 9 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_point_dead_vegetation",
    layout = {
        nested = { { id = "15x15_dead_vegetation", x = { 0, 9 }, y = { 0, 9 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "15x15_dead_vegetation",
    layout = {
        size = { width = 15, height = 15 },
        nested = {
            { id = "7x7_dead_vegetation", x = { 0, 8 }, y = { 0, 8 } },
            { id = "7x7_dead_vegetation", x = { 0, 8 }, y = { 0, 8 } },
            { id = "7x7_dead_vegetation", x = { 0, 8 }, y = { 0, 8 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "7x7_dead_vegetation",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "  xxx  ",
            " xXXXx ",
            "xXXXXXx",
            "xXXXXXx",
            "xXXXXXx",
            " xXXXx ",
            "  xxx  ",
        },
        nested_glyphs = { X = { id = "1x1_dead_vegetation" }, x = { choices = { "1x1_dead_vegetation", "null" } } },
    },
}
