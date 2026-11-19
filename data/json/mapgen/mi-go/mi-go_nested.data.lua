local ccb = require("ccb")

-- Left entry
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room10",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            ";||||.",
            "||Ti|.",
            "|V  +.",
            "|   ||",
            "||i  |",
            ";|||+|",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room13",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ".||||+..",
            "||T   ..",
            "| PT  ..",
            "+   i&..",
            "| PT  ..",
            "||T   ..",
            "||||||..",
            "........",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- Roomfull of zaps
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room15",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "|+||...+",
            "| F|||||",
            "|     P|",
            "||F  F||",
            ".||||||;",
            "........",
            "........",
            "........",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- Right side entrance
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room16",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "|+|||",
            "|   |",
            "|||+|",
            ".....",
            ".....",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room1",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ";||||..",
            "||T +..",
            "|& P|..",
            "||  |..",
            ";| T|..",
            ";| ||..",
            ";|+||..",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_MI-GO_BASE_COMMON",
                x = { 2, 3 },
                y = { 1, 4 },
                density = 0.02,
                repetitions = { 0, 2 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room2",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ";||||||;",
            "||PPPP||",
            "+   i P|",
            "|  &   +",
            "|P    P|",
            "||PPPP||",
            "|||||||.",
            "........",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_MI-GO_BASE_COMMON",
                x = { 1, 6 },
                y = { 2, 4 },
                density = 0.01,
                repetitions = { 1, 3 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room3",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||#....|",
            "+ #####|",
            "|    iT+",
            "||PFPV||",
            ".||||||.",
            "........",
            "........",
            "........",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_MI-GO_BASE_CAPTORS",
                x = { 1, 6 },
                y = 2,
                density = 0.01,
                repetitions = { 1, 2 },
            },
        },
    },
}

-- Observation room with zombies
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room4",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ";;||;;;",
            "||||||;",
            "|V # ||",
            "|# #  |",
            ".#####|",
            ".......",
            ".......",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = {
            {
                choices = {
                    "mon_zombie_brute",
                    "mon_zombie_screecher",
                    "mon_zombie_hollow",
                    "mon_zombie",
                    "mon_zombie_fungus",
                },
                x = 1,
                y = 2,
            },
            {
                choices = {
                    "mon_skeleton",
                    "mon_zombear",
                    "mon_zombie_child",
                    "mon_zombie",
                    "mon_zombie_runner",
                },
                x = 4,
                y = 2,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room5",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ";|||||.",
            "|| P  .",
            "+     .",
            "|  &F .",
            "| P   .",
            "||   i.",
            ".|+|||.",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_MI-GO_BASE_COMMON",
                x = { 2, 5 },
                y = { 1, 5 },
                density = 0.02,
                repetitions = { 1, 3 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room7",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ";|+|||||",
            "||    ||",
            "|T  i  |",
            "|i  &i |",
            "|T     +",
            "||PPPP||",
            ";|||||||",
            "........",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_MI-GO_BASE_COMMON",
                x = { 2, 5 },
                y = { 1, 4 },
                density = 0.01,
                repetitions = { 0, 3 },
            },
        },
    },
}

-- Menagerie
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room8",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "|||| |||",
            "|| ### |",
            "|P   ###",
            "|P iT # ",
            "|P &P #|",
            "+     ||",
            "|###|+|.",
            "|| ||...",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_MI-GO_BASE_CAPTORS",
                x = { 2, 4 },
                y = { 2, 5 },
                density = 0.01,
                repetitions = { 1, 2 },
            },
            { group = "GROUP_DOMESTIC", x = 4, y = 0, density = 0.01 },
            { group = "GROUP_FOREST", x = 6, y = 1, density = 0.01 },
            { group = "GROUP_SWAMP", x = 7, y = 3, density = 0.01 },
            { group = "GROUP_CAVE", x = 2, y = 7, density = 0.01 },
        },
    },
}

-- Storage room, left side
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room9",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "|||P|+|||",
            "|P    PPP",
            "|P P  i  ",
            "| T      ",
            "|    &   ",
            "|T P     ",
            "|||T  P  ",
            "..|||T V ",
            "....||||+",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_MI-GO_BASE_COMMON",
                x = { 1, 8 },
                y = { 3, 5 },
                density = 0.01,
                repetitions = { 0, 2 },
            },
        },
    },
}

-- Storage room, right side, split across map boundaries
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room9a",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "|||;||...",
            "PP|||<...",
            "   P||...",
            "i PTP|...",
            "V P P|...",
            "i    +...",
            "  PP||...",
            "P&|||....",
            "|||.+....",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_MI-GO_BASE_COMMON",
                x = { 0, 3 },
                y = { 2, 5 },
                density = 0.01,
                repetitions = { 0, 2 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room11",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "|||||||.",
            "||TiT ||",
            "|  &   +",
            "|  ||  |",
            "+     i|",
            "||P V ||",
            ".||||+||",
            "........",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_MI-GO_BASE_COMMON",
                x = { 1, 3 },
                y = { 2, 5 },
                density = 0.01,
                repetitions = { 0, 2 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room12",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            ".|+|P|||..",
            "||     |||",
            "|P   i  P|",
            "||  i&i ||",
            ".+      |.",
            ".|+||T  +.",
            ".|..|||||.",
            "..........",
            "..........",
            "..........",
        },
        palettes = { "mi-go_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_group_placements = {
            {
                group = "GROUP_MI-GO_BASE_COMMON",
                x = { 2, 6 },
                y = { 1, 4 },
                density = 0.01,
                repetitions = { 0, 1 },
            },
        },
    },
}

-- Large monster holding cell
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room14",
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
        monster_group_placements = { { group = "GROUP_ZOMBIE_BRUTE", x = { 1, 3 }, y = { 3, 4 }, repetitions = { 1, 2 } } },
    },
}

-- Large monster holding cell
ccb.content.define_mapgen {
    kind = "nested",
    id = "mi-go_encampment1_room17",
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
        monster_group_placements = { { group = "GROUP_ZOMBIE_BRUTE", x = { 1, 3 }, y = { 3, 4 }, repetitions = { 1, 2 } } },
    },
}
