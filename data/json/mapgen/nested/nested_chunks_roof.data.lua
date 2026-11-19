local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_greenhouse_roof",
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
        terrain = { R = "t_glass_roof" },
    },
}

-- zen garden.
ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_garden_4",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "bb__bb",
            "b2222b",
            "_22G2_",
            "_2G22_",
            "b2222b",
            "bb__bb",
        },
        terrain = { _ = "t_railroad_rubble", b = "t_railroad_rubble", ["2"] = "t_sandbox", G = "t_sandbox" },
        furniture = { G = { { id = "f_boulder_medium" }, { id = "f_boulder_large" } }, b = "f_bench" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_6kW_solar_v1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#####",
            "#####",
            "#####",
            "#####",
        },
        terrain = { ["#"] = "t_flat_roof" },
        furniture = { ["#"] = "f_solar_unit" },
        rotation = { 0, 3 },
        flags = { "ERASE_ITEMS_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_6kW_solar_v2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "###  ",
            "###  ",
            "?##  ",
            " ##  ",
            " ##  ",
        },
        terrain = { ["#"] = "t_flat_roof", ["?"] = "t_flat_roof" },
        furniture = {
            ["#"] = "f_solar_unit_v2",
            ["?"] = { { id = "f_solar_unit_v2", copies = 1 }, { id = "f_null", copies = 1 } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ITEMS_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_6kW_solar",
    layout = {
        size = { width = 5, height = 5 },
        nested = {
            {
                choices = {
                    { id = "residential_6kW_solar_v1", weight = 80 },
                    { id = "residential_6kW_solar_v2", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_7kW_solar_v1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "######",
            "######",
            "######",
            "######",
            "######",
            "      ",
        },
        terrain = { ["#"] = "t_flat_roof" },
        furniture = { ["#"] = "f_solar_unit" },
        rotation = { 0, 3 },
        flags = { "ERASE_ITEMS_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_7kW_solar_v2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "###   ",
            "###   ",
            "###   ",
            "###   ",
            "###   ",
            "      ",
        },
        terrain = { ["#"] = "t_flat_roof" },
        furniture = { ["#"] = "f_solar_unit_v2" },
        rotation = { 0, 3 },
        flags = { "ERASE_ITEMS_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_7kW_solar",
    layout = {
        size = { width = 6, height = 6 },
        nested = {
            {
                choices = {
                    { id = "residential_7kW_solar_v1", weight = 80 },
                    { id = "residential_7kW_solar_v2", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_8kW_solar_v1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "######",
            "######",
            "######",
            "######",
            "######",
            "######",
        },
        terrain = { ["#"] = "t_flat_roof" },
        furniture = { ["#"] = "f_solar_unit" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_8kW_solar_v2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "###   ",
            "###   ",
            "###   ",
            "###   ",
            "###   ",
            "###   ",
        },
        terrain = { ["#"] = "t_flat_roof" },
        furniture = { ["#"] = "f_solar_unit_v2" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_8kW_solar",
    layout = {
        size = { width = 6, height = 6 },
        nested = {
            {
                choices = {
                    { id = "residential_8kW_solar_v1", weight = 80 },
                    { id = "residential_8kW_solar_v2", weight = 20 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}
