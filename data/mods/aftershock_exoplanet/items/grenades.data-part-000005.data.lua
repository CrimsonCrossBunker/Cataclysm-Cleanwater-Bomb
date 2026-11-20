local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_HE_grenade_act",
    copy_from = "afs_HE_grenade",
    name = ccb.content.plural_text("active HE grenade", "active HE grenades"),
    looks_like = "grenade_act",
    description = ccb.content.text("A high explosive grenade that deals most of its damage through a powerful shockwave.  It's currently active."),
    inheritance = { add = { flags = { "TRADER_AVOID" } } },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 3000, max_noise = 250, distance_factor = 0.7 } },
}

ccb.content.define_item {
    id = "grenade_cryo_act",
    category = "weapons",
    name = ccb.content.plural_text("active cryo grenade", "active cryo grenades"),
    description = ccb.content.text("This is an active grenade, and will explode any second now.  Once it explodes it spreads exotic highly-thermodynamic shrapnel.  Better throw it!"),
    mass = "397 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = -1,
    materials = { "superalloy" },
    symbol = "*",
    color = "green",
    flags = { "BOMB", "TRADER_AVOID" },
    melee_damage = { bash = 6 },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = {
        kind = "explosion",
        field = "fd_rad_glimmer",
        field_radius = 3,
        field_minimum = 3,
        field_maximum = 3,
        blast = { power = 540, shrapnel = { casing_mass = 217, fragment_mass = 0.125 } },
    },
}
