local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_waycircle",
    name = ccb.content.text("waycircle"),
    move_cost_mod = 100,
    symbol = "X",
    description = ccb.content.text("A ritualistic, circular glyph painted onto a sizable boulder and surrounded with primitive decor, with the intent of channeling the natural of ley lines into a functional landing spot for teleportation.  Theoretically, it could receive any manner of targeted teleport, be it magical, ritualistic, or technological.  Examine to link."),
    color = "light_gray",
    required_strength = -1,
    flags = { "TRANSLOCATOR", "MOUNTABLE", "TRANSPARENT" },
    builtin_examine = "translocator",
}
