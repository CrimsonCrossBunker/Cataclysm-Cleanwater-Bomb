local ccb = require("ccb")

ccb.content.define_item {
    id = "pipebomb_act",
    copy_from = "pipebomb",
    description = ccb.content.text("This pipebomb's fuse is lit, and it will explode any second now.  Throw it immediately!"),
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
        blast = { power = 300, shrapnel = { casing_mass = 410, fragment_mass = 0.5 } },
    },
    countdown_interval = "6 seconds",
}
