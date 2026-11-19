local ccb = require("ccb")

ccb.content.define_item {
    id = "mana_wheel",
    category = "veh_parts",
    name = ccb.content.plural_text("mana wheel", "mana wheels"),
    description = ccb.content.text("A column of mana energy that enables a floating disk to move."),
    mass = "500 g",
    volume = "500 ml",
    price = "1 cent",
    accuracy = -4,
    materials = { "steel" },
    symbol = "]",
    color = "light_gray",
    melee_damage = { bash = 8 },
    wheel = { diameter = 20, width = 10 },
}
