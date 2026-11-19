local ccb = require("ccb")

ccb.content.define_item {
    id = "xl_survivor_vest",
    copy_from = "survivor_vest",
    name = ccb.content.plural_text("handmade harness", "handmade harnesses"),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_survivor_vest",
    copy_from = "survivor_vest",
    name = ccb.content.plural_text("handmade harness", "handmade harnesses"),
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
