local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "bot_skitterbot_base",
    abstract = true,
    name = ccb.content.text_without_extraction("inactive skitterbot"),
    looks_like = "broken_skitterbot",
    materials = { "steel", "plastic" },
    mass = "62650 g",
    volume = "30 L",
    price = "100 USD",
    survival_price = "100 USD",
    accuracy = -3,
    symbol = ";",
    color = "dark_gray",
    flags = { "TRADER_AVOID", "SINGLE_USE" },
    melee_damage = { bash = 6 },
    tool = {},
}
