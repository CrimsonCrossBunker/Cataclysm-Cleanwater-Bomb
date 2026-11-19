local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth2_large_room",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "#####+#####",
            "#.........#",
            "#.........#",
            "#.........#",
            "#.........#",
            "+.........=",
            "#.........#",
            "#.........#",
            "#.........#",
            "#.........#",
            "#####=#####",
        },
        palettes = { "labyrinth2_nest_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { choices = { { id = "labyrinth2_9x9_square_room_nest", weight = 100 } }, x = 1, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth2_large_room",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "  ###+###  ",
            " ##.....## ",
            "##.......##",
            "#.........#",
            "#.........#",
            "+.........=",
            "#.........#",
            "#.........#",
            "##.......##",
            " ##.....## ",
            "  ###=###  ",
        },
        palettes = { "labyrinth2_nest_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { choices = { { id = "labyrinth2_9x9_circle_room_nest", weight = 100 } }, x = 0, y = 0 } },
    },
}
