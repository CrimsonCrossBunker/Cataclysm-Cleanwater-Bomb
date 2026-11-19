local ccb = require("ccb")

ccb.content.define_item {
    id = "XS_holster",
    copy_from = "holster",
    name = ccb.content.text("holster"),
    flags = { "BELTED", "BELT_CLIP", "UNDERSIZE", "PREFIX_XS", "PALS_MEDIUM" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}

ccb.content.define_item {
    id = "XS_nylon_holster",
    copy_from = "nylon_holster",
    name = ccb.content.text("nylon holster"),
    flags = { "BELTED", "BELT_CLIP", "UNDERSIZE", "PREFIX_XS", "PALS_MEDIUM" },
    armor = {},
    inheritance = { scale = { mass = 0.75, volume = 0.75, price = 0.5 } },
}
