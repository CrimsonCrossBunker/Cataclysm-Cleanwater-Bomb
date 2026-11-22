local ccb = require("ccb")

ccb.content.define_item {
    id = "half_barrel_bomb_act",
    copy_from = "half_barrel_bomb",
    description = ccb.content.text("A metal keg filled with stable explosives.  The fuse has been lit and once it ignites the primary explosive, the bomb will detonate and rain fire and steel on everything in sight."),
    color = "light_red",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Activate fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 34400, shrapnel = { casing_mass = 12600, fragment_mass = 600 } },
    },
    countdown_interval = "100 seconds",
}

ccb.content.define_item {
    id = "half_barrel_bomb",
    name = "50 L barrel bomb",
    description = "A metal keg filled with stable explosives.  Contains a volatile explosive core, so 100 seconds after the fuse has been lit the charge will detonate completely, delivering its entire destructive power to everything in sight.",
    symbol = "(",
    color = "red",
    category = "weapons",
    mass = "61620 g",
    volume = "52500 ml",
    price = "1 kUSD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "ALLOWS_REMOTE_USE" },
    materials = { "steel" },
    melee_damage = { bash = 20 },
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    blast = {
        power = 34400,
        shrapnel = { casing_mass = 12600, fragment_mass = 600 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "half_barrel_bomb_act",
            message = "You activate the fuse on the barrel bomb.  Clear the area!",
            menu_text = "Activate fuse",
        },
    },
    tool = {},
}
