local ccb = require("ccb")

ccb.content.define_item {
    id = "granade",
    category = "weapons",
    name = ccb.content.plural_text("Granade", "Granades"),
    description = ccb.content.text("Attached to this grenade is a name tag with the name Maya written on it.  Does not seem to work like a grenade, handle with care."),
    mass = "180 g",
    volume = "250 ml",
    price = "400 USD",
    materials = { "steel", "plastic" },
    symbol = "*",
    color = "green",
    melee_damage = { bash = 6 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "granade_act",
            message = ccb.content.text("You pull the pin on the %s."),
            target_timer = "5 seconds",
        },
    },
}
