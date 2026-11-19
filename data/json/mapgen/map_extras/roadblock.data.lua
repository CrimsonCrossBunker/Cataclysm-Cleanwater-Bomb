local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_roadblock",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            {
                choices = { "24x24_roadblock_turret", "24x24_roadblock_cops", "24x24_roadblock_crash" },
                x = 0,
                y = 0,
            },
        },
    },
}
