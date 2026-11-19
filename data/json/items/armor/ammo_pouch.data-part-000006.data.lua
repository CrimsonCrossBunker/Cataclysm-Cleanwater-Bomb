local ccb = require("ccb")

ccb.content.define_item {
    id = "xl_tacvest",
    copy_from = "tacvest",
    name = ccb.content.text("tac vest"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_tacvest",
    copy_from = "tacvest",
    name = ccb.content.text("tac vest"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
