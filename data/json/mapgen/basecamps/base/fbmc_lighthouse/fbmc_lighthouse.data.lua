local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lighthouse_0",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 10, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_lighthouse_root_cellar",
    layout = {
        tile_edits = { { shape = "point", operation = "terrain", id = "t_rootcellar", x = 9, y = 15 } },
    },
}
