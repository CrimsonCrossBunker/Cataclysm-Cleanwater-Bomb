local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "afs_formless_ruins_pipe" },
    layout = {
        rows = {
            "1           1           ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "1           1           ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        predecessor_mapgen = "glacial_field",
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "formless_ruins_ribs1", weight = 20 },
                    { id = "formless_ruins_ribs2", weight = 20 },
                    { id = "formless_ruins_empty1", weight = 10 },
                    { id = "formless_ruins_empty2", weight = 10 },
                    { id = "formless_ruins_empty3", weight = 10 },
                    { id = "formless_ruins_empty4", weight = 10 },
                },
            },
        },
        loot_placements = {
            {
                group = "afs_formless_ruins_random_loot",
                x = { 0, 23 },
                y = { 0, 23 },
                chance = 50,
                repetitions = { 1, 4 },
            },
        },
        monster_placements = {
            { id = "mon_wraitheon_isohypsa", x = 12, y = 12, patrol = { { x = 12, y = 12 } } },
            {
                id = "mon_wraitheon_irradiant",
                x = 8,
                y = 8,
                patrol = { { x = 8, y = 8 }, { x = 8, y = 16 }, { x = 16, y = 16 }, { x = 16, y = 8 } },
            },
            { id = "mon_wraitheon_kaburaya", x = 4, y = 4, repetitions = { 6, 10 } },
        },
    },
}
