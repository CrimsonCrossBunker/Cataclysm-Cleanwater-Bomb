local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_inferno",
    category = "weapons",
    name = ccb.content.plural_text("inferno grenade", "inferno grenades"),
    description = ccb.content.text("This is an inferno grenade, designed to channel Netherum energy to increase its incendiary power.  Once you throw it, you will have five seconds to get away before it explodes into a raging firestorm."),
    mass = "230 g",
    volume = "270 ml",
    price = "50 USD",
    survival_price = "35 USD",
    accuracy = -1,
    melee_damage = { bash = 6 },
    materials = { "steel", "nether_crystal" },
    symbol = "*",
    color = "red",
    flags = { "BOMB", "ACT_IN_FIRE", "GRENADE" },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "grenade_inferno_act",
            message = ccb.content.text("You pull the pin on the %s."),
            target_timer = "5 seconds",
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}
