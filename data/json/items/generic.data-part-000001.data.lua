local ccb = require("ccb")

ccb.content.define_item {
    id = "mutant_bug_hydrogen_sacs",
    symbol = "o",
    color = "light_gray",
    name = ccb.content.plural_text("cluster of gas sacs", "clusters of gas sacs"),
    description = ccb.content.text("A cluster of membranous bubbles, each about the size of a grape, retrieved from inside a mutant insect.  They float like tiny helium balloons - perhaps they are full of a lighter-than-air gas."),
    price = "0 cent",
    materials = { "flesh" },
    flags = { "NO_SALVAGE" },
    mass = "50 g",
    volume = "250 ml",
    comestible = {
        kind = "FOOD",
        shelf_life = "8 hours",
        fun = -25,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
}
