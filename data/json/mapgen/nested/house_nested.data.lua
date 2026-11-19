local ccb = require("ccb")

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_1_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "¤@@¤",
            " @@ ",
            "y   ",
            "D   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_1_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "¤@@¤",
            " @@ ",
            "E   ",
            "I   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_1_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "¤@@¤",
            " @@ ",
            "E   ",
            "ɱ   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_1_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "@@  ",
            "¤  I",
            "  hI",
            "DT  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_1_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "@@  ",
            "¤  I",
            "  hɱ",
            "DT  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_1_E",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "II  ",
            "h  ¤",
            "y @@",
            "D   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_1_E",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "ɱI  ",
            "h  ¤",
            "y @@",
            "D   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_1_S",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "IIy ",
            "h  D",
            " @  ",
            "¤@  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_1_S",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "ɱIy ",
            "h  D",
            " @  ",
            "¤@  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "¤@@¤",
            " @@ ",
            "y   ",
            "D   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "¤@@¤",
            " @@ ",
            "E   ",
            "I   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "¤@@¤",
            " @@ ",
            "E   ",
            "ɱ   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "D@@D",
            " @@ ",
            " == ",
            " == ",
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        rotation = { 0, 3 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "D@@D",
            " @@ ",
            "    ",
            " ɱa ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "D@@D",
            " @@ ",
            "    ",
            " Ia ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "D@@D",
            " @@ ",
            "    ",
            " bT ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = {
            "ERASE_FURNITURE_BEFORE_PLACING_TERRAIN",
            "ERASE_TRAP_BEFORE_PLACING_TERRAIN",
            "ALLOW_TERRAIN_UNDER_ITEMS",
        },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_E",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "D  ¤",
            "  @@",
            "  @@",
            "T  ¤",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_E",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "   D",
            "==@@",
            "==@@",
            "   D",
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_E",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "   D",
            "I @@",
            "a @@",
            "   D",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_E",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "   D",
            "ɱ @@",
            "a @@",
            "   D",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_E",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "   D",
            "b @@",
            "T @@",
            "   D",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "¤   ",
            "@@ D",
            "@@ y",
            "¤   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE", "ALLOW_TERRAIN_UNDER_ITEMS" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "¤   ",
            "@@ E",
            "@@ I",
            "¤   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE", "ALLOW_TERRAIN_UNDER_ITEMS" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "¤   ",
            "@@ E",
            "@@ ɱ",
            "¤   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE", "ALLOW_TERRAIN_UNDER_ITEMS" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "D   ",
            "@@==",
            "@@==",
            "D   ",
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE", "ALLOW_TERRAIN_UNDER_ITEMS" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "D   ",
            "@@ a",
            "@@ I",
            "D   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE", "ALLOW_TERRAIN_UNDER_ITEMS" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "D   ",
            "@@ a",
            "@@ ɱ",
            "D   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE", "ALLOW_TERRAIN_UNDER_ITEMS" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "D   ",
            "@@ T",
            "@@ b",
            "D   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE", "ALLOW_TERRAIN_UNDER_ITEMS" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_S",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " aD ",
            "    ",
            " @@ ",
            "¤@@¤",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_S",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " == ",
            " == ",
            " @@ ",
            "D@@D",
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_S",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " Ia ",
            "    ",
            " @@ ",
            "D@@D",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_2_S",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " bT ",
            "    ",
            " @@ ",
            "D@@D",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed, works for rooms with corner doors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_3_S",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " ER ",
            "D   ",
            " @@ ",
            " @@ ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed, works for rooms with corner doors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_3_S",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " Eɱ ",
            "D   ",
            " @@ ",
            " @@ ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed, works for rooms with corner doors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_3_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " @@ ",
            " @@ ",
            "D   ",
            " RE ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed, works for rooms with corner doors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_3_N",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " @@ ",
            " @@ ",
            "D   ",
            " ɱE ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed, works for rooms with corner doors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_3_E",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "R @@",
            "E @@",
            " D  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed, works for rooms with corner doors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_3_E",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "ɱ @@",
            "E @@",
            " D  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed, works for rooms with corner doors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_3_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "@@ E",
            "@@ R",
            "  D ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed, works for rooms with corner doors.
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_4x4_adult_3_W",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "@@ E",
            "@@ ɱ",
            "  D ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_5x5_adult_N_1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " ¤@@¤",
            "  @@ ",
            "y    ",
            "Ih   ",
            "I  DD",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_5x5_adult_N_1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " ¤@@¤",
            "  @@ ",
            "y    ",
            "ɱh   ",
            "I  DD",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_5x5_adult_S_1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "  II ",
            "D h  ",
            "D   y",
            " @@  ",
            "¤@@¤ ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_5x5_adult_W_1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "¤    ",
            "@@  I",
            "@@ hI",
            "¤    ",
            "DDy  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_5x5_adult_W_1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "¤    ",
            "@@  I",
            "@@ hɱ",
            "¤    ",
            "DDy  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_5x5_adult_E_1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "D   ¤",
            "D  @@",
            "h  @@",
            "II  ¤",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_5x5_adult_N_2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "  @¤ ",
            "D @ y",
            "    E",
            " h  T",
            " II  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_5x5_adult_S_2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "Ih  y",
            "I   R",
            "  @ T",
            "D @¤ ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_5x5_adult_E_2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "@@  I",
            "¤  AI",
            "y   R",
            "DEy  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates head of bed
