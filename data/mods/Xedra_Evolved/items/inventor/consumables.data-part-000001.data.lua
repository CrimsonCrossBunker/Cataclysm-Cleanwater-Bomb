local ccb = require("ccb")

ccb.content.define_item {
    id = "oxygen_jelly_quick",
    name = ccb.content.plural_text("Quick-release Oxyjelly", "Quick-release Oxyjelly"),
    description = ccb.content.text("Oxyjelly made to cause a big burst of oxygen, helping against asthma and smoke inhalation."),
    category = "food",
    mass = "3 g",
    volume = "2 ml",
    price = "1 cent",
    survival_price = "1 cent",
    symbol = "*",
    color = "blue",
    flags = { "INVENTOR_CRAFTED" },
    comestible = { kind = "FOOD" },
    use_actions = { "OXYGEN_BOTTLE" },
}
