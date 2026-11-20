local ccb = require("ccb")

ccb.content.define_item {
    id = "alchemist_bomb_act",
    category = "weapons",
    name = ccb.content.plural_text("mana bomb (lit)", "mana bombs (lit)"),
    description = ccb.content.text("The liquid in the bottle is sizzling.  Throwing it away from you, preferably at an enemy, would be a very good idea."),
    mass = "430 g",
    volume = "200 ml",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = -3,
    materials = { "concentrated_mana", "crystallized_mana" },
    symbol = "*",
    color = "red",
    explode_in_fire = true,
    flags = { "TRADER_AVOID" },
    melee_damage = { bash = 14 },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("The reaction has already started - all you can do is get it away from you!"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 200 } },
    blast = { power = 200 },
}
