local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_calorie_pill",
    name = ccb.content.text("nutriment"),
    mass = "10 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A crumbly white biscuit half the size of your thumb, packed with vitamins and calories.  Provides a whole meal's nutrition in portable form, but it's a little hard to keep down, thanks to the rancid taste and chalky texture."),
    price = "20 USD",
    volume = "1 ml",
    looks_like = "vitamins",
    comestible = {
        kind = "FOOD",
        calories = 400,
        healthy = 3,
        quench = -5,
        fun = -8,
        freezing_point = -9999,
        vitamins = {
            { id = "calcium", amount = 36 },
            { id = "iron", amount = 36 },
            { id = "vitC", amount = 36 },
            { id = "bad_food", amount = 10 },
        },
    },
}

ccb.content.define_item {
    id = "afs_calorie_water",
    name = ccb.content.plural_text("nutriment water", "nutriment water"),
    copy_from = "water_clean",
    color = "white",
    description = ccb.content.text("Nutriment that has been dissolved in water to dilute its taste.  Unnervingly resembles spoiled milk."),
    price = "100 USD",
    looks_like = "bleach",
    comestible = {
        kind = "DRINK",
        calories = 400,
        healthy = 3,
        fun = -2,
        vitamins = {
            { id = "calcium", amount = 36 },
            { id = "iron", amount = 36 },
            { id = "vitC", amount = 36 },
            { id = "bad_food", amount = 10 },
        },
    },
}
