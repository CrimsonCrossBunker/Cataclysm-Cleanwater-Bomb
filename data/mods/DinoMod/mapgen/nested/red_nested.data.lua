local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "NC_Red_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "old_guard_red", x = 0, y = 0 } },
    },
}
