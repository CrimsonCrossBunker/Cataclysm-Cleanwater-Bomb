local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "riverside_jetski",
    layout = {
        size = { width = 24, height = 24 },
        vehicle_placements = { { id = "jetskis", x = 12, y = 1, rotation = 90, status = -1 } },
    },
}
