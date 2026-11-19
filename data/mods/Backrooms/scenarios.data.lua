local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_backrooms",
    name = ccb.content.text("The Backrooms"),
    targets = { "backfloorchamber" },
}
