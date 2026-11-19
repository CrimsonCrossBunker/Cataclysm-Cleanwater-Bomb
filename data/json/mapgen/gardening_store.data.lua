local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "s_gardening_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "  --------------------  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "###..................-  ",
            "#v#..................-  ",
            "###..................-  ",
            "  -------------------5  ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "roof_palette" },
        fill_terrain = "t_flat_roof",
        nested = {
            {
                choices = {
                    { id = "null", weight = 20 },
                    { id = "roof_2x2_utilities_b", weight = 15 },
                    { id = "roof_2x2_utilities_c", weight = 5 },
                    { id = "roof_2x2_utilities_d", weight = 40 },
                    { id = "roof_2x2_utilities", weight = 50 },
                },
                x = { 4, 17 },
                y = { 7, 8 },
            },
            {
                choices = {
                    { id = "null", weight = 20 },
                    { id = "roof_4x4_utility", weight = 40 },
                    { id = "roof_4x4_utility_1", weight = 30 },
                },
                x = { 4, 15 },
                y = { 11, 13 },
            },
        },
    },
}
