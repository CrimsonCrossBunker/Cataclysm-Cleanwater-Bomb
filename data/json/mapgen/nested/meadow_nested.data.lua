local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "meadow_12x12_pond",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            " 7   7777   ",
            "   77 ~ 77  ",
            " 777 ~~~ 77 ",
            "77 ~~~~~~ 7 ",
            " 77 ~~~~~ 77",
            "  7 ~~~~~~77",
            "  77 ~~~~ 7 ",
            "7  77  ~ 77 ",
            "  77777777  ",
            " 7  777777  ",
            "       7  7 ",
            "   7        ",
        },
        erase_before_terrain = true,
        terrain = {
            [" "] = "t_null",
            ["7"] = {
                { id = "t_null", copies = 250 },
                { id = "t_region_tree_forest", copies = 25 },
                { id = "t_region_shrub_forest", copies = 25 },
            },
            ["~"] = "t_pond_water_sh",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "meadow_12x12_shrubs",
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
        terrain = {
            [" "] = "t_null",
            ["7"] = { { id = "t_null", copies = 250 }, { id = "t_region_shrub_forest", copies = 25 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "meadow_12x12_trees",
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
        terrain = {
            [" "] = "t_null",
            ["7"] = {
                { id = "t_null", copies = 500 },
                { id = "t_region_tree_forest", copies = 80 },
                { id = "t_region_shrub_forest", copies = 5 },
            },
        },
    },
}
