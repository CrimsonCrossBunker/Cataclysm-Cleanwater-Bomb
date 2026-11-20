local ccb = require("ccb")

ccb.content.define_item {
    id = "full_barrel_bomb_act",
    copy_from = "full_barrel_bomb",
    description = ccb.content.text("A 100 L metal barrel filled with military explosives.  It has been activated and will soon explode, delivering its entire destructive power to everything in sight."),
    looks_like = "half_barrel_bomb_act",
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
        blast = { power = 69200, shrapnel = { casing_mass = 12000, fragment_mass = 600 } },
    },
    countdown_interval = "100 seconds",
}
