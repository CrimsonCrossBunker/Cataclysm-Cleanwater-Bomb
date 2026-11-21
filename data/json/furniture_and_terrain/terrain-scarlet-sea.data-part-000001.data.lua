local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nl_obelisk_scarlet",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Obelisk"),
    description = ccb.content.text("A dark gray obelisk.  Despite its solid appearance, the face of it seems to slightly ripple, as if it were sand, loosely suspended in space."),
    symbol = "A",
    color = "dark_gray",
    light_color = { 110, 0, 0 },
    light_emitted = 200,
    examine_handler = "examine_t_nl_obelisk_scarlet",
}
