local ccb = require("ccb")

ccb.content.define_item {
    id = "mininuke_act",
    copy_from = "mininuke",
    description = ccb.content.text("The nuclear bomb looks no different from the outside, yet you know that the device is armed and counting down.  You should probably get far, far away from it."),
    flags = { "STURDY", "LEAK_DAM", "BELTED", "RADIOACTIVE", "DANGEROUS", "SPAWN_ACTIVE" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
        },
    },
    countdown_action = {
        kind = "explosion",
        field = "fd_nuke_gas",
        field_radius = 18,
        field_minimum = 3,
        field_maximum = 3,
        blast = { power = 9000000 },
    },
    countdown_interval = "60 seconds",
}
