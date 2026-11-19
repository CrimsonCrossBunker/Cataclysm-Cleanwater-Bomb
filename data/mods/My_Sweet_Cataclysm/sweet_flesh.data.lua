local ccb = require("ccb")

ccb.content.define_item {
    id = "cow_candy_flesh",
    name = ccb.content.plural_text("chunk of chocolate meat", "chunks of chocolate meat"),
    mass = "158 g",
    looks_like = "cow_candy",
    color = "red",
    symbol = "%",
    description = ccb.content.text("A chunk of chocolate meat, still dripping with liquid chocolate."),
    survival_price = "4 USD",
    materials = { "junk" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "360 days",
        kind = "FOOD",
        calories = 287,
        vitamins = { { id = "iron", amount = 9 }, { id = "junk_allergen", amount = 1 } },
        fun = 3,
    },
}

ccb.content.define_item {
    id = "licorice_flesh",
    name = ccb.content.plural_text("fillet of licorice snake", "fillets of licorice snake"),
    symbol = "%",
    volume = "250 ml",
    looks_like = "licorice",
    mass = "488 g",
    color = "red",
    materials = { "junk" },
    description = ccb.content.text("A sweet licorice snake fillet, you can see the strands of licorice intertwining in a swirl of sweetness."),
    price = "3 USD 40 cent",
    flags = { "EDIBLE_FROZEN" },
    comestible = {
        shelf_life = "230 days",
        kind = "FOOD",
        quench = -1,
        calories = 270,
        stimulation = 1,
        fun = 7,
        vitamins = { { id = "junk_allergen", amount = 1 } },
    },
}

-- will be used for chocolate-branched additions later on. currently only from cows, will be added from additional chocolate monsters.
ccb.content.define_item {
    id = "blood_chocolate",
    name = ccb.content.plural_text("chocolate ichor", "chocolate ichor"),
    symbol = "~",
    color = "brown",
    description = ccb.content.text("Ichor harvested from the corpse of a chocolate cow.  Quite bitter and… oddly warm?"),
    price = "20 cent",
    survival_price = "50 cent",
    materials = { "junk" },
    volume = "250 ml",
    mass = "260 g",
    phase = "liquid",
    comestible = {
        kind = "DRINK",
        shelf_life = "1 day",
        quench = 50,
        healthy = -1,
        calories = 200,
        servings = 1,
        fun = -1,
    },
}
