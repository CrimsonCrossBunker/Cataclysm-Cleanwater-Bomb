local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nl_obelisk_earth_broken",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Alien Obelisk"),
    description = ccb.content.text("A dark gray obelisk with a massive crack down the middle."),
    symbol = "A",
    color = "dark_gray",
    examine_handler = "examine_t_nl_obelisk_earth_broken",
}
