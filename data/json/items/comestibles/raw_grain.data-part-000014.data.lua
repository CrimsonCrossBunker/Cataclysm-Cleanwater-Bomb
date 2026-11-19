local ccb = require("ccb")

ccb.content.define_item {
    id = "dry_lentil_stalks",
    name = ccb.content.plural_text("dried lentil stalks", "sheaves of dried lentil stalks"),
    copy_from = "dry_wheat_stalks",
    mass = "149 g",
    description = ccb.content.text("A pile of short stalks with lentils rattling in their pods.  These plants dried in the field and didn't need a tool to harvest, but they'll still need to be threshed and winnowed."),
    price = "12 cent",
    survival_price = "10 cent",
    volume = "315 ml",
    comestible = { quench = -5, calories = 247 },
}

ccb.content.define_item {
    id = "threshed_lentils",
    name = ccb.content.plural_text("threshed lentils", "handfuls of threshed lentils"),
    copy_from = "threshed_wheat",
    mass = "134 g",
    description = ccb.content.text("Lentils with chaff mixed in.  These will have to be winnowed before they're usable."),
    price = "12 cent",
    survival_price = "10 cent",
    volume = "252 ml",
    comestible = { quench = -5, calories = 235 },
}
