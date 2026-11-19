local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_map_lights_on",
    layout = {
        size = { width = 24, height = 24 },
        transform_placements = { { id = "afs_lights_on", x = { 0, 23 }, y = { 0, 23 } } },
    },
}
