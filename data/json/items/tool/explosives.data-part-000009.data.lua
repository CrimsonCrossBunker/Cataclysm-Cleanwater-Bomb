local ccb = require("ccb")

-- Something this useful doesn't come cheap after the apocalypse
ccb.content.define_item {
    id = "scrambler",
    category = "weapons",
    name = ccb.content.plural_text("scrambler grenade", "scrambler grenades"),
    description = ccb.content.text("A specialized grenade designed to scramble robots' IFF control chips.  This converts the robot to your side for a short time, before the backup systems kick in.  Use this item to pull the pin and start the fuse, turning it into an active scrambler grenade."),
    mass = "500 g",
    volume = "270 ml",
    price = "60 USD",
    survival_price = "50 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel", "plastic" },
    symbol = "*",
    color = "yellow",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE" },
    melee_damage = { bash = 2 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "scrambler_act",
            message = ccb.content.text("You pull the pin on the %s."),
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}