ccb.content.define_mapgen {
    kind = "nested",
    id = "bedroom_5x5_adult_W_2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "  DD ",
            "Ih  ¤",
            "I  @@",
            "y   R",
            "RET  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates table orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "diningroom_5x5_E_W",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "y    ",
            " hhh ",
            " sss ",
            " hhh ",
            "     ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates table orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "diningroom_5x5_N_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            " hsh ",
            " hsh ",
            " hsh ",
            "y    ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates table orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "diningroom_6x6_N_S_1A",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "  hsh ",
            "I hsh ",
            "I hsh ",
            "y hsh ",
            "      ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates table orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "diningroom_6x6_N_S_1B",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " hsh T",
            " hsh I",
            " hsh I",
            " hsh y",
            "      ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates table orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "diningroom_6x6_E_W_1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            " yIIy ",
            "      ",
            " hhhh ",
            " ssss ",
            " hhhh ",
            "      ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates table orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "diningroom_6x6_E_W_1A",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " hhhh ",
            " ssss ",
            " hhhh ",
            "      ",
            " yIIy ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates table orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "diningroom_6x6_E_W_2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "y     ",
            " hhhh ",
            " ssss ",
            " ssss ",
            " hhhh ",
            "      ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates table orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "diningroom_6x6_N_S_2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "y     ",
            " hssh ",
            " hssh ",
            " hssh ",
            " hssh ",
            "      ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates table orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "diningroom_6x6_E_W_2A",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " hhhh ",
            " ssss ",
            " ssss ",
            " hhhh ",
            "y    a",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates table orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "diningroom_6x6_N_S_2A",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " hssh ",
            " hssh ",
            " hssh ",
            " hssh ",
            "Y    y",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_4x4_N_S_1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "yxxx",
            "    ",
            "E l ",
            " HHH",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_4x4_N_S_1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "EllE",
            " ==T",
            " == ",
            "RRRR",
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_4x4_N_S_1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "RRRR",
            "====",
            "====",
            "HHHT",
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_4x4_N_S_1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "Exxx",
            "    ",
            "R l ",
            "RHHH",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_4x4_N_S_1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "yHHH",
            "  l ",
            "E   ",
            " xxx",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_4x4_N_S_1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "eee ",
            "eee ",
            "    ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates sofa orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_5x5_N_1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "yHHHs",
            "     ",
            " lll ",
            "     ",
            "TEsE ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates sofa orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_5x5_S_1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " ElET",
            "     ",
            " lll ",
            "     ",
            "yHHHs",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates sofa orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_5x5_E_1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "T   s",
            "E s H",
            "s s H",
            "E s H",
            "    y",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates sofa orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_5x5_W_1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "y   T",
            "H l E",
            "H l s",
            "H l E",
            "s   y",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates sofa orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_5x5_N_2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " HHl ",
            "    R",
            " ll R",
            "     ",
            " xxx ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates sofa orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_5x5_S_2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " xxx ",
            "     ",
            "H ll ",
            "H    ",
            " HHH ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates sofa orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_5x5_E_2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "  E l",
            "x l H",
            "x l H",
            "x   H",
            "     ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- compass direction indicates sofa orientation
ccb.content.define_mapgen {
    kind = "nested",
    id = "livingroom_5x5_W_2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "H l x",
            "H l x",
            "H   x",
            " HHl ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- bookcases and chair for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_2x2_1",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "RR",
            "E ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- bookcase and chair for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_2x2_2",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "E ",
            "R ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- bookcase and chair for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_2x2_2",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "E ",
            "ɱ ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- bookcase and chair for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_2x2_3",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            " E",
            "TR",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- filing cabinets, shredder for workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_2x2_4_N",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "PP",
            "  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- filing cabinets, shredder for workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_2x2_4_S",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "  ",
            "PP",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- filing cabinets, shredder for workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_2x2_4_W",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "P ",
            "P ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- filing cabinets, shredder for workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_2x2_4_E",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            " P",
            " P",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- bookcases and chair for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_1",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "R T",
            "RE ",
            "R  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- bookcases, computer, and chair for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_1",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "R T",
            "ɱE ",
            "R  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- bookcases and chair for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_1A",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "T R",
            " ER",
            "  R",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- computer and chair for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_1A",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "T I",
            " Eɱ",
            "  I",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_2",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "III",
            " h ",
            "y  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_2",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "IɱI",
            " h ",
            "y  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "I  ",
            "Ih ",
            "I y",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "I  ",
            "ɱh ",
            "I y",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_4",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "III",
            "h  ",
            "  y",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_4",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "ɱII",
            "h  ",
            "  y",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_5",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "HHH",
            "   ",
            "Ell",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_S_5",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            " ss",
            "   ",
            "HHH",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_E_5",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "s H",
            "s H",
            "E H",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_N_6",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "NNN",
            " A ",
            "   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_E_6",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "  N",
            " AN",
            "  N",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_S_6",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            " A ",
            "NNN",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_W_6",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "N  ",
            "NA ",
            "N  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_N_8",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "III",
            " h ",
            "   ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_E_8",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "  I",
            " hI",
            "  I",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_S_8",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            " h ",
            "III",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_W_8",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "I  ",
            "Ih ",
            "I  ",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_S_7",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            " @ ",
            "¤@¤",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- small furniture groupings for studies, workrooms, hobby rooms, etc
ccb.content.define_mapgen {
    kind = "nested",
    id = "bonus_room_3x3_E_7",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            "¤  ",
            "@@y",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for lawns
ccb.content.define_mapgen {
    kind = "nested",
    id = "greenhouse_5x5_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "RRRRR ",
            "RRRRR ",
            "RRRRR ",
            "RRRRR ",
            "RRRRR ",
        },
        terrain = { R = "t_glass_roof" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- a nested map for lawns
ccb.content.define_mapgen {
    kind = "nested",
    id = "shed_6x6_roof",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "------",
            "-....-",
            "-....-",
            "-....-",
            "-....-",
            "------",
        },
        palettes = { "roof_palette" },
        flags = { "ERASE_ITEMS_BEFORE_PLACING_TERRAIN" },
    },
}

-- a nested map for lawns
ccb.content.define_mapgen {
    kind = "nested",
    id = "pond_6x6",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "    N ",
            "  Kk  ",
            "kKkKK ",
            "NKKK  ",
            "  Kcc ",
            "   cZ ",
        },
        palettes = { "domestic_garden_nest_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- a nested map for lawns
ccb.content.define_mapgen {
    kind = "nested",
    id = "playset_4x4_1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "GG c",
            "G% c",
            "  II",
            "N II",
        },
        palettes = { "domestic_garden_nest_palette" },
        terrain = { ["%"] = "t_sandbox" },
        furniture = { ["%"] = "f_sand_castle" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

-- a nested map for lawns
ccb.content.define_mapgen {
    kind = "nested",
    id = "playset_4x4_2",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "H   ",
            "H  I",
            "G  I",
            " ccI",
        },
        palettes = { "domestic_garden_nest_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

-- a nested map for lawns
ccb.content.define_mapgen {
    kind = "nested",
    id = "reflecting_pool_5x5_1",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            " MMM ",
            " fMf ",
            " MMM ",
            "     ",
        },
        palettes = { "domestic_garden_nest_palette" },
        terrain = { [" "] = "t_concrete", f = "t_concrete" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

-- a nested map for lawns
ccb.content.define_mapgen {
    kind = "nested",
    id = "reflecting_pool_5x5_2",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            " MMM ",
            " MZM ",
            " MMM ",
            "     ",
        },
        palettes = { "domestic_garden_nest_palette" },
        terrain = { [" "] = "t_concrete" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

-- a nested map for lawns
ccb.content.define_mapgen {
    kind = "nested",
    id = "garden_3x3_3",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "111",
            "1Z1",
            "111",
        },
        palettes = { "domestic_garden_nest_palette" },
        terrain = { ["1"] = "t_dirtfloor_no_roof" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

-- Replace bookshelf with plant instead
ccb.content.define_mapgen {
    kind = "nested",
    id = "domestic_bookcase_nest_plant",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "R",
        },
        furniture = { R = "f_indoor_plant" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}
