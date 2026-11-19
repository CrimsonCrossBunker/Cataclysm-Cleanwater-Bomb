local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_lizardfolk_hunting_party_add",
    layout = {
        monster_placements = { { group = "GROUP_LIZARDFOLK_RANDENC", x = { 0, 23 }, y = { 0, 23 } } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_RandEnc_lizardfolk_hunting_party_remove",
    layout = {
        flags = { "NO_UNDERLYING_ROTATE" },
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
