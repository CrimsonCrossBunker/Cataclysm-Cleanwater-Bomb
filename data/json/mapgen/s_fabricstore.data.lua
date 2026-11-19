local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "s_fabricstore_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "     -------------      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -...........-      ",
            "     -.......5----      ",
            "     -...&...-          ",
            "     ---------          ",
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
                    { id = "roof_2x2_utilities_d", weight = 20 },
                    { id = "roof_4x4_utility", weight = 20 },
                    { id = "roof_2x2_utilities", weight = 30 },
                },
                x = { 7, 12 },
                y = { 5, 13 },
            },
        },
        item_group_placements = {
            {
                group = "SUS_trash_roof",
                x = { 7, 13 },
                y = { 5, 15 },
                chance = 50,
                repetitions = { 1, 3 },
            },
        },
    },
}
