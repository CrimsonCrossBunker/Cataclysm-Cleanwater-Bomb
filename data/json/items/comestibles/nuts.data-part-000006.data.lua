local ccb = require("ccb")

ccb.content.define_item {
    id = "butternut_roasted",
    name = ccb.content.plural_text("Handful of roasted butternuts", "of roasted butternuts"),
    display_type = "BY_WEIGHT",
    copy_from = "butternut_shelled",
    description = ccb.content.text("A handful of roasted nuts from a butternut tree."),
    price = "90 cent",
    flags = { "EATEN_HOT", "EDIBLE_FROZEN" },
    comestible = { fun = 1 },
}
