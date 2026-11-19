local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "s_arcade_roof",
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
            " -....................- ",
            " -..:.N...............- ",
            " -....................- ",
            " -....................- ",
            " -....................- ",
            " -............&.......- ",
            " -....................- ",
            " -....................- ",
            " -...............X....- ",
            " -....................- ",
            " --------------------5- ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "roof_palette" },
        fill_terrain = "t_flat_roof",
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "roof_4x4_utility", weight = 50 } },
                x = 3,
                y = { 10, 15 },
            },
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "roof_2x2_utilities", weight = 20 },
                    { id = "roof_2x2_utilities_c", weight = 20 },
                    { id = "roof_2x2_utilities_b", weight = 20 },
                },
                x = 17,
                y = { 12, 15 },
            },
        },
        item_group_placements = {
            {
                group = "SUS_trash_roof",
                x = { 3, 20 },
                y = { 11, 18 },
                chance = 50,
                repetitions = { 1, 3 },
            },
            {
                group = "child_items",
                x = { 3, 20 },
                y = { 11, 18 },
                chance = 50,
                repetitions = { 1, 3 },
            },
        },
    },
}
