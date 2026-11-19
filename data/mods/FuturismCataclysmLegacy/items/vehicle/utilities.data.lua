local ccb = require("ccb")

ccb.content.define_item {
    id = "minireactor",
    name = ccb.content.plural_text("minireactor", "minireactors"),
    description = ccb.content.text("A small, portable plutonium reactor.  Handle with great care!"),
    mass = "27215 g",
    accuracy = -4,
    color = "light_cyan",
    symbol = ":",
    materials = { "superalloy", "ceramic" },
    pockets = { { kind = "MAGAZINE", ammunition = { plutonium = 10000 }, rigid = true } },
    volume = "100 L",
    category = "veh_parts",
    price = "900 USD",
    survival_price = "50 USD",
    melee_damage = { bash = 7 },
    tool = { ammo_types = { "plutonium" } },
}
