local ccb = require("ccb")

-- OBSOLETION NOTE: when this file is deleted, C++ faction camp code from #55026 that generates pipelines can also be deleted.
-- Hard coded name for a map that's used to implement the salt water pipe functionality
-- required to construct a salt water pipe from a swamp to an expansion. These
-- blueprints can be used for any expansion, while the recipes have to be tailored
-- to their specific expansions.
ccb.content.define_mapgen {
    kind = "update",
    id = "faction_expansion_salt_water_pipe_swamp_N",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirt",
                x = 12,
                end_x = 12,
                y = 0,
                end_y = 2,
            },
            {
                shape = "line",
                operation = "furniture",
                id = "f_clear",
                x = 12,
                end_x = 12,
                y = 0,
                end_y = 2,
            },
            {
                shape = "point",
                operation = "terrain",
                id = "t_covered_salt_water_well",
                x = 12,
                y = 3,
            },
            { shape = "point", operation = "furniture", id = "f_clear", x = 12, y = 3 },
        },
    },
}

-- The corresponding blueprint for the 4 diagonal orientations.
ccb.content.define_mapgen {
    kind = "update",
    id = "faction_expansion_salt_water_pipe_swamp_NE",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_dirt", x = 23, y = 0 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 23, y = 0 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 22, y = 1 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 22, y = 1 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 21, y = 2 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 21, y = 2 },
            {
                shape = "point",
                operation = "terrain",
                id = "t_covered_salt_water_well",
                x = 20,
                y = 3,
            },
            { shape = "point", operation = "furniture", id = "f_clear", x = 20, y = 3 },
        },
    },
}

-- Hard coded name for the salt water line expansion functionality. This blueprint
-- is rotated and/or mirrored by code to fit any of the 4 cardinal directions. It
-- is used to actually change the terrain after pretending to have dug pits, put
-- a pipe down into them, and then filled up the pits again.
ccb.content.define_mapgen {
    kind = "update",
    id = "faction_expansion_salt_water_pipe_N",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_dirt",
                x = 12,
                end_x = 12,
                y = 0,
                end_y = 11,
            },
            {
                shape = "line",
                operation = "furniture",
                id = "f_clear",
                x = 12,
                end_x = 12,
                y = 0,
                end_y = 11,
            },
        },
    },
}

-- The corresponding blueprint for the 4 diagonal orientations.
ccb.content.define_mapgen {
    kind = "update",
    id = "faction_expansion_salt_water_pipe_NE",
    layout = {
        tile_edits = {
            { shape = "point", operation = "terrain", id = "t_dirt", x = 23, y = 0 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 23, y = 0 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 22, y = 1 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 22, y = 1 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 21, y = 2 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 21, y = 2 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 20, y = 3 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 20, y = 3 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 19, y = 4 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 19, y = 4 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 18, y = 5 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 18, y = 5 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 17, y = 6 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 17, y = 6 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 16, y = 7 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 16, y = 7 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 15, y = 8 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 15, y = 8 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 14, y = 9 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 14, y = 9 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 13, y = 10 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 13, y = 10 },
            { shape = "point", operation = "terrain", id = "t_dirt", x = 12, y = 11 },
            { shape = "point", operation = "furniture", id = "f_clear", x = 12, y = 11 },
        },
    },
}
