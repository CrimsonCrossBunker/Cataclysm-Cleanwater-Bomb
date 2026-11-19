local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "rock_border",
    layout = {
        fill_terrain = "t_rock",
    },
}
