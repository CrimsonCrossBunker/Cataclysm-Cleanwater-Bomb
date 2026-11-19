local ccb = require("ccb")

-- delete chest rig variants
ccb.content.define_item {
    id = "xl_chestrig",
    copy_from = "chestrig",
    name = ccb.content.text("chest rig"),
    variants = {},
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

-- delete chest rig variants
ccb.content.define_item {
    id = "xs_chestrig",
    copy_from = "chestrig",
    name = ccb.content.text("chest rig"),
    variants = {},
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5 },
    },
}
