local ccb = require("ccb")

-- Based off of the M67 grenade
ccb.content.define_item {
    id = "grenade",
    category = "weapons",
    name = ccb.content.plural_text("grenade", "grenades"),
    description = ccb.content.text("A military-grade fragmentation hand grenade.  Use this item to pull the pin and start the fuse.  You will then have five seconds before it explodes; throwing it would be a good idea."),
    mass = "397 g",
    volume = "540 ml",
    length = "110 mm",
    price = "15 USD",
    survival_price = "10 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel", "plastic" },
    symbol = "*",
    color = "green",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE" },
    melee_damage = { bash = 2 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "grenade_act",
            message = ccb.content.text("You pull the pin on the %s."),
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}
