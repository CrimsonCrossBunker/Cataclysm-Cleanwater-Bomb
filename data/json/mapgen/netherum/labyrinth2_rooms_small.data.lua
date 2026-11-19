local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "labyrinth2_small_room",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "#+##",
            "#..#",
            "#..#",
            "####",
        },
        palettes = { "labyrinth2_backdrop_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 1 }, { id = "ls_2x2_furniture", weight = 1 } },
                x = 1,
                y = 1,
            },
        },
    },
}
