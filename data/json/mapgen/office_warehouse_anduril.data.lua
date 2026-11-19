local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "office_warehouse_anduril_roof",
    layout = {
        rows = {
            "                        ",
            "  --------------------  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -.U................-  ",
            "  -..................-  ",
            "  -...............K..-  ",
            "  -.Z................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -.................o-  ",
            "  --------------------  ",
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
                y = { 10, 19 },
            },
        },
        nested_glyphs = {
            U = { id = "roof_2x2_infrastructure" },
            K = { id = "roof_2x2_infrastructure_1" },
            Z = { id = "roof_2x2_infrastructure_2" },
        },
    },
}
