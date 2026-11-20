local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_glimmer_floor",
    name = ccb.content.text("glimmering floor"),
    color = "yellow",
    symbol = "#",
    visibility = 99,
    avoidance = 4,
    difficulty = 99,
    trap_radius = 4,
    action = "none",
    always_invisible = true,
    benign = false,
    flags = { "CONSUME_ON_TRIGGER" },
    trigger_handler = "random_telepad",
}
