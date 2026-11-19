local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "robofac_mi3_photonics_chunk",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "T",
        },
        terrain = { T = "t_metal_floor" },
        item_groups = { T = { group = "nano_templates", chance = 100 } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
