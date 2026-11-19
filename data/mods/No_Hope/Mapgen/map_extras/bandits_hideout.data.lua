local ccb = require("ccb")

-- TODO: Add more variations
ccb.content.define_mapgen {
    kind = "update",
    id = "bandits_hideout",
    layout = {
        nested = { { id = "bandits_hideout", x = 0, y = 0 } },
    },
}
