local ccb = require("ccb")

ccb.content.define_item {
    id = "homemade_grenade_act",
    copy_from = "homemade_grenade",
    looks_like = "grenade_act",
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
        blast = { power = 300, shrapnel = { casing_mass = 400, fragment_mass = 0.4 } },
    },
    countdown_interval = "5 seconds",
}
