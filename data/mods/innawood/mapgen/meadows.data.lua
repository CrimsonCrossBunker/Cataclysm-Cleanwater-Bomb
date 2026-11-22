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

ccb.content.define_mutable_overmap_special {
    id = "meadow_mutable",
    root = "meadow_core",
    locations = { "field_no_meadow" },
    flags = { "WILDERNESS", "CLASSIC" },
    occurrences = { 10, 20 },
    priority = 3,
    check_for_locations_area = {
        {
            from = { 5, 5, 0 },
            to = { -5, -5, 0 },
            locations = { "field_no_meadow" },
        },
    },
    joins = { "meadow_to_meadow" },
    overmaps = {
        meadow_core = {
            overmap = "meadow_core",
            north = "meadow_to_meadow",
            south = "meadow_to_meadow",
            east = "meadow_to_meadow",
            west = "meadow_to_meadow",
        },
        meadow_end = { overmap = "meadow_end_north", north = "meadow_to_meadow" },
        meadow_fill = {
            overmap = "meadow_end_north",
            north = { id = "meadow_to_meadow", type = "available" },
            east = { id = "meadow_to_meadow", type = "available" },
            west = { id = "meadow_to_meadow", type = "available" },
        },
    },
    phases = {
        {
            { overmap = "meadow_core", weight = 2600 },
            { overmap = "meadow_end", weight = 50 },
            { overmap = "meadow_fill", weight = 1000 },
        },
    },
}
