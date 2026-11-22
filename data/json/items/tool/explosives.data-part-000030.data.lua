local ccb = require("ccb")

ccb.content.define_item {
    id = "homemade_bomb_act",
    copy_from = "homemade_bomb",
    description = ccb.content.text("A homemade explosive device, consisting of a large plastic jug filled with stable explosives and scrap metal.  Its fuse has been lit, its final countdown starting."),
    color = "light_red",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = {
            power = 2320,
            shrapnel = { casing_mass = 3000, fragment_mass = 0.5, drop = "scrap", recovery = 20 },
        },
    },
    countdown_interval = "20 seconds",
}

ccb.content.define_item {
    id = "homemade_bomb",
    name = "homemade bomb",
    description = "A homemade explosive device, consisting of a large plastic jug filled with stable explosives and scrap metal, equipped with a long fuse.  Use this item to light the fuse.  Once you do, it should explode after about 20 seconds.",
    symbol = "*",
    color = "red",
    category = "weapons",
    mass = "6500 g",
    volume = "3900 ml",
    price = "100 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    materials = { "steel", "plastic" },
    blast = {
        power = 2320,
        shrapnel = { casing_mass = 3000, fragment_mass = 0.5, drop = "scrap", recovery = 20 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "homemade_bomb_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the fuse on the bomb.  Get rid of it quickly!",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}
