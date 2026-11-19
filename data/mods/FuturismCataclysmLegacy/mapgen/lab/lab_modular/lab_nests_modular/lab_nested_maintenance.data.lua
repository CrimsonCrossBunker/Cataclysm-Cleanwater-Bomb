local ccb = require("ccb")

-- A nested map for a 5x9 room, includes door on east wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_9x9_E",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "A   Q|   ",
            "NN  Q|   ",
            "     |   ",
            "J    #   ",
            "J A  #   ",
            "J    |   ",
            "    Y|   ",
            "N A Q|   ",
            "NN  Q|   ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        loot_placements = {
            { id = "broken_fcl_eyebot", x = 0, y = 2, chance = 100 },
            { id = "broken_secubot", x = 0, y = 6, chance = 100 },
        },
    },
}
