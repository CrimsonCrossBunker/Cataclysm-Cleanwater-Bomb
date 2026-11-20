local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_inferno_makeshift",
    category = "weapons",
    name = ccb.content.plural_text("makeshift inferno grenade", "makeshift inferno grenades"),
    description = ccb.content.text("This is a post-apocalyptic recreation of an inferno grenade, less powerful than a lab-made one but still very dangerous.  Once you throw it, you will have five seconds to get away before it explodes into a raging firestorm."),
    mass = "230 g",
    volume = "270 ml",
    price = "20 USD",
    survival_price = "15 USD",
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
            target = "grenade_inferno_makeshift_act",
            message = ccb.content.text("You pull the pin on the %s."),
            target_timer = "5 seconds",
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}
