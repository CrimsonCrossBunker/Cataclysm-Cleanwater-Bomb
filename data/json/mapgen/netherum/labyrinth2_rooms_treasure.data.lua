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

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth2_treasure_room",
    layout = {
        rows = {
            "#########1     #########",
            "####vvvvv      vvvvv####",
            "###vvvvvv      vvvvvv###",
            "##vvvvvvv      vvvvvvv##",
            "#vvvvvvvv      vvvvvvvv#",
            "#vvvvvvvv      vvvvvvvv#",
            "#vvvvvvvvvv   Çvvvvvvvv#",
            "#vvvvvvvvvvvvvvvvvvvvvv#",
            "#vvvvvvvvvvvvvvvvvvvvvv#",
            "#vvvvvv####++####vvvvvv#",
            "#vvvvv##........##vvvvv#",
            "#vvvvv#..........#vvvvv#",
            "#vvvvv#..........#vvvvv#",
            "#vvvvv#..........#vvvvv#",
            "#vvvvv#..........#vvvvv#",
            "#vvvvv#..........#vvvvv#",
            "#vvvvv#..........#vvvvv#",
            "#vvvvv#..........#vvvvv#",
            "#vvvvv#..........#vvvvv#",
            "#vvvvv##........##vvvvv#",
            "##vvvvv##########vvvvv##",
            "###vvvvvvvvvvvvvvvvvv###",
            "####vvvvvvvvvvvvvvvv####",
            "########################",
        },
        size = { width = 24, height = 24 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "labyrinth2_backdrop_palette" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "ls_ns_6x6hall_basic", weight = 50 },
                    { id = "ls_ns_6x6hall_fancy", weight = 50 },
                },
            },
        },
        computer_glyphs = {
            ["Ç"] = {
                name = "Bridge Controls",
                chat_topics = { "COMP_LS_Bridge_control_deadend_1" },
                dialogue_on_access = true,
            },
        },
    },
}
