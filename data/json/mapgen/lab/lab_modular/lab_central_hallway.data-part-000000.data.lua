local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_lab_security_corridor_a",
    name = ccb.content.text("door"),
    color = "light_gray",
    symbol = "+",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "map_regen",
    map_regen = "lab_security_corridor_a",
    benign = false,
}

ccb.content.define_trap {
    id = "tr_lab_security_corridor_b",
    name = ccb.content.text("door"),
    color = "light_gray",
    symbol = "+",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "map_regen",
    map_regen = "lab_security_corridor_b",
    benign = false,
}
