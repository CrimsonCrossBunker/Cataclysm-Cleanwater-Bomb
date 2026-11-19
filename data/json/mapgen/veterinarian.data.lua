local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "veterinarian_roof",
    layout = {
        rows = {
            "                        ",
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
            "  ----------.........5  ",
            "           -.........-  ",
            "           -.........-  ",
            "           -.&...=...-  ",
            "           -...X.....-  ",
            "           -.........-  ",
            "           -----------  ",
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
                y = { 8, 11 },
            },
        },
    },
}
