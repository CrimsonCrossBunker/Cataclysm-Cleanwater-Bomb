local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_straight_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " cc  | PP  PP  PP |     ",
            " cc  | PP  PP  PP |     ",
            "     | PPbb  bbPP |cci  ",
            "  |||| PP      PP ||||  ",
            " F|XX= PPbb  bbPP =XX|  ",
            "|||XX= PP      PP =XX|||",
            " F|XX= PP dd6d PP =XX|c ",
            " F|XX= PP dh d PP =XX|c ",
            " F|XX= PP d hd PP =XX|c ",
            "  |XX= PP d6dd PP =XX|c ",
            "|5|||| PP      PP ||||||",
            "   2  YPP      PPY 2    ",
            "   2  YPP      PPY 2    ",
            "|2|||| PP      PP ||2|||",
            "   hc| PP |||| PP |c    ",
            "cc  c| PP  YY  PP |6    ",
            "cc  6| PP  ^???PP |c c  ",
            "     | PP   t ?PP |ciccc",
            "|2|||| PP? t   PP ||||||",
            "  ch | PP???^  PP |     ",
            "  cc | PP      PP |F c  ",
            "  ch | PP  PP  PP |F c  ",
            "  cc | PP  PP  PP |F c  ",
            "     | PP  PP  PP |     ",
        },
        palettes = { "microlab" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_straight_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " cc  | PP  PP  PP |     ",
            " cc  | PP      PP |     ",
            "     | PP b  b PP |cci  ",
            "  |||| PP b  b PP ||||  ",
            " F|XX= PP      PP =XX|  ",
            "|||XX= PP ==== PP =XX|||",
            " F|XX= PP =XX= PP =XX|c ",
            " F|XX= PP =XX= PP =XX|c ",
            " F|XX= PP =XX= PP =XX|c ",
            "  |XX= PP =XX= PP =XX|c ",
            "|5||||=[[======[[=||||||",
            "    2YPPPPPPPPPPPPY2    ",
            "    2YPPPPPPPPPPPPY2    ",
            "|2||||=[[======[[=||||||",
            "  |XX= PP =XX= PP =XX|  ",
            "c |XX= PP =XX= PP =XX|  ",
            "c |XX= PP =XX= PP =XX|  ",
            "  |XX= PP =XX= PP =XX|cc",
            "|2|XX= PP =XX= PP =XX|||",
            "  |XX= PP =XX= PP =XX|c ",
            "  |||| PP =XX= PP ||||c ",
            "  icc| PP ==== PP |F cc ",
            "    F| PP      PP |F c  ",
            "    F| PP  PP  PP |     ",
        },
        palettes = { "microlab" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_straight_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " cc  | PP  PP  PP |     ",
            " cc  | PP      PP |     ",
            "     | PP ==== PP |cci  ",
            "  |||| PP =XX= PP ||||  ",
            " F|XX= PP =XX= PP =XX|  ",
            "|||XX==[[==XX==[[==XX|||",
            " F|XX= PP =XX= PP =XX|c ",
            " F|XX= PP =XX= PP =XX|c ",
            " F|XX= PP =XX= PP =XX|c ",
            "  |XX= PP =XX= PP =XX|c ",
            "|5|XX= PP =XX= PP =XX|||",
            "  |XX= PP =XX= PP =XX|  ",
            "  |XX= PP =XX= PP =XX|  ",
            "|2|XX= PP =XX= PP =XX|2|",
            "  |XX= PP =XX= PP =XX|  ",
            "c |XX= PP =XX= PP =XX|  ",
            "c |XX= PP =XX= PP =XX|  ",
            "  |XX= PP =XX= PP =XX|cc",
            "|2|XX= PP =XX= PP =XX|||",
            "  |XX=YPP =XX= PPY=XX|c ",
            "  |||| PP =XX= PP ||||c ",
            "  icc| PP ==== PP |F cc ",
            "    F| PP      PP |F c  ",
            "    F| PP  PP  PP |     ",
        },
        palettes = { "microlab" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_straight_isolated_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "|####| PP  PP  PP |####|",
            "|####| PP      PP |####|",
            "|####| PP ==== PP |####|",
            "|#|||| PP =XX= PP ||||#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX==[[==XX==[[==XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX= PP =XX= PP =XX|#|",
            "|#|XX=YPP =XX= PPY=XX|#|",
            "|#|||| PP =XX= PP ||||#|",
            "|####| PP ==== PP |####|",
            "|####| PP      PP |####|",
            "|||||| PP  PP  PP ||||||",
        },
        palettes = { "microlab" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_straight_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " cc c| PP  PP  PP |c c  ",
            " cc c| PP  PP  PP |c    ",
            "    c| PP  PP  PP |cci  ",
            "  |||| PP  PP  PP ||||F ",
            " F|XX= PP  PP  PP =XX|F ",
            "|||XX= PP  PP  PP =XX|||",
            " F|XX= PP  PP  PP =XX|c ",
            " F|XX= PP  PP  PP =XX|c ",
            " F|XX= PP      PP =XX|i ",
            "  |XX=            =XX|c ",
            "|5||||            ||||||",
            "   2  Y          Y 2    ",
            "   2  Y          Y 2    ",
            "|2||||            ||2|||",
            "   hc|            |c    ",
            "cc  c| PP      PP |6    ",
            "cc  6| PP  PP  PP |c c  ",
            "     | PP  PP  PP |ciccc",
            "|2|||| PP  PP  PP ||||||",
            "  ch | PP  PP  PP |     ",
            "  cc | PP  PP  PP |F i  ",
            "  ch | PP  PP  PP |F c  ",
            "  cc | PP  PP  PP |F i  ",
            "     | PP  PP  PP |     ",
        },
        palettes = { "microlab" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_curved_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " cc c||||||||||||||c c  ",
            " cc c|############|c    ",
            "    c|############|cci  ",
            "  |||||||||||||||||c  h ",
            " F|XXXXXXXXXXXXXXX|cccc ",
            "|||XX=============||||||",
            " F|XX=      d           ",
            " F|XX=     hd     PPPPPP",
            " F|XX=   dd6d     PPPPPP",
            "  |XX=                  ",
            "|5||||    PPPP          ",
            "   2      PPPP    PPPPPP",
            "   2      PPPP    PPPPPP",
            "|2||||    PPPP          ",
            "   hc|                  ",
            "cc  c|            PPPPPP",
            "cc  6|            PPPPPP",
            "     |                  ",
            "|2|||| PP  PP  PP ||||||",
            "  ch | PP  PP  PP |     ",
            "  cc | PP  PP  PP |F i  ",
            "  ch | PP  PP  PP |F c  ",
            "  cc | PP  PP  PP |F i  ",
            "     | PP  PP  PP |     ",
        },
        palettes = { "microlab" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_tee_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " cc  ||||||  ||||||     ",
            " cc  2   [   [    2     ",
            "     |   =   =    |     ",
            "  ||||||||||||||||||||F ",
            " F|XXXXXXXXXXXXXXXXXX|F ",
            "|||==================|||",
            "  Y                  Y  ",
            "PPPPPP PPPPPPPPPP  PPPPP",
            "PPPPPP PPPPPPPPPP  PPPPP",
            "                        ",
            "====== PP ==== PP ======",
            "=XXXX= PP =XX= PP =XXXX=",
            "=XXXX= PP =XX= PP =XXXX=",
            "====== PP ==== PP ======",
            "       PP      PP       ",
            "PPPPP  PP  PP  PP  PPPPP",
            "PPPPP  PP  PP  PP  PPPPP",
            "  Y    PP      PP    Y  ",
            "|||=== PP ==== PP ===|||",
            " F|XX=YPP =XX= PPY=XX|c ",
            " F|||| PP =XX= PP ||||c ",
            "  icc| PP ==== PP |F cc ",
            "    F| PP      PP |F c  ",
            "    F| PP  PP  PP |     ",
        },
        palettes = { "microlab" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_generic_hallway_four_way_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            " cc  | PP      PP |     ",
            " cc  | PP      PP |     ",
            "     | PP ==== PP |     ",
            "  |||| PP =XX= PP ||||F ",
            " F|XX=YPP =XX= PP =XX|F ",
            "|||=== PP ==== PP ===|||",
            "  Y    PP      PP    Y  ",
            "PPPPPP PP  PP  PP  PPPPP",
            "PPPPPP PP  PP  PP  PPPPP",
            "       PP      PP       ",
            "====== PP ==== PP ======",
            "=XXXX= PP =XX= PP =XXXX=",
            "=XXXX= PP =XX= PP =XXXX=",
            "====== PP ==== PP ======",
            "       PP      PP       ",
            "PPPPP  PP  PP  PP  PPPPP",
            "PPPPP  PP  PP  PP  PPPPP",
            "  Y    PP      PP    Y  ",
            "|||=== PP ==== PP ===|||",
            " F|XX=YPP =XX= PPY=XX|c ",
            " F|||| PP =XX= PP ||||c ",
            "  icc| PP ==== PP |F cc ",
            "    F| PP      PP |F c  ",
            "    F| PP  PP  PP |     ",
        },
        palettes = { "microlab" },
    },
}

