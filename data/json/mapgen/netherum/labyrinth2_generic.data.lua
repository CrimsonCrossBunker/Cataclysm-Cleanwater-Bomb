local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "labyrinth2" },
    layout = {
        fill_terrain = "t_nl_metal_floor",
        nested = {
            { choices = { { id = "labyrinth2_backdrop", weight = 100 } }, x = 0, y = 0 },
            {
                choices = { { id = "null", weight = 500 }, { id = "labyrinth2_hall", weight = 250 } },
                x = 0,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 250 }, { id = "labyrinth2_large_room", weight = 250 } },
                x = { 0, 13 },
                y = { 0, 13 },
                repetitions = { 0, 2 },
            },
            {
                choices = { { id = "null", weight = 250 }, { id = "labyrinth2_small_room", weight = 250 } },
                x = { 0, 18 },
                y = { 0, 18 },
                repetitions = { 0, 3 },
            },
            {
                choices = { { id = "null", weight = 49 }, { id = "labyrinth_stairs_2_to_1", weight = 1 } },
                x = { 1, 18 },
                y = { 1, 18 },
            },
            {
                choices = { { id = "null", weight = 49 }, { id = "labyrinth2_treasure_room", weight = 1 } },
                x = 0,
                y = 0,
            },
        },
    },
}
