local ccb = require("ccb")

ccb.content.define_item {
    id = "royal_jelly",
    name = ccb.content.plural_text("royal jelly", "royal jelly"),
    category = "food",
    mass = "150 g",
    color = "white",
    symbol = "%",
    description = ccb.content.text("A translucent hexagonal chunk of wax, filled with dense, milky, bitter and acidic-tasting jelly.  Though some hold it as a panacea, it doesn't have any medical benefit.  Still it is rich with the most beneficial substances the hive can produce."),
    price = "200 USD",
    survival_price = "4 USD",
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN", "NUTRIENT_OVERRIDE" },
    stackable = true,
    comestible = { kind = "FOOD", calories = 240, fun = -5 },
}

-- It takes about 30 portions of honeydew to feed an adult (~2000 kkal). 2000 kkal is about 10 raw chunks of mutant meat, which is 250% toxins. Honeydew probably isn't as toxic as meat, so 30 portions of it would give you 180% of toxins.
ccb.content.define_item {
    id = "honeydew",
    name = ccb.content.plural_text("honeydew", "honeydew"),
    description = ccb.content.text("A sugar-rich sticky substance, produced by aphids from plant sap.  Ants and bees love it."),
    mass = "22 g",
    color = "green",
    symbol = "~",
    materials = { "honey" },
    flags = { "NUTRIENT_OVERRIDE" },
    volume = "16 ml",
    stackable = true,
    comestible = {
        quench = 4,
        calories = 67,
        fun = 2,
        kind = "FOOD",
        vitamins = { { id = "mutant_toxin", amount = 6 } },
    },
}
