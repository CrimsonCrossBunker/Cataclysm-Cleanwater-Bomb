local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "mi-go_scout_tower_dino_1",
    layout = {
        rows = {
            "........................",
            "........................",
            "........................",
            "............||..........",
            "..........||||||........",
            "........|||TPTP|||......",
            "......|||       V|||....",
            "....|||V          T||...",
            "...||<            T |...",
            "...|||      P P     ||..",
            "....||       &      T|..",
            ".....|      P P     T|..",
            ".....+              ||..",
            "....|| TPTP     TPTP|...",
            "..|||V              |...",
            "||| +      TPTP  V ||...",
            "||  ||| TPTP     |||....",
            "|| 14 ||||||||TT||......",
            ".|&  ||......||||.......",
            ".|||||..................",
            "........................",
            "........................",
            "........................",
            "........................",
        },
        palettes = { "mi-go_palette" },
        terrain = { ["."] = "t_region_groundcover" },
        fill_terrain = "t_floor_resin",
        nested = { { id = "mi-go_encampment1_dino_room14", x = 1, y = 14 } },
        monster_group_placements = { { group = "GROUP_MI-GO_BASE_COMMON", density = 0.1, x = 8, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "mi-go_scout_tower_dino_3",
    layout = {
        rows = {
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvv||vvvvvvvvvv",
            "vvvvvvvvvv||||||vvvvvvvv",
            "vvvvvvvv|||    |||vvvvvv",
            "vvvvvv|||        |||vvvv",
            "vvvv|||            ||vvv",
            "vvv||<              |vvv",
            "vvv||>       6      ||vv",
            "vvvv||               |vv",
            "vvvvv|               |vv",
            "vvvvv|              ||vv",
            "vvvv||              |vvv",
            "vv|||               |vvv",
            "||| +              ||vvv",
            "||  |||          |||vvvv",
            "|| 14 ||||||||  ||vvvvvv",
            "v|   ||vvvvvv||||vvvvvvv",
            "v|||||vvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
            "vvvvvvvvvvvvvvvvvvvvvvvv",
        },
        palettes = { "mi-go_palette" },
        fill_terrain = "t_floor_resin",
        nested = {
            { id = "mi-go_scout_tower_cells", x = 4, y = 3 },
            { id = "mi-go_encampment1_dino_room17", x = 1, y = 14 },
        },
        monster_group_placements = { { group = "GROUP_MI-GO_SCOUT_TOWER", density = 0.1, x = 12, y = 12 } },
    },
}

-- Large monster holding cell
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_dino_room14",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            ".|||..",
            "|| +..",
            "|##|||",
            "|1  P|",
            "|  1||",
            "|||||;",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_zallosaurus_BRUTE",
                x = { 1, 3 },
                y = { 3, 4 },
                repetitions = { 1, 2 },
            },
        },
    },
}

-- Large monster holding cell
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_dino_room17",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            ".|||..",
            "|| +..",
            "|##|||",
            "|1  P|",
            "|  1||",
            "|||||v",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_zyrannosaurus_BRUTE",
                x = { 1, 3 },
                y = { 3, 4 },
                repetitions = { 1, 2 },
            },
        },
    },
}
