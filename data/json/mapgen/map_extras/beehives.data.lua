local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_beehive_natural",
    layout = {
        nested = {
            {
                choices = { { id = "nested_beehive_natural", weight = 100 } },
                x = { 0, 23 },
                y = { 0, 23 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nested_beehive_natural",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_beehive_natural", x = 0, y = 0 } },
    },
}
