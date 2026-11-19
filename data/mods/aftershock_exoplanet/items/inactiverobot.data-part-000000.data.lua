local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "bot_milbot_base",
    abstract = true,
    name = ccb.content.text_without_extraction("inactive military robot"),
    looks_like = "mon_secubot",
    materials = { "steel", "kevlar" },
    mass = "140 kg",
    volume = "62500 ml",
    price = "100 USD",
    survival_price = "100 USD",
    accuracy = -3,
    symbol = ";",
    color = "light_gray",
    flags = { "LEAK_DAM", "RADIOACTIVE", "TRADER_AVOID", "SINGLE_USE" },
    melee_damage = { bash = 8 },
    tool = {},
}
