local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_livestock_2_0",
    layout = {
        nested = { { id = "fbml_2", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_1",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "F  ",
            "g  ",
            "Fbb",
        },
        palettes = { "fbml_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_bench",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "F    ",
            "g    ",
            "Fb   ",
            " b   ",
            " b   ",
        },
        palettes = { "fbml_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "F  ",
            "g  ",
            "F  ",
        },
        palettes = { "fbml_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_stall_5",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "g    ",
            "Fb   ",
            " b   ",
            "Fb   ",
            "g    ",
        },
        palettes = { "fbml_2_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbml_2_shack_furniture",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "rrr",
            "  t",
            "  w",
        },
        palettes = { "fbml_2_common_palette" },
    },
}
