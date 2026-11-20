local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_mom_find_dead_fifth_sun_ocelopilli_trooper",
    name = ccb.content.text("Dead Fifth Sun Achievement Trap"),
    color = "dark_gray",
    symbol = "/",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    always_invisible = true,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    action = "none",
    avatar_message = "",
    trigger_handler = "find_ocelopilli_trooper",
}
