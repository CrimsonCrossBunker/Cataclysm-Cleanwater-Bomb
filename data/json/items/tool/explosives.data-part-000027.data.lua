local ccb = require("ccb")

ccb.content.define_item {
    id = "small_homemade_grenade_act",
    copy_from = "small_homemade_grenade",
    looks_like = "homemade_grenade_act",
    description = ccb.content.text("The fuse on this improvised grenade is lit, and it will explode any second now.  Better throw it!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 150, shrapnel = { casing_mass = 200, fragment_mass = 0.4 } },
    },
    countdown_interval = "5 seconds",
}

ccb.content.define_item {
    id = "small_homemade_grenade",
    copy_from = "grenade",
    name = "small homemade grenade",
    description = "An improvised explosive device cobbled together from spare parts.  Use this item to light the fuse.  You will then have 5 seconds before it explodes; throwing it would be a good idea.",
    symbol = "*",
    color = "green",
    looks_like = "homemade_grenade",
    mass = "460 g",
    volume = "270 ml",
    price = "7 USD 50 cent",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE" },
    materials = { "aluminum", "iron" },
    blast = {
        power = 150,
        shrapnel = { casing_mass = 200, fragment_mass = 0.4 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "small_homemade_grenade_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the fuse on the improvised grenade.  Throw it before it blows up in your face!",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}
