local ccb = require("ccb")

ccb.content.define_item {
    id = "feces_dino",
    name = ccb.content.plural_text("droppings", "droppings"),
    copy_from = "feces_bird",
    mass = "750 g",
    volume = "250 ml",
    description = ccb.content.text("Dinosaur fecal matter; this could probably be used to make some great fertilizer."),
    comestible = {},
}
