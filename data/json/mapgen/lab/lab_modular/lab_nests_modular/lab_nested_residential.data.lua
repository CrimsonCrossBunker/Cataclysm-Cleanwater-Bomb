local ccb = require("ccb")

-- A nested map for small residential areas. For extra population.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_12x12_small_rooms_A",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "@@ d|||d @@|",
            "s   +,+   s|",
            "T  R|,|R  T|",
            "|||||,||||||",
            "    +,+    |",
            "9|St|,|tS|9|",
            "|||||,||||||",
            "@s R|,|R s@|",
            "@   +,+   @|",
            "T  d|,|d  T|",
            "|||||,||||||",
            "U+,,,,,,,+w|",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for small residential areas. For extra population.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_12x12_small_rooms_B",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "|@@ d|||d @@",
            "|s   +,+   s",
            "|T  R|,|R  T",
            "||||||,|||||",
            "|    +,+    ",
            "|9|St|,|tS|9",
            "||||||,|||||",
            "|@s R|,|R s@",
            "|@   +,+   @",
            "|T  d|,|d  T",
            "||||||,|||||",
            "|U+,,,,,,,+w",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for small residential areas. Entrance can be East or West center tile.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_13x13_EW",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "T@@s |D|BB  8",
            " @@  + |    S",
            "     |||t   8",
            "     |w|||+||",
            "E d y|+|¶¶¶¶ ",
            "|||+||  ¶hh¶ ",
            "        ¶ff¶ ",
            "        ¶hh¶ ",
            "||| |   ¶¶¶¶ ",
            "7   JA  H l x",
            "5   JA  H l x",
            "4           y",
            "F1O32     E R",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        terrain = { h = "t_carpet_concrete_yellow", f = "t_carpet_concrete_yellow" },
        rotation = { 0, 3 },
        loot_placements = {
            { id = "television", x = 12, y = 10, chance = 40 },
            { id = "stereo", x = 12, y = 9, chance = 40 },
        },
    },
}

-- A nested map for small residential areas. Entrance can be East or West center tile.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_13x13_EW",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "F1O32     E R",
            "4       y   y",
            "5   JA  H l x",
            "7   JA  H l x",
            "||| |   ¶¶¶¶ ",
            "Y       ¶hh¶ ",
            "        ¶ff¶ ",
            "|||+||  ¶hh¶ ",
            "E d  |+|¶¶¶¶ ",
            "     |w|||+||",
            "     |||t   8",
            " @@  + |    S",
            "T@@s |D|BB  8",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        terrain = {
            h = "t_carpet_concrete_purple",
            f = "t_carpet_concrete_purple",
            ["¶"] = "t_carpet_concrete_purple",
        },
        rotation = { 0, 3 },
        loot_placements = {
            { id = "television", x = 12, y = 2, chance = 40 },
            { id = "stereo", x = 12, y = 3, chance = 40 },
        },
    },
}

-- A nested map for small residential areas. Entrance can be East or West center tile.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_13x13_EW",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "BB S|D|s@@  d",
            "t  8| + @@   ",
            "||+||||  ¶HHs",
            "13  JJJ  ¶¶¶¶",
            "F        yxxT",
            "||||||+||||||",
            "             ",
            "||||||+||||||",
            "F         xxT",
            "13  JJJ  ¶¶¶¶",
            "||+||||  ¶HHs",
            "t  8| + @@   ",
            "BB S|D|y@@  d",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        terrain = {
            s = "t_carpet_concrete_red",
            H = "t_carpet_concrete_red",
            ["¶"] = "t_carpet_concrete_red",
        },
        rotation = { 0, 3 },
        loot_placements = {
            { id = "television", x = 10, y = 4, chance = 40 },
            { id = "stereo", x = 11, y = 4, chance = 40 },
            { id = "television", x = 10, y = 8, chance = 40 },
            { id = "stereo", x = 11, y = 8, chance = 40 },
        },
    },
}

