local ccb = require("ccb")

ccb.content.define_item {
    id = "cereal",
    name = ccb.content.plural_text("sugary cereal", "sugary cereal"),
    description = ccb.content.text("Sugary breakfast cereal.  It takes you back to your childhood."),
    color = "yellow",
    symbol = "%",
    looks_like = "cereal",
    price = "3 USD",
    survival_price = "2 USD",
    mass = "110 g",
    volume = "100 ml",
    materials = { "junk" },
    flags = { "EDIBLE_FROZEN", "USE_EAT_VERB" },
    stackable = true,
    comestible = {
        kind = "FOOD",
        shelf_life = "90 days",
        quench = -2,
        fun = 10,
        calories = 354,
        vitamins = { { id = "iron", amount = 47 }, { id = "junk_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "cereal2",
    copy_from = "cereal",
    name = ccb.content.plural_text("whole-grain cereal", "whole-grain cereal"),
    description = ccb.content.text("Whole-grain wheat cereal.  It's surprisingly good, and for your heart too, allegedly."),
    materials = { "wheat" },
    comestible = {
        calories = 444,
        vitamins = { { id = "iron", amount = 172 }, { id = "wheat_allergen", amount = 1 } },
    },
}

ccb.content.define_item {
    id = "cereal3",
    copy_from = "cereal",
    name = ccb.content.plural_text("corn flakes", "corn flakes"),
    description = ccb.content.text("Plain cornflake cereal.  They're not that good, but it beats nothing."),
    materials = { "dried_vegetable" },
    comestible = { fun = 6, calories = 402, vitamins = { { id = "iron", amount = 172 } } },
}
