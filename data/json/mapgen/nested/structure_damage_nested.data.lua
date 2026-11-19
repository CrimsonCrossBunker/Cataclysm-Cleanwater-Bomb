local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "struc_damage",
    layout = {
        transform_glyphs = {
            c = {
                id = {
                    select = { parameter = "crashvariant" },
                    cases = { fromleft = "struc_carcrash_dirt", fromright = "tft_null" },
                },
            },
            v = {
                id = {
                    select = { parameter = "crashvariant" },
                    cases = { fromleft = "tft_null", fromright = "struc_carcrash_dirt" },
                },
            },
            w = {
                id = {
                    select = { parameter = "crashvariant" },
                    cases = { fromleft = "struc_carcrash_rubble", fromright = "tft_null" },
                },
            },
            j = {
                id = {
                    select = { parameter = "crashvariant" },
                    cases = { fromleft = "tft_null", fromright = "struc_carcrash_rubble" },
                },
            },
            r = { id = "struc_carcrash_rubble" },
            x = { id = "struc_carcrash_clear" },
            d = { id = "struc_carcrash_dirt" },
        },
        field_glyphs = {
            m = { id = "fd_blood", intensity = 2 },
            h = { id = "fd_blood", intensity = 3 },
            k = { id = "fd_blood", intensity = 3 },
        },
        parameters = {
            crashvariant = {
                value_type = "string",
                default = { weighted = { "fromleft", "fromright" } },
                scope = "map_tile",
            },
        },
    },
}

-- Randomizes between the three car crash variants. The walls for the structure being damaged start at y:3.
ccb.content.define_mapgen {
    kind = "nested",
    id = "carcrash_10x10_rand",
    layout = {
        size = { width = 10, height = 10 },
        palettes = { "struc_damage" },
        nested = {
            {
                choices = {
                    { id = "carcrash_10x10_straight", weight = 33 },
                    { id = "carcrash_10x10_diag_fromleft", weight = 33 },
                    { id = "carcrash_10x10_diag_fromright", weight = 33 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

-- Same as 8x8, but made to distribute with the diagonal variants of the same size.
ccb.content.define_mapgen {
    kind = "nested",
    id = "carcrash_10x10_straight",
    layout = {
        size = { width = 10, height = 10 },
        palettes = { "struc_damage" },
        nested = { { id = "carcrash_8x8_straight", x = { 0, 2 }, y = 0 } },
    },
}

-- The walls for the structure being damaged start at y:3.
ccb.content.define_mapgen {
    kind = "nested",
    id = "carcrash_8x8_straight",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " cccdvvv",
            " ccdddvv",
            " ccdddv ",
            " jxxxxw ",
            " jxxxxw ",
            "jjxxxxww",
            "jjxxxxww",
            "jjrrrrww",
        },
        palettes = { "struc_damage" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "carcrash_8x8_straight_bloodcorpse", weight = 50 },
                },
                x = 0,
                y = 0,
            },
        },
        vehicle_placements = { { fuel = 10, rotation = 90, status = 1, id = "cars_only", x = 4, y = 4 } },
    },
}

-- The walls for the structure being damaged start at y:3.
ccb.content.define_mapgen {
    kind = "nested",
    id = "carcrash_10x10_diag_fromleft",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "dddd      ",
            "ddddd     ",
            "dddddddd  ",
            "rrrrxrrrw ",
            "rrrxxxxrrw",
            "jrxxxxxrrw",
            "jjrrxxxrr ",
            "  jjjrrrw ",
            "          ",
            "          ",
        },
        palettes = { "struc_damage" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "carcrash_10x10_diag_fromleft_bloodcorpse", weight = 50 },
                },
                x = 0,
                y = 0,
            },
        },
        vehicle_placements = { { fuel = 10, rotation = 35, status = 1, id = "cars_only", x = 5, y = 3 } },
    },
}

-- The walls for the structure being damaged start at y:3.
ccb.content.define_mapgen {
    kind = "nested",
    id = "carcrash_10x10_diag_fromright",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "      dddd",
            "     ddddd",
            "  dddddddd",
            " wrrrxrrrr",
            "wrrxxxxrrr",
            "wrrxxxxxrj",
            " rrxxxrrjj",
            " wrrrjjj  ",
            "          ",
            "          ",
        },
        palettes = { "struc_damage" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = {
                    { id = "null", weight = 50 },
                    { id = "carcrash_10x10_diag_fromright_bloodcorpse", weight = 50 },
                },
                x = 0,
                y = 0,
            },
        },
        vehicle_placements = { { fuel = 10, rotation = 145, status = 1, id = "cars_only", x = 4, y = 4 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "carcrash_8x8_straight_bloodcorpse",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "    m   ",
            "    mmmm",
            "    mhhm",
            "    mmm ",
            "     m  ",
            "     m  ",
            "    mm  ",
            "    mm  ",
        },
        palettes = { "struc_damage" },
        item_group_placements = { { group = "corpses_verydead", x = { 6, 7 }, y = { 1, 2 }, chance = 100 } },
        field_placements = {
            {
                id = "fd_gibs_flesh",
                x = { 6, 7 },
                y = { 1, 2 },
                intensity = { 1, 2 },
                repetitions = { 1, 3 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "carcrash_10x10_diag_fromleft_bloodcorpse",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "mm        ",
            "hhmm      ",
            "mmmmmmmmm ",
            "       mm ",
            "       mm ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
        },
        palettes = { "struc_damage" },
        item_group_placements = { { group = "corpses_verydead", x = { 0, 1 }, y = { 0, 1 }, chance = 100 } },
        field_placements = {
            {
                id = "fd_gibs_flesh",
                x = { 0, 1 },
                y = { 0, 1 },
                intensity = { 1, 2 },
                repetitions = { 1, 3 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "carcrash_10x10_diag_fromright_bloodcorpse",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "        mm",
            "      mhhm",
            " mmmmmmmhm",
            " mm       ",
            " mm       ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
        },
        palettes = { "struc_damage" },
        item_group_placements = { { group = "corpses_verydead", x = { 8, 9 }, y = { 0, 1 }, chance = 100 } },
        field_placements = {
            {
                id = "fd_gibs_flesh",
                x = { 8, 9 },
                y = { 0, 1 },
                intensity = { 1, 2 },
                repetitions = { 1, 3 },
            },
        },
    },
}
