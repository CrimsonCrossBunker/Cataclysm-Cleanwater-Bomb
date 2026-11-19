local ccb = require("ccb")

-- TODO: Add more variations
ccb.content.define_mapgen {
    kind = "update",
    id = "bandits_outpost",
    layout = {
        nested = { { id = "bandits_outpost", x = 0, y = 0 } },
    },
}
