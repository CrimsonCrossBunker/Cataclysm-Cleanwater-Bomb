local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_hunger_track",
    layout = {
        rows = {
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "-----------1----------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "----------------------  ",
            "                        ",
            "                        ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["-"] = {
                choices = {
                    { id = "corpse_blood_gibs_college_3x3", weight = 1 },
                    { id = "null", weight = 250 },
                },
            },
            ["1"] = { id = "hunger_track" },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "hunger_track",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "x",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        furniture = { x = "f_hunger_track" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "cave_greed_and_hunger" },
    weight = 300,
    layout = {
        rows = {
            "..................~~~~..",
            ".....    ........   ~~~.",
            "...     BB.......    ~~~",
            "..  BB  BB  ......    ..",
            "..  BB    BB........ ...",
            "..        BB........ ...",
            "...BB         .....   ..",
            "....B   BB       .XXXX .",
            ".....   BB..       XXXX ",
            ".....  ........   XXXXX ",
            ".....  ........... XXXX ",
            "..      ...........  XX.",
            ".           .......  ...",
            ".            ......  ...",
            ".  ..  ....   .....  ...",
            ".   ..YY....  .....  ...",
            ".    .YY....  ...    ...",
            "...  .....    ...    ...",
            "...___...          .....",
            ".._____..          .....",
            "._______..      ........",
            "._______...    .........",
            ".._____..... ...........",
            "....__......>...........",
        },
        rotation = { 0, 3 },
        item_groups = {
            [" "] = { group = "xe_midden_heap", chance = 2 },
            X = {
                { group = "corpses", chance = 5, repetitions = 1 },
                { group = "default_zombie_death_drops", chance = 15 },
            },
            Y = {
                { group = "corpses", chance = 100, repetitions = { 1, 2 } },
                { group = "default_zombie_death_drops", chance = 100, repetitions = { 1, 3 } },
            },
            _ = { group = "xe_midden_heap", chance = 40, repetitions = { 1, 2 } },
        },
        field_placements = {
            { id = "fd_blood", x = { 17, 21 }, y = { 7, 11 }, repetitions = { 4, 6 } },
            { id = "fd_blood", x = { 6, 7 }, y = { 14, 16 }, repetitions = { 4, 6 } },
        },
        monster_placements = { { id = "mon_civilian_wendi", x = { 8 }, y = { 6 } } },
        fill_terrain = "t_dirt_underground",
        terrain = {
            ["."] = "t_soil",
            [" "] = "t_dirt_underground",
            _ = "t_dirt_underground",
            X = "t_dirt_underground",
            Y = "t_dirt_underground",
            B = "t_dirt_underground",
            [">"] = "t_slope_up",
            ["~"] = "t_water_sh_underground",
        },
        furniture = { B = "f_straw_bed" },
    },
}
