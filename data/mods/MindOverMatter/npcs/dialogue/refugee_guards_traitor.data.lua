local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "remove_refugee_center_traitor_because_banished",
    layout = {
        npc_removals = { { id = "evac_guard3", x = 0, y = 0 } },
    },
}
