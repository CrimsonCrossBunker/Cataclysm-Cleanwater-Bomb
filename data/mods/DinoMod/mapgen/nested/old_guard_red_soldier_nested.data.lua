local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "old_guard_red_soldier_spawn",
    layout = {
        size = { width = 1, height = 1 },
        npc_placements = { { id = "old_guard_red_soldier", x = 0, y = 0 } },
    },
}
