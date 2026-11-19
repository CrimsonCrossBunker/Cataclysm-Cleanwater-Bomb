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
