local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "open_airlock",
    layout = {
        nested = { { x = 0, y = 0, id = "24x24_sidewalk_airlock_open" } },
    },
}
