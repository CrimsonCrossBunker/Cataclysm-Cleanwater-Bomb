local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "1x1_triffid_field_terrain",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "I",
        },
        palettes = { "triffid" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
