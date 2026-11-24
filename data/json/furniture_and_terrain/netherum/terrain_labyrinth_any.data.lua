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

ccb.content.define_terrain {
    id = "t_nl_chasm",
    name = ccb.content.text("sparkling chasm"),
    description = ccb.content.text("At a glance this just looks like darkness.  Then, gazing deeper, you think it might be full of stars.  Still deeper, perhaps those stars are eyes?"),
    symbol = "*",
    color = "dark_gray",
    move_cost = -1,
    coverage = 0,
    trap = "tr_nl_chasm",
    flags = { "TRANSPARENT", "EMPTY_SPACE", "DESTROY_ITEM", "NOCOLLIDE", "MON_AVOID_STRICT" },
    examine_handler = "examine_labyrinth_chasm",
}

ccb.content.define_terrain {
    id = "t_nl_chasm_no_trap",
    name = ccb.content.text("sparkling chasm"),
    description = ccb.content.text("At a glance this just looks like darkness.  Then, gazing deeper, you think it might be full of stars.  Still deeper, perhaps those stars are eyes?"),
    symbol = "*",
    color = "dark_gray",
    move_cost = -1,
    coverage = 0,
    flags = { "TRANSPARENT", "EMPTY_SPACE", "DESTROY_ITEM", "NOCOLLIDE", "MON_AVOID_STRICT" },
    examine_handler = "examine_labyrinth_chasm",
}
