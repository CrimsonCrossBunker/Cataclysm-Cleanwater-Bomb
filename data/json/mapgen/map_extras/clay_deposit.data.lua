local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_clay_deposit",
    layout = {
        nested = {
            { id = "15x15_clay_deposit", x = { 0, 9 }, y = { 0, 9 } },
            {
                choices = { { id = "15x15_clay_deposit", weight = 1 }, { id = "null", weight = 3 } },
                x = { 4, 5 },
                y = { 4, 5 },
            },
            {
                choices = { { id = "15x15_clay_deposit", weight = 1 }, { id = "null", weight = 3 } },
                x = { 0, 4 },
                y = { 0, 9 },
            },
            {
                choices = { { id = "15x15_clay_deposit", weight = 1 }, { id = "null", weight = 3 } },
                x = { 5, 9 },
                y = { 0, 9 },
            },
            {
                choices = { { id = "15x15_clay_deposit", weight = 1 }, { id = "null", weight = 3 } },
                x = { 0, 9 },
                y = { 0, 4 },
            },
            {
                choices = { { id = "15x15_clay_deposit", weight = 1 }, { id = "null", weight = 3 } },
                x = { 0, 9 },
                y = { 5, 9 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "15x15_clay_deposit",
    layout = {
        size = { width = 15, height = 15 },
        nested = {
            { id = "7x7_clay_deposit", x = { 0, 8 }, y = { 0, 8 } },
            { id = "7x7_clay_deposit", x = { 0, 8 }, y = { 0, 8 } },
            { id = "7x7_clay_deposit", x = { 0, 8 }, y = { 0, 8 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "7x7_clay_deposit",
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
        terrain = { X = "t_clay", x = { { id = "t_clay" }, { id = "t_null" } } },
        furniture = {
            X = {
                { id = "f_burdock", copies = 1 },
                { id = "f_dogbane", copies = 1 },
                { id = "f_japanese_knotweed", copies = 1 },
                { id = "f_null", copies = 21 },
            },
            x = {
                { id = "f_burdock", copies = 1 },
                { id = "f_dogbane", copies = 1 },
                { id = "f_japanese_knotweed", copies = 1 },
                { id = "f_null", copies = 13 },
            },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
