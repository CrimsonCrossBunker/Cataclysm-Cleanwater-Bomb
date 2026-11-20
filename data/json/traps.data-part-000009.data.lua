local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_swirling_vortex",
    name = ccb.content.text("swirling vortex"),
    color = "green",
    symbol = "#",
    visibility = -1,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    action = "none",
    trigger_handler = "swirling_vortex",
}
