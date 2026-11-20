local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "crater_bomb",
    category = "weapons",
    name = ccb.content.text_without_extraction("active alien bomb"),
    description = ccb.content.text_without_extraction("This item is used to make a hole for a crater.  It should not otherwise appear in game."),
    mass = "4400 g",
    volume = "10 L",
    price = "0 cent",
    materials = { "steel" },
    symbol = "(",
    color = "light_red",
    explode_in_fire = true,
    flags = { "BOMB", "TRADER_AVOID" },
    melee_damage = { bash = 20 },
    tool = {},
    countdown_action = { kind = "explosion", blast = { power = 25000, max_noise = 0 } },
    countdown_interval = "1 seconds",
    blast = { power = 25000, max_noise = 0 },
}
