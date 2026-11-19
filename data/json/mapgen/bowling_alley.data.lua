local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "bowling_alley_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "-----------------------5",
            "-......................-",
            "-......................-",
            "-......................-",
            "-......................-",
            "-......................-",
            "-......................-",
            "-......................-",
            "-.:....................-",
            "-.X....................-",
            "-......................-",
            "-......................-",
            "-......................-",
            "-......................-",
            "-......................-",
            "-.........=.&..........-",
            "------------------------",
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
                x = { 5, 15 },
                y = { 10, 15 },
            },
        },
        item_group_placements = {
            {
                group = "SUS_trash_roof",
                x = { 3, 20 },
                y = { 9, 20 },
                chance = 50,
                repetitions = { 1, 3 },
            },
        },
    },
}
