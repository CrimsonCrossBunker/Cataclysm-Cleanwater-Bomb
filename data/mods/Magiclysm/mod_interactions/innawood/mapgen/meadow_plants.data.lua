local ccb = require("ccb")

-- Patch of moly growing in a meadow
ccb.content.define_mapgen {
    kind = "nested",
    id = "meadow_12x12_shrubs",
    weight = 100,
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
        erase_before_terrain = true,
        furniture = {
            [" "] = "f_null",
            ["7"] = { { id = "f_null", copies = 250 }, { id = "f_moly", copies = 25 } },
        },
    },
}

-- Patch of olieribos growing in a meadow
ccb.content.define_mapgen {
    kind = "nested",
    id = "meadow_12x12_shrubs",
    weight = 100,
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
        erase_before_terrain = true,
        furniture = {
            [" "] = "f_null",
            ["7"] = { { id = "f_null", copies = 250 }, { id = "f_olieribos", copies = 25 } },
        },
    },
}

-- Patch of flowering fern growing in a meadow
ccb.content.define_mapgen {
    kind = "nested",
    id = "meadow_12x12_shrubs",
    weight = 100,
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
        erase_before_terrain = true,
        furniture = {
            [" "] = "f_null",
            ["7"] = { { id = "f_null", copies = 250 }, { id = "f_flowering_fern", copies = 25 } },
        },
    },
}

-- Patch of whiskflower bush growing in a meadow
ccb.content.define_mapgen {
    kind = "nested",
    id = "meadow_12x12_shrubs",
    weight = 100,
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
        erase_before_terrain = true,
        furniture = {
            [" "] = "f_null",
            ["7"] = { { id = "f_null", copies = 250 }, { id = "f_whiskflower", copies = 25 } },
        },
    },
}

-- Stand of sojourner's palm growing in a meadow
ccb.content.define_mapgen {
    kind = "nested",
    id = "meadow_12x12_trees",
    weight = 100,
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
        erase_before_terrain = true,
        furniture = {
            [" "] = "f_null",
            ["7"] = { { id = "f_null", copies = 250 }, { id = "f_sojourners_palm", copies = 25 } },
        },
    },
}
