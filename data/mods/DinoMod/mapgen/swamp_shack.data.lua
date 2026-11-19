local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "cattail",
    layout = {
        rows = {
            "i",
        },
        furniture = { i = "f_cattails" },
        size = { width = 1, height = 1 },
    },
}
