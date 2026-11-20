local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_telepad",
    trigger_weight = "200 g",
    name = ccb.content.text("teleport pad"),
    color = "magenta",
    memorial_male = ccb.content.text("Triggered a teleport trap.", "memorial_male"),
    memorial_female = ccb.content.text("Triggered a teleport trap.", "memorial_female"),
    symbol = "_",
    visibility = 0,
    avoidance = 15,
    difficulty = 20,
    action = "none",
    drops = { "telepad" },
    flags = { "CONSUME_ON_TRIGGER" },
    trigger_handler = "random_telepad",
}
