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

ccb.content.define_terrain {
    id = "t_inner_cabins_door_o",
    name = ccb.content.text("strange open door"),
    description = ccb.content.text("A wide open door swinging outward, into the darkness, beyond your reach.  The door and the frame look fresh, as if installed recently."),
    symbol = "'",
    color = "brown",
    looks_like = "t_door_o",
    move_cost = 2,
    roof = "t_wood_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "FLAT", "ROAD", "SUPPORTS_ROOF" },
}

ccb.content.define_terrain {
    id = "t_inner_cabins_nether_glass_floor",
    name = ccb.content.text("black glass"),
    description = ccb.content.text("An endless expanse of black glass, illuminated by dim, otherworldly light."),
    symbol = " ",
    color = "black",
    move_cost = 2,
    light_emitted = 5,
    light_color = { 150, 75, 0 },
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
}
