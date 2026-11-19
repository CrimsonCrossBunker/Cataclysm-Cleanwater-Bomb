local ccb = require("ccb")

ccb.content.define_item {
    id = "barley_stalks",
    name = ccb.content.plural_text("barley stalks", "sheaves of barley stalks"),
    copy_from = "wheat_stalks",
    description = ccb.content.text("A sheaf of freshly-cut barley, now ready for drying in a stook or smoker."),
    comestible = { calories = 775, smoking_result = "dry_barley_stalks" },
}

ccb.content.define_item {
    id = "dry_barley_stalks",
    name = ccb.content.plural_text("dried barley stalks", "sheaves of dried barley stalks"),
    copy_from = "dry_wheat_stalks",
    description = ccb.content.text("A sheaf of dried barley stalks.  These will require threshing before anything can be done with them."),
    comestible = { calories = 775 },
}

ccb.content.define_item {
    id = "threshed_barley",
    name = ccb.content.plural_text("threshed barley", "handfuls of threshed barley"),
    copy_from = "threshed_wheat",
    description = ccb.content.text("Barley with the chaff still mixed in.  It will have to be winnowed before it's usable."),
    comestible = { calories = 745 },
}
