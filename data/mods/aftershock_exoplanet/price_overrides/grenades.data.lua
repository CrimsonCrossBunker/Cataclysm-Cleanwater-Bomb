local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_emp",
    name = ccb.content.plural_text("EMP grenade", "EMP grenades"),
    copy_from = "grenade_emp",
    price = "500 USD",
    survival_price = "500 USD",
    tool = {},
}

ccb.content.define_item {
    id = "grenade",
    name = ccb.content.plural_text("grenade", "grenades"),
    copy_from = "grenade",
    price = "350 USD",
    survival_price = "350 USD",
    tool = {},
}

ccb.content.define_item {
    id = "grenade_inc",
    name = ccb.content.plural_text("incendiary grenade", "incendiary grenades"),
    copy_from = "grenade_inc",
    price = "450 USD",
    survival_price = "450 USD",
    tool = {},
}

ccb.content.define_item {
    id = "scrambler",
    name = ccb.content.plural_text("scrambler grenade", "scrambler grenades"),
    copy_from = "scrambler",
    price = "800 USD",
    survival_price = "800 USD",
    tool = {},
}
