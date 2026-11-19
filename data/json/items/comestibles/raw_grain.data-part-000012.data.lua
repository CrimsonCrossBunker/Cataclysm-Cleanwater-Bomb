local ccb = require("ccb")

ccb.content.define_item {
    id = "canola_stalks",
    name = ccb.content.plural_text("canola stalks", "sheaves of canola stalks"),
    copy_from = "wheat_stalks",
    mass = "171 g",
    description = ccb.content.text("A sheaf of tall grass with slender little seed pods, now ready for drying."),
    price = "12 cent",
    survival_price = "10 cent",
    volume = "315 ml",
    comestible = { quench = -5, calories = 247, smoking_result = "dry_canola_stalks" },
}

ccb.content.define_item {
    id = "dry_canola_stalks",
    name = ccb.content.plural_text("dried canola stalks", "sheaves of dried canola stalks"),
    copy_from = "dry_wheat_stalks",
    mass = "149 g",
    description = ccb.content.text("A sheaf of dry grass, it must be threshed to separate out the seeds."),
    price = "12 cent",
    survival_price = "10 cent",
    volume = "315 ml",
    comestible = { quench = -5, calories = 247 },
}

ccb.content.define_item {
    id = "threshed_canola",
    name = ccb.content.plural_text("threshed canola", "handfuls of threshed canola"),
    copy_from = "threshed_wheat",
    mass = "134 g",
    description = ccb.content.text("Round black seeds mixed in with dry chaff."),
    price = "12 cent",
    survival_price = "10 cent",
    volume = "252 ml",
    comestible = { quench = -5, calories = 235 },
}
