local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_6kW_solar_v1",
    weight = 1000000,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "#####",
            "#####",
            "#####",
            "#####",
            "#####",
        },
        furniture = { ["#"] = "f_null" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_6kW_solar_v2",
    weight = 1000000,
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "###  ",
            "###  ",
            " ##  ",
            " ##  ",
            " ##  ",
        },
        furniture = { ["#"] = "f_null" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_6kW_solar",
    weight = 1000000,
    layout = {
        size = { width = 5, height = 5 },
        nested = { { id = "null", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_7kW_solar_v1",
    weight = 1000000,
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
        furniture = { ["#"] = "f_null" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_7kW_solar_v2",
    weight = 1000000,
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
        furniture = { ["#"] = "f_null" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_7kW_solar",
    weight = 1000000,
    layout = {
        size = { width = 6, height = 6 },
        nested = { { id = "null", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_8kW_solar_v1",
    weight = 1000000,
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
        furniture = { ["#"] = "f_null" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_8kW_solar_v2",
    weight = 1000000,
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
        furniture = { ["#"] = "f_null" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_8kW_solar",
    weight = 1000000,
    layout = {
        size = { width = 6, height = 6 },
        nested = { { id = "null", x = 0, y = 0 } },
    },
}
