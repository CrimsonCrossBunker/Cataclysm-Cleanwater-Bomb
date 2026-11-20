local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_toxic_grenade_act",
    copy_from = "afs_toxic_grenade",
    name = ccb.content.plural_text("active neurotoxin grenade", "active neurotoxin grenades"),
    looks_like = "grenade_act",
    description = ccb.content.text("A neurotoxic device that deploys thick swathes of toxic foam upon detonation.  It's currently active."),
    inheritance = { add = { flags = { "TRADER_AVOID" } } },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
        },
    },
    countdown_action = {
        kind = "explosion",
        field_radius = 4,
        field = "fd_toxic_foam",
        field_minimum = 3,
        field_maximum = 6,
        blast = { power = 150, max_noise = 250, distance_factor = 0.7 },
    },
}

ccb.content.define_item {
    id = "afs_reactor_unstable",
    category = "weapons",
    name = ccb.content.plural_text("unstable fusion reactor", "unstable fusion reactors"),
    looks_like = "c4armed",
    description = ccb.content.text("A pressurized plasma reactor that is on the verge of a catastrophic explosion."),
    mass = "4400 g",
    volume = "10 L",
    price = "0 cent",
    accuracy = -5,
    materials = { "steel" },
    symbol = "(",
    color = "light_red",
    explode_in_fire = true,
    flags = { "BOMB", "TRADER_AVOID", "SPAWN_ACTIVE" },
    tool = {},
    countdown_action = { kind = "explosion", blast = { power = 28000, max_noise = 150, distance_factor = 0.15 } },
    countdown_interval = "3 seconds",
    blast = { power = 28000, max_noise = 150, distance_factor = 0.15 },
}
