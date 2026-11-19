local ccb = require("ccb")

ccb.content.define_item {
    id = "dreamforged_nail",
    copy_from = "nail",
    name = ccb.content.text("dreamforged nail"),
    description = ccb.content.text("A pin-shaped piece of steel.  It can be used to construct various things with a hammer.  Forged from dreamdross, which makes it much lighter.  They do curse and scream at you in an eldritch tongue while you hammer them in and sometimes refuse to be used in specific purposes."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "forged_dreamstuff" },
    symbol = "=",
    color = "light_gray",
    inheritance = { scale = { mass = 0.25, melee_damage = { bash = 0.25 } } },
    ammunition = {},
}
