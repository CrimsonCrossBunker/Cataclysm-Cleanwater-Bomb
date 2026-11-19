local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "LMOE_unlock_door",
    layout = {
        transform_placements = { { id = "unlock_door", x = 11, y = 12 } },
    },
}
