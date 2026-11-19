local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "backfloorchamber" },
    layout = {
        nested = {
            { x = 0, y = 0, choices = { { id = "mx_backrooms_whole", weight = 100 } } },
            {
                x = { 0, 13 },
                y = { 0, 13 },
                repetitions = { 0, 2 },
                choices = {
                    { id = "null", weight = 250 },
                    { id = "mx_backroom_big_empty", weight = 50 },
                    { id = "mx_backroom_big_generic", weight = 50 },
                    { id = "mx_backroom_big_common", weight = 100 },
                    { id = "mx_backroom_big_storage", weight = 25 },
                    { id = "mx_backroom_big_breakroom", weight = 25 },
                    { id = "mx_backroom_big_bathroom", weight = 20 },
                },
            },
            {
                x = { 0, 18 },
                y = { 0, 18 },
                repetitions = { 0, 3 },
                choices = {
                    { id = "null", weight = 250 },
                    { id = "mx_backroom_small_empty", weight = 50 },
                    { id = "mx_backroom_small_generic", weight = 50 },
                    { id = "mx_backroom_small_common", weight = 100 },
                    { id = "mx_backroom_small_storage", weight = 25 },
                    { id = "mx_backroom_small_breakroom", weight = 25 },
                    { id = "mx_backroom_small_bathroom", weight = 20 },
                },
            },
        },
        fill_terrain = "t_carpet_backrooms",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "backroom_border",
    layout = {
        fill_terrain = "t_backroom_wall_border",
    },
}

ccb.content.define_overmap_terrain {
    id = "backfloorchamber",
    name = ccb.content.text("backroom chamber"),
    symbol = ".",
    color = "white",
    see_cost = "full_high",
    spawns = { group = "GROUP_BACKROOMS", population = { 2, 15 }, chance = 40 },
    extras = "backrooms",
}

ccb.content.define_overmap_terrain {
    id = { "backroom_stairs_bottom", "backroom_stairs_top" },
    name = ccb.content.text("backroom stairs"),
    symbol = "S",
    color = "white",
    see_cost = "full_high",
    spawns = { group = "GROUP_BACKROOMS", population = { 2, 15 }, chance = 40 },
    extras = "backrooms",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "backroom_border",
    name = "",
    symbol = ".",
    color = "white",
    see_cost = "full_high",
    flags = { "NO_ROTATE" },
}
