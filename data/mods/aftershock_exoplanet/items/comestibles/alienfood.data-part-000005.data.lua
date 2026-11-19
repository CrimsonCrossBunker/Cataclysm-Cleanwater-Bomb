local ccb = require("ccb")

ccb.content.define_item {
    id = "alien_fat",
    name = ccb.content.plural_text("chunk of alien fat", "chunks of alien fat"),
    mass = "220 g",
    color = "pink",
    symbol = "%",
    survival_price = "2 USD 50 cent",
    description = ccb.content.text("Freshly butchered fat from an alien.  You could eat it cooked or raw, but it is more safely used for crafting non edible-products."),
    price = "0 cent",
    materials = { "flesh" },
    volume = "250 ml",
    comestible = {
        shelf_life = "7 days",
        kind = "FOOD",
        quench = -10,
        healthy = -5,
        calories = 1923,
        vitamins = { { id = "mutant_toxin", amount = 25 }, { id = "meat_allergen", amount = 1 } },
        parasites = 32,
        fun = -20,
    },
}

-- *May* have been commercially traded.
ccb.content.define_item {
    id = "alien_tallow",
    name = ccb.content.plural_text("alien tallow", "alien tallow"),
    mass = "55 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A smooth white block of cleaned and rendered alien animal fat.  It'll last for a very long time, but you are unsure of its edibility.  Can be used as an ingredient in many foods and projects."),
    price = "125 cent",
    survival_price = "2 USD",
    materials = { "flesh" },
    volume = "62 ml",
    comestible = {
        shelf_life = "60 days",
        kind = "FOOD",
        quench = -10,
        healthy = -1,
        calories = 496,
        vitamins = { { id = "mutant_toxin", amount = 25 }, { id = "meat_allergen", amount = 1 } },
        fun = -18,
    },
}
