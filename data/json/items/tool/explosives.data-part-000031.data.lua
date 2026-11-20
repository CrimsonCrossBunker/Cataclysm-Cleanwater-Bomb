local ccb = require("ccb")

ccb.content.define_item {
    id = "homemade_demolition_charge_act",
    copy_from = "homemade_demolition_charge",
    looks_like = "homemade_bomb_act",
    description = ccb.content.text("The fuse on this primitive demolition charge is lit and hissing.  It'll explode any moment now."),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 2590 } },
    countdown_interval = "20 seconds",
}
