local ccb = require("ccb")

-- = one cent, gives correct prices for cash cards
ccb.content.define_item {
    id = "money",
    price = "1 cent",
    survival_price = "1 cent",
    name = ccb.content.text("cent"),
    symbol = "=",
    color = "light_gray",
    description = ccb.content.text("A unit of currency equivalent to 0.01 US dollars."),
    flags = { "ZERO_WEIGHT" },
    volume = "0 ml",
    ammunition = { type = "money" },
}

ccb.content.define_item {
    id = "cash_card",
    category = "currency",
    copy_from = "card_plastic_abstract",
    symbol = "$",
    color = "yellow",
    name = ccb.content.plural_text("cash card", "cash cards"),
    ascii_picture = "cashcard",
    description = ccb.content.text("UICA's normally digital currency, rendered physical for use in the frontier.  The card can be programmed with any amount of United Solar Denominations and is commonly used to anonymously transfer funds."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { money = 200000000 } } },
    inheritance = { add = { flags = { "NO_UNLOAD", "NO_RELOAD" } } },
    tool = { ammo_types = { "money" } },
}
