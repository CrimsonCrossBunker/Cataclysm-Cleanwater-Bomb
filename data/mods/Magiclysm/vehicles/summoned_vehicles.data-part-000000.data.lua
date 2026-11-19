local ccb = require("ccb")

ccb.content.define_vehicle {
    id = "floating_disk",
    name = ccb.content.text("Floating disk"),
    blueprint = { "o" },
    mounts = { { x = 0, y = 0, parts = { "mana_frame" } } },
}
