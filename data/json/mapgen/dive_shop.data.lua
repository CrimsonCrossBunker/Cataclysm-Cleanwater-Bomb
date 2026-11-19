local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "s_dive_shop_roof",
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
            "-.....................- ",
            "-.:...................- ",
            "-..1..................- ",
            "-.....................- ",
            "-.....................- ",
            "-.....................- ",
            "-.....................- ",
            "-.....................- ",
            "-.....................- ",
            "-..............ooo..Я.- ",
            "-....A.........ooo..Я.- ",
            "-..............ooo....- ",
            "-..................&..- ",
            "-.....................- ",
            "-5--------------------- ",
            "                   #v## ",
        },
        palettes = { "roof_palette" },
        terrain = { ["."] = "t_tar_flat_roof" },
        fill_terrain = "t_tar_flat_roof",
        nested = {
            {
                choices = {
                    { id = "roof_2x2_golf", weight = 5 },
                    { id = "null", weight = 85 },
                    { id = "roof_3x3_wine", weight = 10 },
                },
                x = { 13, 20 },
                y = 16,
            },
            {
                choices = {
                    { id = "null", weight = 40 },
                    { id = "roof_4x4_party", weight = 5 },
                    { id = "roof_4x4_utility", weight = 50 },
                    { id = "roof_4x4_holdout", weight = 3 },
                },
                x = { 4, 13 },
                y = { 9, 11 },
            },
        },
        item_group_placements = {
            {
                group = "SUS_trash_roof",
                x = { 4, 16 },
                y = { 9, 12 },
                chance = 50,
                repetitions = { 1, 3 },
            },
        },
    },
}
