local ccb = require("ccb")

ccb.content.define_item {
    id = "amphora_plums",
    name = ccb.content.text("plum"),
    mass = "66 g",
    color = "magenta",
    symbol = "%",
    description = ccb.content.text("A large bright red amphora plum.  These plums ferment while still on the branch.  Each fruit is roughly similar in alcohol to a glass of wine.  Cannot be dried."),
    survival_price = "19 cent",
    materials = { "fruit" },
    volume = "82 ml",
    comestible = {
        shelf_life = "3 days 12 hours",
        kind = "FOOD",
        quench = 2,
        calories = 60,
        fun = 3,
        vitamins = {
            { id = "vitC", amount = "630 μg" },
            { id = "iron", amount = "10 μg" },
            { id = "calcium", amount = "1 mg" },
            { id = "fruit_allergen", amount = 1 },
            { id = "ethanol", amount = 7 },
        },
    },
}

ccb.content.define_item {
    id = "oxblood_apple",
    name = ccb.content.text("oxblood apple"),
    mass = "182 g",
    color = "cyan",
    symbol = "%",
    description = ccb.content.text("A bruised blue skin covers this fruit with a blood red meat.  The uncooked fruit is too bitter for humans to eat and must be cooked into a stew or paste.  Cannot be dried."),
    price = "40 cent",
    survival_price = "40 cent",
    materials = { "fruit" },
    volume = "232 ml",
    flags = { "INEDIBLE", "RAT", "BIRD", "MOUSE" },
    comestible = {
        shelf_life = "2 days 16 hours",
        kind = "FOOD",
        quench = 3,
        calories = 165,
        fun = -3,
        vitamins = {
            { id = "vitC", amount = "840 μg" },
            { id = "iron", amount = "800 μg" },
            { id = "calcium", amount = "1090 μg" },
            { id = "fruit_allergen", amount = 1 },
        },
    },
}
