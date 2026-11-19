local ccb = require("ccb")

-- TODO: Add more variations
ccb.content.define_mapgen {
    kind = "update",
    id = "bandits_grave",
    layout = {
        nested = { { id = "bandits_grave", x = 0, y = 0 } },
    },
}
