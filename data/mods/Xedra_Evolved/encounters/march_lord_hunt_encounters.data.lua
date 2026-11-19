local ccb = require("ccb")

-- Adds a random encounter at this field
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_March_Lord_Hunting_Party",
    layout = {
        monster_placements = {
            { group = "GROUP_MARCH_LORDS", x = { 0, 23 }, y = { 0, 23 } },
            { id = "mon_wild_hunt_hound", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 2, 4 } },
            { id = "mon_wild_huntsman", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 1, 2 } },
            {
                id = "mon_changeling_bannerman",
                x = { 0, 23 },
                y = { 0, 23 },
                repetitions = { 3, 6 },
            },
        },
    },
}

-- removes a random encounter at the field
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_March_Lord_Hunting_Party_remove",
    layout = {
        tile_edits = {
            {
                shape = "rectangle",
                operation = "remove_creatures",
                x = 0,
                y = 0,
                end_x = 23,
                end_y = 23,
            },
        },
    },
}
