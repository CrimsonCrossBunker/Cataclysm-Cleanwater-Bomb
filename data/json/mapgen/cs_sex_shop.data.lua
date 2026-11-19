local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "cs_sex_shop_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "  --------------------  ",
            "  -..................-  ",
            "  -...............X..-  ",
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
            "  -................=.-  ",
            "  -..................-  ",
            "  -..............AA..-  ",
            "  --5----------......-  ",
            "              --------  ",
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
                    { id = "roof_4x4_utility", weight = 40 },
                    { id = "roof_6x6_utility", weight = 20 },
                },
                x = { 4, 13 },
                y = { 9, 12 },
            },
        },
        item_group_placements = {
            {
                group = "SUS_trash_roof",
                x = { 4, 16 },
                y = { 7, 20 },
                chance = 50,
                repetitions = { 1, 3 },
            },
        },
    },
}
