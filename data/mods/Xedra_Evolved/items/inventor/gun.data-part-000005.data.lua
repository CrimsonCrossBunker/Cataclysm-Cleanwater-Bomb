local ccb = require("ccb")

ccb.content.define_item {
    id = "inventor_grenade_noise_expl_act",
    category = "weapons",
    name = ccb.content.plural_text("inventor's noise grenade", "inventor's noise grenades"),
    description = ccb.content.text("A small energy grenade with an additional timer slapped onto it.  When triggered, the timer will start to count to 70 seconds.  As it ends a massive explosion will rip your enemies apart."),
    mass = "300 g",
    volume = "450 ml",
    materials = { "lc_steel" },
    symbol = "*",
    color = "blue",
    flags = { "TRADER_AVOID", "BOMB", "INVENTOR_CRAFTED" },
    tool = {},
    tick_actions = {
        {
            kind = "sound",
            message = ccb.content.text("whistle"),
            volume = 35,
            sound_variant = "bomb_ticking",
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 1200 } },
}

ccb.content.define_item {
    id = "inventor_grenade_noise_emp_act",
    category = "weapons",
    name = ccb.content.plural_text("inventor's noise EMP grenade", "inventor's noise EMP grenades"),
    description = ccb.content.text("A small energy grenade with an additional timer and a whistle slapped onto it.   When triggered, the timer will start to count to 70 seconds.  As it ends a huge EMP explosion will cover the zone."),
    mass = "300 g",
    volume = "450 ml",
    materials = { "lc_steel" },
    symbol = "*",
    color = "blue",
    flags = { "TRADER_AVOID", "BOMB", "INVENTOR_CRAFTED", "SPAWN_ACTIVE" },
    tool = {},
    tick_actions = {
        {
            kind = "sound",
            message = ccb.content.text("whistle"),
            volume = 35,
            sound_variant = "bomb_ticking",
        },
    },
    countdown_action = {
        kind = "explosion",
        field = "fd_electricity",
        field_radius = 5,
        field_minimum = 10,
        field_maximum = 10,
        emp_radius = 12,
    },
    countdown_interval = "70 seconds",
}

ccb.content.define_item {
    id = "inventor_grenade_noise_fire_act",
    category = "weapons",
    name = ccb.content.plural_text("inventor's noise fire grenade", "inventor's noise fire grenades"),
    description = ccb.content.text("A small energy grenade with an additional timer slapped onto it.  When triggered, the timer will start to count to 70 seconds.  As it ends a massive fire explosion will rip your enemies apart."),
    mass = "300 g",
    volume = "450 ml",
    materials = { "lc_steel" },
    symbol = "*",
    color = "blue",
    flags = { "TRADER_AVOID", "BOMB", "INVENTOR_CRAFTED" },
    tool = {},
    tick_actions = {
        {
            kind = "sound",
            message = ccb.content.text("whistle"),
            volume = 35,
            sound_variant = "bomb_ticking",
        },
    },
    countdown_action = {
        kind = "explosion",
        field = "fd_fire",
        field_radius = 4,
        field_minimum = 0,
        field_maximum = 2,
        blast = { power = 225 },
    },
}
