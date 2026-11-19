local ccb = require("ccb")

-- Patch of cotton growing in a meadow
ccb.content.define_mapgen {
    kind = "nested",
    id = "meadow_12x12_shrubs",
    weight = 350,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "    7777    ",
            "   777777   ",
            "   777777   ",
            "  77777777  ",
            " 7777777777 ",
            "777777777777",
            "777777777777",
            " 7777777777 ",
            "  77777777  ",
            "   777777   ",
            "   777777   ",
            "    7777    ",
        },
        furniture = {
            [" "] = "f_null",
            ["7"] = { { id = "f_null", copies = 250 }, { id = "f_wildcotton", copies = 25 } },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- Patch of spurge growing in a meadow
ccb.content.define_mapgen {
    kind = "nested",
    id = "meadow_12x12_shrubs",
    weight = 350,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "    7777    ",
            "   777777   ",
            "   777777   ",
            "  77777777  ",
            " 7777777777 ",
            "777777777777",
            "777777777777",
            " 7777777777 ",
            "  77777777  ",
            "   777777   ",
            "   777777   ",
            "    7777    ",
        },
        furniture = {
            [" "] = "f_null",
            ["7"] = { { id = "f_null", copies = 250 }, { id = "f_flower_spurge", copies = 25 } },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- Patch of corn growing in a meadow
ccb.content.define_mapgen {
    kind = "nested",
    id = "meadow_12x12_shrubs",
    weight = 350,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "    7777    ",
            "   777777   ",
            "   777777   ",
            "  77777777  ",
            " 7777777777 ",
            "777777777777",
            "777777777777",
            " 7777777777 ",
            "  77777777  ",
            "   777777   ",
            "   777777   ",
            "    7777    ",
        },
        furniture = {
            [" "] = "f_null",
            ["7"] = { { id = "f_null", copies = 250 }, { id = "f_wildcorn", copies = 25 } },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
