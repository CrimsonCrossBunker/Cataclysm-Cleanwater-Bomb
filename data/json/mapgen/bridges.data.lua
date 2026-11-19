local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bridge_road_trash",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        item_group_placements = { { group = "bridge", x = { 4, 19 }, y = { 0, 23 }, chance = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bridgehead_ground_trash",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        item_group_placements = { { group = "bridge", x = { 4, 19 }, y = { 0, 12 }, chance = 5 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_bridgehead_ramp_trash",
    layout = {
        size = { width = 24, height = 24 },
        rotation = { 0, 3 },
        item_group_placements = { { group = "bridge", x = { 4, 19 }, y = { 15, 23 }, chance = 5 } },
    },
}
