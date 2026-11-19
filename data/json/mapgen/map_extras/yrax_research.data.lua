local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_golden_monoliths_map",
    layout = {
        monster_placements = { { id = "mon_golden_monolith", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 5, 7 } } },
    },
}
