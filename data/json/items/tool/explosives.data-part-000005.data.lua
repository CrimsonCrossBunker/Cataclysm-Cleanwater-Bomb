local ccb = require("ccb")

-- Something this useful doesn't come cheap after the apocalypse
ccb.content.define_item {
    id = "grenade_emp",
    category = "weapons",
    name = ccb.content.plural_text("EMP grenade", "EMP grenades"),
    description = ccb.content.text("A grenade that generates an electromagnetic pulse with a low-inductance capacitor bank discharged into a single-loop antenna.  It also produces a mild electric shock cloud.  Use this item to pull the pin and light the fuse, turning it into an active EMP grenade.  You will then have three seconds before it detonates, creating an EMP field that damages robots and drains bionic energy."),
    mass = "400 g",
    volume = "270 ml",
    price = "60 USD",
    survival_price = "40 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel", "plastic" },
    symbol = "*",
    looks_like = "EMPbomb",
    color = "cyan",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE", "WATER_BREAK" },
    melee_damage = { bash = 2 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "grenade_emp_act",
            message = ccb.content.text("You pull the pin on the %s."),
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}
