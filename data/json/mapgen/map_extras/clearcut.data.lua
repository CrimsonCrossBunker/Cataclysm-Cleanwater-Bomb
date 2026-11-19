local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_clearcut",
    layout = {
        transform_glyphs = { [" "] = { id = "clearcut" } },
    },
}
