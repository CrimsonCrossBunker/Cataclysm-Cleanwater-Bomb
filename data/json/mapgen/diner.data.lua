local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "s_restaurant_roof_3" },
    layout = {
        rows = {
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
            " -.........&..........- ",
            " -....................- ",
            " -.........&..........- ",
            " -5-------------------- ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "roof_palette" },
        terrain = { ["."] = "t_tar_flat_roof" },
        fill_terrain = "t_tar_flat_roof",
        nested = {
            {
                choices = {
                    { id = "roof_2x2_utilities_b", weight = 20 },
                    { id = "roof_2x2_utilities_c", weight = 20 },
                    { id = "roof_2x2_utilities_d", weight = 20 },
                    { id = "roof_2x2_utilities", weight = 20 },
                    { id = "null", weight = 40 },
                },
                x = { 13, 17 },
                y = { 16, 17 },
            },
            {
                choices = {
                    { id = "roof_4x4_utility_1", weight = 30 },
                    { id = "roof_6x6_utility", weight = 30 },
                    { id = "null", weight = 80 },
                },
                x = { 3, 14 },
                y = { 8, 9 },
            },
        },
        item_group_placements = {
            {
                group = "SUS_trash_roof",
                x = { 4, 16 },
                y = { 7, 15 },
                chance = 50,
                repetitions = { 1, 3 },
            },
        },
    },
}
