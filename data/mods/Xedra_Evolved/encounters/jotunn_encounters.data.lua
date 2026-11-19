local ccb = require("ccb")

-- Adds a random encounter at this rural gas station
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_ruralgas_jotunn",
    layout = {
        monster_placements = { { group = "GROUP_Exodii_Jotunn", x = { 3, 17 }, y = { 13, 15 } } },
        vehicle_placements = { { id = "bearcub", chance = 30, status = -3, x = { 11 }, y = { 12 } } },
        corpse_placements = { { group = "GROUP_FERAL_AGENTS", x = { 7, 14 }, y = { 6, 18 } } },
    },
}

-- removes a random encounter at this roadstop
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_ruralgas_jotunn_remove",
    layout = {
        tile_edits = {
            {
                shape = "rectangle",
                operation = "remove_creatures",
                x = 0,
                y = 0,
                end_x = 23,
                end_y = 23,
            },
        },
    },
}
