local ccb = require("ccb")

ccb.content.define_item {
    id = "wild_rice_stalks",
    name = ccb.content.plural_text("wild rice stalks", "sheaves of wild rice stalks"),
    copy_from = "buckwheat_stalks",
    description = ccb.content.text("A sheaf of wild rice stalks, ready for drying."),
    price = "12 cent",
    survival_price = "10 cent",
    comestible = { quench = -5, calories = 135, smoking_result = "dry_wild_rice_stalks" },
}

ccb.content.define_item {
    id = "dry_wild_rice_stalks",
    name = ccb.content.plural_text("dried wild rice stalks", "sheaves of dried wild rice stalks"),
    copy_from = "dry_buckwheat_stalks",
    description = ccb.content.text("A bunch of dry wild rice stalks.  Threshing these would knock the grains loose."),
    price = "12 cent",
    survival_price = "10 cent",
    comestible = { quench = -5, calories = 135 },
}
