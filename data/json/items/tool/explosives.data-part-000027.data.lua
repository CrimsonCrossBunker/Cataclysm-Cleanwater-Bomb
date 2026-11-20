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
