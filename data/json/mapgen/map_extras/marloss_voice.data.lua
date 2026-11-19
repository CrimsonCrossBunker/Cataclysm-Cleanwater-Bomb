local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "marloss_zealot",
    layout = {
        size = { width = 1, height = 1 },
        monster_placements = { { id = "mon_marloss_zealot_f", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "marloss_zealot",
    layout = {
        size = { width = 1, height = 1 },
        monster_placements = { { id = "mon_marloss_zealot_m", x = 0, y = 0 } },
    },
}
