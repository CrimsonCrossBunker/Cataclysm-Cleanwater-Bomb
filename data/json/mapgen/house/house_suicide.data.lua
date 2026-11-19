local ccb = require("ccb")

-- uses house_10 basement
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "house_suicide" },
    layout = {
        rows = {
            "............--..........",
            "............--..........",
            "...........p--..........",
            "..##oo##oo##--......%...",
            "..#c      y#--..........",
            "..or hffh  o-------.....",
            "..or hffh  #-------.....",
            "..or hffh  #**###ooo##..",
            "..#c          y|Ih  d#..",
            "..#||| |||||  L|I  @@o..",
            "..oS +  EsE    +   @@o..",
            "..#8t|x       H| y  s#..",
            "..#|||x    l  H|+||||#..",
            "..#q>+     l  H|D|8St#..",
            "..####R  A    s|||8 B#^.",
            "....^oY AJJ    |D| 8B#..",
            ".....o7 AJ  6|+|+||!|#..",
            "%....o1     6|   RE T#..",
            ".....#F 45O32|d      o..",
            ".....##*#ooo##I @@   o..",
            ".....--------oI @@s D#..",
            ".....--------##o###o##..",
            "........................",
            "........................",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            ["%"] = {
                { id = "t_region_shrub" },
                { id = "t_region_shrub_fruit" },
                { id = "t_region_shrub_decorative" },
            },
            ["!"] = "t_door_locked_interior",
        },
        fill_terrain = "t_floor",
        nested = {
            { choices = { { id = "bathroom_suicide", weight = 100 } }, x = 18, y = 13 },
            { id = "rolling_trash_can_1x1", x = 3, y = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "house_suicide_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "  ----------            ",
            "  -........-            ",
            "  -........-            ",
            "  -........-            ",
            "  -........-----------  ",
            "  -..................-  ",
            "  -.....&...1........-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  ---5............oo.5  ",
            "     -....=.......oo.-  ",
            "     -...............-  ",
            "     -...............-  ",
            "     -...............-  ",
            "     ---------.......-  ",
            "             -.......-  ",
            "             ---------  ",
            "                        ",
            "                        ",
        },
        palettes = { "roof_palette" },
        terrain = { ["."] = "t_shingle_flat_roof" },
        fill_terrain = "t_shingle_flat_roof",
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bathroom_suicide",
    layout = {
        size = { width = 3, height = 3 },
        field_placements = { { id = "fd_blood", x = { 0, 2 }, y = { 0, 2 }, repetitions = { 8, 12 } } },
        loot_placements = {
            { group = "house_suicide_clothing", x = 1, y = 1 },
            { group = "house_suicide_shotgun", x = 1, y = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bathroom_suicide",
    layout = {
        size = { width = 3, height = 3 },
        furniture_placements = { { id = "f_chair", x = 0, y = 1 } },
        loot_placements = {
            { group = "house_suicide_clothing", x = 1, y = 1 },
            { id = "corpse", x = 1, y = 1 },
            { id = "rope_30", x = 1, y = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bathroom_suicide",
    layout = {
        size = { width = 3, height = 3 },
        field_placements = { { id = "fd_bile", x = { 0, 2 }, y = { 0, 2 }, repetitions = { 0, 5 } } },
        liquid_placements = { { id = "vodka", x = { 1, 2 }, y = { 1, 2 }, amount = { 2, 4 } } },
        loot_placements = {
            { group = "house_suicide_clothing", x = 2, y = 2 },
            { group = "oxy_small", x = { 1, 2 }, y = { 1, 2 }, repetitions = { 2, 8 } },
            { id = "bottle_glass", x = 2, y = 2 },
            { id = "corpse", x = 2, y = 2 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bathroom_suicide",
    layout = {
        size = { width = 3, height = 3 },
        field_placements = {
            { id = "fd_blood", x = 2, y = 1, repetitions = { 0, 2 } },
            { id = "fd_blood", x = 2, y = 2, repetitions = { 0, 2 } },
        },
        liquid_placements = {
            { id = "blood", x = 2, y = 1, amount = { 1, 3 } },
            { id = "blood", x = 2, y = 2, amount = { 1, 3 } },
            { id = "water", x = 2, y = 1, amount = 50 },
            { id = "water", x = 2, y = 2, amount = 50 },
        },
        loot_placements = {
            { group = "house_suicide_clothing", x = 2, y = 2 },
            { id = "razor_blade", x = 2, y = 2 },
            { id = "corpse", x = 2, y = 2 },
        },
    },
}
