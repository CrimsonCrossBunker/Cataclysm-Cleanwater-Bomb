local ccb = require("ccb")

ccb.content.define_item {
    id = "feces_cow",
    name = ccb.content.text("cow pie"),
    copy_from = "feces_bird",
    mass = "750 g",
    volume = "250 ml",
    description = ccb.content.text("A fresh cow pie; this could probably be used to make some great fertilizer."),
    comestible = {},
}

ccb.content.define_item {
    id = "feces_dog",
    name = ccb.content.text("dog dung"),
    copy_from = "feces_manure",
    description = ccb.content.text("Droppings from a canine."),
    comestible = {},
}

ccb.content.define_item {
    id = "feces_manure",
    name = ccb.content.plural_text("manure", "manure"),
    copy_from = "feces_bird",
    mass = "250 g",
    volume = "125 ml",
    description = ccb.content.text("Common manure, could probably be used to make some great fertilizer."),
    comestible = {},
}

ccb.content.define_item {
    id = "feces_roach",
    name = ccb.content.plural_text("roach dirt", "roach dirt"),
    copy_from = "feces_bird",
    description = ccb.content.text("Large black pellets of rotting material."),
    comestible = {},
}
