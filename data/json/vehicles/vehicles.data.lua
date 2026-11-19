local ccb = require("ccb")

-- don't remove, used for initializing empty vehicle prototype
ccb.content.define_vehicle {
    id = "none",
    name = ccb.content.text("empty prototype"),
    blueprint = { "H" },
    mounts = {},
}
