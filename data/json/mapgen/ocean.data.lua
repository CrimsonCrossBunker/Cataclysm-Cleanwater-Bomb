local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "ocean_bed" },
    layout = {
        furniture = { [" "] = { { id = "f_region_ocean_bed", copies = 1 }, { id = "f_null", copies = 99 } } },
        fill_terrain = "t_ocean_bed",
    },
}
