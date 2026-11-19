local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "microlab_distorted" } },
    layout = {
        predecessor_mapgen = "microlab_generic",
        nested = {
            { id = "microlab_distorted_chunk", x = 0, y = 0 },
            { id = "microlab_distorted_chunk", x = 12, y = 0 },
            { id = "microlab_distorted_chunk", x = 0, y = 12 },
            { id = "microlab_distorted_chunk", x = 12, y = 12 },
        },
        item_group_placements = {
            {
                chance = 65,
                group = "microlab_artifacts",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 1, 3 },
            },
        },
        monster_placements = {
            {
                group = "GROUP_DISTORTED_MICROLAB",
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 10, 20 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "microlab_distorted_special_room" } },
    layout = {
        predecessor_mapgen = "microlab_generic_special_room",
        nested = {
            { id = "microlab_distorted_chunk", x = 0, y = 0 },
            { id = "microlab_distorted_chunk", x = 12, y = 0 },
            { id = "microlab_distorted_chunk", x = 0, y = 12 },
            { id = "microlab_distorted_chunk", x = 12, y = 12 },
        },
        item_group_placements = {
            {
                chance = 65,
                group = "microlab_artifacts",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 1, 3 },
            },
        },
        monster_placements = {
            {
                group = "GROUP_DISTORTED_MICROLAB",
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 10, 20 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "microlab_distorted_edge" } },
    layout = {
        predecessor_mapgen = "microlab_generic_edge",
        nested = {
            { id = "microlab_distorted_chunk", x = 0, y = 0 },
            { id = "microlab_distorted_chunk", x = 12, y = 0 },
            { id = "microlab_distorted_chunk", x = 0, y = 12 },
            { id = "microlab_distorted_chunk", x = 12, y = 12 },
            { otherwise = { "concrete_wall_ew" }, x = 0, y = 0, neighbors = { north = "microlab" } },
            { otherwise = { "concrete_wall_ns" }, x = 23, y = 0, neighbors = { east = "microlab" } },
            {
                otherwise = { "concrete_wall_ew" },
                x = 0,
                y = 23,
                neighbors = { south = "microlab" },
            },
            { otherwise = { "concrete_wall_ns" }, x = 0, y = 0, neighbors = { west = "microlab" } },
            {
                otherwise = { "concrete_corner" },
                x = 0,
                y = 0,
                neighbors = { north_west = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 23,
                y = 0,
                neighbors = { north_east = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 23,
                y = 23,
                neighbors = { south_east = "microlab" },
            },
            {
                otherwise = { "concrete_corner" },
                x = 0,
                y = 23,
                neighbors = { south_west = "microlab" },
            },
        },
        item_group_placements = {
            {
                chance = 65,
                group = "microlab_artifacts",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 1, 3 },
            },
        },
        monster_placements = {
            {
                group = "GROUP_DISTORTED_MICROLAB",
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 10, 20 },
            },
        },
    },
}
