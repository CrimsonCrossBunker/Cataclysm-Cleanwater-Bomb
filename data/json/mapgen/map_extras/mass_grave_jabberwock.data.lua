local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_mass_grave_jabberwock",
    layout = {
        nested = { { choices = { { id = "mass_grave_jabberwock_finished", weight = 10 } }, x = 0, y = 0 } },
    },
}
