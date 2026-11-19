local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_augustmoon_docking",
    name = ccb.content.text("Port Augustmoon"),
    targets = { "augustmoon_docking_arm" },
}

ccb.content.define_start_location {
    id = "your_ship",
    name = ccb.content.text("Crashed escape pod"),
    targets = { "afs_shuttlepad_salvors_old_pad" },
}

ccb.content.define_start_location {
    id = "sloc_escape_pod",
    name = ccb.content.text("Crashed escape pod"),
    targets = { "afs_crashed_escape_pod" },
}

ccb.content.define_start_location {
    id = "sloc_crashing_ship",
    name = ccb.content.text("crashing ship"),
    targets = { "crashing_ship_3" },
}
