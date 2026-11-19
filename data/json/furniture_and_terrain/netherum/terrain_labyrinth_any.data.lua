local ccb = require("ccb")

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
