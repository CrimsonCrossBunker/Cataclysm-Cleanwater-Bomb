local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "trash",
    layout = {
        size = { width = 1, height = 1 },
        item_group_placements = { { group = "SUS_trash_floor_heavy", x = 0, y = 0, chance = 100 } },
    },
}
