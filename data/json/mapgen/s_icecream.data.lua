local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "icecream_shop_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "  -------               ",
            "  -.....-               ",
            "  -.....-               ",
            "  -.....--------------  ",
            "  -......1...........-  ",
            "  -..................-  ",
            "  -.................&-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -5------------.....-  ",
            "               -.....-  ",
            "               -------  ",
            "                        ",
        },
        palettes = { "roof_palette" },
        fill_terrain = "t_flat_roof",
        nested = {
            {
                choices = {
                    { id = "null", weight = 15 },
                    { id = "roof_4x4_utility", weight = 30 },
                    { id = "roof_4x4_utility_1", weight = 30 },
                    { id = "roof_4x4_holdout", weight = 3 },
                },
                x = { 16, 17 },
                y = { 16, 18 },
            },
        },
        item_group_placements = {
            {
                group = "SUS_trash_roof",
                x = { 4, 19 },
                y = { 15, 18 },
                chance = 50,
                repetitions = { 1, 3 },
            },
        },
    },
}
