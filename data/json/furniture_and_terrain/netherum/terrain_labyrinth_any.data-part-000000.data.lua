local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nl_mist",
    name = ccb.content.text("swirling mist"),
    description = ccb.content.text("A swirling, exotic pattern of shapes, floating in an ill-defined darkness.  Staring at it too long hurts your brain."),
    looks_like = "fd_smoke",
    symbol = "|",
    color = "green",
    coverage = 100,
    move_cost = -1,
    flags = {
        "NOITEM",
        "SUPPORTS_ROOF",
        "WALL",
        "NO_SCENT",
        "AUTO_WALL_SYMBOL",
        "BLOCK_WIND",
        "MON_AVOID_STRICT",
    },
}
