local ccb = require("ccb")

-- A 12-charge gallon currently goes for around US$4.
ccb.content.define_item {
    id = "milk",
    name = ccb.content.plural_text("milk", "milk"),
    mass = "258 g",
    color = "white",
    symbol = "~",
    description = ccb.content.text("Baby cow food, appropriated for human consumption.  Spoils rapidly."),
    display_type = "BY_VOLUME",
    price = "38 cent",
    survival_price = "50 cent",
    materials = { "milk" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "EATEN_COLD" },
    comestible = {
        shelf_life = "1 d",
        kind = "DRINK",
        quench = 70,
        calories = 132,
        servings = 1,
        vitamins = {
            { id = "vitC", amount = 4 },
            { id = "calcium", amount = 25 },
            { id = "milk_allergen", amount = 1 },
        },
        fun = 1,
    },
}

ccb.content.define_item {
    id = "milk_choc",
    name = ccb.content.plural_text("chocolate milk", "chocolate milk"),
    copy_from = "milk",
    color = "brown",
    description = ccb.content.text("Baby cow food, with chocolate added for human enjoyment.  Spoils rapidly."),
    comestible = { calories = 272, fun = 6 },
}

ccb.content.define_item {
    id = "milk_reconstituted",
    name = ccb.content.plural_text("reconstituted milk", "reconstituted milk"),
    copy_from = "milk",
    description = ccb.content.text("Baby cow food, appropriated for adult humans.  This milk has been reconstituted from powder.  Spoils rapidly."),
    comestible = {},
}
