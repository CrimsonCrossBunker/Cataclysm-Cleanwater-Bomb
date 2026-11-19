local ccb = require("ccb")

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "utility_3x3_N",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "gfa",
            "...",
            "   ",
        },
        palettes = { "basement_utility_nest_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "utility_3x3_S",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            "...",
            "gfa",
        },
        palettes = { "basement_utility_nest_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "utility_3x3_W",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "a. ",
            "f. ",
            "g. ",
        },
        palettes = { "basement_utility_nest_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "utility_3x3_e",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            " .a",
            " .f",
            " .g",
        },
        palettes = { "basement_utility_nest_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basement
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_junk",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||++||",
            "|D  U|",
            "|z  U|",
            "|zzPU|",
            "|PzzU|",
            "||||||",
        },
        palettes = { "domestic_general_and_variant_palette" },
        terrain = {
            [" "] = "t_thconc_floor",
            P = "t_thconc_floor",
            z = "t_thconc_floor",
            U = "t_thconc_floor",
            D = "t_thconc_floor",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- a nested map for basement
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_junk_S",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|qz Q|",
            "|q zQ|",
            "|Uz 6|",
            "|U  6|",
            "||++||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            [" "] = "t_thconc_floor",
            U = "t_thconc_floor",
            Q = "t_thconc_floor",
            ["6"] = "t_thconc_floor",
            z = "t_thconc_floor",
            q = "t_thconc_floor",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- a nested map for basement
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_junk_E",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|qzQQ|",
            "|q   +",
            "|Uz 6|",
            "|U z6|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            [" "] = "t_thconc_floor",
            U = "t_thconc_floor",
            Q = "t_thconc_floor",
            ["6"] = "t_thconc_floor",
            z = "t_thconc_floor",
            q = "t_thconc_floor",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- a nested map for basement
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_junk_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|qqzQ|",
            "+   Q|",
            "|Uz 6|",
            "|U z6|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            [" "] = "t_thconc_floor",
            U = "t_thconc_floor",
            Q = "t_thconc_floor",
            ["6"] = "t_thconc_floor",
            z = "t_thconc_floor",
            q = "t_thconc_floor",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_office_N",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "|||+||",
            "|PP E|",
            "|T   |",
            "|rh y|",
            "|rrYR|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_office_S",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|PPYE|",
            "|r   |",
            "|rh y|",
            "|rr R|",
            "|:|+||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_office_E",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|PPTE|",
            "|r   +",
            "|rh y:",
            "|rrYR|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_office_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|PPTE|",
            "+    |",
            ":rh Y|",
            "|rrrR|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_junk_N",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||+|||",
            "|6h  U|",
            "|Qh  U|",
            "|vzAHU|",
            "|@AEHq|",
            "|@zzPq|",
            "|||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_junk_S",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|6hzzU|",
            "|QhE U|",
            "|vzAHU|",
            "|@A Hq|",
            "|@  Pq|",
            "|||+|||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_junk_E",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|6hzzU|",
            "|QhE U|",
            "|vzAH +",
            "|@A Hq|",
            "|@QUPq|",
            "|||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_junk_W",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|6hzzU|",
            "|QhE U|",
            "+ zAHv|",
            "|@A Hq|",
            "|@RUPq|",
            "|||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_junk_N",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||+|||",
            "|6h   U|",
            "|6h  hU|",
            "|Qh Ø U|",
            "|vzAH U|",
            "|@AEH q|",
            "|@zzPÆq|",
            "||||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_junk_S",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||||||",
            "|6hz@@U|",
            "|6h zhU|",
            "|Qh Ø U|",
            "|vzAHzU|",
            "|@AEH q|",
            "|@  PÆq|",
            "|||+||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_hobby_N",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||+|||",
            "|1     |",
            "|      |",
            "|      |",
            "|      |",
            "|      |",
            "|      |",
            "||||||||",
        },
        terrain = { ["|"] = "t_wall_y", ["+"] = "t_door_c" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 5 },
                    { id = "6x6_sewing_open", weight = 40 },
                    { id = "6x6_electronics_open", weight = 40 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_hobby_S",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||||||",
            "|1     |",
            "|      |",
            "|      |",
            "|      |",
            "|      |",
            "|      |",
            "||||+|||",
        },
        terrain = { ["|"] = "t_wall_y", ["+"] = "t_door_c" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 5 },
                    { id = "6x6_sewing_open", weight = 40 },
                    { id = "6x6_electronics_open", weight = 40 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_hobby_E",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||||||",
            "|1     |",
            "|      |",
            "|      |",
            "|      +",
            "|      |",
            "|      |",
            "||||||||",
        },
        terrain = { ["|"] = "t_wall_y", ["+"] = "t_door_c" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 5 },
                    { id = "6x6_sewing_open", weight = 40 },
                    { id = "6x6_electronics_open", weight = 40 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_hobby_W",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||||||",
            "|1     |",
            "|      |",
            "|      |",
            "+      |",
            "|      |",
            "|      |",
            "||||||||",
        },
        terrain = { ["|"] = "t_wall_y", ["+"] = "t_door_c" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 5 },
                    { id = "6x6_sewing_open", weight = 40 },
                    { id = "6x6_electronics_open", weight = 40 },
                },
            },
        },
    },
}
