local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_crater",
    layout = {
        nested = { { choices = { { id = "crater_bomb", weight = 100 } }, x = { 0, 23 }, y = { 0, 23 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "crater_bomb",
    layout = {
        size = { width = 1, height = 1 },
        item_placements = { { id = "crater_bomb", x = 0, y = 0, flags = { "ACTIVATE_ON_PLACE" } } },
    },
}
