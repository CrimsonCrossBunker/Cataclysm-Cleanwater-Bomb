local ccb = require("ccb")

ccb.content.define_item {
    id = "feces_bat",
    name = ccb.content.plural_text("guano", "guano"),
    copy_from = "feces_bird",
    mass = "150 g",
    volume = "250 ml",
    description = ccb.content.text("A fresh pile of bat guano; this could probably be used to make some great fertilizer."),
    comestible = {},
}

ccb.content.define_item {
    id = "bezoar",
    name = ccb.content.plural_text("bezoar", "bezoar"),
    copy_from = "feces_manure",
    mass = "150 g",
    volume = "250 ml",
    description = ccb.content.text("A solid, indigestible mass of material—commonly hair, fiber, or calcium and phosphorous—that accumulates in the gastrointestinal tract, usually the stomach of goats."),
    comestible = {},
}
