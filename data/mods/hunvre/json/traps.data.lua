local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_contraband_scanner",
    name = ccb.content.text("contraband scanner"),
    color = "brown",
    flags = { "UNCONSUMED", "UNDODGEABLE" },
    symbol = "0",
    visibility = -1,
    avoidance = -1,
    difficulty = 99,
    always_invisible = true,
    action = "none",
    trigger_handler = "hunvre_contraband_scanner_trigger",
}
