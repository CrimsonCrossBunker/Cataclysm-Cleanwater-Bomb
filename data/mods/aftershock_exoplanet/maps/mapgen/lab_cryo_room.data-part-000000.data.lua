local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_cryo_pod_switch",
    name = ccb.content.text("cryo pod switch"),
    color = "brown",
    symbol = "+",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "map_regen",
    map_regen = "cryo_pod_open",
    benign = false,
}
