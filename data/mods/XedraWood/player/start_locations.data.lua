local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_wise_one_hut",
    name = ccb.content.text("Remote dwelling"),
    targets = { "xedrawood_scenario_wise_one_hut" },
    flags = { "ALLOW_OUTSIDE" },
}
