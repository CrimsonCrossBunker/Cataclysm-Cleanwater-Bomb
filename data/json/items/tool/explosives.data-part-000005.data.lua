local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_inc",
    category = "weapons",
    name = ccb.content.plural_text("incendiary grenade", "incendiary grenades"),
    description = ccb.content.text("A military-grade incendiary hand grenade.  Use this item to pull the pin and start the fuse.  You will then have five seconds before it explodes into a raging inferno; throwing it would be a good idea."),
    mass = "180 g",
    volume = "270 ml",
    price = "20 USD",
    survival_price = "15 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel" },
    symbol = "*",
    color = "light_red",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "ACT_IN_FIRE", "GRENADE", "CYLINDER_GRENADE" },
    melee_damage = { bash = 1 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "grenade_inc_act",
            message = ccb.content.text("You pull the pin on the %s."),
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}

-- This is based on the B54 Mod 1, all other man-portable nuclear weapons have far too high a yield.
ccb.content.define_item {
    id = "mininuke",
    category = "weapons",
    name = ccb.content.plural_text("SADM mininuke", "SADM mininukes"),
    description = ccb.content.text("The B54 Special Atomic Demolition Munition is an extremely powerful weapon, a portable nuclear bomb, using the smallest nuclear warhead in US inventory.  It is housed inside a extremely sturdy transit container.  Use it to activate the timer.  You guess that the explosion would be large enough to take out a small house."),
    mass = "26500 g",
    volume = "33389 ml",
    length = "46 cm",
    price = "1 kUSD 800 USD",
    survival_price = "100 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "aluminum", "nylon" },
    symbol = "*",
    color = "light_green",
    flags = { "STURDY", "LEAK_DAM", "BELTED", "RADIOACTIVE", "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    melee_damage = { bash = 8 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 2.0 } },
                encumbrance = 90,
                coverage = 10,
                covers = { "hand_l", "hand_r" },
            },
        },
    },
    use_actions = { "MININUKE" },
}
