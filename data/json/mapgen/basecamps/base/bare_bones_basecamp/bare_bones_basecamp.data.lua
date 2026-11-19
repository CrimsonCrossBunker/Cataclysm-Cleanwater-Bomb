local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbbb",
    layout = {
        palettes = { "fbbb_palette" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}
