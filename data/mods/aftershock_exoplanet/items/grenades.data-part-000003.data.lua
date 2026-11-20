local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_demo_charge_act",
    copy_from = "afs_demo_charge",
    name = ccb.content.plural_text("active demolition charge", "active demolition charges"),
    looks_like = "c4armed",
    description = ccb.content.text("A powerful explosive with a highly focused blast radius, often used for mining or demolition work.  It's currently active."),
    inheritance = { add = { flags = { "TRADER_AVOID" } } },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 3000, max_noise = 250, distance_factor = 0.3 } },
}
