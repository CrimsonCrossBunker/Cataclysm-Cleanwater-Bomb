local ccb = require("ccb")

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
