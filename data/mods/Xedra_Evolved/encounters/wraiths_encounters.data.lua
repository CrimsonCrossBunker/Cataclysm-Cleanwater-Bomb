local ccb = require("ccb")

-- Adds a random encounter at this field
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_XE_Wraiths_On_Dark_Nights",
    layout = {
        monster_placements = { { id = "mon_darkman", x = { 6, 14 }, y = { 6, 14 }, repetitions = { 2, 3 } } },
    },
}

-- removes a random encounter at the field
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_XE_Wraiths_On_Dark_Nights_remove",
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
