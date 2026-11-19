local ccb = require("ccb")

-- Random chemicals mixed together is bound to create toxic gas, also makes it harder to get to any loot.
ccb.content.define_mapgen {
    kind = "nested",
    id = "toxic_gas_vent",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_gas_vent", x = 0, y = 0, intensity = 3, age_turns = 0 } },
        loot_placements = { { group = "toxic_waste_mx_chems", x = 0, y = 0, repetitions = { 2, 3 } } },
        tile_edits = { { shape = "point", operation = "terrain", id = "t_pit", x = 0, y = 0 } },
    },
}
