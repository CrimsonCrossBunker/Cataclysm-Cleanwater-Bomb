local ccb = require("ccb")

-- Left entry
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room10",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            ";||||.",
            "||Ti|.",
            "|V  +.",
            "|   ||",
            "||i  |",
            ";|||+|",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room13",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ".||||+..",
            "||T   ..",
            "| PT  ..",
            "+   i&..",
            "| PT  ..",
            "||T   ..",
            "||||||..",
            "........",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- Roomfull of zaps
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room15",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "|+||...+",
            "| F|||||",
            "|     P|",
            "||F  F||",
            ".||||||;",
            "........",
            "........",
            "........",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- Right side entrance
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room16",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|+|||",
            "|   |",
            "|||+|",
            ".....",
            ".....",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
