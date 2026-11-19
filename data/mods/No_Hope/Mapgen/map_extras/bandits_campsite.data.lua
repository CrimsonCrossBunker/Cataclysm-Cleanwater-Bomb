local ccb = require("ccb")

-- TODO: Add more variations
ccb.content.define_mapgen {
    kind = "update",
    id = "bandits_campsite",
    layout = {
        nested = { { id = "bandits_campsite", x = 0, y = 0 } },
    },
}
