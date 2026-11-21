local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nl_obelisk_earth",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Alien Obelisk"),
    description = ccb.content.text("A dark gray obelisk.  Despite its solid appearance, the face of it seems to slightly ripple, as if it were sand, loosely suspended in space.  The depths of the ripples scream with an eerie, green fluorescence."),
    symbol = "A",
    color = "dark_gray",
    light_color = { 220, 255, 200 },
    light_emitted = 200,
    examine_handler = "examine_t_nl_obelisk_earth",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_earth_broken",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Alien Obelisk"),
    description = ccb.content.text("A dark gray obelisk with a massive crack down the middle."),
    symbol = "A",
    color = "dark_gray",
    examine_handler = "examine_t_nl_obelisk_earth_broken",
}
