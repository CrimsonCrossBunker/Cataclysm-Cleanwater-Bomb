local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_nether_pond",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "nether_pond_chunk", x = { 2, 11 }, y = { 2, 11 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nether_pond_chunk",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "     SS     ",
            "    SSSS    ",
            "   SSssSS   ",
            "  SSsddsSS  ",
            " SSsdDDdsSS ",
            "SSsdDDDDdsSS",
            "SSsdDDDDdsSS",
            " SSsdDDdsSS ",
            "  SSsddsSS  ",
            "   SSssSS   ",
            "    SSSS    ",
            "     SS     ",
        },
        terrain = {
            D = "t_nether_water_dp",
            d = { { id = "t_nether_water_dp", copies = 1 }, { id = "t_nether_water_sh", copies = 1 } },
            s = { { id = "t_nether_water_dp", copies = 1 }, { id = "t_nether_water_sh", copies = 4 } },
            S = { { id = "t_nether_water_sh", copies = 1 }, { id = "t_null", copies = 1 } },
            [" "] = "t_null",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
