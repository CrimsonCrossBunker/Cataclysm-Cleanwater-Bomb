local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "outer_space",
    layout = {
        fill_terrain = "t_hard_vacuum",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "high_orbit_salus_4", "high_orbit_salus_4tp" },
    layout = {
        fill_terrain = "t_open_air",
    },
}
