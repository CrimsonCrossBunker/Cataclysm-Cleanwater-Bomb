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
