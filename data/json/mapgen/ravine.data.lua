local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "ravine" },
    layout = {
        fill_terrain = "t_open_air",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "ravine_floor" },
    layout = {
        fill_terrain = "t_region_groundcover",
    },
}