-- These chunks spawn theme-specific monsters.
ccb.content.define_mapgen {
    kind = "overmap",
    id = "microlab_generic_hallway_straight",
    layout = {
        nested = {
            {
                x = 0,
                y = 0,
                choices = {
                    { id = "microlab_generic_hallway_straight_tile", weight = 98 },
                    { id = "microlab_generic_hallway_straight_isolated_tile", weight = 2 },
                },
            },
            {
                x = 0,
                y = 0,
                id = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "micolab_meat_pools",
                        microlab_serum = "null",
                        microlab_generic = "null",
                    },
                },
            },
            {
                x = 0,
                y = 0,
                id = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "microlab_meat_unique_foe",
                        microlab_serum = "microlab_serum_unique_foe",
                        microlab_generic = "microlab_unique_foe",
                    },
                },
            },
            {
                x = 0,
                y = 0,
                neighbors = { north_west = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 23,
                y = 0,
                neighbors = { north_east = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 23,
                y = 23,
                neighbors = { south_east = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 0,
                y = 23,
                neighbors = { south_west = "microlab" },
                otherwise = { "concrete_corner" },
            },
        },
        monster_placements = {
            {
                group = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "GROUP_MEATLAB",
                        microlab_serum = "GROUP_SERUM_LAB",
                        microlab_generic = "GROUP_LAB",
                    },
                },
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 0, 1 },
            },
        },
        fill_terrain = "t_strconc_floor",
    },
}

