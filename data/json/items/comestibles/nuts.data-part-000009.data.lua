local ccb = require("ccb")

ccb.content.define_item {
    id = "hazelnut_roasted",
    name = ccb.content.plural_text("Handful of roasted hazelnuts", "of roasted hazelnuts"),
    display_type = "BY_WEIGHT",
    copy_from = "hazelnut_shelled",
    description = ccb.content.text("A handful of roasted nuts from a hazelnut tree."),
    price = "90 cent",
    flags = { "EATEN_HOT", "EDIBLE_FROZEN" },
    subtype_order = { "milling", "comestible" },
    milling = { result = "null", recipe = "" },
    comestible = { fun = 1 },
}
