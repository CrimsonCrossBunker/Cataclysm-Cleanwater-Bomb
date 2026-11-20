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
