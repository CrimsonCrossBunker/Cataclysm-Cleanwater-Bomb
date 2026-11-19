local ccb = require("ccb")

ccb.content.define_item {
    id = "acorn_roasted",
    name = ccb.content.plural_text("Handful of roasted acorns", "of roasted acorns"),
    display_type = "BY_WEIGHT",
    copy_from = "acorns",
    mass = "22 g",
    volume = "46 ml",
    description = ccb.content.text("A handful of roasted nuts from an oak tree."),
    price = "22 cent",
    survival_price = "50 cent",
    flags = { "EATEN_HOT", "EDIBLE_FROZEN" },
    comestible = { shelf_life = "30 days", fun = 1 },
}
