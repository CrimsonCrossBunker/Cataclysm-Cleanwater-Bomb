local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "grenade_canister",
    abstract = true,
    category = "weapons",
    name = ccb.content.text_without_extraction("canister grenade"),
    mass = "1058 g",
    volume = "270 ml",
    materials = { "steel" },
    symbol = "*",
    color = "dark_gray",
}

ccb.content.define_item {
    id = "afs_kaburaya_bomb_act",
    copy_from = "grenade_canister",
    looks_like = "c4",
    name = ccb.content.plural_text("armed Kabura-ya antipersonnel device", "armed Kabura-ya antipersonnel devices"),
    description = ccb.content.text("A tiny plastic explosive meant to be installed within a Kabura-ya drone.  It is on the verge of exploding."),
    flags = { "BOMB", "TRADER_AVOID" },
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
        blast = {
            power = 100,
            max_noise = 25,
            distance_factor = 0.2,
            shrapnel = { casing_mass = 217, fragment_mass = 0.125 },
        },
    },
}

ccb.content.define_item {
    id = "afs_demo_charge",
    copy_from = "grenade_canister",
    looks_like = "c4",
    name = ccb.content.plural_text("demolition charge", "demolition charges"),
    price = "450 USD",
    description = ccb.content.text("A powerful explosive with a highly focused blast radius, often used for mining or demolition work.  It's configured to work alongside a radio detonator, and will explode immediately after activation."),
    flags = { "RADIO_ACTIVATION", "RADIO_INVOKE_PROC", "RADIOSIGNAL_1", "BOMB" },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "afs_demo_charge_act",
            message = ccb.content.text("You activate the demolition charge."),
            target_timer = "1 seconds",
            menu_text = ccb.content.text("Activate"),
        },
    },
}

ccb.content.define_item {
    id = "afs_demo_charge_act",
    copy_from = "afs_demo_charge",
    name = ccb.content.plural_text("active demolition charge", "active demolition charges"),
    looks_like = "c4armed",
    description = ccb.content.text("A powerful explosive with a highly focused blast radius, often used for mining or demolition work.  It's currently active."),
    inheritance = { add = { flags = { "TRADER_AVOID" } } },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 3000, max_noise = 250, distance_factor = 0.3 } },
}

ccb.content.define_item {
    id = "afs_HE_grenade",
    copy_from = "grenade_canister",
    looks_like = "grenade",
    name = ccb.content.plural_text("HE grenade", "HE grenades"),
    price = "450 USD",
    mass = "300 g",
    volume = "250 ml",
    description = ccb.content.text("A high explosive grenade that deals most of its damage through a powerful shockwave.  Reduced shrapnel makes it much safer to use in open spaces."),
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE" },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "afs_HE_grenade_act",
            message = ccb.content.text("You pull the pin on the %s."),
            target_timer = "5 seconds",
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}

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

ccb.content.define_item {
    id = "afs_toxic_grenade",
    copy_from = "grenade_canister",
    looks_like = "grenade",
    name = ccb.content.plural_text("neurotoxin grenade", "neurotoxin grenades"),
    price = "650 USD",
    mass = "300 g",
    volume = "250 ml",
    description = ccb.content.text("A neurotoxic device that deploys thick swathes of toxic foam upon detonation.  Exposure proves fatal within seconds.  Use against human targets is considered in breach of the Ganymede Accords."),
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE" },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "afs_toxic_grenade_act",
            message = ccb.content.text("You pull the pin on the %s."),
            target_timer = "5 seconds",
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}

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
