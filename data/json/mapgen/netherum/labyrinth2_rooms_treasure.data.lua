local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth2_treasure_room",
    layout = {
        rows = {
            "#####              #####",
            "1          ##2          ",
            "                        ",
            "                        ",
            "      3                 ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "           5            ",
            "            4           ",
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
        size = { width = 24, height = 24 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "labyrinth2_backdrop_palette" },
        monster_glyphs = {
            ["5"] = { id = "mon_labyrinth_turret_1_2" },
        },
        nested_glyphs = {
            ["1"] = { id = "ls_ns_11x23_maze" },
            ["2"] = { id = "ls_ns_11x23_maze" },
            ["3"] = {
                choices = {
                    { id = "ls_ns_9x9_maze_cutout", weight = 97 },
                    { id = "null", weight = 3 },
                },
            },
            ["4"] = {
                choices = {
                    { id = "ls_ns_9x9_maze_cutout", weight = 97 },
                    { id = "null", weight = 3 },
                },
            },
        },
    },
}
