local ccb = require("ccb")

-- Based on the M84 stun grenade
ccb.content.define_item {
    id = "flashbang",
    category = "weapons",
    name = ccb.content.plural_text("flashbang", "flashbangs"),
    description = ccb.content.text("A military police-style flashbang.  Use this item to pull the pin and start the fuse.  You will then have two seconds before it detonates with intense light and sound, blinding, deafening, and disorienting anyone nearby."),
    mass = "425 g",
    volume = "207 ml",
    length = "141 mm",
    price = "20 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel", "plastic" },
    symbol = "*",
    color = "dark_gray",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE", "CYLINDER_GRENADE" },
    melee_damage = { bash = 1 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "flashbang_act",
            message = ccb.content.text("You pull the pin on the %s."),
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}
