local ccb = require("ccb")

-- 1: reserve for furniture. 2: reserve for terrain. 3: reserve for items.
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "field", "isherwood_barry_rescue_field" },
    layout = {
        rows = {
            "123123123123123123123123",
            "231231231231231231231231",
            "312312312312312312312312",
            "123123123123123123123123",
            "231231231231231231231231",
            "312312312312312312312312",
            "123123123123123123123123",
            "231231231231231231231231",
            "312312312312312312312312",
            "123123123123123123123123",
            "231231231231231231231231",
            "312312312312312312312312",
            "123123123123123123123123",
            "231231231231231231231231",
            "312312312312312312312312",
            "123123123123123123123123",
            "231231231231231231231231",
            "312312312312312312312312",
            "123123123123123123123123",
            "231231231231231231231231",
            "312312312312312312312312",
            "123123123123123123123123",
            "231231231231231231231231",
            "312312312312312312312312",
        },
        terrain = {
            ["1"] = "t_region_groundcover",
            ["2"] = {
                { id = "t_region_groundcover", copies = 35000 },
                { id = "t_region_shrub_plains", copies = 6 },
                { id = "t_region_tree", copies = 2 },
            },
            ["3"] = "t_region_groundcover",
        },
        furniture = {
            ["1"] = {
                { id = "f_null", copies = 35000 },
                { id = "f_region_plain", copies = 100 },
                { id = "f_boulder_small", copies = 10 },
                { id = "f_boulder_medium", copies = 8 },
                { id = "f_boulder_large", copies = 2 },
                { id = "f_region_flower", copies = 1 },
            },
            ["2"] = "f_null",
            ["3"] = "f_null",
        },
        fill_terrain = "t_region_groundcover",
        item_groups = { ["3"] = { group = "field", chance = 1 } },
    },
}
