local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "shopkeep_lobby_cleanup1",
    layout = {
        tile_edits = {
            {
                shape = "rectangle",
                operation = "remove_items",
                x = 5,
                y = 22,
                end_x = 18,
                end_y = 23,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "shopkeep_lobby_cleanup2",
    layout = {
        tile_edits = { { shape = "rectangle", operation = "remove_items", x = 5, y = 0, end_x = 18, end_y = 2 } },
    },
}
