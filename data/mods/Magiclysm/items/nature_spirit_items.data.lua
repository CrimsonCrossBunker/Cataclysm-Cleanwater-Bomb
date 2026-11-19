local ccb = require("ccb")

ccb.content.define_item {
    id = "mossling_fur",
    copy_from = "grass",
    name = ccb.content.plural_text("tuft of mossling fur", "tufts of mossling fur"),
    description = ccb.content.text("A tangled tuft of mossling fur, more like grass or lichen than the fur of an animal.  A cow might be able to eat it, but you couldn't."),
    mass = "100 g",
    volume = "250 ml",
    flags = { "TRADER_AVOID", "INEDIBLE" },
    comestible = { calories = 70 },
}
