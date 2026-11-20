local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_magic_door",
    name = ccb.content.text("magic door"),
    color = "brown",
    symbol = "+",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    action = "map_regen",
    map_regen = "magic_door_appear",
    benign = false,
}
