local ccb = require("ccb")

ccb.content.define_item {
    id = "firecracker_act",
    copy_from = "firecracker",
    description = ccb.content.text("A firecracker that has been lit; the fuse is hissing.  Throw it quickly before it explodes."),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light up"),
        },
    },
    tick_actions = {
        {
            kind = "sound",
            message = ccb.content.text("ssss…"),
            volume = 0,
            sound_id = "misc",
            sound_variant = "lit_fuse",
        },
    },
    countdown_action = {
        kind = "sound",
        message = ccb.content.text_without_extraction("Bang!"),
        volume = 20,
        sound_id = "explosion",
        sound_variant = "small",
    },
    countdown_interval = "2 seconds",
}
