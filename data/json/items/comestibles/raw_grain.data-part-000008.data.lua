local ccb = require("ccb")

ccb.content.define_item {
    id = "oat_stalks",
    name = ccb.content.plural_text("oat stalks", "sheaves of oat stalks"),
    copy_from = "wheat_stalks",
    description = ccb.content.text("A sheaf of freshly-cut oats, now ready for drying in a stook or smoker."),
    price = "12 cent",
    survival_price = "10 cent",
    comestible = { calories = 524, smoking_result = "dry_oat_stalks" },
}

ccb.content.define_item {
    id = "dry_oat_stalks",
    name = ccb.content.plural_text("dried oat stalks", "sheaves of dried oat stalks"),
    copy_from = "dry_wheat_stalks",
    description = ccb.content.text("A sheaf of dried oat stalks.  These will require threshing before anything can be done with them."),
    price = "12 cent",
    survival_price = "10 cent",
    comestible = { quench = -5, calories = 355 },
}

ccb.content.define_item {
    id = "threshed_oats",
    name = ccb.content.plural_text("threshed oats", "handfuls of threshed oats"),
    copy_from = "threshed_wheat",
    description = ccb.content.text("Oats with the chaff still mixed in.  They will have to be winnowed before they're usable."),
    price = "12 cent",
    survival_price = "10 cent",
    comestible = { quench = -5, calories = 524 },
}
