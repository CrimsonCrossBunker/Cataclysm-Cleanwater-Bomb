local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_inner_cabins_void",
    name = ccb.content.text("fluid void"),
    color = "black",
    memorial_male = ccb.content.text("Lost to a pool of darkness.", "memorial_male"),
    memorial_female = ccb.content.text("Lost to a pool of darkness.", "memorial_female"),
    symbol = "~",
    visibility = 1000,
    avoidance = 99,
    difficulty = 99,
    vehicle = { damage = 5000 },
    flags = { "UNDODGEABLE", "CONSUME_ON_TRIGGER" },
    action = "none",
    always_invisible = true,
    trigger_handler = "inner_cabins_void_trap",
}
