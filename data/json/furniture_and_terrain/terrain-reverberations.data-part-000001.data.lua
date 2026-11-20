local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_inner_cabins_exit_portal",
    name = ccb.content.text("unstable portal"),
    description = ccb.content.text("A swirling tear in reality.  Beyond it, you see a field of ever-expanding buildings.  Something else is moving inside, beyond your ability to resolve."),
    symbol = "O",
    color = "magenta",
    trap = "tr_inner_cabins_exit_portal",
    flags = { "TRANSPARENT" },
    move_cost = 3,
    examine_handler = "examine_inner_cabins_portal",
}
