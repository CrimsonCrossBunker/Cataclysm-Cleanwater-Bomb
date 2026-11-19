local ccb = require("ccb")

ccb.content.define_item {
    id = "gum_flesh",
    looks_like = "gum",
    name = ccb.content.plural_text("chunk of gum flesh", "chunks of gum flesh"),
    description = ccb.content.text("Bright pink chunk of fresh gum flesh."),
    category = "food",
    mass = "300 g",
    volume = "250 ml",
    survival_price = "10 cent",
    symbol = "*",
    color = "pink",
    materials = { "junk" },
    flags = { "NO_INGEST" },
    comestible = { kind = "FOOD", stimulation = 1, fun = 2, vitamins = { { id = "junk_allergen", amount = 1 } } },
    use_actions = { "CHEW" },
}

ccb.content.define_item {
    id = "caff_gum_flesh",
    looks_like = "caff_gum",
    name = ccb.content.plural_text("chunk of caffeinated gum flesh", "chunks of caffeinated gum flesh"),
    description = ccb.content.text("A nice chunk of still shivering caffeinated gum flesh."),
    category = "drugs",
    mass = "300 g",
    volume = "250 ml",
    survival_price = "1 USD",
    symbol = "*",
    color = "white",
    materials = { "junk" },
    flags = { "NO_INGEST" },
    comestible = {
        kind = "FOOD",
        addiction = "caffeine",
        fun = 1,
        vitamins = { { id = "junk_allergen", amount = 1 }, { id = "caffeine", amount = 90 } },
    },
    use_actions = { "CHEW" },
}
