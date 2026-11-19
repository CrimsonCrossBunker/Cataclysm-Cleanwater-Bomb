local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_mansion_+3",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 17, y = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_mansion_+3_radio",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 6, y = 0 },
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 6, y = 1 },
        },
    },
}
