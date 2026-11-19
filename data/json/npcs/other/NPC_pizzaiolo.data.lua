local ccb = require("ccb")

-- For MISSION_PYROMANIAC. Will spawn fire on tile where PC is standing.
ccb.content.define_mapgen {
    kind = "update",
    id = "MISSION_PYROMANIAC_BURN",
    layout = {
        liquid_placements = { { id = "gasoline", x = { 5, 20 }, y = { 5, 20 }, amount = 5, repetitions = 40 } },
        field_placements = { { id = "fd_fire", x = { 5, 20 }, y = { 5, 20 }, repetitions = 40 } },
    },
}
