local ccb = require("ccb")

ccb.content.define_item {
    id = "oxygen_jelly_long",
    name = ccb.content.plural_text("Long-release Oxyjelly", "Long-release Oxyjelly"),
    description = ccb.content.text("Oxyjelly made to slowly provide oxygen over a long timespan, allowing the user to breathe underwater."),
    category = "food",
    mass = "3 g",
    volume = "2 ml",
    price = "1 cent",
    survival_price = "1 cent",
    symbol = "*",
    color = "blue",
    flags = { "INVENTOR_CRAFTED" },
    comestible = { kind = "FOOD", on_consume = "consume_oxygen_jelly_long" },
}