-- These chunks spawn theme-specific monsters.
ccb.content.define_mapgen {
    kind = "overmap",
    id = "microlab_generic_hallway_curved",
    layout = {
        nested = {
            { x = 0, y = 0, id = "microlab_generic_hallway_curved_tile" },
            {
                x = 0,
                y = 0,
                id = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "microlab_meat_unique_foe",
                        microlab_serum = "microlab_serum_unique_foe",
                        microlab_generic = "microlab_unique_foe",
                    },
                },
            },
            {
                x = 0,
                y = 0,
                neighbors = { north_west = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 23,
                y = 0,
                neighbors = { north_east = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 23,
                y = 23,
                neighbors = { south_east = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 0,
                y = 23,
                neighbors = { south_west = "microlab" },
                otherwise = { "concrete_corner" },
            },
        },
        monster_placements = {
            {
                group = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "GROUP_MEATLAB",
                        microlab_serum = "GROUP_SERUM_LAB",
                        microlab_generic = "GROUP_LAB",
                    },
                },
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 2, 5 },
            },
        },
        fill_terrain = "t_strconc_floor",
    },
}

-- These chunks spawn theme-specific monsters.
ccb.content.define_mapgen {
    kind = "overmap",
    id = "microlab_generic_hallway_tee",
    layout = {
        nested = {
            { x = 0, y = 0, id = "microlab_generic_hallway_tee_tile" },
            {
                x = 0,
                y = 0,
                id = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "microlab_meat_unique_foe",
                        microlab_serum = "microlab_serum_unique_foe",
                        microlab_generic = "microlab_unique_foe",
                    },
                },
            },
            {
                x = 0,
                y = 0,
                neighbors = { north_west = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 23,
                y = 0,
                neighbors = { north_east = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 23,
                y = 23,
                neighbors = { south_east = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 0,
                y = 23,
                neighbors = { south_west = "microlab" },
                otherwise = { "concrete_corner" },
            },
        },
        monster_placements = {
            {
                group = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "GROUP_MEATLAB",
                        microlab_serum = "GROUP_SERUM_LAB",
                        microlab_generic = "GROUP_LAB",
                    },
                },
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 2, 5 },
            },
        },
        fill_terrain = "t_strconc_floor",
    },
}

-- These chunks spawn theme-specific monsters.
ccb.content.define_mapgen {
    kind = "overmap",
    id = "microlab_generic_hallway_four_way",
    layout = {
        nested = {
            { x = 0, y = 0, id = "microlab_generic_hallway_four_way_tile" },
            {
                x = 0,
                y = 0,
                id = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "microlab_meat_unique_foe",
                        microlab_serum = "microlab_serum_unique_foe",
                        microlab_generic = "microlab_unique_foe",
                    },
                },
            },
            {
                x = 0,
                y = 0,
                neighbors = { north_west = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 23,
                y = 0,
                neighbors = { north_east = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 23,
                y = 23,
                neighbors = { south_east = "microlab" },
                otherwise = { "concrete_corner" },
            },
            {
                x = 0,
                y = 23,
                neighbors = { south_west = "microlab" },
                otherwise = { "concrete_corner" },
            },
        },
        monster_placements = {
            {
                group = {
                    select = { parameter = "labtype", fallback = "microlab_generic" },
                    cases = {
                        microlab_meat = "GROUP_MEATLAB",
                        microlab_serum = "GROUP_SERUM_LAB",
                        microlab_generic = "GROUP_LAB",
                    },
                },
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 2, 5 },
            },
        },
        fill_terrain = "t_strconc_floor",
    },
}
