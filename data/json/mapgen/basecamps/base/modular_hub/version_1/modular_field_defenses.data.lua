local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_trench_north",
    layout = {
        item_group_placements = {
            { x = 3, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 4, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 5, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 6, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 7, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 8, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 9, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 10, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 11, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 12, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 13, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 14, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 15, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 16, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 17, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 18, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 19, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 20, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
        },
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 3,
                end_x = 20,
                y = 0,
                end_y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_trench_south",
    layout = {
        item_group_placements = {
            { x = 3, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 4, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 5, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 6, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 7, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 8, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 9, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 10, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 11, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 12, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 13, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 14, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 15, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 16, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 17, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 18, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 19, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 20, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
        },
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 3,
                end_x = 20,
                y = 23,
                end_y = 23,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_trench_corner_northeast",
    layout = {
        item_group_placements = {
            { x = 20, y = 0, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 20, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 20, y = 2, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 20, y = 3, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 20, y = 4, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
        },
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 21,
                end_x = 21,
                y = 0,
                end_y = 4,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_trench_corner_northwest",
    layout = {
        item_group_placements = {
            { x = 3, y = 0, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 3, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 3, y = 2, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 3, y = 3, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 3, y = 4, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
        },
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 2,
                end_x = 2,
                y = 0,
                end_y = 4,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_trench_corner_southeast",
    layout = {
        item_group_placements = {
            { x = 20, y = 19, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 20, y = 20, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 20, y = 21, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 20, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 20, y = 23, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
        },
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 21,
                end_x = 21,
                y = 19,
                end_y = 23,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_trench_corner_southwest",
    layout = {
        item_group_placements = {
            { x = 3, y = 19, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 3, y = 20, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 3, y = 21, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 3, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 3, y = 23, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
        },
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 2,
                end_x = 2,
                y = 19,
                end_y = 23,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_trench_east",
    layout = {
        item_group_placements = {
            { x = 22, y = 0, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 2, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 3, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 4, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 5, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 6, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 7, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 8, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 9, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 10, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 11, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 12, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 13, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 14, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 15, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 16, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 17, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 18, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 19, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 20, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 21, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 22, y = 23, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
        },
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 21,
                end_x = 22,
                y = 0,
                end_y = 0,
            },
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 21,
                end_x = 22,
                y = 23,
                end_y = 23,
            },
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 23,
                end_x = 23,
                y = 0,
                end_y = 23,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmh_trench_west",
    layout = {
        item_group_placements = {
            { x = 1, y = 0, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 1, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 2, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 3, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 4, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 5, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 6, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 7, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 8, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 9, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 10, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 11, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 12, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 13, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 14, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 15, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 16, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 17, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 18, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 19, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 20, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 21, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 22, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
            { x = 1, y = 23, group = "digging_soil_loam_50L", chance = 99, repetitions = 30 },
        },
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 1,
                end_x = 2,
                y = 0,
                end_y = 0,
            },
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 1,
                end_x = 2,
                y = 23,
                end_y = 23,
            },
            {
                shape = "line",
                operation = "terrain",
                id = "t_pit",
                x = 0,
                end_x = 0,
                y = 0,
                end_y = 23,
            },
        },
    },
}
