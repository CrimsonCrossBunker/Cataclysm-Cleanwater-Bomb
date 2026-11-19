local ccb = require("ccb")

ccb.content.define_item {
    id = "wash_dragonfire",
    copy_from = "wash_vodka",
    name = ccb.content.plural_text("dragonfire wash", "dragonfire wash"),
    description = ccb.content.text("Fermented, but not distilled dragonfire.  Basically undrinkable until properly distilled."),
    comestible = { fun = -8 },
}

ccb.content.define_item {
    id = "wash_goldbrew",
    copy_from = "wash_whiskey",
    name = ccb.content.plural_text("goldbrew wash", "goldbrew wash"),
    description = ccb.content.text("Fermented, but not distilled goldbrew.  Even unrefined, this is a nice, aromatic drink."),
    comestible = { fun = 4 },
}
