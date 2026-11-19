local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "afs_shuttlepad_salvors_garage_place_lynx",
    layout = {
        vehicle_placements = { { id = "uica_lynx_ex", x = 6, y = 5, status = 0, faction = "your_followers" } },
    },
}
