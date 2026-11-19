local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_inner_cabins_void",
    name = ccb.content.text("sprawling plane of black"),
    description = ccb.content.text("There's an otherworldly surface here, black as the depths of the earth."),
    symbol = " ",
    color = "black",
    flags = { "FLAT" },
}

ccb.content.define_terrain {
    id = "t_inner_cabins_void_trans",
    name = ccb.content.text("fluid void"),
    description = ccb.content.text("At first glance this looks like a pool of dark water, slowly undulating in an unnaturally slow fashion.  The air around it is frigid cold, stale, and softens ambient light.  It does not look safe to walk through, but you could try."),
    symbol = "~",
    color = "black",
    trap = "tr_inner_cabins_void",
    flags = { "TRANSPARENT", "DESTROY_ITEM" },
    move_cost = 600,
}

ccb.content.define_terrain {
    id = "t_inner_cabins_void_trans_retracting",
    name = ccb.content.text("fluid void"),
    description = ccb.content.text("At first glance this looks like a pool of dark water, slowly undulating in an unnaturally slow fashion.  The air around it is frigid cold, stale, softens ambient light.  This patch seems to be slowly retracting toward the center of the pool.  The grass growing at its edges wobbles as if there is a breeze, constantly bending toward the blackness.  It does not look safe to walk through, but you could try."),
    symbol = "~",
    color = "light_gray",
    trap = "tr_inner_cabins_void",
    flags = { "TRANSPARENT", "DESTROY_ITEM" },
    move_cost = 600,
}
