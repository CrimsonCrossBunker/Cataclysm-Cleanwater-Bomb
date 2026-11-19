local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_pottery_cottage_0",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 13, y = 14 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_pottery_cottage_butchery_rack",
    layout = {
        tile_edits = {
            { shape = "point", operation = "furniture", id = "f_butcher_rack", x = 14, y = 13 },
            { shape = "point", operation = "furniture", id = "f_table", x = 15, y = 13 },
        },
    },
}
