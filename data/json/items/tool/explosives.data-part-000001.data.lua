local ccb = require("ccb")

ccb.content.define_item {
    id = "c4armed",
    copy_from = "c4",
    description = ccb.content.text("A block of military-grade RDX composition explosive.  A label reads: \"Highly explosive, use with extreme caution!\" It comes with a small timer, which is currently ticking down."),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 2000 } },
    countdown_interval = "6 seconds",
}
