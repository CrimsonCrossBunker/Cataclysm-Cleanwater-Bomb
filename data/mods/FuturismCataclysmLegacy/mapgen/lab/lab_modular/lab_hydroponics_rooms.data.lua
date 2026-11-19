local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_6x6",
    weight = 50,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "HH..HH",
            "......",
            ".HHHH.",
            ".HHHH.",
            "......",
            "HH..HH",
        },
        palettes = { "lab_common_palette", "fcl_hydroponics_lab_palette" },
        rotation = { 0, 3 },
        loot_placements = { { group = "fcl_hydroponics_lab_documents", x = 2, y = 1, chance = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_9x9_E",
    weight = 50,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "HH.HH|   ",
            ".....|   ",
            "HHHHH|   ",
            ".....|   ",
            "H...H+   ",
            ".....|   ",
            "HHHHH|   ",
            ".....|   ",
            "HH.HH|   ",
        },
        palettes = { "lab_common_palette", "fcl_hydroponics_lab_palette" },
        loot_placements = { { group = "fcl_hydroponics_lab_documents", x = 0, y = 1, chance = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_common_9x9_W",
    weight = 50,
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "   |HH.HH",
            "   |.....",
            "   |HHHHH",
            "   |.....",
            "   +H...H",
            "   |.....",
            "   |HHHHH",
            "   |.....",
            "   |HH.HH",
        },
        palettes = { "lab_common_palette", "fcl_hydroponics_lab_palette" },
        loot_placements = { { group = "fcl_hydroponics_lab_documents", x = 8, y = 1, chance = 20 } },
    },
}
