local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "microlab_distorted_hallway_end",
    layout = {
        fill_terrain = "t_strconc_floor",
        nested = {
            { id = "microlab_generic_end_tile", x = 0, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 0, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 12, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 0, y = 12 },
            { id = "microlab_distorted_hallway_chunk", x = 12, y = 12 },
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
        monster_placements = {
            {
                group = "GROUP_DISTORTED_MICROLAB",
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 2, 5 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "microlab_distorted_hallway_straight",
    layout = {
        fill_terrain = "t_strconc_floor",
        nested = {
            { id = "microlab_generic_hallway_straight_tile", x = 0, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 0, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 12, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 0, y = 12 },
            { id = "microlab_distorted_hallway_chunk", x = 12, y = 12 },
            { choices = { "hallway_shrapnel", "null" }, x = 6, y = 6 },
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
        monster_placements = {
            {
                group = "GROUP_DISTORTED_MICROLAB",
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 2, 5 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "microlab_distorted_hallway_curved",
    layout = {
        fill_terrain = "t_strconc_floor",
        nested = {
            { id = "microlab_generic_hallway_curved_tile", x = 0, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 0, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 12, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 0, y = 12 },
            { id = "microlab_distorted_hallway_chunk", x = 12, y = 12 },
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
        monster_placements = {
            {
                group = "GROUP_DISTORTED_MICROLAB",
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 2, 5 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "microlab_distorted_hallway_tee",
    layout = {
        fill_terrain = "t_strconc_floor",
        nested = {
            { id = "microlab_generic_hallway_tee_tile", x = 0, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 0, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 12, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 0, y = 12 },
            { id = "microlab_distorted_hallway_chunk", x = 12, y = 12 },
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
        monster_placements = {
            {
                group = "GROUP_DISTORTED_MICROLAB",
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 2, 5 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "microlab_distorted_hallway_four_way",
    layout = {
        fill_terrain = "t_strconc_floor",
        nested = {
            { id = "microlab_generic_hallway_four_way_tile", x = 0, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 0, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 12, y = 0 },
            { id = "microlab_distorted_hallway_chunk", x = 0, y = 12 },
            { id = "microlab_distorted_hallway_chunk", x = 12, y = 12 },
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
        monster_placements = {
            {
                group = "GROUP_DISTORTED_MICROLAB",
                chance = 80,
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 2, 5 },
            },
        },
    },
}