-- A nested map for small residential areas. Entrance can be East or West center tile.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_13x13_EW",
    layout = {
        size = { width = 13, height = 13 },
        rows = {
            "@@ꞝhd|  RxxR ",
            "@@ꞝꞝy|  ¶¶¶¶H",
            "|||  +  ¶¶¶¶H",
            "S |+||   HHHs",
            "t   9|  ꞝꞝꞝꞝ ",
            "||||||  ꞝhhꞝ ",
            "        ꞝffꞝ ",
            "||||||  ꞝhhꞝ ",
            "t   9|  ꞝꞝꞝꞝA",
            "S |+||  JJJJJ",
            "|||  +   A  5",
            "@@ꞝꞝ |      1",
            "@@ꞝhd|F123O47",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        terrain = { f = "t_carpet_concrete_green", h = "t_carpet_concrete_green" },
        rotation = { 0, 3 },
        loot_placements = {
            { id = "television", x = 10, y = 0, chance = 40 },
            { id = "stereo", x = 9, y = 0, chance = 40 },
        },
    },
}

-- A nested map for small residential areas. Door orientation to the west.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_6x6_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " RRRR ",
            "      ",
            " hsh R",
            " hsh R",
            " hsh R",
            "  h   ",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for small residential areas. Door orientation to the west.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_6x6_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " ssssT",
            "      ",
            " ee AJ",
            " ee  J",
            " ee AJ",
            "A     ",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
        item_groups = {
            J = { group = "wetbar_stack", chance = 30 },
            s = { group = "SUS_office_desk", chance = 30 },
        },
    },
}

-- A nested map for small residential areas. Door orientation to the west.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_6x6_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " ssssT",
            "      ",
            " ee AJ",
            " ee  J",
            " ee AJ",
            "A     ",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        rotation = { 0, 3 },
        item_groups = {
            s = { group = "wetbar_stack", chance = 30 },
            Y = { group = "SUS_trash_trashcan", chance = 20 },
        },
    },
}

-- A nested map for small residential areas. Door orientation to the west.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_6x6_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " ÆsØ  ",
            "A     ",
            "     !",
            "     x",
            "Hl   !",
            "HHH   ",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        furniture = { ["!"] = "f_speaker_cabinet" },
        rotation = { 0, 3 },
        loot_placements = {
            { id = "stereo", x = 5, y = 3, chance = 100 },
            { id = "laptop", x = 1, y = 4, chance = 60 },
        },
    },
}

-- A nested map for small residential areas. Door orientation to the west.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_6x6_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " EsE R",
            "     R",
            "     _",
            "     a",
            "Hll  _",
            "HHH  R",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        furniture = { ["!"] = "f_speaker_cabinet" },
        rotation = { 0, 3 },
        loot_placements = {
            { group = "games", x = 2, y = 0, chance = 100 },
            { id = "laptop", x = 1, y = 4, chance = 60 },
        },
    },
}

-- A nested map for small residential areas. Door orientation to the west.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_residential_6x6_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " EsE R",
            "     R",
            " eee _",
            " eee a",
            "     _",
            " EsE R",
        },
        palettes = { "lab_common_palette", "lab_residential_palette" },
        furniture = { ["!"] = "f_speaker_cabinet" },
        rotation = { 0, 3 },
        loot_placements = {
            { group = "games", x = 2, y = 0, chance = 100 },
            { group = "games", x = 2, y = 5, chance = 100 },
            { id = "laptop", x = 1, y = 4, chance = 60 },
        },
    },
}

-- A nested map for small recreational/fitness areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_dojo",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "!!!!!",
            "!!!!!",
            "!!!!!",
            "!!!!!",
            "yyÿyy",
        },
        palettes = { "lab_common_palette" },
        furniture = { ["!"] = "f_tatami", ["ÿ"] = "f_coffee_table" },
        rotation = { 0, 3 },
        loot_placements = {
            { group = "dojo_manuals", x = 2, y = 4, chance = 100 },
            { id = "candle", x = 2, y = 4, chance = 100, repetitions = { 1, 2 } },
        },
    },
}
