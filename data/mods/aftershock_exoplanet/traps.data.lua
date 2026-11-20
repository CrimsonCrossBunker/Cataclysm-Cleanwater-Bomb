local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_escape_pod",
    name = ccb.content.text("escape pod launch button"),
    color = "red",
    symbol = "#",
    visibility = -1,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    action = "none",
    flags = { "UNCONSUMED", "UNDODGEABLE", "CONSUME_ON_TRIGGER" },
    trigger_handler = "launch_escape_pod_from_seat",
}
