local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_void_spider_entry",
    name = "",
    color = "green",
    symbol = "#",
    visibility = 99,
    always_invisible = true,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 0,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    action = "none",
    trigger_handler = "enter_void_spider_lair",
}
