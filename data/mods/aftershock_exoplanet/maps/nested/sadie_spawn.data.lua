local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "Sadie_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "sadie", x = 0, y = 0 } },
    },
}
