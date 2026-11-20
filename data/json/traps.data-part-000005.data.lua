local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_portal",
    name = ccb.content.text("shimmering portal"),
    color = "magenta",
    memorial_male = ccb.content.text("Triggered a teleport trap.", "memorial_male"),
    memorial_female = ccb.content.text("Triggered a teleport trap.", "memorial_female"),
    symbol = "%",
    visibility = 0,
    avoidance = 99,
    difficulty = 99,
    action = "none",
    flags = { "CONSUME_ON_TRIGGER" },
    trigger_handler = "random_telepad",
}
