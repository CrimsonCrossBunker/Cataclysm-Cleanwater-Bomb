local ccb = require("ccb")

ccb.content.define_item {
    id = "dynamite_act",
    description = ccb.content.text("The fuse on this dynamite is lit and hissing.  It'll explode any moment now."),
    copy_from = "dynamite",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 938 } },
    countdown_interval = "20 seconds",
}
