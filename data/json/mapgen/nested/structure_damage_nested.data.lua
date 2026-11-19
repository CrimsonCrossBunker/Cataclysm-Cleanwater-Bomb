local ccb = require("ccb")

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
