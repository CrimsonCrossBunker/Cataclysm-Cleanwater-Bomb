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

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_2x2_utilities_c",
    weight = 1000000,
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_water_heater", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_2x2_utilities",
    weight = 1000000,
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = {
            { id = "f_water_heater", x = 0, y = 0 },
            { id = "f_air_conditioner", x = 1, y = 0 },
            { id = "f_water_purifier", x = 1, y = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_2x2_solar",
    weight = 50000,
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_null", x = { 0, 1 }, y = { 0, 1 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_1x2_solar",
    weight = 50000,
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_null", x = 0, y = { 0, 1 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_1x3_solar",
    weight = 50000,
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = { { id = "f_solar_unit", x = 0, y = { 0, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_3x3_solar",
    weight = 50000,
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = { { id = "f_solar_unit", x = { 0, 2 }, y = { 0, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "industrial_1x5_solar",
    weight = 50000,
    layout = {
        size = { width = 5, height = 5 },
        furniture_placements = { { id = "f_solar_unit", x = { 0, 4 }, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "industrial_1x1_solar",
    weight = 50000,
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_solar_unit", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_2x2_solar_v2",
    weight = 1000000,
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_null", x = { 0, 1 }, y = { 0, 1 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_1x2_solar_v2",
    weight = 1000000,
    layout = {
        size = { width = 2, height = 2 },
        furniture_placements = { { id = "f_null", x = 0, y = { 0, 1 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_1x3_solar_v2",
    weight = 1000000,
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = { { id = "f_null", x = 0, y = { 0, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "residential_3x3_solar_v2",
    weight = 1000000,
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = { { id = "f_null", x = { 0, 2 }, y = { 0, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "industrial_1x5_solar_v2",
    weight = 1000000,
    layout = {
        size = { width = 5, height = 5 },
        furniture_placements = { { id = "f_null", x = { 0, 4 }, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "industrial_1x1_solar_v2",
    weight = 1000000,
    layout = {
        size = { width = 1, height = 1 },
        furniture_placements = { { id = "f_null", x = 0, y = 0 } },
    },
}
