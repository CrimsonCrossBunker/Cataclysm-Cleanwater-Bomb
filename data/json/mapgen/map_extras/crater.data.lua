local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_crater",
    layout = {
        nested = { { choices = { { id = "crater_bomb", weight = 100 } }, x = { 0, 23 }, y = { 0, 23 } } },
    },
}
