local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_grave",
    layout = {
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = {
                    { id = "human_corpse", weight = 95 },
                    { id = "pet_corpse", weight = 95 },
                    { id = "grave_easter_egg", weight = 5 },
                },
                x = { 0, 22 },
                y = { 0, 22 },
            },
        },
    },
}
