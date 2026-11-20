local ccb = require("ccb")

ccb.content.define_item {
    id = "lens",
    symbol = ".",
    color = "light_cyan",
    name = ccb.content.plural_text("high-quality lens", "high-quality lenses"),
    category = "spare_parts",
    description = ccb.content.text("A high-quality glass lens, useful for focusing or diffusing light.  Might be useful for starting a fire."),
    price = "1 kUSD 200 USD",
    survival_price = "1 USD",
    materials = { "glass" },
    mass = "1 g",
    volume = "2 ml",
    flags = { "FIRESTARTER" },
    use_actions = { { kind = "firestarter", moves = 1000, slow_moves = 30000, need_sunlight = true } },
}
