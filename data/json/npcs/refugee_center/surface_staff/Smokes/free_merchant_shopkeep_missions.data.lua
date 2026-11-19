local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "smokes_take_down_back_bay_barricade",
    layout = {
        tile_edits = {
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 6,
                y = 3,
                end_x = 17,
                end_y = 3,
            },
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 3,
                y = 4,
                end_x = 20,
                end_y = 14,
            },
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 4,
                y = 15,
                end_x = 20,
                end_y = 15,
            },
            {
                shape = "rectangle",
                operation = "furniture",
                id = "f_clear",
                x = 5,
                y = 16,
                end_x = 18,
                end_y = 16,
            },
            {
                shape = "rectangle",
                operation = "remove_items",
                x = 3,
                y = 3,
                end_x = 20,
                end_y = 16,
            },
            {
                shape = "rectangle",
                operation = "remove_items",
                x = 21,
                y = 12,
                end_x = 23,
                end_y = 15,
            },
        },
    },
}
