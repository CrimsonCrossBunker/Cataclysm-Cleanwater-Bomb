local ccb = require("ccb")

ccb.content.define_item {
    id = "dynamite_bomb_act",
    description = ccb.content.text("The fuse on this dynamite bomb is lit and hissing.  It'll explode any moment now."),
    copy_from = "dynamite_bomb",
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
        blast = { power = 938, shrapnel = { casing_mass = 1597, fragment_mass = 0.5 } },
    },
    countdown_interval = "20 seconds",
}
