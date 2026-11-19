local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "bandits_ambush",
    layout = {
        nested = { { id = "bandits_ambush", x = 0, y = 0 } },
    },
}
