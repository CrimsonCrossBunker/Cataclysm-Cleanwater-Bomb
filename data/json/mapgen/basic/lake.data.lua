local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "lake_bed" },
    weight = { global = "vanilla_lake_weight", fallback = 1000 },
    layout = {
        fill_terrain = "t_lake_bed",
        furniture = {
            [" "] = {
                { id = "f_region_lake_bed", copies = 1 },
                { id = "f_null", copies = 199 },
            },
        },
    },
}
