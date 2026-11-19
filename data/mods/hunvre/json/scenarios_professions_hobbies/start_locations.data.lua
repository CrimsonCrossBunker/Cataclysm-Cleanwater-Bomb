local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_depths",
    name = ccb.content.text("Depths"),
    targets = { "hab_unit" },
    flags = { "ALLOW_OUTSIDE" },
}
