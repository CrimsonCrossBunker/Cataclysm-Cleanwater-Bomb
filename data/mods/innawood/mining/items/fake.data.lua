local ccb = require("ccb")

ccb.content.define_item {
    id = "bloomery",
    copy_from = "fake_item",
    name = ccb.content.plural_text("bloomery", "bloomeries"),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { charcoal = 2000 } } },
    tool = { ammo_types = { "charcoal" } },
}
