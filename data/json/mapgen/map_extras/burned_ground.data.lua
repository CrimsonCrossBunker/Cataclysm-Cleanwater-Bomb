local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_burned_ground",
    layout = {
        nested = {
            { id = "15x15_burned_ground", x = { 4, 5 }, y = { 4, 5 } },
            { id = "15x15_burned_ground", x = { 0, 4 }, y = { 0, 9 } },
            { id = "15x15_burned_ground", x = { 5, 9 }, y = { 0, 9 } },
            { id = "15x15_burned_ground", x = { 0, 9 }, y = { 0, 4 } },
            { id = "15x15_burned_ground", x = { 0, 9 }, y = { 5, 9 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_point_burned_ground",
    layout = {
        nested = { { id = "15x15_burned_ground", x = { 0, 9 }, y = { 0, 9 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "15x15_burned_ground",
    layout = {
        size = { width = 15, height = 15 },
        nested = {
            { id = "7x7_burned_ground", x = { 0, 8 }, y = { 0, 8 } },
            { id = "7x7_burned_ground", x = { 0, 8 }, y = { 0, 8 } },
            { id = "7x7_burned_ground", x = { 0, 8 }, y = { 0, 8 } },
        },
    },
}

-- Here rather than the 1x1 nest for mapgen ordering, otherwise the transform occurs afterwards
ccb.content.define_mapgen {
    kind = "nested",
    id = "7x7_burned_ground",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "  xxx  ",
            " xxXxx ",
            "xxXXXxx",
            "xxXXXxx",
            "xxXXXxx",
            " xxXxx ",
            "  xxx  ",
        },
        furniture = {
            X = { { id = "f_null", copies = 7 }, { id = "f_fireweed", copies = 1 } },
            x = { { id = "f_null", copies = 11 }, { id = "f_fireweed", copies = 1 } },
        },
        flags = { "SKIP_ON_OPEN_AIR" },
        nested_glyphs = {
            X = { id = "1x1_burned_ground" },
            x = { choices = { "1x1_burned_ground_slight", "null" } },
        },
    },
}
