local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "faction_base_helipad_garage_0" },
    layout = {
        fill_terrain = "t_dirt",
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_helipad_garage_0",
    layout = {
        tile_edits = { { shape = "point", operation = "furniture", id = "f_clear", x = 0, y = 0 } },
    },
}
