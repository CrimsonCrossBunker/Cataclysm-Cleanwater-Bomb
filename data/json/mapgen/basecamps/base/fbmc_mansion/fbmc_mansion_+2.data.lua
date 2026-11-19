local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_mansion_+2",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_bulletin", x = 18, y = 6 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_mansion_+2_radio",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_radio_tower", x = 12, y = 0 },
            { shape = "point", operation = "terrain", id = "t_radio_controls", x = 12, y = 1 },
        },
    },
}
