local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_sealab_small_0",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 10, y = 12 } },
    },
}
