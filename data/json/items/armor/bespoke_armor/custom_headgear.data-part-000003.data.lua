local ccb = require("ccb")

ccb.content.define_item {
    id = "xl_helmet_scavenger",
    copy_from = "helmet_scavenger",
    name = ccb.content.text("scavenger cowl"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "helmet_scavenger_xs",
    copy_from = "helmet_scavenger",
    name = ccb.content.text("scavenger cowl"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
