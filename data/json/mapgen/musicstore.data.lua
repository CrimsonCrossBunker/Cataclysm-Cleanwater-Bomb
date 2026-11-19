local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "s_music_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            " ---------------------- ",
            " -....................- ",
            " -....................- ",
            " -....................- ",
            " -....................- ",
            " -....................- ",
            " -....................- ",
            " -....................- ",
            " -....................- ",
            " -....................- ",
            " -....................- ",
            " -.&..................- ",
            " -.....---------------5 ",
            " -.....-                ",
            " -.....-                ",
            " -------                ",
            "                        ",
        },
        palettes = { "roof_palette" },
        fill_terrain = "t_flat_roof",
        nested = {
            {
                choices = {
                    { id = "null", weight = 5 },
                    { id = "roof_2x2_utilities_d", weight = 30 },
                    { id = "roof_2x2_utilities", weight = 50 },
                    { id = "roof_6x6_survivor", weight = 5 },
                },
                x = { 3, 15 },
                y = { 10, 13 },
            },
        },
        item_group_placements = {
            {
                group = "SUS_trash_roof",
                x = { 2, 21 },
                y = { 9, 18 },
                chance = 50,
                repetitions = { 1, 3 },
            },
        },
    },
}
