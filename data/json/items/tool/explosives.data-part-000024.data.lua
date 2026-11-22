local ccb = require("ccb")

ccb.content.define_item {
    id = "military_explosive_bomb_act",
    copy_from = "military_explosive_bomb",
    looks_like = "homemade_bomb_act",
    description = ccb.content.text("A homemade explosive device, consisting of a large plastic jug filled with military explosives and scrap metal.  Its fuse has been lit, its final countdown starting."),
    color = "light_red",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = {
            power = 6970,
            shrapnel = { casing_mass = 3000, fragment_mass = 0.5, drop = "scrap", recovery = 20 },
        },
    },
    countdown_interval = "20 seconds",
}

ccb.content.define_item {
    id = "military_explosive_bomb",
    name = "military explosive bomb",
    description = "A homemade explosive device, consisting of a large plastic jug filled with military explosives and scrap metal, equipped with a delayed fuse.  Use this item to pull the pin.  Once you do, it should explode after about 20 seconds.",
    symbol = "*",
    color = "red",
    category = "weapons",
    looks_like = "homemade_bomb",
    mass = "8760 g",
    volume = "3900 ml",
    price = "200 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    materials = { "steel", "plastic" },
    blast = {
        power = 6970,
        shrapnel = { casing_mass = 3000, fragment_mass = 0.5, drop = "scrap", recovery = 20 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_explosive_bomb_act",
            need_wielding = true,
            message = "You pull the pin on the %s.",
            menu_text = "Pull pin",
        },
    },
    tool = {},
}
